# .Files 
- sane nvim 
- cappucin Xresources 
- bashrc 


# Search list 
https://stackoverflow.com/questions/509690/how-can-you-list-the-matches-of-vims-search

Type `:lvim foo %` to search for foo in the current file and enter all matches containing foo into the location list.
Type `:lopen` to open the location list in the quickfix window, which is fully navigable as usual.
Use `:lnext`/`:lprevious` to to through the list (use tpope/unimpaired mappings for the best experience)

# Vim key map

Harpoon 
- `<leader>a` -- add to list 
- `<Ctrl>e` -- show list

Folds 
- `za` -- toggle fold


Spell check
- `:Spell`  -- spellcheck in pl, en
- `z=` -- show spelling suggestions

Undotree
- `<leader>F5` -- toogle  

[Comments](https://github.com/terrortylor/nvim-comment?tab=readme-ov-file#usage)
## Running node based LSP

Nodejs from ubuntu repository is too old to run most lsps.
[Docker compose lsp](https://github.com/microsoft/compose-language-service) for sure.
For some unknown reason only node from this [repo](https://github.com/nodesource/distributions?tab=readme-ov-file#installation-instructions) 

## Plant-uml 

ubuntu deps 

`sudo apt install libimlib2-dev libexif-dev x11-common plantuml libxft-dev`

## Language tool 
` languagetool org.languagetool.server.HTTPServer --port 8081 --allow-origin &` 
