#include "meegocamera.h"

#include <fcntl.h>
#include <syslog.h>
#include <errno.h>

#include <sys/socket.h>
#include <sys/stat.h>
#include <QFile>

#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QGraphicsObject>
#include <QDeclarativeContext>
#include <QtOpenGL/QGLWidget>
#include <QKeyEvent>
#include <QDeclarativeEngine>
#include <QFileInfo>

#include "qdeclarativecamera_p.h"
#include "qdeclarativecamerapreviewprovider_p.h"
#include "qmlcamerasettings.h"


#include <QFile>

#define GPIO_KEYS "/dev/input/gpio-keys"

MeegoCamera::MeegoCamera(bool visible): QObject(),
    m_uiVisible(visible),
    m_background(!visible),
    m_gpioFile(-1),
    m_gpioNotifier(0),
    m_server(0),
    m_connections(0),
    m_view(0),
    m_resourcesGranted(false)
{
    //qDebug() << Q_FUNC_INFO;

    qmlRegisterType<QDeclarativeCamera>("com.meego.MeegoHandsetCamera", 1, 0, "MeegoCamera");
    qmlRegisterType<QmlCameraSettings>("com.meego.MeegoHandsetCamera", 1, 0, "CameraSettings");

    m_server = new QLocalServer(this);

    //qDebug() << Q_FUNC_INFO << "socket server created";

    connect(m_server, SIGNAL(newConnection()), this, SLOT(newConnection()));

    cleanSocket();

    m_server->listen(SERVER_NAME);

    //qDebug() << Q_FUNC_INFO << "connected to socket server";

    m_gpioFile = open(GPIO_KEYS, O_RDONLY | O_NONBLOCK);
    if (m_gpioFile != -1) {
        m_gpioNotifier = new QSocketNotifier(m_gpioFile, QSocketNotifier::Read);
        connect(m_gpioNotifier, SIGNAL(activated(int)), this, SLOT(didReceiveKeyEventFromFile(int)));
    } else {
        m_gpioNotifier = 0;
    }

    //qDebug() << Q_FUNC_INFO << "gpio device opened";

#ifdef CUSTOM_RESOURCES
    m_cameraForegroundResources = new ResourcePolicy::ResourceSet("camera", this);
    m_cameraForegroundResources->setAlwaysReply();

    m_cameraBackgroundResources = new ResourcePolicy::ResourceSet("background", this);
    m_cameraBackgroundResources->setAlwaysReply();

    connect(m_cameraForegroundResources, SIGNAL(resourcesGranted(const QList<ResourcePolicy::ResourceType>)), this, SLOT(resourcesGranted(QList<ResourcePolicy::ResourceType>)));
    connect(m_cameraForegroundResources, SIGNAL(resourcesDenied()), this, SLOT(resourcesDenied()));
    connect(m_cameraForegroundResources, SIGNAL(lostResources()), this, SLOT(lostResources()));

    // LensCover resource for getting lenscover state when camera app is in foreground.
    // Other needed resources are handled in QDeclarativeCamera.
    m_cameraForegroundResources->addResource(ResourcePolicy::LensCoverType);

    connect(m_cameraBackgroundResources, SIGNAL(resourcesGranted(const QList<ResourcePolicy::ResourceType>)), this, SLOT(resourcesGranted(QList<ResourcePolicy::ResourceType>)));
    connect(m_cameraBackgroundResources, SIGNAL(resourcesDenied()), this, SLOT(resourcesDenied()));
    connect(m_cameraBackgroundResources, SIGNAL(lostResources()), this, SLOT(lostResources()));

    // If UI is not visible or active the needed resources are snap button and camera hw
    // camera HW button to bring UI to foreground when pressed
    m_cameraBackgroundResources->addResource(ResourcePolicy::LensCoverType);
    m_cameraBackgroundResources->addResource(ResourcePolicy::SnapButtonType);

    //qDebug() << Q_FUNC_INFO << "volume key resource connected";
#else
    m_resourcesGranted = true;
#endif

    m_coverState = !getSwitchState(m_gpioFile, 9);

    if (m_uiVisible)
        showUI();

    //qDebug() << Q_FUNC_INFO << "UI created  ";
}

