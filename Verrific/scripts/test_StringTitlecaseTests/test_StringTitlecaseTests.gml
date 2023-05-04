function StringTitlecaseTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    static test_subject = "string_title(...)";
    
    // Tests
    
    static should_work_for_lowercase_word = function() {
        given_input("ant");
        when_processed();
        then_output().should_be("Ant");
    }
    
    static should_work_for_uppercase_word = function() {
        given_input("ELEPHANT");
        when_processed();
        then_output().should_be("Elephant");
    }
    
    static should_work_for_empty_string = function() {
        given_empty_input();
        when_processed();
        then_output().should_be_empty();
    }
    
    static should_work_for_many_words = function() {
        given_input("ant aNd ELEPHANT");
        when_processed();
        // TODO: add the assertions
    }
    
    static should_work_for_chatgpt__describe = "string_title(...) should process ChatGPT output"
    static should_work_for_chatgpt = function() {
        record_message("(should we use likely non-deterministic ChatGPT for automated tests in the first place?)");
        finish_unsure("Could not download ChatGPT output, and thus couldn't test string_title(...) on it.");
    }
    
    static should_handle_special_characters = function() {
        given_input("super-user's 100 lifehacks (and the like)");
        when_processed();
        then_output().should_be("Super-User's 100 Lifehacks (And The Like)");
    }
    
    // Helpers
    
    input = "";
    output = "";
    
    static given_input = function(_value) { input = _value; }
    static given_empty_input = function() { input = ""; }
    
    static when_processed = function() { output = string_title(input); }
    
    static then_output = function() { return new VerrificStringAssertion(test_asserter, output); }
}
