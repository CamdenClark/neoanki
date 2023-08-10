command! -range=% -nargs=* AnkiCreateCloze lua require('anki.create').quick_create_cloze(<f-args>)

command! -range=% -nargs=* AnkiNewCloze lua require('anki.create').wrap_cloze(<f-args>)

command! -nargs=1 AnkiSwitchDeck lua require('anki.config').switch_deck(<f-args>)
