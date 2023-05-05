Overview
========

"Verrific" is an automated test framework for GameMaker. It's *planned to* support a wide range of testing scenarios and provide advanced tools for tests management.

...as of the current 0.1.0 version, it supports:
- method-based unit test definitions
- basic value and type assertions
- wrappers for string and numeric fluent assertions

It also provides a simple "log" runner that runs a given test suite, processes all its test and outputs the tests results along with their messages.

Installation
============

At the moment, you can get Verrific 0.1.0 *.yymps package from [its itch.io page](https://alphish-creature.itch.io/verrific).

To add the Verrific framework to your project, import the entire **_Packages >> Alphish >> Verrific** folder.

Additionally, you can import **Example** folder to see example tests and suites. It also has a room with Verrific log runner set up to run these example tests.

Getting started
===============

Creating example tests
----------------------

Let's write some unit tests first! Right now, only method-based test definitions are supported out of the box. There is room for implementing custom test logic by inheriting from `VerrificTest` type, but that's in the realm of advanced use. For now, let's make a type inheriting from `VerrificMethodTest` type instead:
```gml
function MyExampleTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    // tests to be added here
}
```
The `VerrificMethodTest` constructor takes two arguments. The first argument is a special test run instance; it's used by all tests for keeping track of test assertions, messages, status and the like. The second argument is specific to method-based tests, and is the name of the static method the test should run.

In method-based tests, you need to provide:
- a test subject description, as defined by static `test_subject` variable; it's used for automatically generating descriptions of individual tests and their suite
- test methods, found among static methods starting with the `should_` prefix

Let's add these to the example test type:
```gml
function MyExampleTests(_run, _method) : VerrificMethodTest(_run, _method) constructor {
    static test_subject = "My example";
    
    static should_pass_correct_assertion = function() {
        var _expected = 4;
        var _actual = 2 + 2;
        assert_equal(_expected, _actual);
    }
    
    static should_fail_incorrect_assertion = function() {
        var _expected = { x: 12, y: 34 };
        var _actual = { x: 12, y: 34 };
        assert_equal(_expected, _actual); // it fails, because those are two distinct structs with same values
    }
    
    static should_fail_with_custom_message = function() {
        var _expected = 7;
        var _actual = 2 + 2;
        var _onfailure = "Arithmetics incompatible with Trurl's Machine.";
        assert_equal(_expected, _actual, _onfailure);
    }
    
    static should_crash_and_carry_on = function() {
        throw "Keep Calm and Carry On";
    }
    
    static should_warn_about_unproven_test = function() {
        // var _expected = *still figuring out what's expected outcome here*
        var _actual = string_upper("Lorem ipsum aet cetera");
        // assert_equal(_expected, _actual)
        
        // because no assertion function is actually called throughout the text
        // the test will end with an Unproven status
    }
    
    static should_work_somehow = function() {
        // I don't care what result it gives, it not crashing is good enough for me
        var _result = string_hash_to_newline("#####");
        assert_pass(); // prevents the test being marked as Unproven
    }
}
```

Checking tests
--------------

In order to run and check your tests, you can use the Verrific log runner. For that, place an instance of **ctrl_VerrificLog** in some otherwise empty room. The log tool has a "suite" object variable, which should contain either an expression resolving to a suite itself, or an identifier of a suite constructor.

To create a suite out of `VerrificMethodTest` subtype, you need `VerrificMethodSuite`. It will automatically find all the test methods and prepare them for running.

To create a suite from **MyExampleTests** type shown earlier, you can simply call the constructor: `new VerrificMethodSuite(MyExampleTests)`
Alternatively, you can call this static method instead: `VerrificMethodSuite.from(MyExampleTests)`

Both approaches return a valid suite of method-based tests, and both expressions can be passed to the **ctrl_VerrificLog** "suite" variablle.

Grouping suites
---------------

Finally, you can group test suites together into larger suites. `VerrificSuiteGroup` type is especially useful here, as it defines methods for adding different kinds of inner suites.
- `add_methods_from(type)` will add a suite of method-based tests; it uses `VerrificMethodSuite` type internally
- `add_group(description)` will add another suite group with a given description and return it, making it work well with `with` statements

It might be useful to create a separate type inheriting from `VerrificSuiteGroup` to serve as your main suite, like so:
```gml
function MasterExampleTestSuite() : VerrificSuiteGroup("Example tests from all around") {
    with (add_group("Own tests")) {
        add_methods_from(MyExampleTests);
    }
    
    with (add_group("Everyone else's tests")) {
        add_methods_from(YourExampleTests);
        add_methods_from(TheirExampleTests);
        add_methods_from(NoonesExampleTests);
    }
}
```

Then, to run such a test suite via the Verrific log runner, you can just pass the suite's name as the "suite" object variable. The log runner will recognise it's a constructor and create a suite from it accordingly.

More information
================

Currently, there is no extensive documentation of Verrific functionality (maybe aside from many, many JSDoc comments). To get a general idea of how Verrific can be used in practice, check out the **Examples** folder as imported from the *.yymps package.
