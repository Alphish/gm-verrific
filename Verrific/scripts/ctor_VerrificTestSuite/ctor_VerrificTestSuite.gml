/// @desc A test suite containing other test items.
/// @arg {String} title     The title of the test suite.
function VerrificTestSuite(_title) : VerrificTestItem(_title) constructor {
    /// @desc Indicates this test item is a test suite.
    /// @returns {Bool}
    static is_suite = true;
    
    /// @desc The test items exposed by the suite.
    /// @returns {Array<Struct.VerrificTestItem>}
    items = [];
    
    /// @desc Performs custom logic to find relevant test items automatically.
    static discover = function() {
        // nothing by default
    }
    
    /// @desc Retrieves a test item at the given index. If the index exceeds the number of items, undefined is returned.
    /// @arg {Real} idx     The index of the test item being accessed.
    /// @returns {Struct.VerrificTestItem}
    static get_item_at = function(_idx) {
        return _idx < array_length(items) ? items[_idx] : undefined;
    }
    
    /// @desc Adds the given test item to the suite and returns it.
    /// @arg {Struct.VerrificTestItem} item     The test item to add.
    /// @returns {Struct.VerrificTestItem}
    static add_item = function(_item) {
        array_push(items, _item);
        return _item;
    }
    
    /// @desc Creates and adds a new test suite with the given title.
    /// @arg {String} title                     The title of the newly created suite.
    /// @returns {Struct.VerrificTestSuite}
    static add_suite = function(_title) {
        var _suite = new VerrificTestSuite(_title);
        return add_item(_suite);
    }
    
    /// @desc Creates and adds a new callback-based test case.
    /// @arg {String} title                     The title of the newly created test case.
    /// @arg {Function} callback                The callback to execute in the test.
    /// @arg {Any} [context]                    The context the callback will be executed from; test instance by default.
    /// @returns {Struct.VerrificTestCase}
    static add_case = function(_title, _callback, _context = undefined) {
        var _case = new VerrificCallbackTestCase(_title, _callback, _context);
        return add_item(_case);
    }
}