MeegoCamera::~MeegoCamera()
{
    //qDebug() << Q_FUNC_INFO;

#ifdef CUSTOM_RESOURCES
    m_cameraForegroundResources->release();
    m_cameraBackgroundResources->release();
#endif

    //qDebug() << Q_FUNC_INFO << "volume ker resource released";

    if (m_view)
        delete m_view;

    //qDebug() << Q_FUNC_INFO << "view deleted";

    m_view = 0;

    m_server->close();
    delete m_server;
    m_server = 0;

    //qDebug() << Q_FUNC_INFO << "socket server closed";

    closelog();

    //qDebug() << Q_FUNC_INFO << "system log closed";

    if (m_gpioFile != -1) {
        close(m_gpioFile);
        m_gpioFile = -1;
        delete m_gpioNotifier;
        m_gpioNotifier = 0;
    }

    //qDebug() << Q_FUNC_INFO << "destructor complete";
}


void MeegoCamera::createCamera()
{
    if (!m_view) {
        //qDebug() << Q_FUNC_INFO << "new UI created";

        const QString mainQmlApp = QLatin1String("qrc:/declarative-camera.qml");

        m_view = new QDeclarativeView;

        m_view->setViewport(new QGLWidget);

        m_view->engine()->addImageProvider("meegocamera", new QDeclarativeCameraPreviewProvider);

        m_view->rootContext()->setContextProperty("mainWindow", m_view);

        m_view->setSource(QUrl(mainQmlApp));

        m_view->rootObject()->setProperty("lensCoverStatus", m_coverState);
        m_view->rootObject()->setProperty("videoModeEnabled", isVideoCaptureSupported());

        m_view->setResizeMode(QDeclarativeView::SizeRootObjectToView);
        // Qt.quit() called in embedded .qml by default only emits
        // quit() signal, so do this (optionally use Qt.exit()).
        // If application was started with background flag, then just hide UI.
        if ( m_background )
            QObject::connect(m_view->engine(), SIGNAL(quit()), this, SLOT(hideUI()));
        else
            QObject::connect(m_view->engine(), SIGNAL(quit()), this, SIGNAL(quit()));

        // QObject::connect(view.engine(), SIGNAL(()), qApp, SLOT(quit()));
        m_view->setGeometry(QRect(0, 0, 800, 480));
        m_view->installEventFilter(this);

	QObject::connect(m_view->rootObject(), SIGNAL(deleteImage()), this, SLOT(deleteImage()));
        
	//qDebug() << Q_FUNC_INFO << "new UI ready";
    }
}



/* Called when we get an input event from a file descriptor. */
void MeegoCamera::didReceiveKeyEventFromFile(int fd)
{
    for (;;) {
        struct input_event ev;
        memset(&ev, 0, sizeof(ev));
        int ret = read(fd, &ev, sizeof(ev));

        if (ret <= 0)
            break;

        if (ret == sizeof(ev) )
            HandleGpioKeyEvent(ev);
    }
}

void MeegoCamera::HandleGpioKeyEvent(struct input_event &ev)
{
    if (ev.code == 528) { // Focus button state changed
        if ( m_uiVisible) {
            if ( ev.value == 1 ) { // Focus button down
                QApplication::postEvent(m_view,
                        new QKeyEvent(QEvent::KeyPress,
                        Qt::Key_CameraFocus,
                        Qt::NoModifier));
            }
            if ( ev.value == 0 ) { // Focus button up
                QApplication::postEvent(m_view,
                        new QKeyEvent(QEvent::KeyRelease,
                        Qt::Key_CameraFocus,
                        Qt::NoModifier));
            }
        }
    } else if (ev.code == 212 && ev.value == 1 ) { // Camera button pressed
        // Check if UI is running and show it if not
        if(m_resourcesGranted)
            showUI();
    } else if ((ev.code == 9 && ev.value == 0) ) { // Lens cover opened
        //qDebug() << Q_FUNC_INFO << "lens cover opened ->";
        // Check if UI is running and show it if not
        m_coverState = true;
        if(m_resourcesGranted) {
            showUI();
            m_view->rootObject()->setProperty("lensCoverStatus",true);
        }
        //qDebug() << Q_FUNC_INFO << "lens cover opened <-";
    } else if (ev.code == 9 && ev.value == 1) { // Lens cover closed
        //qDebug() << Q_FUNC_INFO << "lens cover closed ->";
        m_coverState = false;
        if(m_resourcesGranted)
            hideUI();
        //qDebug() << Q_FUNC_INFO << "lens cover closed <-";
    }
}


