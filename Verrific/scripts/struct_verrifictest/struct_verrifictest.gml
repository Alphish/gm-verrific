/// @func VerrificTest(description, callback)
/// @desc Constructor for the Verrific test.
/// @param {String} description
/// @param {Function} callback
function VerrificTest(description, callback) constructor {
    self.description = description;
    self.callback = callback;
    
    /// @func run()
    /// @desc Runs the test and returns the result.
    /// @return {Struct.VerrificTestResult}
    static run = function() {
        var context = new VerrificTestContext();
        try {
            self.callback(context);
            return create_basic_result(context);
        } catch (exception) {
            return create_crash_result(context, exception);
        }
    }
    
    /// @ignore
    /// Internal: Creates a non-crash test result based on the test context.
    static create_basic_result = function(context) {
        if (context.is_failed)
            return new VerrificTestResult(VerrificTestStatus.Failed, "Test failed.", context.failures, undefined);
        else if (!context.is_asserted)
            return new VerrificTestResult(VerrificTestStatus.Unverified, "Test had no assertions.", [], undefined);
        else
            return new VerrificTestResult(VerrificTestStatus.Passed, "Test passed", [], undefined);
    }
    
    /// @ignore
    /// Internal: Creates a crash test result based on the test context and the exception caught.
    static create_crash_result = function(context, exception) {
        return new VerrificTestResult(VerrificTestStatus.Crashed, "Test crashed.", context.failures, exception);
    }
}