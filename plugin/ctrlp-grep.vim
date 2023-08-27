" ==============================================================
" Description:  CtrlP grep extension
" Author:       Alexander Skachko <alexander.skachko@gmail.com>
" Homepage:     https://github.com/lucerion/ctrlp-grep
" Version:      1.2.0 (2016-11-20)
" Licence:      BSD-3-Clause
" ==============================================================

if exists('g:loaded_ctrlp_grep') || &compatible || v:version < 700
  finish
endif
let g:loaded_ctrlp_grep = 1

comm! -nargs=* -complete=dir CtrlPGrep call ctrlp#grep#run(<f-args>)
