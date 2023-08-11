# neoanki

Neoanki is a Neovim plugin that facilitates quickly creating notes
in Anki using the AnkiConnect plugin.

## Requirements

1. Anki must be started, and you must install the 
[AnkiConnect](https://ankiweb.net/shared/info/2055492159) plugin

2. Have curl installed on your machine

3. Install `plenary.nvim` and `neoanki` using your package manager:

For example, using plug

```vim
Plug 'nvim-lua/plenary.nvim'
Plug 'CamdenClark/neoanki'
```

## Creating a cloze note

Let's say you have the following sentence in a buffer:

```
The Eiffel Tower is in the city of Paris
```

You can either manually add a cloze here, or you can select part of the 
text in visual mode and call `:AnkiWrapCloze`:

```
The Eiffel Tower is in the city of {{c1::Paris}}
```

Then, you can highlight the entire sentence in visual mode, and call `:AnkiCreateCloze`.

This will create a cloze note with that text.

## Creating a basic note

Let's say you have the following sentence in a buffer:

```
Where is the Eiffel Tower?
```

You can highlight the entire sentence in visual mode, and call `:AnkiCreateBasic`.

Neovim will prompt you for the back, where you can type in `Paris`.
This will create a basic note with that Front and Back text.

### Alternative basic note creation

Alternatively you can create a basic note in one go by typing out this:

```
Where is the Eiffel Tower?
===
Paris
```

You can highlight all three lines in visual mode, and call `:AnkiCreateBasic`.
This will skip the prompting step and allow you to directly create a note.

## Configuration

Here is how you configure options for neoanki. What's shown is the defaults:

```lua
require('anki.config').setup({
  deckName = "Default",
  anki_connect = { url = "http://localhost:8765", api_key = nil },
  tags = {}
})
```


## Development

### Run tests

Running tests requires [plenary.nvim][plenary] to be checked out in the parent directory of _this_ repository.
You can then run:

```bash
just test
```

or, more verbose:

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"
```

Or if you want to run a single test file:

```bash
just test chat_spec.lua
```

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/path_to_file.lua {minimal_init = 'tests/minimal.vim'}"
```

Read the [nvim-lua-guide][nvim-lua-guide] for more information on developing neovim plugins.

[nvim-lua-guide]: https://github.com/nanotee/nvim-lua-guide
[plenary]: https://github.com/nvim-lua/plenary.nvim
