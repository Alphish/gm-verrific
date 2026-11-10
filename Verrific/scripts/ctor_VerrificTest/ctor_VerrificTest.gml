/// @desc A test instance executing the test logic.
function VerrificTest() constructor {
    /// @desc The asserter checking test outputs.
    /// @returns {Struct.VerrificAsserter}
    asserter = VerrificAsserter.instance;
    
    /// @desc The test run managing the test.
    /// @returns {Struct.VerrificTestRun}
    run = undefined;
    
    /// @desc The algorithm according to which the test is executed.
    /// @arg {Struct.VerrificTestAlgorithm}
    algorithm = undefined;
    
    /// @desc Executes the test.
    /// @arg {Struct.VerrificTest} test     The test instance performing the execution logic.
    /// @returns {Any}
    static execute = function(_test) {
        throw VerrificException.test_no_algorithm(self);
    }
    
    /// @desc Applies the given algorithm to the test.
    /// @arg {Struct.VerrificTestAlgorithm} algorithm   The algorithm according to which the test is executed.
    /// @returns {Struct.VerrificTest}
    static with_algorithm = function(_algorithm) {
        algorithm = _algorithm;
        execute = _algorithm.prepare_execute(self);
        return self;
    }
    
    /// @desc Links the test to a test run and prepares it before execution.
    /// @arg {Struct.VerrificTestRun} run               The test run managing the test.
    static init = function(_run) {
        run = _run;
        
        if (is_undefined(algorithm))
            throw VerrificException.test_no_algorithm(self);
        
        algorithm.init_test(self);
    }
    
    /// @desc Frees resources used by the test.
    static cleanup = function() {
        if (is_undefined(algorithm))
            throw VerrificException.test_no_algorithm(self);
        
        algorithm.cleanup_test(self);
    }
    
    static toString = function() {
        if (is_undefined(run))
            return "<no run linked>";
        
        return run.test_case.title;
    }
    
    // ----------
    // Assertions
    // ----------
    
    assert_confirm = function() {
        return asserter.assert_confirm(run);
    }
    
    assert_fail = function(_failure, _failargs) {
        return asserter.assert_fail(run, _failure, _failargs);
    }
    
    assert_that = function(_condition, _onfailure, _failargs) {
        return asserter.assert_that(run, _condition, _onfailure, _failargs);
    }
}
