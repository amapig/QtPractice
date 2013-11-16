#include <iostream>
using namespace std;

#include <QMediaPlayer>

int main(int argc, char *argv[])
{
    QMediaPlayer player;

    QVideoWidget videoWidget;
    player->setVideoOutput(videoWidget);

    videoWidget->show();
    player.setMedia(QUrl::fromLocalFile());
    player->play();

    return a.exec();
}
