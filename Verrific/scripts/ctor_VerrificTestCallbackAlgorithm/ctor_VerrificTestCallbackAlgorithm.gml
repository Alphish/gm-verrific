/// @desc A test algorithm based on a simple callback execution.
/// @arg {Function} callback        The callback to execute in the test.
/// @arg {Any} [context]            The context the callback will be executed from; test instance by default.
function VerrificTestCallbackAlgorithm(_callback, _context = undefined) : VerrificTestAlgorithm() constructor {
    /// @ignore
    callback = _callback;
    
    /// @ignore
    context = _context;
    
    /// @desc Providers the callback execution for the given test instance.
    /// @arg {Struct.VerrificTest} test     The test to provide the callback execution to.
    static prepare_execute = function(_test) {
        return method(context ?? _test, callback);
    };
}
