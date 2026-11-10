/// @desc A test status information.
/// @arg {String} code          The code character associated with the status.
/// @arg {String} title         The title of the status.
/// @arg {String} desc          The description explaining the status.
/// @arg {Bool} final           Indicates whether the status matches a finished test or not.
function VerrificStatus(_code, _title, _desc, _final) constructor {
    static statuses_by_code = {};
    
    statuses_by_code[$ _code] = self;
    
    /// @desc The code character associated with the status.
    /// @returns {String}
    code = _code;
    
    /// @desc The title of the status.
    /// @returns {String}
    title = _title;
    
    /// @desc The description explaining the status.
    /// @returns {String}
    desc = _desc;
    
    /// @desc Indicates whether the status matches a finished test or not.
    /// @returns {Bool}
    is_final = _final;
    
    static toString = function() {
        return title;
    }
}

/// @desc Indicates the test has been scheduled for eventual execution.
/// @returns {Struct.VerrificStatus}
VerrificStatus.Scheduled = new VerrificStatus("Q" /* as in Queued */, "Scheduled", "The test has been scheduled.", /* final */ false);

/// @desc Indicates the test has passed successfully.
/// @returns {Struct.VerrificStatus}
VerrificStatus.Passed = new VerrificStatus("P", "Passed", "The test has passed successfully.", /* final */ true);

/// @desc Indicates the test has finished without any failures, but also no assertions/confirmations.
/// @returns {Struct.VerrificStatus}
VerrificStatus.Unverified = new VerrificStatus("U", "Unverified", "The test has finished without any assertion/confirmation. It may not have been implemented.", /* final */ true);

/// @desc Indicates the test has failed one or more assertions.
/// @returns {Struct.VerrificStatus}
VerrificStatus.Failed = new VerrificStatus("F", "Failed", "The test has failed one or more assertions.", /* final */ true);

/// @desc Indicates the test has thrown an exception during its execution.
/// @returns {Struct.VerrificStatus}
VerrificStatus.Crashed = new VerrificStatus("X" /* as in X_X */, "Crashed", "The test has thrown an exception.", /* final */ true);

/// @desc Retrieves a Verrific test status by its code.
/// @arg {String} code          The code to find the status by.
/// @returns {Struct.VerrificStatus}
VerrificStatus.get_by_code = function(_code) {
    return VerrificStatus.statuses_by_code[$ _code];
}
