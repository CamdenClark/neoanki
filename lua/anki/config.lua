local M = {}

local defaults = {
    deckName = "Default",
    tags = {},
    anki_connect = { url = "http://localhost:8765", token = nil },
}

M.options = {}

function M.setup(options)
    M.options = vim.tbl_deep_extend("force", {}, defaults, options or {})
end

function M.select_deck(deckName)
    M.options.deckName = deckName
end

function M.select_tags(tags_string)
    local tags = {}
    for tag in tags_string:gmatch("%S+") do
        table.insert(tags, tag)
    end
    M.options.tags = tags
end

M.setup()

return M
