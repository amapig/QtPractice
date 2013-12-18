/***************************************************************************
    Copyright (C) 2013 by CMOS
    Author: ZhaoDongshuang
    Email: zhaodongshuang@cmos.net
    Date: 2013-12-04
    File: SelectTime.qml
    // 时间选择器
 ***************************************************************************/
import QtQuick 2.0
import "./DateJS.js" as TimeJS

Rectangle {
    // public:
    id: root;
    height: 300;

    function hour(){ return __hour; }
    function minute(){ return __minute; }
    function second(){ return __second; }
    function time(separate){
        var time = "";
        if(selectHour.visible){ time += TimeJS.addZero(__hour); time += separate.toString(); }
        time += TimeJS.addZero(__minute);
        if(selectSec.visible){ time += separate.toString(); time += TimeJS.addZero(__second); }
        return time;
    }

    function setHours(hours){
        __hour = TimeJS.bound(0, hours, 23);
        selectHour.setCurrentIndex(__hour);
    }
    function setMinutes(minutes){
        __minute = TimeJS.bound(0, minutes, 59);
        selectMin.setCurrentIndex(__minute);
    }
    function setSeconds(seconds){
        __second = TimeJS.bound(0, seconds, 59);
        selectSec.setCurrentIndex(__second);
    }
    function setTime(hh,mm,ss){
        setHours(hh); setMinutes(mm); setSeconds(ss);
    }

    function setHourEnabled(enabled){ selectHour.visible = enabled; root.width = __width(); }
    function setSecondEnabled(enabled){ selectSec.visible = enabled; root.width = __width(); }

    // content:
    Row{
        id: container
        anchors { fill: parent; } spacing: 20
        SpinnerBase{
            id: selectHour; width: 148; height: parent.height;
            model: hourModel; unitText: qsTr("时")
            onCurrentIndexChanged: { __hour = curIndex }
        }
        SpinnerBase{
            id: selectMin; width: 148; height: parent.height;
            model: minuteModel; unitText: qsTr("分");
            onCurrentIndexChanged: { __minute = curIndex }
        }
        SpinnerBase{
            id: selectSec; width: 148; height: parent.height;
            model: secendModel; unitText: qsTr("秒");
            onCurrentIndexChanged: { __second = curIndex }
        }
        populate: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 500 }
        }
    }

    Component.onCompleted: {
        __updateTimeHour(); __updateTimeMinute(); __updateTimeSecond();
        setHours(__hour); setMinutes(__minute); setSeconds(__second);
        root.width = __width();
    }

    // private:
    property int __hour: TimeJS.getHours();
    property int __minute: TimeJS.getMinutes();
    property int __second: TimeJS.getSeconds();

    ListModel { id: hourModel } ListModel { id: minuteModel } ListModel { id: secendModel }
    function __updateTimeHour(){
        hourModel.clear();
        for(var i=0; i<=23; ++i) { hourModel.append({"content": TimeJS.addZero(i)}); }
    }
    function __updateTimeMinute(){
        minuteModel.clear();
        for(var i=0; i<=59; ++i) { minuteModel.append({"content": TimeJS.addZero(i)}); }
    }
    function __updateTimeSecond(){
        secendModel.clear();
        for(var i=0; i<=59; ++i) { secendModel.append({"content": TimeJS.addZero(i)}); }
    }

    function __width(){
        var w = selectHour.visible ? selectHour.width : 0;
        w += selectMin.visible ? selectMin.width : 0;
        if(selectHour.visible && selectMin.visible)
            w += container.spacing;
        w += selectSec.visible ? selectSec.width : 0;
        if(selectMin.visible && selectSec.visible)
            w += container.spacing;
        return w;
    }
}
