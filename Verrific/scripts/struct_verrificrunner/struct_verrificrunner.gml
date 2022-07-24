/// @func VerrificRunner([config])
/// @desc Contructor for the Verrific tests runner. Can be configured by passing a corresponding struct.
/// @param {Struct} [config]
function VerrificRunner(config = undefined) constructor {
    config = config ?? {};
    batch_time = config[$ "batch_time"] ?? 40;
    on_test_complete = config[$ "on_test_complete"];
    
    pending_tests = [];
    
    // ----------
    // Scheduling
    // ----------
    
    /// @func schedule(tests,[predicate])
    /// @desc Schedules a test node or a tests branch to run.
    /// @param {Struct, Array<Struct>} tests
    /// @param {Function} [predicate]
    /// @return {Undefined}
    static schedule = function(tests, predicate = undefined) {
        tests.schedule(self, predicate);
    }
    
    /// @func enqueue_test(test)
    /// @desc Adds a given test to the queue of pending tests.
    /// @param {Struct} test
    /// @return {Undefined}
    static enqueue_test = function(test) {
        array_push(pending_tests, test);
    }
    
    // -------
    // Running
    // -------
    
    /// @func run_batch()
    /// @desc Runs a batch of tests for a designated batch time.
    ///       NOTE: The actual time might be significantly longer for an especially long-running test.
    /// @return {Undefined}
    static run_batch = function() {
        var start_time = get_timer();
        var milliseconds_difference = batch_time * 1000;
        var end_time = start_time + milliseconds_difference;

        do {
            if (array_length(pending_tests) == 0)
                return;
            
            var test = pending_tests[0];
            array_delete(pending_tests, 0, 1);
            test.run();
            
            if (!is_undefined(on_test_complete))
                on_test_complete(test);
        } until (get_timer() > end_time);
    }
}