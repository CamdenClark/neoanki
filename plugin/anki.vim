command! -range=% -nargs=* AnkiCreateCloze lua require('anki.create').quick_create_cloze(<f-args>)
command! -range=% -nargs=* AnkiCreateBasic lua require('anki.create').quick_create_basic(<f-args>)

command! -range=% -nargs=* AnkiWrapCloze lua require('anki.create').wrap_cloze(<f-args>)

command! -nargs=1 AnkiSelectDeck lua require('anki.config').select_deck(<f-args>)
command! -nargs=1 AnkiSelectTags lua require('anki.config').select_tags(<f-args>)
