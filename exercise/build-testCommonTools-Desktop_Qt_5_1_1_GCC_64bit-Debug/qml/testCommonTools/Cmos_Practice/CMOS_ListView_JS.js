.pragma library

var dataArray;
function createArray(size) {
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
    return dataArray[index]
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




