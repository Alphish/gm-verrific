function StringSplitUppercaseTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    static test_subject = "string_split_uppercase(...)";
    
    // Tests
    
    static should_work_for_lowercase_word = function() {
        given_input("ant");
        when_processed();
        then_output().should_be("ant");
    }
    
    static should_work_for_uppercase_word = function() {
        given_input("ELEPHANT");
        when_processed();
        then_output().should_be("E|L|E|P|H|A|N|T");
    }
    
    static should_work_for_camelcase__describe = "should work for camelCase";
    static should_work_for_camelcase = function() {
        given_input("camelCase");
        when_processed();
        then_output().should_be("camel|Case");
    }
    
    static should_work_for_pascalcase__describe = "should work for PascalCase";
    static should_work_for_pascalcase = function() {
        given_input("PascalCase");
        when_processed();
        then_output().should_be("Pascal|Case");
    }
    
    static should_return_one_of_valid_combinations = function() {
        given_input("SomeThingOrAnother");
        when_processed();
        then_output().should_be_one_of(["Some|Thing", "Other|Thing", "Some|Thing|Or|Another"]);
    }
    
    // Helpers
    
    input = "";
    output = "";
    
    static given_input = function(_value) { input = _value; }
    static given_empty_input = function() { input = ""; }
    
    static when_processed = function() {
        // I have yet to handle array assertions, so I use a joined string for now
        var _split = string_split_uppercase(input);
        output = string_join_ext("|", _split);
    }
    
    static then_output = function() { return new VerrificStringAssertion(test_asserter, output); }
}
