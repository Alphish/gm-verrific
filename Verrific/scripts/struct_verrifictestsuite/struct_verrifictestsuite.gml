/// @func VerrificTestSuite(description)
/// @desc Constructor for the Verrific test suite.
/// @param {String} description
function VerrificTestSuite(description) constructor {
    self.description = description;
    self.suites = [];
    self.tests = [];
    
    /// @func add_suite(suite)
    /// @desc Adds a given subsuite to the current suite.
    /// @param {Struct.VerrificTestSuite, Function} suite
    static add_suite = function(suite) {
        // if the given suite is not a struct
        // it's used as a parameterless constructor function instead
        if (!is_struct(suite))
            suite = new suite();
        
        array_push(suites, suite);
    }
    
    /// @func add_test(description,callback)
    /// @desc Defines a test within the current suite.
    /// @param {String} description
    /// @param {Function} callback
    static add_test = function(description, callback) {
        var test = new VerrificTest(description, callback);
        array_push(tests, test);
    }
}
