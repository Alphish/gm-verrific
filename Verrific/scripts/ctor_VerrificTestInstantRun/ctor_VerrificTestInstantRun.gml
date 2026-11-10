/// @desc A simple test run executing its test in a single step.
/// @arg {Struct.VerrificTestCase} case     The test case the run has been made for.
function VerrificTestInstantRun(_case) : VerrificTestRun(_case) constructor {
    
    /// @desc Executes the entire test, and returns true to indicate the test is finished.
    /// @returns {Bool}
    static process_step = function() {
        test.execute(test);
        is_done = true;
        return true;
    }
}
