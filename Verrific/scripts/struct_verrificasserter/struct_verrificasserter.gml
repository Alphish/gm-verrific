/// @function VerrificAsserter(message)
/// @desc Constructor for the Verrific asserter.
/// @param {Struct.VerrificTestContext} context
function VerrificAsserter(context) constructor {
    self.context = context;
    
    // ------------
    // Pass/failure
    // ------------
    
    /// @func pass()
    /// @desc Marks the test as asserted.
    /// @return {Bool}
    static pass = function() {
        context.is_asserted = true;
        return true;
    }
    
    /// @func add_failure(failure)
    /// @desc Adds a failure to the test context and marks it as failed.
    /// @return {Bool}
    static add_failure = function(failure) {
        array_push(context.failures, failure);
        context.is_failed = true;
        return false;
    }
    
    /// @func fail(message)
    /// @desc Creates an assertion failure with a given message.
    /// @param {String} message
    /// @return {Bool}
    static fail = function(message) {
        var failure = new VerrificTestFailure(message)
        return add_failure(failure);
    }
    
    // ----------
    // Assertions
    // ----------
    
    /// @func assert(condition,message)
    /// @desc Asserts that the given condition is true, otherwise fails with a given message.
    /// @param {Bool} condition
    /// @param {String} message
    /// @return {Bool}
    static assert = function(condition, message) {
        if (condition)
            return fail(message);
        else
            return pass();
    }
}
