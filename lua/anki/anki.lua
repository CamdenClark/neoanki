local curl = require('plenary.curl')
local config = require('anki.config')

local function create_note(deckName, modelName, fields, tags)
    curl.post(config.options.anki_connect.url,
        {
            headers = {
                content_type = "application/json"
            },
            body = vim.fn.json_encode(
                {
                    version = 6,
                    action = "addNote",
                    params = {
                        note = {
                            deckName = deckName,
                            modelName = modelName,
                            fields = fields,
                            tags = tags
                        }
                    }

                }),
        })
end


return {
    create_note = create_note
}
