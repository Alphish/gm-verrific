function TestableUtilsSuite() : VerrificSuiteGroup("Testable utils tests") constructor {
    with (add_group("String utils")) {
        add_methods_from(StringSplitUppercaseTests);
        add_methods_from(StringTitlecaseTests);
    }
    
    with (add_group("Math utils")) {
        add_methods_from(ApproachTests);
    }
    
    with (add_group("Array utils")) {
        add_methods_from(RangeTests);
    }
}
