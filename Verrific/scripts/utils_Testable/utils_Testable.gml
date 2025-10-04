// Converts The Text To Title Case
function string_title(_str) {
    if (_str == "")
        return "";
    
    var _split = string_split(_str, " ");
    var _titled_split = array_map(_split, function(_str) {
        if (_str == "")
            return "";
        
        return string_upper(string_char_at(_str, 1)) + string_lower(string_delete(_str, 1, 1));
    });
    
    return string_join_ext(" ", _titled_split);
}

// splits SomePascalCaseNames to arrays like ["Some", "Pascal", "Case", "Names"]
function string_split_uppercase(_str) {
    var _split_start = 1;
    var _length = string_length(_str);
    var _result = [];
    for (var i = 2; i <= _length; i++) {
        var c = string_char_at(_str, i);
        if (c != string_upper(c))
            continue;
        
        array_push(_result, string_copy(_str, _split_start, i - _split_start));
        _split_start = i;
    }
    array_push(_result, string_copy(_str, _split_start, _length - _split_start + 1));
    return _result;
}

// returns a value gradually approaching the target
// when close enough, returns the target itself
function approach(_current, _target, _amount = 1) {
    var _diff = _target - _current;
    if (abs(_diff) <= _amount)
        return _target;
    else
        return _current + _amount * sign(_diff);
}

// returns a range of items
function array_create_range(_from, _count, _step = 1) {
    var _result = array_create(_count);
    for (var i = 0; i < _count; i++) {
        _result[i] = _from + _step * i;
    }
    return _result;
}
