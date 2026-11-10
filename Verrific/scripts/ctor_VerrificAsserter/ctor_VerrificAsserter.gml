function VerrificAsserter() constructor {
    /// @desc Confirms the given test run as verified. Useful when running the test without errors is itself being tested.
    /// @arg {Struct.VerrificTestRun} run       The run to confirm as verified.
    /// @returns {Bool}
    static assert_confirm = function(_run) {
        _run.mark_verified();
        return true;
    }
    
    /// @ignore
    static record_failure = function(_run, _onfailure, _failargs = undefined) {
        var _failure = is_callable(_onfailure) ? _onfailure(_failargs) : _onfailure;
        _run.record_failure(_failure);
        return false;
    }
    
    /// @desc Records a failure for the given test run. The failure may be given directly or as a generator method.
    /// @arg {Struct.VerrificTestRun} run   The run to record the failure of.
    /// @arg {Any,Function} failure         The failure to record or its generator function/method.
    /// @arg {Any} [failargs]               Arguments to generate the failure with, if any.
    /// @returns {Bool}
    static assert_fail = function(_run, _failure, _failargs = undefined) {
        _run.mark_verified();
        return record_failure(_run, _failure, _failargs);
    }
    
    /// @desc Records a failure for the given test run. The failure may be given directly or as a generator method.
    /// @arg {Struct.VerrificTestRun} run   The run to record the failure of.
    /// @arg {Bool} condition               The condition to check.
    /// @arg {Any,Function} onfailure       The failure to record when the condition isn't met, or its generator function/method.
    /// @arg {Any} [failargs]               Arguments to generate the failure with, if any.
    static assert_that = function(_run, _condition, _onfailure = undefined, _failargs = undefined) {
        _run.mark_verified();
        _onfailure ??= "Expected the assertion condition to be true, but it wasn't.";
        return _condition ? true : record_failure(_run, _onfailure, _failargs);
    }
}

VerrificAsserter.instance = new VerrificAsserter();
