function ApproachTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    static test_subject = "approach(...)";
    
    // Tests
    
    static should_work_for_positive_change = function() {
        given_current(5);
        given_target(10);
        when_calculated();
        then_result().should_be(6);
    }
    
    static should_work_for_negative_change = function() {
        given_current(5);
        given_target(0);
        when_calculated();
        then_result().should_be(4);
    }
    
    static should_handle_different_amount = function() {
        given_current(5);
        given_target(10);
        given_amount(3)
        when_calculated();
        then_result().should_be(8);
    }
    
    static should_handle_final_step = function() {
        given_current(5);
        given_target(5.5);
        when_calculated();
        then_result().should_be(5.5);
    }
    
    static should_handle_wordy_numbers = function() {
        given_current("five");
        given_target(10);
        when_calculated();
        then_result().should_be(6);
    }
    
    // Helpers
    
    current = NaN;
    target = NaN;
    amount = 1;
    
    result = NaN;
    
    static given_current = function(_value) { current = _value; }
    static given_target = function(_value) { target = _value; }
    static given_amount = function(_value) { amount = _value; }
    
    static when_calculated = function() { result = approach(current, target, amount); }
    
    static then_result = function() { return new VerrificNumericAssertion(test_asserter, result); }
}
