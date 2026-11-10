/// @desc A test run managing the test execution and reporting the results.
/// @arg {Struct.VerrificTestCase} case     The test case the run has been made for.
function VerrificTestRun(_case) constructor {
    /// @desc The test case the run has been made for.
    /// @returns {Struct.VerrificTestCase}
    test_case = _case;
    
    /// @desc The test managed by the run.
    /// @returns {Struct.VerrificTest}
    test = undefined;
    
    /// @desc The test execution/completion status.
    /// @returns {Struct.VerrificStatus}
    status = VerrificStatus.Scheduled;
    
    /// @desc Indicates whether the run has ran the test to completion/failure.
    /// @returns {Bool}
    is_done = false;
    
    /// @desc Indicates whether the run has been verified (by an assertion or specific confirmation).
    /// @returns {Bool}
    is_verified = false;
    
    /// @desc The result of the test.
    /// @returns {Any}
    result = undefined;
    
    /// @desc The failures found during the test.
    /// @returns {Array,Undefined}
    failures = undefined;
    
    /// @desc The error encountered during the test.
    /// @returns {Any}
    error = undefined;
    
    // ---------
    // Test flow
    // ---------
    
    /// @desc Creates and prepares the test instance.
    static init = function() {
        test = test_case.create_test(self);
        test.init(self);
    }
    
    /// @desc Executes the next test step, and returns whether more processing is needed.
    /// @returns {Bool}
    static process_step = function() {
        throw VerrificException.not_implemented(self, nameof(process_step));
    }
    
    /// @desc Updates the run state after the latest processing step.
    static prepare_update = function() {
        if (!is_undefined(error))
            status = VerrificStatus.Crashed;
        else if (!is_undefined(failures))
            status = VerrificStatus.Failed;
        else if (is_done)
            status = is_verified ? VerrificStatus.Passed : VerrificStatus.Unverified;
        else
            status = VerrificStatus.Scheduled;
    }
    
    /// @desc Handles an exception thrown during the test execution.
    /// @arg {Any} exception        The received exception.
    static handle_exception = function(_exception) {
        record_error(_exception);
    }
    
    /// @desc Indicates whether the test has finished.
    /// @returns {Bool}
    static is_finished = function() {
        return status.is_final;
    }
    
    /// @desc Cleans up the test after completion/cancellation.
    /// @arg {Bool} auto            Indicates if the cleanup was called manually (false) or from the general task management system (true).
    static cleanup = function(_auto) {
        if (!is_undefined(test))
            test.cleanup();
    }
    
    // ----------------
    // State management
    // ----------------
    
    /// @desc Confirms the test run as verified.
    static mark_verified = function() {
        is_verified = true;
    }
    
    /// @desc Records a failure found during a test.
    /// @arg {Any} failure          The failure to record.
    static record_failure = function(_failure) {
        failures ??= [];
        array_push(failures, _failure);
    }
    
    /// @desc Records an error encountered during a test.
    /// @arg {Any} error            The error to record.
    static record_error = function(_error) {
        error = _error;
    }
}
