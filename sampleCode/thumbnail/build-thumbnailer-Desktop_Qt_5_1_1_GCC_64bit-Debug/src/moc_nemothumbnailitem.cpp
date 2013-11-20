/****************************************************************************
** Meta object code from reading C++ file 'nemothumbnailitem.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.1.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../nemo-qml-plugin-thumbnailer-qt5-0.0.5/src/nemothumbnailitem.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'nemothumbnailitem.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.1.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_NemoThumbnailItem_t {
    QByteArrayData data[27];
    char stringdata[307];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_NemoThumbnailItem_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_NemoThumbnailItem_t qt_meta_stringdata_NemoThumbnailItem = {
    {
QT_MOC_LITERAL(0, 0, 17),
QT_MOC_LITERAL(1, 18, 13),
QT_MOC_LITERAL(2, 32, 0),
QT_MOC_LITERAL(3, 33, 15),
QT_MOC_LITERAL(4, 49, 17),
QT_MOC_LITERAL(5, 67, 15),
QT_MOC_LITERAL(6, 83, 15),
QT_MOC_LITERAL(7, 99, 13),
QT_MOC_LITERAL(8, 113, 6),
QT_MOC_LITERAL(9, 120, 8),
QT_MOC_LITERAL(10, 129, 10),
QT_MOC_LITERAL(11, 140, 8),
QT_MOC_LITERAL(12, 149, 8),
QT_MOC_LITERAL(13, 158, 8),
QT_MOC_LITERAL(14, 167, 8),
QT_MOC_LITERAL(15, 176, 6),
QT_MOC_LITERAL(16, 183, 6),
QT_MOC_LITERAL(17, 190, 17),
QT_MOC_LITERAL(18, 208, 18),
QT_MOC_LITERAL(19, 227, 12),
QT_MOC_LITERAL(20, 240, 14),
QT_MOC_LITERAL(21, 255, 11),
QT_MOC_LITERAL(22, 267, 13),
QT_MOC_LITERAL(23, 281, 4),
QT_MOC_LITERAL(24, 286, 5),
QT_MOC_LITERAL(25, 292, 7),
QT_MOC_LITERAL(26, 300, 5)
    },
    "NemoThumbnailItem\0sourceChanged\0\0"
    "mimeTypeChanged\0sourceSizeChanged\0"
    "fillModeChanged\0priorityChanged\0"
    "statusChanged\0source\0mimeType\0sourceSize\0"
    "fillMode\0FillMode\0priority\0Priority\0"
    "status\0Status\0PreserveAspectFit\0"
    "PreserveAspectCrop\0HighPriority\0"
    "NormalPriority\0LowPriority\0Unprioritized\0"
    "Null\0Ready\0Loading\0Error\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_NemoThumbnailItem[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       6,   50, // properties
       3,   74, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x05,
       3,    0,   45,    2, 0x05,
       4,    0,   46,    2, 0x05,
       5,    0,   47,    2, 0x05,
       6,    0,   48,    2, 0x05,
       7,    0,   49,    2, 0x05,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       8, QMetaType::QUrl, 0x00495103,
       9, QMetaType::QString, 0x00495103,
      10, QMetaType::QSize, 0x00495103,
      11, 0x80000000 | 12, 0x0049510b,
      13, 0x80000000 | 14, 0x0049510b,
      15, 0x80000000 | 16, 0x00495009,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       4,
       5,

 // enums: name, flags, count, data
      12, 0x0,    2,   86,
      14, 0x0,    4,   90,
      16, 0x0,    4,   98,

 // enum data: key, value
      17, uint(NemoThumbnailItem::PreserveAspectFit),
      18, uint(NemoThumbnailItem::PreserveAspectCrop),
      19, uint(NemoThumbnailItem::HighPriority),
      20, uint(NemoThumbnailItem::NormalPriority),
      21, uint(NemoThumbnailItem::LowPriority),
      22, uint(NemoThumbnailItem::Unprioritized),
      23, uint(NemoThumbnailItem::Null),
      24, uint(NemoThumbnailItem::Ready),
      25, uint(NemoThumbnailItem::Loading),
      26, uint(NemoThumbnailItem::Error),

       0        // eod
};

void NemoThumbnailItem::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        NemoThumbnailItem *_t = static_cast<NemoThumbnailItem *>(_o);
        switch (_id) {
        case 0: _t->sourceChanged(); break;
        case 1: _t->mimeTypeChanged(); break;
        case 2: _t->sourceSizeChanged(); break;
        case 3: _t->fillModeChanged(); break;
        case 4: _t->priorityChanged(); break;
        case 5: _t->statusChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (NemoThumbnailItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&NemoThumbnailItem::sourceChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (NemoThumbnailItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&NemoThumbnailItem::mimeTypeChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (NemoThumbnailItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&NemoThumbnailItem::sourceSizeChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (NemoThumbnailItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&NemoThumbnailItem::fillModeChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (NemoThumbnailItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&NemoThumbnailItem::priorityChanged)) {
                *result = 4;
            }
        }
        {
            typedef void (NemoThumbnailItem::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&NemoThumbnailItem::statusChanged)) {
                *result = 5;
            }
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject NemoThumbnailItem::staticMetaObject = {
    { &QQuickItem::staticMetaObject, qt_meta_stringdata_NemoThumbnailItem.data,
      qt_meta_data_NemoThumbnailItem,  qt_static_metacall, 0, 0}
};


const QMetaObject *NemoThumbnailItem::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *NemoThumbnailItem::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_NemoThumbnailItem.stringdata))
        return static_cast<void*>(const_cast< NemoThumbnailItem*>(this));
    return QQuickItem::qt_metacast(_clname);
}

int NemoThumbnailItem::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QUrl*>(_v) = source(); break;
        case 1: *reinterpret_cast< QString*>(_v) = mimeType(); break;
        case 2: *reinterpret_cast< QSize*>(_v) = sourceSize(); break;
        case 3: *reinterpret_cast< FillMode*>(_v) = fillMode(); break;
        case 4: *reinterpret_cast< Priority*>(_v) = priority(); break;
        case 5: *reinterpret_cast< Status*>(_v) = status(); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setSource(*reinterpret_cast< QUrl*>(_v)); break;
        case 1: setMimeType(*reinterpret_cast< QString*>(_v)); break;
        case 2: setSourceSize(*reinterpret_cast< QSize*>(_v)); break;
        case 3: setFillMode(*reinterpret_cast< FillMode*>(_v)); break;
        case 4: setPriority(*reinterpret_cast< Priority*>(_v)); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 6;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 6;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void NemoThumbnailItem::sourceChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void NemoThumbnailItem::mimeTypeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, 0);
}

// SIGNAL 2
void NemoThumbnailItem::sourceSizeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}

// SIGNAL 3
void NemoThumbnailItem::fillModeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, 0);
}

// SIGNAL 4
void NemoThumbnailItem::priorityChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void NemoThumbnailItem::statusChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, 0);
}
QT_END_MOC_NAMESPACE
