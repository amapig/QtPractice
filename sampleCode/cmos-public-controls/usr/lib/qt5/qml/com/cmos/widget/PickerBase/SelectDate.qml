/***************************************************************************
    Copyright (C) 2013 by CMOS
    Author: ZhaoDongshuang
    Email: zhaodongshuang@cmos.net
    Date: 2013-12-04
    File: SelectDate.qml
    // 日期选择器
 ***************************************************************************/
import QtQuick 2.0
import "DateJS.js" as DateJS

Item {
    // public:
    id: root;
    height: 300;

    function year() { return __curYear }
    function month() { return __curMonth }
    function day() { return __curDay }
    function date(separate) {
        var date = "";
        if(selectYear.visible){ date += __curYear.toString(); date += separate.toString(); }
        date += DateJS.addZero(__curMonth);
        if(selectDay.visible){ date += separate.toString(); date += DateJS.addZero(__curDay); }
        return date;
    }
    function setYear( year ){
        __curYear = DateJS.bound(__minYear, year, __maxYear);
        selectYear.setCurrentIndex(__curYear - __minYear);
    }
    function setMonth( month ){
        __curMonth = DateJS.bound(1, month, 12);
        selectMonth.setCurrentIndex(__curMonth - 1);
    }
    function setDay( day ){
        __curDay = DateJS.bound(1, day, DateJS.days(__curYear,__curMonth));
        selectDay.setCurrentIndex(__curDay - 1);
    }
    function setDate( year, month, day){
        setYear(year); setMonth(month); setDay(day);
    }
    function setYearsRange(min,max) {
        __minYear = min; __maxYear = max;
        __updateDateYears();
        setYear(__curYear);
    }

    function setYearEnabled(enabled){ selectYear.visible = enabled; root.width = __width(); }
    function setDayEnabled(enabled){ selectDay.visible = enabled; root.width = __width(); }

    // content:
    Row{
        id: container; anchors { fill: parent; } spacing: 20
        SpinnerBase{
            id: selectYear
            width: 240; model: yearModel; unitText: qsTr("年")
            onCurrentIndexChanged: { __curYear = curIndex + __minYear; __updateDays(); }
        }
        SpinnerBase{
            id: selectMonth
            model: monthModel; unitText: qsTr("月")
            onCurrentIndexChanged: { __curMonth = curIndex + 1; __updateDays(); }
        }
        SpinnerBase{
            id: selectDay
            model: dayModel; unitText: qsTr("日")
            onCurrentIndexChanged:  __curDay = curIndex + 1;
        }
        populate: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 500 }
        }
    }

    Component.onCompleted: {
        __updateDateYears(); __updateDateMonths(); __updateDateDays();
        setYear( __curYear ); setMonth( __curMonth ); setDay( __curDay );
        root.width = __width();
    }


    // private:
    ListModel { id: yearModel } ListModel { id: monthModel } ListModel { id: dayModel }

    property int __maxYear: 2039;
    property int __minYear: 1970;
    property int __curYear: DateJS.getFullYear();
    property int __curMonth: DateJS.getMonth();
    property int __curDay: DateJS.getDate();

    function __updateDateYears(){
        yearModel.clear();
        for(var i=__minYear; i<__maxYear; ++i) { yearModel.append({"content": i}); }
    }
    function __updateDateMonths(){
        monthModel.clear();
        for(var i=1; i<=12; ++i) { monthModel.append({"content": DateJS.addZero(i)}); }
    }
    function __updateDateDays(){
        var days = DateJS.days(__curYear,__curMonth);
        dayModel.clear();
        for(var i=1; i<=days; ++i) { dayModel.append({"content": DateJS.addZero(i)}); }
    }
    function __updateDays(){
        var tmpDay = __curDay;
        var n = dayModel.count - 28;
        if(n)
            dayModel.remove(28,n);
        var days = DateJS.days(__curYear,__curMonth);
        for(var i=29; i<=days; ++i) {
            dayModel.set(i-1, {"content": i.toString()});
        }
        if(tmpDay > 28){
            selectDay.setCurrentIndex(Math.min(tmpDay,days) - 1);
        }
    }

    function __width(){
        var w = selectYear.visible ? selectYear.width : 0;
        w += selectMonth.visible ? selectMonth.width : 0;
        if(selectYear.visible && selectMonth.visible)
            w += container.spacing;
        w += selectDay.visible ? selectDay.width : 0;
        if(selectMonth.visible && selectDay.visible)
            w += container.spacing;
        return w;
    }
}
