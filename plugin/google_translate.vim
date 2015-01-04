"
"@file google_translate.js
"@synopsis  google translte online
"@author foding, <xiaol.ghost@gmail.com>
"@version 1.0.0
"@date 2015-01-04
"
if exists('g:google_translate_loaded')
  finish
endif
let g:google_translate_loaded = 1

function! s:_initVariable(var, value)
  if !exists(a:value)
    exec 'let ' . a:var . ' = ' . string(a:value)
  endif
endfunction

" config variable
call s:_initVariable('g:google_translate_cmd', 'node')
call s:_initVariable('g:google_translate_tl', 'zh-CN')
" key map variable
call s:_initVariable('g:google_translate_shortcut', '<leader>p')
let s:root_path = expand('<sfile>:p:h')

function! s:_getVisualSelection()
  try
    let a_save = @a
    normal! gv"ay
    return shellescape(escape(join(split(@a, "\n"), "\n"), '\'), 1)
  finally
    let @a = a_save
  endtry
endfunction

function! s:_getNormalSelection()
  return shellescape(expand("<cword>"), 1)
endfunction

function! s:_joinPath(...)
  let paths = join(a:000, '/')
  return shellescape(s:root_path . '/..' . '/' . paths, 1)
endfunction

function! s:GoogleTranslate(mode)
  if (a:mode == 'n')
    let word = s:_getNormalSelection()
  else
    let word = s:_getVisualSelection()
  endif
  let command = 'node ' . s:_joinPath('js', 'google_translate.js') . ' ' . word . ' ' . g:google_translate_tl
  let result = system(command)
  echo result
endfunction 

exe 'nn ' . g:google_translate_shortcut . " :call <SID>GoogleTranslate('n')<cr>"
exe 'vn ' . g:google_translate_shortcut . " :call <SID>GoogleTranslate('v')<cr>"
