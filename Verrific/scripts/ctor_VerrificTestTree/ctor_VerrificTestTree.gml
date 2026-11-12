/// @desc A test tree, exposing all the test suites and cases originating from a root test item.
function VerrificTestTree() constructor {
    /// @desc The root test node.
    /// @returns {Struct.VerrificTestNode}
    root = undefined;
    
    /// @desc Nodes of all the test suites and cases.
    /// @returns {Array<Struct.VerrificTestNode>}
    all_nodes = [];
    
    /// @desc Nodes of all the test cases.
    /// @returns {Array<Struct.VerrificTestNode>}
    test_nodes = [];
}
