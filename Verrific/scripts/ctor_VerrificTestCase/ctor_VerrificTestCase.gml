/// @desc A test case to potentially execute.
/// @arg {String} title     The title of the test case.
function VerrificTestCase(_title) : VerrificTestItem(_title) constructor {
    /// @desc Prepares a test run instance suitable to manage the test execution.
    /// @returns {Struct.VerrificTestRun}
    static create_test_run = function() {
        throw VerrificException.not_implemented(self, nameof(create_test_run));
    }
    
    /// @desc Creates a test instance with a its test logic.
    /// @arg {Struct.VerrificTestRun} run       The test run managing the test execution.
    /// @returns {Struct.VerrificTest}
    static create_test = function(_run) {
        throw VerrificException.not_implemented(self, nameof(create_test));
    }
}
