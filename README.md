# Templ for vim

Vim config for editing [templ](https://github.com/a-h/templ) files in vim.

This plugin integrates with [ALE](https://github.com/dense-analysis/ale) and
[vim-go](https://github.com/fatih/vim-go) to support Templ LSP and auto-formatter.

Features:
* Syntax highlighting
* Indentation that matches Go indent rules
* Support commenting with [tcomment_vim](https://github.com/tomtom/tcomment_vim)
* Go to definition from Go files to Templ files (requires `ALE` and `vim-go`)

This plugin was originally forked from [joerdav/templ.vim](https://github.com/joerdav/templ.vim).

## Install

To install with [vim-plug](https://github.com/junegunn/vim-plug), add to your `.vimrc`:

```vim
Plug 'iefserge/templ.vim'
```

## Using Templ with ALE

This plugin integrates with [ALE](https://github.com/dense-analysis/ale) and
[vim-go](https://github.com/fatih/vim-go) to support Templ LSP and auto-formatter.

Enable `templ` linter (or add this to your existing linters):

```vim
let g:ale_linters = {
  \  'templ': ['templ'],
  \}
```

To enable format on save, enable `templfmt` fixer and `ale_fix_on_save` flag:

```vim
let g:ale_fixers = {'templ': ['templfmt']}
let g:ale_fix_on_save = 1
```

Add ALE keybindings and override "Go to Definition" for Go files:

```vim
augroup ale_keybindings
autocmd!
  autocmd FileType * nmap <buffer> gd :ALEGoToDefinition<CR>
  autocmd FileType * nmap <buffer> gr :ALEFindReferences<CR>
  autocmd FileType * nmap <buffer> gi :ALEGoToImplementation<CR>
  autocmd FileType * nmap <buffer> gt :ALEGoToTypeDefinition<CR>
  autocmd FileType * nmap <buffer> K :ALEHover<CR>
  autocmd FileType * nmap <buffer> <leader>rn :ALERename<CR>
  autocmd FileType * nmap <buffer> <leader>ca :ALECodeAction<CR>
  autocmd FileType * nmap <buffer> [d :ALEPrevious<CR>
  autocmd FileType * nmap <buffer> ]d :ALENext<CR>
  autocmd FileType * nmap <buffer> <leader>f :ALEFix<CR>
  " Go override (go -> templ)
  autocmd FileType go nmap <buffer> gd :call TemplGoToDefinition()<CR>
augroup END
```
