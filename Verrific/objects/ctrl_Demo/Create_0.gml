var _main_suite = new VerrificTestSuite("All tests");
with (_main_suite) {
    with (add_suite("Good suite")) {
        add_case("2 + 2 = 4", function() { assert_that(2 + 2 == 4); });
        add_case("verified", function() { assert_confirm(); });
    }
    
    with (add_suite("Bad suite")) {
        add_case("2 + 2 = 5", function() { assert_that(2 + 2 == 5); });
        add_case("42 + apples = ...", function() { var _value = 42 + "apples"; });
        add_case("autofailed", function() { assert_fail("Bad things happened."); });
    }
    
    add_case("2 + 2 = ...", function() { var _value = 2 + 2; });
    add_case("donotrun", function() {});
}

var _discoverer = new VerrificTestDiscoverer(_main_suite);
_discoverer.init();
while (!_discoverer.process_step()) {}

var _test_tree = _discoverer.result;
array_foreach(_test_tree.all_nodes, function(_node) {
    var _indent = string_repeat("  ", _node.depth);
    var _header = _indent + _node.test_item.title;
    if (_node.test_item.is_suite) {
        show_debug_message(_header);
        return;
    }
    
    var _run = _node.test_item.create_test_run();
    if (_node.test_item.title != "donotrun") {
        try {
            _run.init();
            _run.process_step();
        } catch (_exception) {
            _run.handle_exception(_exception);
        }
        _run.prepare_update();
        _run.cleanup(true);
    }
    
    show_debug_message($"{_header}: {_run.status.title}");
    if (!is_undefined(_run.failures))
        with ({ indent: _indent }) array_foreach(_run.failures, function(_failure) { show_debug_message(indent + "  " + _failure); });
    if (!is_undefined(_run.error))
        with ({ indent: _indent }) show_debug_message(indent + "  " + _run.error.message);
});
