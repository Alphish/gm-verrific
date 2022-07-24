/// @func VerrificTestBranch(branch,suite)
/// @desc Constructor for the Verrific test tree branch.
/// @param {Struct.VerrificTestBranch, Undefined} branch
/// @param {Struct.VerrificTestSuite} suite
function VerrificTestBranch(branch, suite) constructor {
    // -----
    // Setup
    // -----
    
    self.parent = branch;
    self.suite = suite;
    self.subbranches = [];
    self.nodes = [];
    self.status = VerrificRunStatus.Idle;
    self.substatuses = [0 /* Idle */, 0 /* Pending */, 0 /* Stopped */, 0 /* Passed */, 0 /* Unverified */, 0 /* Failed */, 0 /* Crashed */];
    
    build_subbranches(suite.suites);
    build_nodes(suite.tests);
    
    /// @ignore
    /// Internal: Builds inner test branches from the given test suites.
    static build_subbranches = function(suites) {
        var count = array_length(suites);
        for (var i = 0; i < count; i++) {
            var subbranch = new VerrificTestBranch(self, suites[i]);
            array_push(subbranches, subbranch);
        }
    }
    
    /// @ignore
    /// Internal: Builds test nodes from the given tests.
    static build_nodes = function(tests) {
        var count = array_length(tests);
        for (var i = 0; i < count; i++) {
            var node = new VerrificTestNode(self, tests[i]);
            array_push(nodes, node);
        }
    }
    
    // ----------
    // Scheduling
    // ----------
    
    /// @func schedule(runner,predicate)
    /// @desc Schedules the inner branches/nodes to run within the given runner.
    /// @param {Struct.VerrificRunner} runner
    /// @param {Function} [predicate]
    /// @return {Undefined}
    static schedule = function(runner, predicate) {
        var branches_count = array_length(subbranches);
        for (var i = 0; i < branches_count; i++) {
            subbranches[i].schedule(runner, predicate);
        }
        
        var nodes_count = array_length(nodes);
        for (var i = 0; i < nodes_count; i++) {
            nodes[i].schedule(runner, predicate);
        }
    }
    
    // ------
    // Status
    // ------
    
    /// @func add_status(status)
    /// @desc Increases the count of the given test status and possibly recalculates own overall status.
    /// @param {Real} status
    /// @return {Undefined}
    static add_status = function(status) {
        var to_recalculate = substatuses[status] == 0;
        substatuses[status]++;
        if (to_recalculate)
            self.status = recalculate_status();
        
        if (!is_undefined(parent))
            parent.add_status(status);
    }
    
    /// @func subtract_status(status)
    /// @desc Decreases the count of the given test status and possibly recalculates own overall status.
    /// @param {Real} status
    /// @return {Undefined}
    static subtract_status = function(status) {
        substatuses[status]--;
        var to_recalculate = substatuses[status] == 0;
        if (to_recalculate)
            self.status = recalculate_status();
        
        if (!is_undefined(parent))
            parent.subtract_status(status);
    }
    
    /// @ignore
    /// Internal: Recalculates the overall status based on the inner statuses counts.
    static recalculate_status = function() {
        if (substatuses[VerrificRunStatus.Stopped] > 0)
            return VerrificRunStatus.Stopped;
        if (substatuses[VerrificRunStatus.Crashed] > 0)
            return VerrificRunStatus.Crashed;
        if (substatuses[VerrificRunStatus.Failed] > 0)
            return VerrificRunStatus.Failed;
        if (substatuses[VerrificRunStatus.Unverified] > 0)
            return VerrificRunStatus.Unverified;
        if (substatuses[VerrificRunStatus.Pending] > 0)
            return VerrificRunStatus.Pending;
        if (substatuses[VerrificRunStatus.Passed] > 0)
            return VerrificRunStatus.Passed;
        else
            return VerrificRunStatus.Idle;
    }
}