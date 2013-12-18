import QtQuick 2.0

QtObject{
    id:jsObject

    property var dataArray:[]
    function createArray(size) {
        if(size == dataArray.length)
            return
        dataArray = new Array(size)
        resetValue(false)
    }

    function resetValue(value) //reset as value
    {
        console.log("resetValue",value)
        for(var i =0;i< dataArray.length;i++)
        {
            dataArray[i] = value;
        }
    }

    function checkAll(mode) { //true:check false:uncheck
        if(mode == true)
        {
            resetValue(true)
        }
        else
        {
            resetValue(false)
        }
    }

    function checkOne(index,mode)
    {
        dataArray[index] = mode
    }

    function getCheck(index)
    {
        console.log("getCheck:",index,dataArray.length)
        if(index >= dataArray.length)
            return false
        return dataArray[index]==undefined?false:dataArray[index]
    }

    function getCheckedItems()
    {
        var checkedList = new Array()
        for(var i = 0;i<dataArray.length;i++)
        {
            if(dataArray[i])
            {
                checkedList.push(i)
            }
        }
        console.log("getCheckedItems "+checkedList.length,":",checkedList)
        return checkedList;
    }
}
