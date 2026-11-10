/// @desc A test case using a callback as the test execution logic.
/// @arg {String} title         The title of the test case.
/// @arg {Function} callback    The callback to execute in the test.
/// @arg {Any} [context]        The context the callback will be executed from; test instance by default.
function VerrificCallbackTestCase(_title, _callback, _context = undefined) : VerrificTestCase(_title) constructor {
    /// @ignore
    test_algorithm = new VerrificTestCallbackAlgorithm(_callback, _context);
    
    /// @desc Prepares a test run instance suitable to manage the test execution.
    /// @returns {Struct.VerrificTestRun}
    static create_test_run = function() {
        return new VerrificTestInstantRun(self);
    }
    
    /// @desc Creates a test instance with the callback as its test logic.
    /// @returns {Struct.VerrificTest}
    static create_test = function() {
        return new VerrificTest().with_algorithm(test_algorithm);
    }
}
