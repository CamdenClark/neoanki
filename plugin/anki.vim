command! -range=% -nargs=* AnkiCreateCloze lua require('flyboy.chat').quick_create_cloze(<f-args>)

command! -nargs=1 AnkiSwitchDeck lua require('flyboy.config').switch_deck(<f-args>)
