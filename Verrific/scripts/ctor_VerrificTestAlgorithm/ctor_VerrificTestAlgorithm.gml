/// @desc A test algorithm determining how the test should be executed, by providing the execution method.
function VerrificTestAlgorithm() constructor {
    /// @desc Prepares resources to be used by the test.
    /// @arg {Struct.VerrificTest} test     The test to provide the execution method to.
    static init_test = function(_test) {
        // nothing by default
    }
    
    /// @desc Providers the execution method for the given test instance.
    /// @arg {Struct.VerrificTest} test     The test to provide the execution method to.
    static prepare_execute = function(_test) {
        throw VerrificException.not_implemented(self, nameof(prepare_execute));
    };
    
    /// @desc Removes any resources used by the test.
    /// @arg {Struct.VerrificTest} test     The test to provide the execution method to.
    static cleanup_test = function(_test) {
        // nothing by default
    }
}
