/// @func VerrificTestResult(status,summary,failures,exception)
/// @desc Constructor for the Verrific test result.
/// @param {Real} status
/// @param {String} summary
/// @param {Array<Struct.VerrificTestFailure>} failures
/// @param {Struct, Undefined} exception
function VerrificTestResult(status, summary, failures, exception) constructor {
    self.status = status;
    self.summary = summary;
    self.failures = failures;
    self.exception = exception;
}
