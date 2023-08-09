local curl = require('plenary.curl')

local function create_note(deckName, modelName, fields, tags)
    curl.post("http://localhost:8765",
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
