/// @desc Builds a test tree from the given root item; if it's a test suite, creates a tree of all its nested suites and test cases.
/// @arg {Struct.VerrificTestItem} root        The root test item (suite or case).
function VerrificTestDiscoverer(_root) constructor {
    /// @desc The test tree whose tests are being discovered.
    /// @returns {Struct.VerrificTestTree}
    test_tree = new VerrificTestTree();
    
    /// @desc The test item (suite or case) from which the test tree is built.
    /// @returns {Struct.VerrificTestItem}
    root_item = _root;
    
    /// @ignore
    processed_suites = [];
    
    /// @ignore
    processed_indices = [];
    
    /// @ignore
    processed_depth = -1;
    
    /// @desc The status of the test discovery - true if completed, false if not.
    /// @returns {Bool}
    status = false;
    
    /// @desc The test tree once discovered, or undefined if it's still in progress.
    /// @returns {Struct.VerrificTestTree}
    result = undefined;
    
    /// @desc The error encountered during test discovery.
    /// @returns {Any}
    error = undefined;
    
    // ----------
    // Processing
    // ----------
    
    /// @desc Initialises the test tree with its root item.
    static init = function() {
        // add the root as the first item in the tree
        handle_test_item(root_item, /* parent */ undefined);
    }
    
    /// @desc Processes the next test item. Returns whether the discovery has finished (true) or not (false).
    /// @returns {Bool}
    static process_step = function() {
        if (status)
            return true;
        
        var _suite_node = processed_suites[processed_depth];
        var _suite = _suite_node.test_item;
        var _idx = processed_indices[processed_depth]++;
        var _item = _suite.get_item_at(_idx);
        
        if (!is_undefined(_item)) {
            handle_test_item(_item, _suite_node);
            return false;
        } else {
            pop_suite();
            return try_complete();
        }
    }
    
    /// @ignore
    static handle_test_item = function(_item, _parent) {
        var _node = new VerrificTestNode(_item).linked_to(test_tree, _parent);
        if (_node.test_item.is_suite) {
            _item.discover();
            push_suite(_node);
        }
    }
    
    /// @ignore
    static push_suite = function(_node) {
        array_push(processed_suites, _node);
        array_push(processed_indices, 0);
        processed_depth++;
    }
    
    /// @ignore
    static pop_suite = function() {
        array_pop(processed_suites);
        array_pop(processed_indices);
        processed_depth--;
    }
    
    /// @ignore
    static try_complete = function() {
        if (processed_depth >= 0)
            return false;
        
        status = true;
        result = test_tree;
        return true;
    }
    
    /// @desc Indicates whether the test discovery has finished.
    /// @returns {Bool}
    static is_finished = function() {
        return status;
    }
    
    /// @ignore
    static cleanup = function() {
        // do nothing
    }
}
