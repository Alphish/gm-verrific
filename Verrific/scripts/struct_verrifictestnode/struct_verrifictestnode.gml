/// @func VerrificTestNode(test)
/// @desc Constructor for the Verrific test tree node.
/// @param {Struct.VerrificTestBranch} branch
/// @param {Struct.VerrificTest} test
function VerrificTestNode(branch, test) constructor {
    self.parent = branch;
    self.test = test;
    self.result = undefined;
    self.status = VerrificRunStatus.Idle;
    
    self.parent.add_status(status);
    
    /// @func schedule(runner,predicate)
    /// @desc Schedules the test node to run within the given runner.
    /// @param {Struct.VerrificRunner} runner
    /// @param {Function} [predicate]
    /// @return {Undefined}
    static schedule = function(runner, predicate) {
        if (self.status == VerrificRunStatus.Pending || (!is_undefined(predicate) && !predicate(self)))
            return;
        
        self.parent.subtract_status(self.status);
        self.result = undefined;
        self.status = VerrificRunStatus.Pending;
        self.parent.add_status(self.status);
        runner.enqueue_test(self);
    }
    
    /// @func run()
    /// @desc Runs the underlying test and applies its result.
    /// @return {Undefined}
    static run = function() {
        self.parent.subtract_status(self.status);
        self.result = test.run();
        self.status = map_test_status(result.status);
        self.parent.add_status(status);
    }
    
    /// @ignore
    /// Internal: Maps a test result status to the runnable node status.
    static map_test_status = function(test_status) {
        switch (test_status) {
            case VerrificTestStatus.Passed:
                return VerrificRunStatus.Passed;
            case VerrificTestStatus.Unverified:
                return VerrificRunStatus.Unverified;
            case VerrificTestStatus.Failed:
                return VerrificRunStatus.Failed;
            case VerrificTestStatus.Crashed:
                return VerrificRunStatus.Crashed;
        }
    }
}