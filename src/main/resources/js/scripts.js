function keyDown(evt) {
    if (evt.keyCode == 13 || evt.which == 13) {
        evt.preventDefault();
    }
}

function keyPress(evt) {
    var str = document.getElementById("guess-text").value;
    var chr = getChar(evt);
    if (chr == null) {
        return;
    }
    if (chr < '0' || chr > '9' || str.indexOf(chr) > -1) {
        return evt.preventDefault();
    }
}

function getChar(evt) {
    if (evt.which == null) {
        if (evt.keyCode < 32) {
            return null;
        }
        return String.fromCharCode(evt.keyCode) // IE
    }
    if (evt.which != 0 && evt.charCode != 0) {
        if (evt.which < 32) {
            return null;
        }
        return String.fromCharCode(evt.which) // others
    }
    return null;
}

function btnClick(chr) {
    var text = document.getElementById("guess-text");
    if (text.value.length < 4 && chr >= '0' && chr <= '9' && text.value.indexOf(chr) < 0) {
        text.value += chr;
    }
}