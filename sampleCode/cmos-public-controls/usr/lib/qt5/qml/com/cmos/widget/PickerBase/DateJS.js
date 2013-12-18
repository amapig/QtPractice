/***************************************************************************
    Copyright (C) 2013 by CMOS
    Author: ZhaoDongshuang
    Email: zhaodongshuang@cmos.net
    Date: 2013-12-04
    File: DateJS.js
    // 主要用于获取时间和日期，以及bound和addzero功能
    // 使用JS的Date对象接口，内部是用Qt的Date方法进行实现
 ***************************************************************************/
var today = new Date();

function getFullYear(){ // 从 Date 对象以四位数字返回年份。
    return Qt.formatDate(today,"yyyy");
}

function getMonth(){ // 从 Date 对象返回月份 (1 ~ 12)。
    return Qt.formatDate(today,"MM");
}

function getDate(){ // 从 Date 对象返回一个月中的某一天 (1 ~ 31)。
    return Qt.formatDate(today,"dd");
}

function bound(min,value,max){
    return Math.max(min,Math.min(value,max));
}

function days(year,month){
    var day = new Date(year,month,0);
    return day.getDate();
}

function getHours(){
    return Qt.formatTime(today,"hh");
}

function getMinutes(){
    return Qt.formatTime(today,"mm");
}

function getSeconds(){
    return Qt.formatTime(today,"ss");
}

function addZero(num) {
    if( num <= 9 ){ num = "0" + num; }
    return num.toString();
}

