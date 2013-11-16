/****************************************************************************
** Meta object code from reading C++ file 'frequencymonitor.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.1.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../video/snippets/frequencymonitor/frequencymonitor.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'frequencymonitor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.1.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_FrequencyMonitor_t {
    QByteArrayData data[22];
    char stringdata[321];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_FrequencyMonitor_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_FrequencyMonitor_t qt_meta_stringdata_FrequencyMonitor = {
    {
QT_MOC_LITERAL(0, 0, 16),
QT_MOC_LITERAL(1, 17, 12),
QT_MOC_LITERAL(2, 30, 0),
QT_MOC_LITERAL(3, 31, 5),
QT_MOC_LITERAL(4, 37, 13),
QT_MOC_LITERAL(5, 51, 23),
QT_MOC_LITERAL(6, 75, 20),
QT_MOC_LITERAL(7, 96, 16),
QT_MOC_LITERAL(8, 113, 29),
QT_MOC_LITERAL(9, 143, 23),
QT_MOC_LITERAL(10, 167, 6),
QT_MOC_LITERAL(11, 174, 5),
QT_MOC_LITERAL(12, 180, 9),
QT_MOC_LITERAL(13, 190, 8),
QT_MOC_LITERAL(14, 199, 19),
QT_MOC_LITERAL(15, 219, 16),
QT_MOC_LITERAL(16, 236, 5),
QT_MOC_LITERAL(17, 242, 6),
QT_MOC_LITERAL(18, 249, 16),
QT_MOC_LITERAL(19, 266, 13),
QT_MOC_LITERAL(20, 280, 22),
QT_MOC_LITERAL(21, 303, 16)
    },
    "FrequencyMonitor\0labelChanged\0\0value\0"
    "activeChanged\0samplingIntervalChanged\0"
    "traceIntervalChanged\0frequencyChanged\0"
    "instantaneousFrequencyChanged\0"
    "averageFrequencyChanged\0notify\0trace\0"
    "setActive\0setLabel\0setSamplingInterval\0"
    "setTraceInterval\0label\0active\0"
    "samplingInterval\0traceInterval\0"
    "instantaneousFrequency\0averageFrequency\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_FrequencyMonitor[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       6,  112, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   79,    2, 0x05,
       4,    1,   82,    2, 0x05,
       5,    1,   85,    2, 0x05,
       6,    1,   88,    2, 0x05,
       7,    0,   91,    2, 0x05,
       8,    1,   92,    2, 0x05,
       9,    1,   95,    2, 0x05,

 // slots: name, argc, parameters, tag, flags
      10,    0,   98,    2, 0x0a,
      11,    0,   99,    2, 0x0a,
      12,    1,  100,    2, 0x0a,
      13,    1,  103,    2, 0x0a,
      14,    1,  106,    2, 0x0a,
      15,    1,  109,    2, 0x0a,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::Bool,    2,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QReal,    3,
    QMetaType::Void, QMetaType::QReal,    3,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,    3,
    QMetaType::Void, QMetaType::QString,    3,
    QMetaType::Void, QMetaType::Int,    3,
    QMetaType::Void, QMetaType::Int,    3,

 // properties: name, type, flags
      16, QMetaType::QString, 0x00495103,
      17, QMetaType::Bool, 0x00495103,
      18, QMetaType::Int, 0x00495103,
      19, QMetaType::Int, 0x00495103,
      20, QMetaType::QReal, 0x00495001,
      21, QMetaType::QReal, 0x00495001,

 // properties: notify_signal_id
       0,
       1,
       2,
       3,
       5,
       6,

       0        // eod
};

void FrequencyMonitor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        FrequencyMonitor *_t = static_cast<FrequencyMonitor *>(_o);
        switch (_id) {
        case 0: _t->labelChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->activeChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 2: _t->samplingIntervalChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 3: _t->traceIntervalChanged((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 4: _t->frequencyChanged(); break;
        case 5: _t->instantaneousFrequencyChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 6: _t->averageFrequencyChanged((*reinterpret_cast< qreal(*)>(_a[1]))); break;
        case 7: _t->notify(); break;
        case 8: _t->trace(); break;
        case 9: _t->setActive((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 10: _t->setLabel((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 11: _t->setSamplingInterval((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 12: _t->setTraceInterval((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (FrequencyMonitor::*_t)(const QString & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::labelChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (FrequencyMonitor::*_t)(bool );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::activeChanged)) {
                *result = 1;
            }
        }
        {
            typedef void (FrequencyMonitor::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::samplingIntervalChanged)) {
                *result = 2;
            }
        }
        {
            typedef void (FrequencyMonitor::*_t)(int );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::traceIntervalChanged)) {
                *result = 3;
            }
        }
        {
            typedef void (FrequencyMonitor::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::frequencyChanged)) {
                *result = 4;
            }
        }
        {
            typedef void (FrequencyMonitor::*_t)(qreal );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::instantaneousFrequencyChanged)) {
                *result = 5;
            }
        }
        {
            typedef void (FrequencyMonitor::*_t)(qreal );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&FrequencyMonitor::averageFrequencyChanged)) {
                *result = 6;
            }
        }
    }
}

const QMetaObject FrequencyMonitor::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_FrequencyMonitor.data,
      qt_meta_data_FrequencyMonitor,  qt_static_metacall, 0, 0}
};


const QMetaObject *FrequencyMonitor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *FrequencyMonitor::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_FrequencyMonitor.stringdata))
        return static_cast<void*>(const_cast< FrequencyMonitor*>(this));
    return QObject::qt_metacast(_clname);
}

int FrequencyMonitor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 13;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = label(); break;
        case 1: *reinterpret_cast< bool*>(_v) = active(); break;
        case 2: *reinterpret_cast< int*>(_v) = samplingInterval(); break;
        case 3: *reinterpret_cast< int*>(_v) = traceInterval(); break;
        case 4: *reinterpret_cast< qreal*>(_v) = instantaneousFrequency(); break;
        case 5: *reinterpret_cast< qreal*>(_v) = averageFrequency(); break;
        }
        _id -= 6;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setLabel(*reinterpret_cast< QString*>(_v)); break;
        case 1: setActive(*reinterpret_cast< bool*>(_v)); break;
        case 2: setSamplingInterval(*reinterpret_cast< int*>(_v)); break;
        case 3: setTraceInterval(*reinterpret_cast< int*>(_v)); break;
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
void FrequencyMonitor::labelChanged(const QString & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void FrequencyMonitor::activeChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void FrequencyMonitor::samplingIntervalChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void FrequencyMonitor::traceIntervalChanged(int _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void FrequencyMonitor::frequencyChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}

// SIGNAL 5
void FrequencyMonitor::instantaneousFrequencyChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void FrequencyMonitor::averageFrequencyChanged(qreal _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}
QT_END_MOC_NAMESPACE
