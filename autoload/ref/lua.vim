" A ref source for clojure.
" Version: 0.1.0
" Author:  ujihisa <ujihisa at gmail com>
" License: Creative Commons Attribution 2.1 Japan License
"          <http://creativecommons.org/licenses/by/2.1/jp/deed.en>
" Todo:    * specify lua version (now it's only for 5.1)
" NOTE:    lua.html is from http://www.lua.org/manual/5.1/
"          lua.md is from lua.html with the following commands
"          $ nkf -W --in-place lua.html
"          $ pandoc --from=html --to=markdown lua.html -o lua.md

let s:save_cpo = &cpo
set cpo&vim

let g:ref_lua_cmd = 'lua'
let s:source = {'name': 'lua'}
let s:this_dirpath = expand('<sfile>:p:h')

function! s:source.available()
  return 1
endfunction

function! s:source.get_body(query)
  let mdfilepath = printf('%s/lua.md', s:this_dirpath)
  let mdfile = readfile(mdfilepath)
  let L = g:V.import('Data.List')
  return L.break(printf('v:val =~ "^### `%s "', a:query), mdfile)[1]
endfunction

function! s:source.opened(query)
  "call s:syntax()
endfunction

function! s:source.get_keyword()
  let isk = &l:iskeyword
  setlocal iskeyword+=.,:
  let keyword = expand('<cword>')
  let &l:iskeyword = isk
  return keyword
endfunction

"function! s:syntax()
"  if exists('b:current_syntax') && b:current_syntax == 'ref-clojure'
"    return
"  endif
"
"  syntax clear
"  syntax match refClojureDelimiter "^-\{25}\n" nextgroup=refClojureFunc
"  syntax match refClojureFunc "^.\+$" contained
"
"  highlight default link refClojureDelimiter Delimiter
"  highlight default link refClojureFunc Function
"
"  let b:current_syntax = 'ref-clojure'
"endfunction

function! ref#lua#define()
  return copy(s:source)
endfunction

call ref#register_detection('lua', 'lua')

let &cpo = s:save_cpo
unlet s:save_cpo