void MeegoCamera::hideUI()
{
    //qDebug() << Q_FUNC_INFO << "->";
    m_uiVisible = false;

//    m_cameraResources->release();

    if (m_view) {
        //qDebug() << Q_FUNC_INFO << "hide";

        // LOL part starts here

        // Viewfinder must be running when the view is deleted.
        // Otherwise the viewfinder (xvoverlay) goes to
        // inconsistent state when the view is created again.
        m_view->rootObject()->setProperty("lensCoverStatus",true);
        m_view->rootObject()->setProperty("active",true);

        m_view->deleteLater();
        m_view = 0;
    }
    //qDebug() << Q_FUNC_INFO << "<-";

    updateResources();
}

void MeegoCamera::showUI()
{
    //qDebug() << Q_FUNC_INFO << "show ->";
    //m_cameraResources->acquire();
    createCamera();

    //qDebug() << Q_FUNC_INFO << "show: camera created";

    m_view->showFullScreen();

    //qDebug() << Q_FUNC_INFO << "show: UI shown";

    m_view->rootObject()->setVisible(true);
    m_view->rootObject()->setProperty("active",true);
    m_uiVisible = true;
    //qDebug() << Q_FUNC_INFO << "show <-";

    updateResources();
}

bool MeegoCamera::isVideoCaptureSupported() const
{
    // Video capture is supported only if ti-dsp codecs are installed and running.
    // Video recording does not work in current camera pipelinewithout them.
    QFileInfo fi("/dev/DspBridge");
    return fi.exists();

}

void MeegoCamera::updateResources()
{

#ifdef CUSTOM_RESOURCES
    if(m_uiVisible && m_view && m_view->isActiveWindow()) {
        m_cameraBackgroundResources->release();
        m_cameraForegroundResources->acquire();
    } else {
        m_cameraForegroundResources->release();
        m_cameraBackgroundResources->acquire();
    }
#endif

}

void MeegoCamera::newConnection()
{
    while (m_server->hasPendingConnections()) {
        showUI();
        QLocalSocket *socket = m_server->nextPendingConnection();
        connect(socket, SIGNAL(disconnected()), this, SLOT(disconnected()));
        m_connections.push_back(socket);
    }
}

void MeegoCamera::disconnected()
{
    QLocalSocket *socket = qobject_cast<QLocalSocket*>(sender());
    for (QVector<QLocalSocket*>::iterator it = m_connections.begin(); it != m_connections.end(); it++) {
        if (*it == socket) {
            m_connections.erase(it);
            break;
        }
    }
    socket->deleteLater();
}

bool MeegoCamera::eventFilter(QObject* watched, QEvent* event)
{
    //qDebug() << Q_FUNC_INFO << "event = " << event->type();
    if( m_view && watched == m_view) {

        if(event->type() == QEvent::ActivationChange && m_view->rootObject()) {
            //qDebug() << Q_FUNC_INFO << "window active status changed as " << m_view->isActiveWindow();

            m_uiVisible = m_view->isActiveWindow();

            m_view->rootObject()->setProperty("active",m_view->isActiveWindow());

            updateResources();
        }

        if(event->type() == QEvent::Close) {
            //qDebug() << Q_FUNC_INFO << "window closed";

            m_uiVisible = false;

            if ( !m_background ) {
                emit quit();
            } else {
                hideUI();
            }
        }
    }

    return false;
}


void MeegoCamera::cleanSocket()
{
    QFile serverSocket(SERVER_NAME);
    if (serverSocket.exists()) {
        /* If a socket exists but we fail to delete it, it can be a sign of a potential
         * race condition. Therefore, exit the process as it is a critical failure.
         */
        if (!serverSocket.remove()) {
            syslog(LOG_CRIT, "Could not clean the existing socket %s, exit\n", SERVER_NAME);
            QCoreApplication::exit(1);
        }
    }
}

bool MeegoCamera::getSwitchState(int fd, int key)
{
    uint8_t keys[SW_MAX/8 + 1];
    memset(keys, 0, sizeof *keys);
    ioctl(fd, EVIOCGSW(sizeof(keys)), keys);
    return (keys[key/8] & (1 << (key % 8)));
}

void MeegoCamera::deleteImage()
{
    QFile::remove( m_view->rootObject()->property("imagePath").toString());
}

#ifdef CUSTOM_RESOURCES
void MeegoCamera::resourcesGranted(const QList<ResourcePolicy::ResourceType>& /*grantedOptionalResources*/)
{
    m_resourcesGranted = true;
}

void MeegoCamera::resourcesDenied()
{
    m_resourcesGranted = false;
}

void MeegoCamera::lostResources()
{
    m_resourcesGranted = false;
}
#endif

