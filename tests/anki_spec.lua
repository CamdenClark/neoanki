local mock = require('luassert.mock')
local match = require('luassert.match')

local anki = require('anki.anki')
local config = require('anki.config')

describe('addNote on AnkiConnect', function()
    local testCurl = require('plenary.curl')
    it('uses the default AnkiConnect url', function()
        local curl = mock(testCurl, true)

        anki.create_note("Default", "Cloze", { Text = "test" }, {})

        assert.stub(curl.post).was_called_with("http://localhost:8765", match.table({
            headers = {
                ['Content-Type'] = 'application/json',
            },
            body = vim.fn.json_encode({
                version = "6",
                action = "addNote",
                params = { note = {
                    deckName = "Default",
                    modelName = "Cloze",
                    fields = { Text = "test" },
                    tags = {},
                }}
            })
        })
        )
    end)
    it('uses an updated url', function()
        local curl = mock(testCurl, true)

        config.setup({ anki_connect = { url = "http://localhost:8888" }})
        anki.create_note("Default", "Cloze", { Text = "test" }, {})

        assert.stub(curl.post).was_called_with("http://localhost:8888", match.table({
            headers = {
                ['Content-Type'] = 'application/json',
            },
            body = vim.fn.json_encode({
                version = "6",
                action = "addNote",
                params = { note = {
                    deckName = "Default",
                    modelName = "Cloze",
                    fields = { Text = "test" },
                    tags = {},
                }}
            })
        })
        )
    end)
    it('uses an updated url and api key', function()
        local curl = mock(testCurl, true)

        config.setup({ anki_connect = { url = "http://localhost:8888", api_key = "foo" }})
        anki.create_note("Default", "Cloze", { Text = "test" }, {})

        assert.stub(curl.post).was_called_with("http://localhost:8888", match.table({
            headers = {
                ['Content-Type'] = 'application/json',
            },
            body = vim.fn.json_encode({
                version = "6",
                action = "addNote",
                params = { note = {
                    deckName = "Default",
                    modelName = "Cloze",
                    fields = { Text = "test" },
                    tags = {},
                }},
                key = "foo"
            })
        })
        )
    end)
end)
