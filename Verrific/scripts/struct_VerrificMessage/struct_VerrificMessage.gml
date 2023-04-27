/// @function VerrificMessage(description)
/// @desc A struct representing a Verrific test message.
/// @param {String} text            The content of the message.
function VerrificMessage(_text) constructor {
    text = _text;
    is_failure = false;
    is_crash = false;
}