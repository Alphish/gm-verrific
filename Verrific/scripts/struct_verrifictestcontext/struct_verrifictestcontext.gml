/// @func VerrificTestContext()
/// @desc Constructor for the Verrific test context.
function VerrificTestContext() constructor {
    self.is_asserted = false;
    self.is_failed = false;
    self.failures = [];
    self.asserter = new VerrificAsserter(self);
    
    // ------
    // Basics
    // ------
    
    /// @func pass()
    /// @desc Marks the test as asserted.
    /// @return {Bool}
    static pass = function() {
        return self.asserter.pass();
    }
    
    /// @func fail(message)
    /// @desc Creates an assertion failure with a given message.
    /// @param {String} message
    /// @return {Bool}
    static fail = function(message) {
        return self.asserter.fail(message);
    }
    
    /// @func assert(condition,message)
    /// @desc Asserts that the given condition is true, otherwise fails with a given message.
    /// @param {Bool} condition
    /// @param {String} message
    /// @return {Bool}
    static assert = function(condition, message) {
        return self.asserter.assert(condition, message);
    }
}
