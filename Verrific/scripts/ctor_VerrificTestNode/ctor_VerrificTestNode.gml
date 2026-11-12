/// @desc A test tree node corresponding to the given test item.
/// @arg {Struct.VerrificTestItem} item     The test item the node represents.
function VerrificTestNode(_item) constructor {
    /// @desc The test item the node represents.
    /// @returns {Struct.VerrificTestItem}
    test_item = _item;
    
    /// @desc The test tree the node belongs to.
    /// @returns {Struct.VerrificTestTree}
    test_tree = undefined;
    
    /// @desc The index of the node in its test tree.
    /// @returns {Real}
    node_index = -1;
    
    /// @desc For test case nodes, it's the index of the node in the tree test cases. For test suite nodes, it's the test index of its first test case node.
    /// @returns {Real}
    test_index = -1;
    
    /// @desc The parent test node.
    /// @returns {Struct.VerrificTestNode}
    parent = undefined;
    
    /// @desc The number of ancestors the node has in its tree.
    /// @returns {Real}
    depth = 0;
    
    /// @desc The index of the node in its parent's children.
    /// @returns {Real}
    child_index = -1;
    
    /// @desc The node children. For test case nodes, it's undefined.
    /// @returns {Array<Struct.VerrificTestNode>}
    children = test_item.is_suite ? [] : undefined;
    
    /// @desc Links the given test node to its test tree and parent.
    /// @arg {Struct.VerrificTestTree} tree         The tree the test node belongs to.
    /// @arg {Struct.VerrificTestNode} parent       The parent of the test node (undefined for the test tree root).
    /// @returns {Struct.VerrificTestNode}
    static linked_to = function(_tree, _parent) {
        test_tree = _tree;
        
        node_index = array_length(_tree.all_nodes);
        array_push(_tree.all_nodes, self);
        
        test_index = array_length(_tree.test_nodes);
        if (!test_item.is_suite)
            array_push(_tree.test_nodes, self);
        
        if (is_undefined(_parent)) {
            _tree.root = self;
        } else {
            parent = _parent;
            depth = parent.depth + 1;
            child_index = array_length(parent.children);
            array_push(parent.children, self);
        }
        return self;
    }
}