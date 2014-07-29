scriptencoding utf-8
"【注意】
"   Kaoriya版のvimを使っている場合は $VIM/.gvimrc が先に読み込まれる(.vimrcも同様)
"   $VIM/.gvimrcを無効にするには $VIM/gvimrc_local.vimに
"     let g:gvimrc_local_finish = 1
"   を書いておけばよい
" 参考
"   ぼちぼち散歩 MacVim-Kaoriyaでデフォルトのvimrcとgvimrcを読まないようにする
"   http://relaxedcolumn.blog8.fc2.com/blog-entry-153.html

"----------------------------------------
" システム設定
"----------------------------------------
"エラー時の音とビジュアルベルの抑制。
set noerrorbells
set novisualbell
set visualbell t_vb=

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キー
    "set imactivatekey=C-space
  endif
endif

"マウスを有効にする。
if has('mouse')
  set mouse=a
endif

"----------------------------------------
" 表示設定
"----------------------------------------
" 英語メニュー
"set langmenu=en
" ツールバーを非表示
"set guioptions-=T
" コマンドラインの高さ
"set cmdheight=2

" カラー設定:
" 共通の色テーマは.vimrcで指定すること
"colorscheme mycolor
"colorscheme slate
"colorscheme molokai
"colorscheme solarized

" 何故か？？？vimrcのhighlight設定が読み込まれない？？？
" コメントがちょっと暗めなので明るくしておく
"highlight Comment term=bold ctermfg=11 guifg=grey70


" フォント設定
set linespace=1
if has('win32') || has('win64')
"  set guifont=MeiryoKe_Console:h9:cSHIFTJIS
"  set guifontwide=MeiryoKe_Console:h9:cSHIFTJIS
  "set guifont=Ricty:h13.5:cDEFAULT
  "set guifontwide=Ricty:h13.5:cDEFAULT
  set guifont=Ricty:h13.5:cSHIFTJIS
  set linespace=0
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  set guifontset=a14,r14,k14
  set linespace=0
else
endif

" 透明スケスケにはしない
"set transparency=-1

"メッセージの日本語化
"let $LANG='ja'

""""""""""""""""""""""""""""""
" Window位置の保存と復帰
""""""""""""""""""""""""""""""
if 1 && has('gui_running')
  if has('unix')
    let s:infofile = '~/.vim/.vimpos'
  else
    let s:infofile = '~/_vimpos'
  endif

  function! s:WinPosSizeSave(filename)
    let saved_reg = @a
    redir @a
    winpos
    redir END
    let px = substitute(@a, '.*X \(\d\+\).*', '\1', '') + 0
    let py = substitute(@a, '.*Y \(\d\+\).*', '\1', '') + 0
    execute 'redir! >'.a:filename
    if px > 0 && py > 0
      echo 'winpos '.px.' '.py
    endif
    echo 'set lines='.&lines.' columns='.&columns
    redir END
    let @a = saved_reg
  endfunction

  augroup WinPosSizeSaver
  autocmd!
  augroup END
  execute 'autocmd WinPosSizeSaver VimLeave * call s:WinPosSizeSave("'.s:infofile.'")'
  if filereadable(expand(s:infofile))
    execute 'source '.s:infofile
  endif
  unlet s:infofile
endif

"----------------------------------------
" メニューアイテム作成
"----------------------------------------
silent! aunmenu &File.Save
silent! aunmenu &File.保存(&S)
silent! aunmenu &File.差分表示(&D)\.\.\.

let message_revert="再読込しますか?"
amenu <silent> 10.330 &File.再読込(&U)<Tab>:e!  :if confirm(message_revert, "&Yes\n&No")==1<Bar> e! <Bar> endif<CR>
amenu <silent> 10.331 &File.バッファ削除(&K)<Tab>:bd  :confirm bd<CR>
amenu <silent> 10.340 &File.保存(&W)<Tab>:w  :if expand('%') == ''<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
amenu <silent> 10.341 &File.更新時保存(&S)<Tab>:update  :if expand('%') == ''<Bar>browse confirm w<Bar>else<Bar>confirm update<Bar>endif<CR>
amenu <silent> 10.400 &File.現バッファ差分表示(&D)<Tab>:DiffOrig  :DiffOrig<CR>
amenu <silent> 10.401 &File.裏バッファと差分表示(&D)<Tab>:Diff\ #  :Diff #<CR>
amenu <silent> 10.402 &File.差分表示(&D)<Tab>:Diff  :browse vertical diffsplit<CR>


"----------------------------------------
" タブ設定
"----------------------------------------
" set showtabline=2
" " tab navigation like firefox
" nmap <C-S-tab> :tabprevious<cr>
" nmap <C-tab> :tabnext<cr>
" map <C-S-tab> :tabprevious<cr>
" map <C-tab> :tabnext<cr>
" imap <C-S-tab> <ESC>:tabprevious<cr>i
" imap <C-tab> <ESC>:tabnext<cr>i
" "map <C-w> :tabclose<cr>
" nmap <C-t> :tabnew<cr>
" imap <C-t> <ESC>:tabnew<cr> 

"----------------------------------------
"  前回の設定を読む
"----------------------------------------
" Vim起動時に前回のセッションを復元する
"let old_session_file = $CFGHOME . "/my_session.vim"
"source old_session_file
"source $CFGHOME/my_session.vim

" Vim終了時に現在のセッションを保存する
" うまく動かない
"au VimLeave * mksession! old_session_file
"au VimLeave * mksession! $CFGHOME/my_session.vim

" vim:set et ts=2 sts=2 sw=2
