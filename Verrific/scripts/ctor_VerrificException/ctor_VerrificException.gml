/// @desc An exception to be thrown due to invalid Verrific usage.
/// @arg {String} code              The code of the exception to differentiate between different exception causes.
/// @arg {String} description       A detailed description explaining the exception.
function VerrificException(_code, _description) constructor {
    /// @desc The code of the exception to differentiate between different exception causes.
    /// @type {String}
    code = _code;
    
    /// @desc A detailed description explaining the exception.
    /// @type {String}
    description = _description;
    
    toString = function() {
        return $"Verrific.{code}: {description}";
    }
}

/// @desc Creates a Verrific method not implemented exception, thrown from base methods to be implemented in derived type.
/// @arg {Struct} context               The instance whose method was not implemented.
/// @arg {String} method                The name of method that requires implementation in the derived type.
/// @returns {Struct.VerrificException}
VerrificException.not_implemented = function(_context, _method) {
    return new VerrificException(
        nameof(not_implemented),
        $"{instanceof(_context)}.{_method} was not implemented."
        );
}

/// @desc Creates a Verrific no test algorithm exception, thrown from a test when it requires algorithm but has none.
/// @arg {Struct.VerrificTest} test     The test with no algorithm setup.
/// @returns {Struct.VerrificException}
VerrificException.test_no_algorithm = function(_test) {
    return new VerrificException(
        nameof(test_no_algorithm),
        $"The test {_test} has not been setup with any algorithm."
        );
}
