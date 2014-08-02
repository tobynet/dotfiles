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

" Enable mouse
if has('mouse') | set mouse=a | endif

" Change menu to English
set langmenu=en
" Hide toolbar
set guioptions-=T

" カラー設定:
" 共通の色テーマは.vimrcで指定すること
" desert, molokai, solarized
colorscheme desert

" 何故か？？？vimrcのhighlight設定が読み込まれない？？？
" コメントがちょっと暗めなので明るくしておく
"highlight Comment term=bold ctermfg=11 guifg=grey70

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
