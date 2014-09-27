" vim plugin file
" Filename:     setscroll.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/<VIMREPO>/blob/master/LICENSE

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_setscroll')
    finish
endif
let loaded_setscroll = 1

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" constants {{{2
let s:scroll_height_default = 3
lockvar s:scroll_height_default

" functions {{{2
" escape to get an error when the specified 'scroll' value is less than the
" window height.
function! s:SetlocalScroll()
    " a default setting
    let scroll_height = s:scroll_height_default

    " from the user definition
    if exists('g:scroll_height')
        if type(g:scroll_height) != 0
            throw 'g:scroll_height must be Number.'
        endif
        let scroll_height = g:scroll_height
    endif

    " when the new value for 'scroll' is larger than window height
    let current_window_height = winheight(0)
    if current_window_height < scroll_height
        let scroll_height = 0
    endif

    let &l:scroll = scroll_height
endfunction

" autocmds {{{2
augroup setscroll
    autocmd! setscroll

    autocmd! WinEnter,VimResized * call s:SetlocalScroll()
augroup END

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
