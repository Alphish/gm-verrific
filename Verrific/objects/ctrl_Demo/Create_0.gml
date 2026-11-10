var _cases = [
    new VerrificCallbackTestCase("2 + 2 = 4", function() { assert_that(2 + 2 == 4); }),
    new VerrificCallbackTestCase("2 + 2 = 5", function() { assert_that(2 + 2 == 5); }),
    new VerrificCallbackTestCase("2 + 2 = ...", function() { var _value = 2 + 2; }),
    new VerrificCallbackTestCase("42 + apples = ...", function() { var _value = 42 + "apples"; }),
    new VerrificCallbackTestCase("verified", function() { assert_confirm(); }),
    new VerrificCallbackTestCase("autofailed", function() { assert_fail("Bad things happened."); }),
    new VerrificCallbackTestCase("donotrun", function() {}),
];

var _result_runs = array_map(_cases, function(_case) {
    var _run = _case.create_test_run();
    if (_case.title == "donotrun")
        return _run;
    
    try {
        _run.init();
        _run.process_step();
    } catch (_exception) {
        _run.handle_exception(_exception);
    }
    
    _run.prepare_update();
    _run.cleanup(true);
    return _run;
});

array_foreach(_result_runs, function(_run) {
    show_debug_message(_run.status.title);
    if (!is_undefined(_run.failures))
        array_foreach(_run.failures, show_debug_message);
    if (!is_undefined(_run.error))
        show_debug_message(_run.error.message);
});
