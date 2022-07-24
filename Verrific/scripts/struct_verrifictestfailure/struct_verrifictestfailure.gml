/// @function VerrificTestFailure(message)
/// @desc Constructor for the Verrific test failure.
/// @param {String} message
function VerrificTestFailure(message) constructor {
    self.message = message;
    self.can_preview = false;
    
    static preview = function() {
        throw instanceof(self) + ".preview() is not implemented, despite this test failure being marked as previewable.";
    }
}
