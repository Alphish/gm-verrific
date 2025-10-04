function RangeTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    static test_subject = "array_create_range(...)";
    
    // Tests
    
    static should_work_somewhat = function() {
        given_from(1);
        given_count(3);
        given_step(2);
        
        when_calculated();
        
        then_result().should_be_empty()
            .should_have_count(2).should_have_count(3).should_have_count(4)
            .should_equal_array([1, 3, 5]).should_equal_array([1, 2, 3]).should_equal_array([1])
            .should_equal_items(1, 3, 5).should_equal_items(1, 3, 5, 7, 9);
    }
    
    // Helpers
    
    range_from = undefined;
    range_count = undefined;
    range_step = undefined;
    
    result = undefined;
    
    static given_from = function(_value) { range_from = _value; }
    static given_count = function(_value) { range_count = _value; }
    static given_step = function(_value) { range_step = _value; }
    
    static when_calculated = function() {
        if (is_undefined(range_step))
            result = array_create_range(range_from, range_count);
        else
            result = array_create_range(range_from, range_count, range_step);
    }
    
    static then_result = function() {
        return new VerrificArrayAssertion(test_asserter, result);
    }
}
