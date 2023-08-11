local create = require('anki.create')
local anki = require('anki.anki')
local config = require('anki.config')
local mock = require('luassert.mock')

describe('create a cloze card', function()
    it('create a cloze card with default deck', function()
        -- Set up a fake selection, starting on line 3, column 3, and ending on line 5, column 4
        local selected_lines = { "hello world", "example", "some text", "more text here", "and here" }
        vim.api.nvim_command('enew')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, selected_lines)
        -- luacheck: ignore
        vim.fn.getpos = function(mark)
            if (mark == "'<") then
                return { 0, 2, 2 }
            else
                return { 0, 3, 7 }
            end
        end

        local create_called = false

        mock.new(anki, true)

        anki.create_note = function(deckName, modelName, fields, tags)
            assert.are.same("Default", deckName)
            assert.are.same("Cloze", modelName)
            assert.are.same({ Text = "xample\nsome t" }, fields)
            assert.are.same({}, tags)
            create_called = true
        end

        -- Call the function to create a chat from the selection
        create.quick_create_cloze()
        assert.are.same(true, create_called)
    end)
    it('creates a cloze with a different deck', function()
        -- Set up a fake selection, starting on line 3, column 3, and ending on line 5, column 4
        local selected_lines = { "hello world", "example", "some text", "more text here", "and here" }
        vim.api.nvim_command('enew')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, selected_lines)
        -- luacheck: ignore
        vim.fn.getpos = function(mark)
            if (mark == "'<") then
                return { 0, 2, 2 }
            else
                return { 0, 3, 7 }
            end
        end

        config.select_deck("Foo")
        local create_called = false

        mock.new(anki, true)

        anki.create_note = function(deckName, modelName, fields, tags)
            assert.are.same("Foo", deckName)
            assert.are.same("Cloze", modelName)
            assert.are.same({ Text = "xample\nsome t" }, fields)
            assert.are.same({}, tags)
            create_called = true
        end

        -- Call the function to create a chat from the selection
        create.quick_create_cloze()
        assert.are.same(true, create_called)
    end)
    it('creates a cloze with tags', function()
        -- Set up a fake selection, starting on line 3, column 3, and ending on line 5, column 4
        local selected_lines = { "hello world", "example", "some text", "more text here", "and here" }
        vim.api.nvim_command('enew')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, selected_lines)
        -- luacheck: ignore
        vim.fn.getpos = function(mark)
            if (mark == "'<") then
                return { 0, 2, 2 }
            else
                return { 0, 3, 7 }
            end
        end

        config.select_deck("Default")
        config.select_tags("foo bar")
        local create_called = false

        mock.new(anki, true)

        anki.create_note = function(deckName, modelName, fields, tags)
            assert.are.same("Default", deckName)
            assert.are.same("Cloze", modelName)
            assert.are.same({ Text = "xample\nsome t" }, fields)
            assert.are.same({ "foo", "bar" }, tags)
            create_called = true
        end

        -- Call the function to create a chat from the selection
        create.quick_create_cloze()
        assert.are.same(true, create_called)
    end)
end)

describe('create a basic card', function()
    it('create a basic card with default deck', function()
        config.setup()
        local selected_lines = { "hello world", "example", "===", "some text", "more text here", "and here" }
        vim.api.nvim_command('enew')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, selected_lines)
        -- luacheck: ignore
        vim.fn.getpos = function(mark)
            if (mark == "'<") then
                return { 0, 2, 0 }
            else
                return { 0, 4, 10 }
            end
        end

        local create_called = false

        mock.new(anki, true)

        anki.create_note = function(deckName, modelName, fields, tags)
            assert.are.same("Default", deckName)
            assert.are.same("Basic", modelName)
            assert.are.same({ Front = "example", Back = "some text" }, fields)
            assert.are.same({}, tags)
            create_called = true
        end

        -- Call the function to create a chat from the selection
        create.quick_create_basic()
        assert.are.same(true, create_called)
    end)
    it('create a basic card with default deck, prompting for back', function()
        config.setup()
        local selected_lines = { "hello world", "example", "===", "some text", "more text here", "and here" }
        vim.api.nvim_command('enew')
        vim.api.nvim_buf_set_lines(0, 0, -1, false, selected_lines)
        -- luacheck: ignore
        vim.fn.getpos = function(mark)
            if (mark == "'<") then
                return { 0, 2, 0 }
            else
                return { 0, 2, 8 }
            end
        end

        local create_called = false

        mock.new(anki, true)

        anki.create_note = function(deckName, modelName, fields, tags)
            assert.are.same("Default", deckName)
            assert.are.same("Basic", modelName)
            assert.are.same({ Front = "example", Back = "some text" }, fields)
            assert.are.same({}, tags)
            create_called = true
        end

        vim.fn.input = function(_)
            return "some text"
        end
        create.quick_create_basic()

        assert.are.same(true, create_called)
    end)
end)
