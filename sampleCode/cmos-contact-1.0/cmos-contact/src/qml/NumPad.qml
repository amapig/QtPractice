/****************************************************************************
**
** Copyright (C) 2011-2012 Tom Swindell <t.swindell@rubyx.co.uk>
** All rights reserved.
**
** This file is part of the Voice Call UI project.
**
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * The names of its contributors may NOT be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
****************************************************************************/
import QtQuick 2.0
import com.nokia.meego 2.0

GridView {
    id:numpad

    property string mode: 'dial'
    property Item entryTarget


    cellWidth:width / 3
    cellHeight:width/ 6

    interactive:false


    //TODO:i18n
    model: ListModel {

        ListElement {key:'1';sub:'voicemail';imgSource:'./image/key/default/key1.png';imgSelsetSource:'./image/key/select/key1.png'}
        ListElement {key:'2';sub:'abc';imgSource:'./image/key/default/key2.png';imgSelsetSource:'./image/key/select/key2.png'}
        ListElement {key:'3';sub:'def';imgSource:'./image/key/default/key3.png';imgSelsetSource:'./image/key/select/key3.png'}
        ListElement {key:'4';sub:'ghi';imgSource:'./image/key/default/key4.png';imgSelsetSource:'./image/key/select/key4.png'}
        ListElement {key:'5';sub:'jkl';imgSource:'./image/key/default/key5.png';imgSelsetSource:'./image/key/select/key5.png'}
        ListElement {key:'6';sub:'mno';imgSource:'./image/key/default/key6.png';imgSelsetSource:'./image/key/select/key6.png'}
        ListElement {key:'7';sub:'pqrs';imgSource:'./image/key/default/key7.png';imgSelsetSource:'./image/key/select/key7.png'}
        ListElement {key:'8';sub:'tuv';imgSource:'./image/key/default/key8.png';imgSelsetSource:'./image/key/select/key8.png'}
        ListElement {key:'9';sub:'wxyz';imgSource:'./image/key/default/key9.png';imgSelsetSource:'./image/key/select/key9.png'}
        ListElement {key:'*';sub:',';alt:',';imgSource:'./image/key/default/keystar.png';imgSelsetSource:'./image/key/select/keystar.png'}
        ListElement {key:'0';sub:'+';alt:'+';imgSource:'./image/key/default/key0.png';imgSelsetSource:'./image/key/select/key0.png'}
        ListElement {key:'#';alt:'p';imgSource:'./image/key/default/keysharp.png';imgSelsetSource:'./image/key/select/keysharp.png'}
    }

    delegate: NumPadButton {}
}
