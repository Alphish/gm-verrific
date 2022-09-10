/// @func VerrificTestBranch(branch,suite)
/// @desc Constructor for the Verrific test tree branch.
///       After creating, the branch needs to be populated using with_suite(...) method.
/// @param {Struct.VerrificTestBranch, Undefined} branch
function VerrificTestBranch(branch) constructor {
    // -----
    // Setup
    // -----
    
    self.parent = branch;
    self.subbranches = [];
    self.nodes = [];
    self.suite = undefined;
    
    self.status = VerrificRunStatus.Idle;
    self.substatuses = [
        0 /* Idle */,
        0 /* Pending */,
        0 /* Stopped */,
        0 /* Passed */,
        0 /* Unverified */,
        0 /* Failed */,
        0 /* Crashed */
        ];
    
    /// @func with_suite(suite)
    /// @desc Populates a branch from the given test suite.
    /// @param {Struct.VerrificTestSuite} suite
    /// @return {Struct.VerrificTestBranch}
    static with_suite = function(suite) {
        self.suite = suite;
        
        var suites_count = array_length(suite.suites);
        for (var i = 0; i < suites_count; i++) {
            var subbranch = create_subbranch().with_suite(suite.suites[i]);
            array_push(self.subbranches, subbranch);
        }
        
        var nodes_count = array_length(suite.tests);
        for (var i = 0; i < nodes_count; i++) {
            var node = create_node(suite.tests[i]);
            array_push(self.nodes, node);
        }
        
        return self;
    }
    
    /// @func create_subbranch()
    /// @desc Creates a nested test tree branch from a given test suite.
    ///       Can be overriden in derived test branch types.
    static create_subbranch = function() {
        return new VerrificTestBranch(self);
    }
    
    /// @func create_node(test)
    /// @desc Creates a test tree node from a given test.
    ///       Can be overriden in derived test branch types.
    /// @param {Struct.VerrificTest} test
    static create_node = function(test) {
        return new VerrificTestNode(self, test);
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
        var branches_count = array_length(self.subbranches);
        for (var i = 0; i < branches_count; i++) {
            self.subbranches[i].schedule(runner, predicate);
        }
        
        var nodes_count = array_length(self.nodes);
        for (var i = 0; i < nodes_count; i++) {
            self.nodes[i].schedule(runner, predicate);
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
        var to_recalculate = self.substatuses[status] == 0;
        self.substatuses[status]++;
        if (to_recalculate)
            self.status = recalculate_status();
        
        if (!is_undefined(self.parent))
            self.parent.add_status(status);
    }
    
    /// @func subtract_status(status)
    /// @desc Decreases the count of the given test status and possibly recalculates own overall status.
    /// @param {Real} status
    /// @return {Undefined}
    static subtract_status = function(status) {
        self.substatuses[status]--;
        var to_recalculate = self.substatuses[status] == 0;
        if (to_recalculate)
            self.status = recalculate_status();
        
        if (!is_undefined(self.parent))
            self.parent.subtract_status(status);
    }
    
    /// @ignore
    /// Internal: Recalculates the overall status based on the inner statuses counts.
    static recalculate_status = function() {
        if (self.substatuses[VerrificRunStatus.Crashed] > 0)
            return VerrificRunStatus.Crashed;
        if (self.substatuses[VerrificRunStatus.Failed] > 0)
            return VerrificRunStatus.Failed;
        if (self.substatuses[VerrificRunStatus.Unverified] > 0)
            return VerrificRunStatus.Unverified;
        if (self.substatuses[VerrificRunStatus.Stopped] > 0)
            return VerrificRunStatus.Stopped;
        if (self.substatuses[VerrificRunStatus.Pending] > 0)
            return VerrificRunStatus.Pending;
        if (self.substatuses[VerrificRunStatus.Passed] > 0)
            return VerrificRunStatus.Passed;
        else
            return VerrificRunStatus.Idle;
    }
}