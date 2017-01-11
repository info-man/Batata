function allownumbers(e) {
    var key = window.event ? e.keyCode : e.which;
    var keychar = String.fromCharCode(key);
    var reg = new RegExp("[0-9.]")
    if (key == 8) {
        keychar = String.fromCharCode(key);
    }
    if (key == 13) {
        key = 8;
        keychar = String.fromCharCode(key);
    }
    return reg.test(keychar);
}

function SetMaskHour(id) {
    if (id.value.length == 2) {
        id.value = id.value + ":"
        id.focus();
    }
}

function SetMaskDate(id) {
    if (id.value.length == 2 || id.value.length == 5) {
        id.value = id.value + "/"
        id.focus();
    }
}


function replaceall(str, replace, with_this) {
    var str_hasil = "";
    var temp;

    for (var i = 0; i < str.length; i++) // not need to be equal. it causes the last change: undefined..
    {
        if (str[i] == replace) {
            temp = with_this;
        }
        else {
            temp = str[i];
        }

        str_hasil += temp;
    }

    return str_hasil;
}