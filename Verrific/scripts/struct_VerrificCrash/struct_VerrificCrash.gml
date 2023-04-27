/// @func VerrificCrash(exception)
/// @desc A Verrific crash message.
/// @arg {Any} exception        The exception that caused the crash.
function VerrificCrash(_exception) : VerrificMessage("") constructor {
    if (is_string(_exception))
        text = _exception;
    else if (is_string(_exception[$ "message"]))
        text = _exception.message;
    else
        text = "A crash has occurred.";
    
    is_failure = true;
    is_crash = true;
}
