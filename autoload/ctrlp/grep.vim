" ==============================================================
" Description:  CtrlP grep extension
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/ctrlp-grep
" Version:      1.2.0 (2016-11-20)
" Licence:      BSD-3-Clause
" ==============================================================

call add(g:ctrlp_ext_vars, {
  \ 'init': 'ctrlp#grep#init()',
  \ 'accept': 'ctrlp#grep#accept',
  \ 'lname': 'grep',
  \ 'sname': 'grep',
  \ 'type': 'line',
  \ 'opmul': 1
  \ })

func! ctrlp#grep#run(...) abort
  let l:cmd = get(g:, 'ctrlp_grep_command', 'grep -rins')
  let l:pattern = get(a:000, 0, expand('<cword>'))
  let l:dirs = a:0 > 1 ? join(a:000[1:-1]) : '.'
  let s:result = system(l:cmd . ' ' . l:pattern . ' ' . l:dirs)
  call ctrlp#init(ctrlp#grep#id())
endfunc

func! ctrlp#grep#init() abort
  return split(s:result, "\n")
endfunc

func! ctrlp#grep#id() abort
  return g:ctrlp_builtins + len(g:ctrlp_ext_vars)
endfunc

func! ctrlp#grep#accept(mode, str) abort
  let l:marked_list = ctrlp#getmarkedlist()

  if empty(l:marked_list)
    let l:marked_list = [a:str]
  endif

  for l:marked in l:marked_list
    let l:splited = split(l:marked, ':')
    if len(l:splited[0]) == 1
      " Windows absolute path
      let l:file_path = join(l:splited[0:1], ':')
      let l:line_no = l:splited[2]
    else
      let l:file_path = l:splited[0]
      let l:line_no = l:splited[1]
    endif
    call ctrlp#acceptfile(a:mode, l:file_path, l:line_no)
  endfor
endfunc
