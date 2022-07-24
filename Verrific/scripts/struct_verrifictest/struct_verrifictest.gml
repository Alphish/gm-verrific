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
            callback(context);
            return create_basic_result(context);
        } catch (exception) {
            return create_crash_result(context, exception);
        }
    }
    
    /// @ignore
    /// Internal: Creates a non-crash test result based on the test context.
    static create_basic_result = function(context) {
        if (context.is_failed) {
            var summary = array_length(context.failures) == 1 ? context.failures[0].message : "Multiple failures found.";
            return new VerrificTestResult(VerrificTestStatus.Failed, summary, context.failures, undefined);
        } else if (!context.is_asserted) {
            var summary = "No assertion was made during test.";
            return new VerrificTestResult(VerrificTestStatus.Unverified, summary, [], undefined);
        } else {
            var summary = "Test passed.";
            return new VerrificTestResult(VerrificTestStatus.Passed, summary, [], undefined);
        }
    }
    
    /// @ignore
    /// Internal: Creates a crash test result based on the test context and the exception caught.
    static create_crash_result = function(context, exception) {
        var summary = is_struct(exception) && variable_struct_exists(exception, "message") ? exception.message : string(exception);
        return new VerrificTestResult(VerrificTestStatus.Crashed, summary, context.failures, exception);
    }
}