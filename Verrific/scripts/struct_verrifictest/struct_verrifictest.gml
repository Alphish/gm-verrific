/// @func VerrificTest(run)
/// @desc A parent struct for Verrific test instances.
/// @param {Struct.VerrificTestRun} run         The test run responsible for the test.
function VerrificTest(_run) constructor {
    test_run = _run;
    
    // --------------
    // Tests handling
    // --------------
    
    /// @func test_execute()
    /// @desc Executes the test logic. Must be implemented in any VerrificTest child struct.
    static test_execute = function() {
        throw $"{instanceof(self)}.test_execute() was not implemented.";
    }
    
    /// @func test_cleanup()
    /// @desc Performs the cleanup after finishing the test. Doesn't perform any cleanup tasks by default.
    static test_cleanup = function() {
        // by default, there's no special cleanup logic
    }
}
