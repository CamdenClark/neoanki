local mock = require('luassert.mock')
local match = require('luassert.match')

local anki = require('anki.anki')

describe('ChatGPT call', function()
    local testCurl = require('plenary.curl')
    it('uses the correct API key and body', function()
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
end)
