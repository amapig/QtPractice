/****************************************************************************
** Meta object code from reading C++ file 'playlistmodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.1.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../testVideosFilter/playlistmodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'playlistmodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.1.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_PlaylistModel_t {
    QByteArrayData data[23];
    char stringdata[226];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_PlaylistModel_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_PlaylistModel_t qt_meta_stringdata_PlaylistModel = {
    {
QT_MOC_LITERAL(0, 0, 13),
QT_MOC_LITERAL(1, 14, 19),
QT_MOC_LITERAL(2, 34, 0),
QT_MOC_LITERAL(3, 35, 8),
QT_MOC_LITERAL(4, 44, 4),
QT_MOC_LITERAL(5, 49, 10),
QT_MOC_LITERAL(6, 60, 5),
QT_MOC_LITERAL(7, 66, 12),
QT_MOC_LITERAL(8, 79, 15),
QT_MOC_LITERAL(9, 95, 3),
QT_MOC_LITERAL(10, 99, 8),
QT_MOC_LITERAL(11, 108, 16),
QT_MOC_LITERAL(12, 125, 5),
QT_MOC_LITERAL(13, 131, 3),
QT_MOC_LITERAL(14, 135, 14),
QT_MOC_LITERAL(15, 150, 16),
QT_MOC_LITERAL(16, 167, 14),
QT_MOC_LITERAL(17, 182, 11),
QT_MOC_LITERAL(18, 194, 6),
QT_MOC_LITERAL(19, 201, 3),
QT_MOC_LITERAL(20, 205, 6),
QT_MOC_LITERAL(21, 212, 4),
QT_MOC_LITERAL(22, 217, 7)
    },
    "PlaylistModel\0currentIndexChanged\0\0"
    "previous\0next\0getImgPath\0index\0"
    "currentIndex\0setCurrentIndex\0idx\0"
    "getCount\0beginInsertItems\0start\0end\0"
    "endInsertItems\0beginRemoveItems\0"
    "endRemoveItems\0changeItems\0append\0url\0"
    "remove\0nPos\0getPath\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_PlaylistModel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       1,  128, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   89,    2, 0x05,

 // slots: name, argc, parameters, tag, flags
       3,    0,   92,    2, 0x0a,
       4,    0,   93,    2, 0x0a,
       5,    1,   94,    2, 0x0a,
       7,    0,   97,    2, 0x0a,
       8,    1,   98,    2, 0x0a,
      10,    0,  101,    2, 0x0a,
      11,    2,  102,    2, 0x08,
      14,    0,  107,    2, 0x08,
      15,    2,  108,    2, 0x08,
      16,    0,  113,    2, 0x08,
      17,    2,  114,    2, 0x08,

 // methods: name, argc, parameters, tag, flags
      18,    1,  119,    2, 0x02,
      20,    1,  122,    2, 0x02,
      22,    1,  125,    2, 0x02,

 // signals: parameters
    QMetaType::Void, QMetaType::Int,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString, QMetaType::Int,    6,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,    9,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   12,   13,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   12,   13,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   12,   13,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::Void, QMetaType::Int,   21,
    QMetaType::QString, QMetaType::Int,   21,

 // properties: name, type, flags
       7, QMetaType::Int, 0x00495103,

 // properties: notify_signal_id
       0,

       0        // eod
};

void PlaylistModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        PlaylistModel *_t = static_cast<PlaylistModel *>(_o);
        switch (_id) {
        case 0: _t->currentIndexChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->previous(); break;
        case 2: _t->next(); break;
        case 3: { QString _r = _t->getImgPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 4: { int _r = _t->currentIndex();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 5: _t->setCurrentIndex((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 6: { int _r = _t->getCount();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 7: _t->beginInsertItems((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 8: _t->endInsertItems(); break;
        case 9: _t->beginRemoveItems((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 10: _t->endRemoveItems(); break;
        case 11: _t->changeItems((*reinterpret_cast< int(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2]))); break;
        case 12: _t->append((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: _t->remove((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 14: { QString _r = _t->getPath((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (PlaylistModel::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&PlaylistModel::currentIndexChanged)) {
                *result = 0;
            }
        }
    }
}

const QMetaObject PlaylistModel::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_PlaylistModel.data,
      qt_meta_data_PlaylistModel,  qt_static_metacall, 0, 0}
};


const QMetaObject *PlaylistModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PlaylistModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_PlaylistModel.stringdata))
        return static_cast<void*>(const_cast< PlaylistModel*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int PlaylistModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 15)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 15;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = currentIndex(); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setCurrentIndex(*reinterpret_cast< int*>(_v)); break;
        }
        _id -= 1;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 1)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void PlaylistModel::currentIndexChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_END_MOC_NAMESPACE
