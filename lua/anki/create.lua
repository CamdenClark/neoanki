local anki = require('anki.anki')
local config = require('anki.config')

local function get_visual_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    local start_line, start_col = start_pos[2], start_pos[3]
    local end_line, end_col = end_pos[2], end_pos[3]

    local buffer = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buffer, start_line - 1, end_line, false)

    -- Modify the first line to start at the correct column
    lines[1] = lines[1]:sub(start_col)

    -- Modify the last line to end at the correct column
    lines[#lines] = lines[#lines]:sub(1, end_col - 1)

    -- Join the lines into a single string
    return table.concat(lines, "\n")
end

local function quick_create_cloze()
    local visual_selection = get_visual_selection()

    local fields = { Text = visual_selection }

    anki.create_note(
        config.options.deckName,
        "Cloze",
        fields,
        config.options.tags)
end

local function quick_create_basic()
    local visual_selection = get_visual_selection()
    local parts = {}
    for part in visual_selection:gmatch("([^===]+)") do
        table.insert(parts, part:match("^%s*(.-)%s*$"))
    end
    local front = parts[1] or ''
    local back = parts[2] or ''

    if back == '' then
      back = vim.fn.input('Enter the back text: ')
    end
    local fields = { Front = front, Back = back }

    anki.create_note(
        config.options.deckName,
        "Basic",
        fields,
        config.options.tags)
end

local function wrap_cloze(number)
    if not (number) then
        number = "1"
    end
    local save_reg = vim.fn.getreg('"')
    local save_regtype = vim.fn.getregtype('"')
    vim.cmd('normal! gvy')
    local selection = vim.fn.getreg('"')
    vim.fn.setreg('"', '{{c' .. number .. '::' .. selection .. '}}')
    vim.cmd('normal! gvp')
    vim.fn.setreg('"', save_reg, save_regtype)
end

return {
    quick_create_cloze = quick_create_cloze,
    quick_create_basic = quick_create_basic,
    wrap_cloze = wrap_cloze
}
