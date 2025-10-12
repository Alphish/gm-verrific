function StructTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    static test_subject = "some struct";
    
    // Tests
    
    static should_work_somewhat = function() {
        var _assertion = new VerrificStructAssertion(test_asserter, { lorem: 123, ipsum: 456, dolor: 789 });
        
        _assertion.should_have_entry("lorem", 123)
            .should_have_entry("ipsum", 456)
            .should_have_entry("dolor", 78)
            .should_have_entry("sit", 0)
            .should_equal_struct({ lorem: 123, ipsum: 456, dolor: 789 })
            .should_equal_struct({ lorem: 123, ipsum: 45, sit: 789 });
    }
}
