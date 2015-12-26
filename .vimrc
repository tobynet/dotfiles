set encoding=utf-8

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif


if has('win32') || has('win64')
  " To prevent garbled characters in cmd.exe
  set termencoding=sjis
endif

scriptencoding utf-8
"scriptencodingと、このファイルのエンコードが一致するよう注意！
"scriptencodingは、vimの内部エンコードと同じにすると問題が起きにくい。

" 【当.vimrcの指針】
"
" * 設定レスの環境でイライラしないために、デフォルトのキーバインドをなるべく潰さない
" * デフォルトと被らないようにするため、 <space> から続くキーによく使う機能を割り当てるREADME/
"   * <space> ほど使わないが割り当てたい機能は、プラグインで使われやすい  \ に割り当てる
" * 設定レスの環境も考え、なるべくデフォルトの機能を使っていくようにする
"   * :cn[ext] を <space>cn に割り当てるなど気を使う
" * できるだけシンプルにしておく(この.vimrcは何度か1から作りなおしていることを思い出すこと)
" * WindowsではgVim、LinuxではCUIで使うのが便利と感じているため、
"   CUIとGUI両方で使える設定にしておく
"     * 具体的には、Ctrl+Shift系へのキー割り当て等、CUIの制限に引っかかり易いものは使わない
"       * CUIの制限は把握してないので知りたいところ
"     * 例外的に、端末のキー操作をgVimで再現する方向はあり
"       例: Ctrl+Shift+Vをクリップボードからの貼り付けのような操作にする
" * Windowsで重いプラグインはなるべく、利用に気を使う(cygwinではどうするか未定)
" * todo: augroup の名前が統一されてない。命名規則を調べとく

" plugins {{{
if isdirectory(expand('~/.vim/bundle/neobundle.vim/'))

  filetype off                   " required!
  filetype plugin indent off     " required!
  if has('vim_starting')
    set nocompatible

    set runtimepath+=~/.vim/bundle/neobundle.vim/
  endif

  call neobundle#begin(expand('~/.vim/bundle/'))
  
  " let NeoBundle manage NeoBundle
  " ★★★   required! 
  "NeoBundle 'Shougo/neobundle.vim'

  " ★ for template
  NeoBundle 'thinca/vim-template'

  " ★ instantly run command
  NeoBundle 'thinca/vim-quickrun'
  " ★ asynchronously
  NeoBundle 'Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ }

  " for quickrun 'browser' outputter
  NeoBundle 'tyru/open-browser.vim'

  " ★ref.vim
  " TIPS: shift+k で ref.vim でリファレンスを参照する
  " TIPS: :Ref <Tab> で ref.vim でリファレンスを参照する
  NeoBundle 'thinca/vim-ref'
  " ★  便利!!! ref.vim の 標準refe が動かしにくいので ri を使うvim-refプラグイン
  NeoBundle 'taka84u9/vim-ref-ri'

  " benchmark plugin
  " TIPS: :BenchVimrc でvimrcの行毎のベンチマークとる, %sort! で遅い順(降順)に並び替え
  " TODO: :BenchVimrc から %sort! を同時にしたい
  NeoBundleLazy 'mattn/benchvimrc-vim'

  " ★★syntax checker
  " needs some syntax checkers like,
  " html:       $ sudo apt-get install tidy
  " python:     $ sudo pip install flake8
  " yaml:       $ sudo npm install -g js-yaml
  " javascript: $ sudo npm install -g jshint
  " golang(golint)  $ go get -u github.com/golang/lint/golint
  NeoBundle 'scrooloose/syntastic'

  " ★★★like rspec
  NeoBundle 'kana/vim-vspec'

  " special looks statusbar
  NeoBundle 'Lokaltog/vim-powerline'

  " for git
  NeoBundle 'tpope/vim-fugitive'
  " for git diff like IDE
  NeoBundle 'airblade/vim-gitgutter'
  " tig fo vim
  NeoBundle 'gregsexton/gitv'

  " for ruby, I want to hit 'K' to ref from ri!!!!!
  "NeoBundle 'vim-ruby/vim-ruby'

  " for javascript indent
  NeoBundle 'pangloss/vim-javascript'

  " 自動的に 括弧や do end を閉じる 
  " lua, ruby, sh, zsh, vb, vbnet, vim 辺りに対応してる
  " refs. http://d.hatena.ne.jp/babie/20110130/1296348755
  NeoBundle 'tpope/vim-endwise'

  " for tabpagecd
  "NeoBundle 'kana/vim-tabpagecd'
  NeoBundle 'tobynet/vim-tabpagecd'

  " for 対応する括弧を入力したりする。 IDEっぽい
  "NeoBundle 'kana/vim-smartinput'

  " for Haml and Sass, SCSS
  NeoBundle 'tpope/vim-haml'
  " for Slim
  NeoBundleLazy 'slim-template/vim-slim'

  " for CoffeeScript
  NeoBundle 'kchmck/vim-coffee-script'
  " for stylus
  NeoBundle 'wavded/vim-stylus'

  " ipython integration おれも何がおこったのかわからなかった
  "
  NeoBundle 'ivanov/vim-ipython'

  " for haskell
  " cabal install ghc-mod
  NeoBundle 'eagletmt/ghcmod-vim'
  " vim-ref で hoogle を引くやつ: キー 'K' 
  NeoBundle 'ujihisa/ref-hoogle'

  " yet another markdown plugin
  NeoBundle 'tpope/vim-markdown'

  " for indent visualization 
  NeoBundle 'Yggdroot/indentLine'

  " for markdown-preview
  " refs. http://mattn.kaoriya.net/software/vim/20120208161751.htm
  " TIPS: :MkdPreview! markdownのプレビュー
  " install: 
  "   $ sudo apt-get -y install python-pip
  "   $ pip install Markdown
  NeoBundleLazy 'mattn/webapi-vim'
  NeoBundleLazy 'mattn/mkdpreview-vim'

  " for markdown-preview
  " requrements.
  "   $ gem install redcarpet pygments.rb
  "   $ sudo npm -g install instant-markdown-d
  NeoBundleLazy 'suan/vim-instant-markdown'

  " CTRL+P to find something
  NeoBundle 'kien/ctrlp.vim'
  " CTRL+P plugin for mark
  NeoBundle 'mattn/ctrlp-mark'
  " CTRL+P plugin for register
  NeoBundle 'mattn/ctrlp-register'
  " CTRL+P plugin for yanking, cmdline, menu
  NeoBundle 'sgur/ctrlp-extensions.vim'

  " NERD_tree.vim(include trinity) + taglist.vim + srcexpl.vim
  " NeoBundle 'trinity.vim'
  " NeoBundle 'taglist.vim'
  " NeoBundle 'Source-Explorer-srcexpl.vim'
  " 
  " easy to add comment
  NeoBundle 'tomtom/tcomment_vim'

  " web browser
  if executable('w3m')
    NeoBundle 'yuratomo/w3m.vim'
  endif

  " Emmet
  NeoBundle 'mattn/emmet-vim'

  " html5
  NeoBundle 'othree/html5.vim'

  " coq
  NeoBundle 'trefis/coquille'

  " scala
  NeoBundle 'derekwyatt/vim-scala'

  " 図形描画
  " TIPS: \di 図形描画開始 \ds 終了. DrawIt plugin
  NeoBundle 'DrawIt'

  " puppet support
  NeoBundle 'rodjek/vim-puppet'

  " 文字数カウンタ
  " :echo b:charCounterCount
  " :AnekoS_CharCounter_CharCount
  NeoBundle 'anekos/char-counter-vim'

  " Prolog support
  NeoBundle 'adimit/prolog.vim'
  
  " Outline
  NeoBundle 'vim-scripts/VOoM'

  call neobundle#end()

  filetype plugin indent on     " required!
  "
  " Brief help
  " :NeoBundleList          - list configured bundles
  " :NeoBundleInstall(!)    - install(update) bundles
  " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

  " }}}
endif

" refs. vimエディタが（勝手に）作成する、一見、不要に見えるファイルが何をしているか — 名無しのvim使い http://nanasi.jp/articles/howto/file/seemingly-unneeded-file.html
"ファイルの上書きの前にバックアップを作る/作らない
"set writebackupを指定してもオプション 'backup' がオンでない限り、
"バックアップは上書きに成功した後に削除される。
set nowritebackup
"バックアップ/スワップファイルを作成する/しない。
set nobackup
"set noswapfile
" スワップファイル(.swp)が邪魔臭いのでファイルと同じディレクトリには作らないようにする
"  ~/tmp /tmpなどにできるようになるはず
"  :set directory で参照してディレクトリを作っておくこと
"  参考 Vim-users.jp - Hack #32: Vimが強制終了された後の処理 http://vim-users.jp/2009/06/hack32/
"  refs. https://wiki.archlinux.org/index.php/Vimrc
set directory-=.
" Windowsでは(cygwin除く)、スワップファイルやバックアップを環境変数$TMPに設定
if has('win32') || has('win64')
  "ディレクトリを直接指定する場合
  set directory="c:/tmp,c:/temp"
  set backupdir="c:/tmp,c:/temp"
  "環境変数$TMPを使用する場合
  set directory=$TMP
  set backupdir=$TMP
"  set directory=
"  set backupdir=
else
  " その他の環境では、 ~/.cache/ 以下に作成する
  let cache_directory =   expand("$HOME/.cache/.vim")
  let tmp_directory =     cache_directory . "/tmp"
  let backup_directory =  cache_directory . "/backups"
  let view_directory =    cache_directory . "/viewdir"
   
  if exists("*mkdir")
      if !isdirectory(cache_directory)    | call mkdir(cache_directory, "p", 0700)    | endif
      if !isdirectory(tmp_directory)      | call mkdir(tmp_directory, "p", 0700)      | endif
      if !isdirectory(backup_directory)   | call mkdir(backup_directory, "p", 0700)   | endif
      if !isdirectory(view_directory)     | call mkdir(view_directory, "p", 0700)     | endif
  endif
	
  let &dir=tmp_directory
  let &backupdir=backup_directory
  let &viewdir=backup_directory
endif


" 256色対応にする
let &t_Co = 256

" マウスを利用する
set mouse=a
"クリップボードを共有。
set clipboard+=unnamed
"8進数を無効にする。<C-a>,<C-x>などに影響する。
set nrformats-=octal
"編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない。
set hidden
"ヒストリの保存数
set history=10000
"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"Visual blockモードでフリーカーソルを有効にする
" TIPS: CTRL-V で矩形ビジュアルモードに入った後, I 0 文字列 <ESC> で各行頭に文字列を挿入, A $ 文字列 <ESC>
set virtualedit=block
"カーソルキーで行末／行頭の移動可能に設定。
set whichwrap=b,s,[,],<,>
"バックスペースでインデントや改行を削除できるようにする。
set backspace=indent,eol,start
"コマンドライン補完するときに強化されたものを使う。
set wildmenu
"pluginを使用可能にする
filetype plugin on

" ファイルのリスト等で無視するパターン
"  プラグイン(CtrlPで確認)にも影響する
"  一時ファイルやテンポラリを無視するようにするとよさそう
if has('win32') || has('win64')
  set wildignore+=**/tmp/,*.swp,*.zip,*.exe,.git/**    " Windows
else
  set wildignore+=**/tmp/,*.so,*.swp,*.zip,.git/**   " Linux/MacOSX
endif

"----------------------------------------
" 表示設定 {{{
" ハイライトを有効にする。
syntax enable

"Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
"行番号表示 :set number!で切り替え可能
set number
" 対応括弧を表示
set noshowmatch
"対応括弧に飛ばない
set matchtime=0
"タブを設定
" ハードタブの見た目の幅を設定
set tabstop=4
" インデント幅を設定
" tabstop < shiftwidth で expandtab が off の時はインデント時にハードタブとスペースが混在するので注意
set shiftwidth=4
" タブ周りを適当にスマートな感じの動作にする
" shiftwidth, tabstop を考慮して上手いことタブを入れたり、
" <BS>で後ろがハードタブのように空白を一度に削除する
" smarttab on で softtabstop 要らない気がする
set smarttab
" ハードタブをスペースで展開する
set expandtab
"自動的にインデントする (noautoindent:インデントしない)
set autoindent
" スマートなインデントにする
"set smartindent
"Cインデントの設定
set cinoptions+=:0
"タイトルを表示
set title
"画面最後の行をできる限り表示する。
set display=lastline
"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:»-,trail:~,eol:↲,extends:>,precedes:<,nbsp:%
" }}}

" vimの変更があったファイルの自動読み込み autoread http://vim-users.jp/2011/03/hack206/ /20m
set autoread

" 自動で読み込む頻度を上げるために、 :checktimeを適当な場面で発動させる
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

"----------------------------------------
" Insert Mode と Normal Modeの判別 {{{
" refs. http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
" refs. http://vim.wikia.com/wiki/Change_statusline_color_to_show_insert_or_normal_mode
" refs. ステータスラインを変更するのをプラグインにしたもの https://github.com/molok/vim-smartusline
" refs. http://stackoverflow.com/questions/6488683/how-do-i-change-the-vim-cursor-in-insert-normal-mode
" refs. 端末エスケープシーケンス関連の設定 https://gist.github.com/2908941
" refs. iTerm2 https://gist.github.com/1195581
augroup ForDifferentMode
  autocmd!
  
  " Insert Modeでカーソルの行を目立たせる
  autocmd VimEnter,WinEnter,ColorScheme * call s:highlight_for_insert_mode()
  autocmd InsertEnter * call s:on_enter_insert_mode()
  autocmd InsertLeave * call s:on_leave_insert_mode()

  " CTRL-C の時にInsertLeaveが無視されるのを考慮する
  inoremap <c-c> <c-o>:<C-u>call <SID>on_leave_insert_mode()<CR><C-C>

  " For iTerm2, on tmux or not
  " if exists('$TMUX')
  "   let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  "   let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  " else
  "   " for Konsole?
  "   let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  "   let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " endif
augroup END

" Insert Modeでどのように見せるか
function! s:on_enter_insert_mode()
  set cursorline
endfunction

" Insert Mode「以外で」どのように見せるか
function! s:on_leave_insert_mode()
  set nocursorline
endfunction

function! s:highlight_for_insert_mode()
  highlight CursorLine ctermbg=lightgrey
endfunction
" }}}

"-------------------------------------------------------------------------------
" エンコーディング encoding {{{
" gVimではメニューが出る。
" CUIでは<Space>e でメニューを開いてエンコーディングを変更する(タブで補完可能)
menu Encoding.utf-8     :e ++enc=utf-8 <CR>
menu Encoding.cp932     :e ++enc=cp932<CR>
menu Encoding.sjis      :e ++enc=cp932<CR>
menu Encoding.euc       :e ++enc=euc-jp<CR>
menu Encoding.jis       :e ++enc=iso-2022-jp<CR>
nmap <Space>E :emenu Encoding.
nmap <Space>EE :emenu Encoding.
nmap <Space>Es :emenu Encoding.sjis<CR>
nmap <Space>Ee :emenu Encoding.euc<CR>
nmap <Space>Ej :emenu Encoding.jis<CR>
nmap <Space>Eu :emenu Encoding.utf-8<CR>
nmap <Space>E8 :emenu Encoding.utf-8<CR>
" }}}

"-------------------------------------------------------------------------------
" TODO: Pandoc 変換用のメニューを作る

"-------------------------------------------------------------------------------
" ステータスライン StatusLine {{{
"コマンドラインの高さ (gvimはgvimrcで指定)
set laststatus=2
"コマンドをステータス行に表示
set showcmd
"カーソルが何行目の何列目に置かれているかを表示する
set ruler
" }}}

"----------------------------------------
" 検索 {{{
" 検索の時に大文字小文字を区別しない。
set ignorecase
" ファイル名補完時の時に大文字小文字を区別しない。
set wildignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別。
set smartcase
"検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
"インクリメンタルサーチ
set incsearch
"検索文字の強調表示
set hlsearch

" / を検索するには \/と書く必要があるのを楽にする
" (getcmdtype() == '/' は / での検索時かどうかを見分けている)
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
" ? の時も同様に対処する(?の時は、/ でなく ? を \?と書く必要がある様子)
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" }}}

" TIPS: :append! でインデントを無視してペーストする 最後に"." のみの行で終了 (<Space>a として定義)
nnoremap <Space>a :<C-u>append!<CR>

if has('gui_running')
    " gvim用のフォントを変える
    " For programming font, Ricty http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html
    if has('gui_gtk2')
      set guifont=Ricty\ Diminished\ Discord\ 11
    else
      set guifont=Ricty_Diminished_Discord:h14
    endif
    set linespace=0
    
    " □や○の文字があってもカーソル位置がずれないように、
    " 記号を二文字分の幅としとして扱う
    " テキスト端末だとずれるのでgvimのときだけにしてる
    if exists('&ambiwidth')
        set ambiwidth=double
    endif
endif

" 細かい色を変える
augroup MyColor
    autocmd!
    " TODO: highlightのautocmdはどのような時につかうのがよいのか知りたい
    " WinEnterはウインドウの切替時にちらつくので外してある
    autocmd VimEnter,ColorScheme * call s:highlight_mycolor()
augroup END

function! s:highlight_mycolor()
    highlight! MatchParen ctermbg=white guibg=white

    " TODO とか FIXED の類を見やすくしたい
    highlight! Todo term=bold cterm=bold ctermfg=white gui=bold guifg=white guibg=darkyellow

    highlight! Search term=standout cterm=NONE ctermbg=LightYellow

    " high contrast
    highlight! DiffAdd    term=NONE cterm=NONE,reverse ctermfg=DarkGreen ctermbg=NONE
    highlight! DiffChange term=NONE cterm=NONE,reverse ctermfg=DarkYellow ctermbg=NONE
    highlight! DiffDelete term=NONE cterm=NONE,reverse ctermfg=DarkRed ctermbg=NONE
    highlight! DiffText   term=NONE cterm=NONE,reverse ctermfg=DarkBlue ctermbg=NONE
endfunction



"----------------------------------------
" ノーマルモード {{{ " Hint: 
"   noremapはmapを解釈しない(本来のキーや機能を実行する)。
"   mapはmapの定義を解釈する(再帰する)。


" TIPS: :!ruby %       " 外部コマンド実行例 例: 現在ファイルでruby実行(quickrunを使わず)
" TIPS: :r!date        " コマンド実行結果を現在行に挿入 例: 日付を挿入
" TIPS: :'<,'>!cat -n  " コマンド実行し、選択範囲を置き換える 例: 行番号を挿入

" TIPS: <space>! で一つ前の外部コマンドを実行( 内部のは . だいたいで )
nnoremap <Space>!    q:k<Cr>

" TIPS: <Space>.. .vimrcを開く。<space>.s で .vimrc を再読み込み
"   refs Vimの極め方 http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
nnoremap <Space>..    :<C-u>tabedit $MYVIMRC<CR>
nnoremap <Space>.s   :<C-u>source $MYVIMRC<CR>

"強制全保存終了を無効化。
nnoremap ZZ <Nop>

" <Space>n で簡単に,今と同じファイルタイプで新規作成
" refs https://github.com/ujihisa/config/commit/db02d2b89d38a273a28f61d2db364fe1349cb45f
nnoremap <Space>n :<C-u>call <SID>new_with_the_filetype()<CR>
function! s:new_with_the_filetype()
  let f = &filetype
  new
  let &filetype = f
endfunction
" }}}

" spellchecker 用 {{{
" refs. Vim のスペルチェッカ早わかり - Alone Like a Rhinoceros Horn http://d.hatena.ne.jp/h1mesuke/20100803/p1

" TIPS: setlocal spell! でスペルチェック。 <space>sp に割り当ててある
" TIPS: ]s , [s で次へ前へスペルミスへ移動
" TIPS: z= スペルミス修正候補を表示
" TIPS: zg 正しいスペルとして辞書登録、 zw 誤ったスペルとして辞書登録
nnoremap <silent> <Space>sp :<C-u>setlocal spell! spelllang=en_us<CR>:setlocal spell?<CR>
" }}}

" coverage-vim 用 {{{
command! -nargs=?   Coveragevim    :source coverage.vim
" TIPS: Coverage.vimの解除は :Uncov でできる
" }}}

"ファイルを開いたら前回のカーソル位置へ移動 {{{
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END
" }}}

""""""""""""""""""""""""""""""
" 定義されているマップを見る {{{
" Vim-users.jp - Hack #203: 定義されているマッピングを調べる
" http://vim-users.jp/2011/02/hack203/
" " 全てのマッピングを表示
" :Maps
" " 冒頭で言った1のケースのように現在のバッファで定義されたマッピングのみ表示
" :Maps <buffer>
" " どのスクリプトで定義されたかの情報も含め表示
" :verbose Maps <buffer>
command! -nargs=* -complete=mapping    Maps   map <args> | map! <args> | lmap <args>
" }}}

" バッファ設定 {{{
" TIPS: <Space>Tab          次のバッファ(:bnext)
" TIPS: <Space>Shift+Tab    前のバッファ(:bprev)
nnoremap <Space><Tab>   :<C-U>bnext<CR>
nnoremap <Space><S-Tab> :<C-U>bprev<CR>
" }}}
"

" ファイルタイプを List で得る
" ref. http://superuser.com/questions/664638/list-all-filetype-plugins-known-to-vim
function! g:Filetypes()
    let paths = split(globpath(&rtp, 'ftplugin/*.vim'), '\n')
    return map(paths, 'fnamemodify(v:val, ":t:r")')
endfunction

"----------------------------------------
" タブ設定 {{{
" タブ表示設定
"   0: 表示しない
"   1: 1個のときは表示しない
"   2: 常にタブを表示する
set showtabline=2
" TIPS: gt, gT でタブ移動できます 便利
" }}}


"----------------------------------------
" インデント設定 {{{
" TIPS: insert mode: CTRL-T, CTRL-Dでインデント, アンインデント
" TIPS: normal mode: >>, <<でインデント, アンインデント
" TIPS: ">" や "<" の後に "." でインデントを繰り返すことができる
" }}}

"----------------------------------------
" TIPS: :Explore でファイル一覧表示(略:Ex) <space>e にも割り当ててある
nnoremap <space>e       :<C-U>Explore<CR>

" TIPS: :help {topic} で、topicに関するヘルプを見る。<space>hに割り当ててある
nnoremap <space>h       :<C-U>help<space>

" TIPS: :setlocal autoread でtail -f のように更新されたら読み込む。:Tailfthisに割り当ててある
command! -nargs=0   Tailfthis        :setlocal autoread
command! -nargs=* -complete=file  Tailftab    :tabe <args> | setlocal autoread

"----------------------------------------
" コメントつけるための tComment.vim プラグイン {{{
" TIPS: gcc, gCc    で現在行のコメントをトグル(tcommentプラグイン)
" TIPS: gc{motion}  でコメントをトグル(tcommentプラグイン)
" TIPS: Visualモードでgc  で選択範囲のコメントをトグル(tcommentプラグイン)
" }}}

"----------------------------------------
" CTRL-Pプラグイン用 {{{
" TIPS: <C-P> or :CtrlP , CTRLPプラグインを起動して、ファイル等を検索
" TIPS: <C-P> 後 <C-F> か <C-B>, CTRLPプラグイン使用中に、前者がファイル、後者がバッファとMRU
" TIPS: <C-P> 後 <C-R> CTRLPプラグイン使用中に、正規表現検索モードへ
" 「最近使ったファイル」を最大数の大きめにとっておく、遅くなるようなら小さめにする
let g:ctrlp_mruf_max = 25000

" 固まらないように列挙するファイルを少なめにしておきたいところ
" (ディレクトリ探索数の依存が大きいみたいなで設定してない)
"let g:ctrlp_max_files = 10000
" 固まらないようにディレクトリ探索の深さを低めにしておく
"let g:ctrlp_max_depth = 3
" 固まらないように親のディレクトリ探索を無効化
"let g:ctrlp_working_path_mode = 0
" 体感速度を上げるため、キャッシュをクリアしないようにする
let g:ctrlp_clear_cache_on_exit = 1


" CTRL-H で一つ前の文字を削除する(ドキュメントに記載の方法)
" うまくいきました。再起動が必要っっぽい
let g:ctrlp_prompt_mappings = {}
let g:ctrlp_prompt_mappings['PrtCurLeft()'] = ['<left>', '<c-^>']
let g:ctrlp_prompt_mappings['PrtBS()'] = ['<bs>', '<c-]>', '<c-h>']
" 日本語で検索したい cmigemo入れる必要あるっぽい
let g:ctrlp_use_migemo = 1

" 無視するパターン
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.bzr$\|\.gvfs$',
  \ 'file': '\.exe$\|\.so$\|\.dll$',
\ }

"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',

" プラグイン
let g:ctrlp_extensions = [
\    'register',
\    'mark',
\    'yankring',
\ ]
"\    'cmdline',
"\    'menu'

" CTRL-P で前のモードで開く
nnoremap <silent> <c-p> :<c-u>CtrlP<cr>

" 標準の "f" を潰して色々割り当てる(Unite風？) → "f"は便利なのでやめ
" nnoremap <silent> ff :<c-u>CtrlPLastMode<cr>
" nnoremap <silent> fp :<c-u>CtrlPYankring<cr>
" nnoremap <silent> fb :<c-u>CtrlPBuffer<cr>
" nnoremap <silent> fm :<c-u>CtrlPMRUFiles<cr>
" nnoremap <silent> fr :<c-u>CtrlPRegister<cr>
" nnoremap <silent> fk :<c-u>CtrlPMark<cr>
" nnoremap <silent> fc :<c-u>CtrlPClearCache<cr>
" nnoremap <silent> f: :<c-u>CtrlPCmdline<cr>
" スペースに割り当てる(他のキーとは要検討)
nnoremap <silent> <space>F :<c-u>CtrlP<cr>
nnoremap <silent> <space>P :<c-u>CtrlPYankring<cr>
nnoremap <silent> <space>B :<c-u>CtrlPBuffer<cr>
nnoremap <silent> <space>M :<c-u>CtrlPMRUFiles<cr>
nnoremap <silent> <space>R :<c-u>CtrlPRegister<cr>
nnoremap <silent> <space>K :<c-u>CtrlPMark<cr>
nnoremap <silent> <space>: :<c-u>CtrlPCmdline<cr>
"nnoremap <silent> <space>C :<c-u>CtrlPClearCache<cr>
" }}}


"----------------------------------------
" Quickfixを便利にする {{{
" なるべく元のコマンドを生かした形にする
" 操作の簡略化
" TIPS: Quickfixの後ろへ。    :cp[revious] :cN[ext]
nnoremap <space>cp      :<C-u>cprevious<CR>
nnoremap <space>cN      :<C-u>cNext<CR>
" TIPS: Quickfixの次へ。      :cn[ext]
nnoremap <space>cn      :<C-u>cnext<CR>
" TIPS: Quickfixの最初へ。    :cfir[st]
nnoremap <space>cfir    :<C-u>cfirst<CR>
" TIPS: Quickfixの最後へ。    :cla[st]
nnoremap <space>cla     :<C-u>clast<CR>

" 自動的にquickfix-windowを開く
augroup MyQuickfix
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" }}}

"----------------------------------------
" coq ('trefis/coquille') {{{
" TIPS: coq: available commands: :CoqNext :CoqToCursor :CoqUndo :CoqKill and query commands are available: :Coq Check , :Coq Print

augroup MyCoq
  autocmd!
  "
  " Maps Coquille commands to CoqIDE default key bindings
  au FileType coq call coquille#CoqideMapping()

  "" Maps Coquille commands to <F2> (Undo), <F3> (Next), <F4> (ToCursor)
  "au FileType coq call coquille#FNMapping()
augroup END
" }}}

"----------------------------------------
" 日付の挿入用の補助用 {{{
" TIPS: Insert mode で dts とすると、 2XXX-XX-XX と日付を挿入
iabbrev <expr> dymd strftime("%Y-%m-%d")
nnoremap <silent> <space>dd "=strftime("%Y-%m-%d")<cr>P<right>
" TIPS: Insert mode で dts とすると、 2XXX-XX-XX と日付を挿入
iabbrev <expr> dhm strftime("%H:%M")
nnoremap <silent> <space>dt "=strftime("%H:%M")<cr>P<right>
" }}}

"----------------------------------------
" for tpope/vim-markdown

" markdownで コードを書くところでシンタックスハイライトされる書式を設定
" 設定したfiletypeに該当するものがないとmarkdownファイルの読み込み時にエラーになるので注意
"
" ref. https://github.com/github/linguist/blob/master/lib/linguist/languages.yml
" Note: You see "aliases:", and downcased name.
let g:markdown_fenced_languages = [
  \ 'ruby', 'erb=eruby',
  \ 'python',
  \ 'html', 'xhtml=html', 'css',
  \ 'diff',
  \ 'javascript', 'js=javascript', 'node=javascript',
  \ 'zsh=sh', 'bash=sh',
  \ 'c', 'cpp', 
\ ]
"  \ 'bat=batchfile',
"  \ 'go',

" 存在するファイルタイプのみを追加
" ※ 存在していないと markdown プラグインでファイル
"   読み込み時にエラーが起きることがあるため)
let s:temporary_markdown_fenced_languages = [
  \ 'coq',
  \ 'coffee',
\ ]
let filetypes_list = g:Filetypes()
for lang in s:temporary_markdown_fenced_languages
    if 0 <= index(filetypes_list, lang)
        call add(g:markdown_fenced_languages, lang)
    endif
endfor

"----------------------------------------
" 自分のmemo用 {{{
augroup memo
  autocmd!
  " もはやmemoっぽいディレクトリのテキストファイルをmarkdownとしてしまいたい
  autocmd BufRead,BufNewFile */memo/*.txt set filetype=markdown
  autocmd FileType markdown call s:filetype_markdown_init()

  "autocmd BufRead,BufNewFile */memo/*.txt set filetype=markdown.marktag
"  autocmd Syntax markdown call s:set_my_syntax()
"
  " Markdown from filetype.vim
  autocmd BufNewFile,BufRead *.markdown,*.mdown,*.md,*.mkd,*.mkdn,README.md set filetype=markdown
augroup END

function! s:filetype_markdown_init()
  "
  if exists('*UpdateMarkdown')
    autocmd CursorMoved,CursorMovedI,CursorHold,CursorHoldI <buffer> silent call UpdateMarkdown()
    autocmd BufWinLeave <buffer> silent call CloseMarkdown()
    autocmd BufWinEnter <buffer> silent call OpenMarkdown()
  endif
endfunction


" Markdownをすぐ見たい

" 楽にgrepする汎用関数
" ※ 実装時に内部grepを使うか、外部grepにするかはこちらを参考にした
"   vimのgrepの設定と使い方 - fudist https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-grep
function! s:easy_grep(options)
  " 引数の指定がない場合は、現在のカーソルのワードで検索しようとする
  let text = get(a:options, 'text', expand("<cWORD>"))
  let directory = get(a:options, 'directory', getcwd() . '/**/*')

  " noautocmd でvimgrepを高速化
  "fnameescape(
  execute "noautocmd vimgrep /" . escape(text, '/') . "/gj " . directory . " | cwindow"
  
  " 並び替えは上手く行かない…(非表示の内部バッファにデータがあるっぽい)
  "| copen | setl modifiable | sort! | setl nomodifiable | setl nomodified"
endfunction
" }}}
" TIPS: :Grep でgrep検索する( <Space>g でもできる。<Space>G でカーソル下の単語をGrep)
command! -nargs=?   Grep        :call s:easy_grep({'text': '<args>'})
nnoremap <Leader>g :<C-u>Grep 
nnoremap <Leader>G :<C-u>call <SID>easy_grep({})<CR>

" memo内をgrepしたい {{{
" TIPS: :GrepMemo でメモをgrep検索する( <Space>mg でもできる。<Space>mG でカーソル下の単語をGrep)
command! -nargs=?   GrepMemo    :call s:grep_memo({'text': '<args>'})
nnoremap <Space>mg :<C-u>GrepMemo 
nnoremap <Space>mG :<C-u>call <SID>grep_memo({})<CR>

"memoをgrepする汎用関数
function! s:grep_memo(options)
  " merge default options
  call extend(a:options, {'directory': '~/memo/**/*.txt ~/memo/**/*.md ~/memo/**/*.mkd ~/memo/notebook/**/*.py'})
  call s:easy_grep(a:options)
endfunction
" }}}

" アイデアメモのリストを開く {{{
"   検索を '(\[idea\]\|idea\:)' にすると、公開用の 'idea:' も引っかかるので
"   外してある
command! -nargs=?   Ideas    :call s:grep_memo({'text': '\c\[idea\]'})
nnoremap <Space>i :<C-u>Ideas<CR>
nnoremap <Space>I :<C-u>GrepMemo \c\[idea\]<left><left>
" }}}

" TODOのリストを開く {{{
" 今のところは自分のファイルのTODOをすぐ確認するためだけ
command! -nargs=?   Todos   noautocmd vimgrep /\ctodo\:/g % | cwindow
nnoremap <leader>tl :<C-u>Todos<CR>
" }}}


" cheatsheet的にメモを開く {{{
"nnoremap <Space>c :<C-u>edit ~/memo/*_cheatsheet?
nnoremap <Space>mc :<C-u>Memo cheatsheet*

"command! -nargs=?   Cheat    :call s:open_cheatsheet({'text': '<args>'})
"nnoremap <Space>C :<C-u>call <SID>s:open_cheatsheet({})<CR>
" function! s:open_cheatsheet(options)
"   let text = get(a:options, 'text', expand("<cWORD>"))
"   " 上手くいってない!!!!
"   "  execute "noautocmd vimgrep /" . escape(text, '/') . "/gj ~/memo/*-cheatsheet-*.txt | cwindow"
"   execute "edit ~/memo/*-cheatsheet-*" . escape(text, '/') . ".txt"
" endfunction
" }}}

" 今日の日付のメモを開く {{{
" 参考: http://nanasi.jp/articles/howto/file/workingfile.html

" TIPS: :Memo で 今日のメモを開く( <Space>m も可)
" TIPS: :Memo で 今日のメモを開く( <Space>m も可)
command! -nargs=? -complete=customlist,s:MemoComplete
    \ Memo    :call s:open_memo({'context': '<args>'})
nnoremap <Space>mm :<C-u>call <SID>open_memo({})<CR>
nnoremap <Space>m- :<C-u>call <SID>open_memo({'date': <SID>after_date(-1)})<CR>
nnoremap <Space>m+ :<C-u>call <SID>open_memo({'date': <SID>after_date(1)})<CR>
nnoremap <Space>mM :<C-u>Memo<Space>
nnoremap <silent> <space>mf :<c-u>CtrlP ~/memo<cr>

" :Memo fuba から、便利に ~/memo/2011-01-01_fuba.txt を補完したい
function! s:MemoComplete(ArgLead, CmdLine, CursorPos)
    " Ubuntu 12.04 パッケージのvimだと、globpathは大小無視なようなのでglobを使う
    " Patch 7.3.515 Problem:    'wildignorecase' only applies to the last part of the path. 
    " http://ftp.vim.org/pub/vim/patches/7.3/7.3.515
    " 例: return split(globpath($HOME . "/memo/", "*" . a:ArgLead . "*"), '\n')

    let list = []
    
    " メモ の保存先から列挙する
    let list += split(glob($HOME . "/memo/" . "*" . a:ArgLead . "*"), '\n')
    
    " ipython notebook の保存先からも列挙する
    let list += split(glob($HOME . "/memo/notebook/" . "*" . a:ArgLead . "*.py"), '\n')

    return list
endfunction

" 指定の経過日の日付を YYYY-MM-DD 形式で得ます
" 例: s:after_date(10) " => 今日が 2012-10-01 なら 2012-10-11 を返す
" 参考: 日付、時間の計算 — 名無しのvim使い http://nanasi.jp/articles/code/date/localtime.html
function! s:after_date(after_day)
  return strftime('%Y-%m-%d', localtime() + a:after_day * 60 * 60 * 24)
endfunction

" 今日の日付を YYYY-MM-DD 形式で得ます
" 例: s:today() " => 2012-10-01
function! s:today()
  return s:after_date(0)
endfunction

" メモを適当に開きます
" 現在は日付に応じたファイルを開きます
" ふつーのファイル名っぽいならそのファイルをふつーに開きます
" {'context': 'diary' } → YYYY_XX_DD_diary.txt になる 
" {'context': '/home/user/memo/2012-01-01_diary.txt' } →  そのまま開く
" TODO: vimに依存しない形のも作っておきたい rubyかzshで
function! s:open_memo(options)
  let context = get(a:options, 'context', '')
  let date = get(a:options, 'date', s:today())
  let memo_dir = $HOME . '/memo/'
  if filereadable(context) || context =~ memo_dir
    " ふつーのファイルっぽい指定がされてたら、
    " {'context': '/home/user/memo/2012-01-01_diary.txt' } →  そのまま開く
    let memo_filename = context
  else
    " メモっぽく展開
    " {'context': 'diary' } → YYYY_XX_DD_diary.txt になる
    if 0 < strlen(context)
      " diary -> _diary
      let context = '_' . context
    endif
    let memo_filename = memo_dir . date . context . '.md'
  endif

  execute 'edit ' . fnameescape(memo_filename)
endfunction
" }}}


"----------------------------------------
" 'vim-quickrun' でらくらく非同期で何かコマンドを実行 {{{
" refs. :help quickrun
" refs. yokohama.vim #3(http://atnd.org/events/28602)の発表資料 — Gist https://gist.github.com/2802244

" TIPS: :Quickrun で現在のバッファを実行(デフォルト \r か <space>r)
" TIPS: 3,6QuickRun で範囲を実行
" TIPS: QuickRun ruby rubyで実行
" TIPS: QuickRun ruby -src 'puts ARGV'-args 'nemui darui' " rubyで任意のソースを実行
" TIPS: let g:quickrun_config.ruby = {"args": "panai yabai"}  " rubyのスクリプトに渡すデフォルトの引数を設定

silent! map <unique> <Space>r <Plug>(quickrun)
silent! map <unique> <Leader>r <Plug>(quickrun)

command! -nargs=* -complete=file QuickRunConfig   let b:quickrun_config={'args': '<args>'}

" デフォルトの設定
" 非同期で実行
" 出力先
" エラー : quickfix
" 成功   : buffer
let g:quickrun_config={}

" 実行時間を表示
"let g:quickrun_config = {'*': {'hook/time/enable': '1'},}

let g:quickrun_config["_"] = {
\ "runner" : "vimproc",
\ "runner/vimproc/updatetime" : 100,
\ }


" ruby で bundler を考慮する
augroup quickrun_ruby_config
  autocmd!
  autocmd FileType ruby call s:quickrun_ruby_config()
  autocmd FileType ruby call s:quickrun_ruby_config()
augroup END

" TODO: rspec の色分けに対応したい
" refs. add output_filetype to config by tokorom · Pull Request #25 · thinca/vim-quickrun https://github.com/thinca/vim-quickrun/pull/25
" refs. 
function! s:quickrun_ruby_config()
  " detect "bundler" by checking "Gemfile" from upper directory of current file
  "let execs = executable('bundle') && 
  "      \ findfile('Gemfile', '.;') != '' ? 'bundle exec ' : ''
  " buffer local setting for quickrun
  "let b:quickrun_config = {'exec': execs . '%c %o %s %a'}

  let b:quickrun_config = {}
  " コマンド終了時間を表示
  let b:quickrun_config['hook/time/enable'] = '1'

  " detect "bundler" by checking "Gemfile" from upper directory of current file
  " change type for ruby bundle
  if executable('bundle') && findfile('Gemfile', '.;') != ''
    let b:quickrun_config['type'] = 'ruby/bundle'
  endif
endfunction

let g:quickrun_config['ruby/bundle'] = { 'exec': 'bundle exec %c %o %s %a' }

" Prevent corruption of output in Haskell
if has('win32') || has('win64')
    let g:quickrun_config['haskell'] = { 
    \   "hook/output_encode/enable" : 1,
    \   "hook/output_encode/encoding" : "cp932",
    \}
endif

" haskell用
let g:quickrun_config['doctest'] = {
  \ 'command':      'doctest',
  \ 'exec':         '%c %s'
\ }

" markdown 出力
let g:quickrun_config['markdown'] = {
  \ 'type':     'markdown/pandoc'
\ }
let g:quickrun_config['markdown/pandoc'] = {
  \ 'command':  'pandoc',
  \ 'exec':     '%c %s --data-dir=%s:\ p:h %o %a',
  \ 'outputter': 'browser',
  \ 'cmdopt':   '--standalone
    \ --css ~/dev/markdown/template/bootswatch-page/readable/bootstrap.min.css 
    \ --css ~/dev/markdown/template/bootswatch-page/default/bootstrap-responsive.css 
    \ --css ~/dev/markdown/template/bootswatch-page/css/docs.css 
    \ --css ~/dev/markdown/template/my.css
    \ --template ~/dev/markdown/template/pandoc-templates/default.html5
    \',
\ }
" }}}


" vim-vspec 用コマンド {{{
" refs. https://gist.github.com/4105564
" Description: vim-vspec で使ってる便利なコマンド．runnner を vimproc にするとすごく遅いのでデフォルトにしてる．
command! -nargs=0 Vspec
  \ execute 'QuickRun' 'sh' '-src'
  \ '''$HOME/.vim/bundle/vim-vspec/bin/vspec $HOME/.vim/bundle/vim-vspec ' . expand('%:p:h:h') . ' ' . expand('%:p') . ''''
"  \ '''' . expand('~/.vim/bundle/vim-vspec/bin/vspec') . ' ' . expand('~/.vim/bundle/vim-vspec') . ' ' . expand('%:p') . ''''
" TIPS: <Space>v で vim-vspec を実行
"nnoremap <Space>v    :<C-u>Vspec<CR>
" }}}

"----------------------------------------
" Powerline 用コマンド {{{
let g:Powerline_symbols = 'unicode'
let g:Powerline_dividers_override = [ '', [0x2502], '', [0x2502]  ]
" }}}


"----------------------------------------
" for Fugitive {{{
nnoremap <Space>gd :<C-u>Gdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>gl :<C-u>Glog<Enter>
nnoremap <Space>ga :<C-u>Gwrite<Enter>
nnoremap <Space>gc :<C-u>Gcommit --verbose<Enter>
nnoremap <Space>gC :<C-u>Gcommit --amend --verbose<Enter>
nnoremap <Space>gb :<C-u>Gblame<Enter>
" }}}

"----------------------------------------
" gitv用設定 {{{

" TIPS: :Gitv で git のログを gitkやtigのように表示。<leader>gv や <leader>gVでも可能 (gitv plugin)

nnoremap <Space>gv  :<c-u>Gitv --all<cr>
nnoremap <leader>gv :<c-u>Gitv --all<cr>
nnoremap <Space>gV  :<c-u>Gitv! --all<cr>
nnoremap <leader>gV :<c-u>Gitv! --all<cr>
vnoremap <Space>gV  :<c-u>Gitv! --all<cr>
vnoremap <leader>gV :<c-u>Gitv! --all<cr>

" gitvとうったらGitvに補完する via :help gitv
cabbrev gitv Gitv

" foldを防止
augroup gitv
  autocmd!
  autocmd FileType git call s:filetype_gitv_init()
augroup END

function! s:filetype_gitv_init()
  setlocal foldlevel=99
  setlocal spell spelllang=en_us
endfunction
"
" }}}
"
"----------------------------------------
" syntastic で文法チェック {{{

" ファイルを開いた時にチェック
let g:syntastic_check_on_open=1

" 自動で location list への表示を更新
" (下記設定がないと、毎回 :Errors コマンドをたたく必要ある)
let g:syntastic_always_populate_loc_list=1

" エラー一覧のウインドウの縦幅を邪魔にならないようにちょっと狭めに
let g:syntastic_loc_list_height=5

" エラーがあったときにエラー一覧を開く →
" 単に閲覧しようとしたファイルも開いてしまうのでやっぱりやめ
"let g:syntastic_auto_loc_list=1

" rubyの文法チェックにrubocop(ruby style guide準拠？)を利用する
" rubocop(というよりruby style guide)は細かく小うるさいので注意
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
"let g:syntastic_ruby_checkers = ['mri']

" }}}

"----------------------------------------
" お手軽diff
" vimrc_example.vimより :e $VIMRUNTIME/vimrc_example.vim
"
" 現バッファの差分表示(変更箇所の表示)。
" TIPS: スワップファイルがあったときは、:recover して DiffOrigするとよさそう(要確認)
"
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis

"command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
"command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif

"----------------------------------------
" netrwでリモートファイルを開く 関連 {{{
" -L でリダイレクトを処理する
let g:netrw_http_xcmd= "-L -o"

" }}}

"----------------------------------------
" ブラウザを開くコマンド open-browser.vim 関連 {{{

" TIPS: カーソル上のURLを gx で開ける ( open-browser.vim + .vimrc )
" refs.
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

"----------------------------------------
" ウェブブラウザ関係 {{{
" w3m https://github.com/yuratomo/w3m.vim
nnoremap <Space>W    :<C-u>W3m<Space>
nnoremap <Space>w    :<C-u>W3mSplit<Space>
" デフォルト検索エンジン
" ※ googleを利用するときはie,oe でエンコーディングを指定すると化けないっぽい
let g:w3m#search_engine = 
\ 'https://encrypted.google.com/search?&hl=en&tbo=1&complete=0&num=100&ft=i&tbs=qdr:y&ie=' . &encoding . '&oe=' . &encoding . '&q='
"    \ 'http://search.yahoo.co.jp/search?search.x=1&fr=top_ga1_sa_124&tid=top_ga1_sa_124&ei=' . &encoding . '&aq=&oq=&p='

augroup my_w3m
    autocmd!
    autocmd BufWinEnter * call s:my_w3m_setting()
augroup END

function! s:my_w3m_setting()
    if exists('g:loaded_w3m') && g:loaded_w3m == 1
        " default UserAgent
        "call w3m#SetUserAgent('iOS', 1)
        "call w3m#SetUserAgent('chrome', 1)
    endif
endfunction
" }}}

"----------------------------------------
" vim-ref関係の設定 {{{
let g:ref_source_webdict_sites = {
\   'wikipedia:ja':     'http://ja.wikipedia.org/wiki/%s',
\   'alc':              {'url': 'http://eow.alc.co.jp/search?q=%s'},
\   'weblio_ejje':      {'url': 'http://ejje.weblio.jp/content/%s', 'cache': 1},
\   'weblio_ejje_examples': 
\       {'url': 'http://ejje.weblio.jp/content/%s', 'cache': 1},
\   'weblio_thesaurus': {'url': 'http://thesaurus.weblio.jp/content/%s', 'cache': 1},
\   'reference_com':    {'url': 'http://dictionary.reference.com/browse/%s'},
\ }


" デフォルト
let g:ref_source_webdict_sites.default = 'weblio_ejje'

" 出力フィルタ
function! g:ref_source_webdict_sites.alc.filter(output)
  let compact_output = substitute(a:output, "\n\n", "\n", "g")
  return join(split(compact_output, "\n")[39 :], "\n")
endfunction

" 上手くフィルタできない…
function! g:ref_source_webdict_sites.weblio_ejje.filter(output)
  "return join(split(a:output, "\n")[53 :], "\n")
  let compact_output = substitute(a:output, "\n\n", "\n", "g")
  return join(split(compact_output, "\n")[48 :], "\n")
endfunction

" 用例のみを出力
function! g:ref_source_webdict_sites.weblio_ejje_examples.filter(output)
  let examples_only = filter(copy(split(a:output, "\n")), 'v:val =~ "用例\\s"')
  return join(examples_only, "\n")
endfunction

function! g:ref_source_webdict_sites.weblio_thesaurus.filter(output)
  return join(split(a:output, "\n")[35 :], "\n")
endfunction

" TIPS: CTRL+K, <Space>ka で英語の辞書を引く
nnoremap <C-K>        :<C-u>Ref webdict weblio_ejje <C-R><C-W><CR><C-W><C-W>
"nnoremap <C-S-K>      :<C-u>Ref webdict weblio_ejje <C-R><C-W><CR><C-W><C-W>
nnoremap <Space><C-K> :<C-u>Ref webdict weblio_ejje <C-R><C-A>
nnoremap <Space>ka    :<C-u>Ref webdict alc <C-R><C-W><CR><C-W><C-W>
nnoremap <Space>kA    :<C-u>Ref webdict alc <C-R><C-A>
nnoremap <Space>kw    :<C-u>Ref webdict wikipedia:ja <C-R><C-W><CR><C-W><C-W>
nnoremap <Space>kW    :<C-u>Ref webdict wikipedia:ja <C-R><C-A>
nnoremap <Space>ke    :<C-u>Ref webdict weblio_ejje <C-R><C-W><CR><C-W><C-W>
nnoremap <Space>kE    :<C-u>Ref webdict weblio_ejje <C-R><C-A>
nnoremap <Space>kr    :<C-u>Ref webdict weblio_ejje_examples <C-R><C-W><CR><C-W><C-W>
nnoremap <Space>kR    :<C-u>Ref webdict weblio_ejje_examples <C-R><C-A>
nnoremap <Space>kt    :<C-u>Ref webdict weblio_thesaurus <C-R><C-W><CR><C-W><C-W>
nnoremap <Space>kT    :<C-u>Ref webdict weblio_thesaurus <C-R><C-A>


" }}}

"----------------------------------------
" TODO: swapファイルが見つかった時に簡単に処理する用
" refs. http://nanasi.jp/articles/howto/file/crash-recovery.html#id6
"command! Recover  recover | write! %.bk | e | vertical diffsplit %.bk
"現バッファの差分表示(変更箇所の表示)。
"command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
"command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif
" recover
" w! %.bk
" vert diffsplit 
" he :diffsplit
" e
" vert diffsplit %.bk

"----------------------------------------
" Haskell関係の設定 {{{
augroup my_haskell
  autocmd!
  autocmd FileType haskell call s:filetype_haskell_init()

  autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync
augroup END

function! s:filetype_haskell_init()
  nnoremap <buffer> <space>tt    :<C-u>QuickRun doctest<CR>
  nnoremap <silent> <space>tT    :<C-u>GhcModType<CR>
  nnoremap <silent> <space>tl    :<C-u>GhcModCheckAndLintAsync<CR>
  nnoremap <silent> <space><space> :<C-u>GhcModCheckAndLintAsync<CR>

  " http://mattn.kaoriya.net/software/vim/20150209151638.htm
  nnoremap <silent> <space>ht   :<C-u>GhcModType<CR>
  nnoremap <silent> <space>hh   :<C-u>GhcModTypeClear<CR>
  nnoremap <silent> <space>hT   :<C-u>GhcModTypeInsert<CR>
  nnoremap <silent> <space>hc   :<C-u>SyntasticCheck ghc_mod<CR>:lopen<CR>
  nnoremap <silent> <space>hl   :<C-u>SyntasticCheck hlint<CR>:lopen<CR>

endfunction

"----------------------------------------
" python関係の設定 {{{
augroup my_python
  autocmd!
  autocmd FileType python call s:filetype_python_init()
augroup END

function! s:filetype_python_init()
  " via http://oldriver.org/python/pep-0008j.html
  " PEP 8 Indent rule
  setl tabstop=8
  setl softtabstop=4
  setl shiftwidth=4
  setl smarttab
  setl expandtab
  setl autoindent
  setl nosmartindent
  setl cindent
  setl textwidth=80
  setl colorcolumn=80

  " Folding
  setl foldmethod=indent
  setl foldlevel=99
endfunction

" }}}

"----------------------------------------
" Ruby関係の設定 {{{
augroup my_ruby
  autocmd!
  autocmd FileType ruby call s:filetype_ruby_init()
augroup END

function! s:filetype_ruby_init()
  setl tabstop=2
  setl softtabstop=2
  setl shiftwidth=2
endfunction

" }}}

"----------------------------------------
" For prolog {{{

augroup my_prolog
  autocmd!

  " Reassign filetype some file extension as prolog
  autocmd BufRead,BufNewFile *.pro,*.swi set filetype=prolog
augroup END

"----------------------------------------
" 簡易todo処理 {{{
" ref. http://naoty.hatenablog.com/entry/2013/04/28/002926

" Press 'tl' and <leader>t to insert a new todo
abbreviate tl - todo:
abbreviate tL - [ ] 
" Press <leader>ta to insert a new todo
nnoremap <leader>ta ^i* todo: <ESC>
nnoremap <leader>tA ^i- [ ] <ESC>

" Press <leader>tt to toggle todos
nnoremap <leader>tt :<C-u>call ToggleTodoStatus()<CR>

" A Function for 
function! ToggleTodoStatus()
  let l:line = getline('.')

  " '* todo:' <-> '* DONE:'
  if l:line =~ '[\-\*]\stodo:'
    echo '- todo: -> DONE:'
    let l:result = substitute(l:line, '[\-\*]\stodo:', '* DONE:', '')
  elseif l:line =~ '[\-\*]\sDONE:'
    echo '- DONE: -> todo:'
    let l:result = substitute(l:line, '[\-\*]\sDONE:', '* todo:', '')

  " '- [ ] ' <-> '- [x] '
  elseif l:line =~ '[\-\*]\s\[\s\]'
    echo '- [ ] -> [x] '
    let l:result = substitute(l:line, '[\-\*]\s\[\s\]', '- [x]', '')
  elseif l:line =~ '[\-\*]\s\[x\]'
    echo '- [x] -> [ ] '
    let l:result = substitute(l:line, '[\-\*]\s\[x\]', '- [ ]', '')
  else
    return
  end
  call setline('.', l:result)
endfunction
" }}}

" template プラグイン {{{
let g:template_basedir="~/dev/"

" テンプレートの読み込み時の前処理
" 指針: できるだけテキストとしてそのまま使えるようにする(使い回しが効くように)
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
  " __FILE をファイル名で置き換える
  ":%s/__FILE__/\="'".expand('%:t')."'"/g

  " erbを通して処理する
  :%!erb
endfunction
" }}}

"let g:ruby_path = ""

let g:rsenseHome = expand('~/.vim/bundle/rsense')

set iminsert=1

"----------------------------------------
"よく忘れるTIPS集
"----------------------------------------
" TIPS: ":execute !" や "call system" 用ならshellescape, :edit や :cd なら fnameescape を使ってエスケープすること
" TIPS: 「*」「#」でカーソル下の単語で検索 便利!!!(#は*と逆方向)
" TIPS: 「/」「?」で検索(?は/と方向が逆で, nで上方向を見ていく)
" TIPS: 「yiw」でカーソル下の単語をヤンク
" TIPS: gf や <c-w>f でカーソル下のファイルを開く
" TIPS: ":noautocmd vimgrep" : vimgrepが遅い時はこれで
" TIPS: {count}CTRL-^ で count 番目のbuffer list のファイルに移動
" TIPS: Vimのリカバリ対処方法: * 読み込み専用(O): 中身を確認する時。他人がファイルを編集している時, * 復活させる(R): ファイルを復元したい時, * 削除する(D): ファイルを復元後。ファイル復元する必要がない時。, * 終了する(Q): 別のVimエディタで開いていることに気づいて開くのやめよう via Vimテクニックバイブル P76
" TIPS: mV で カーソル位置をマーク, 'V でマーク位置を開く(viminfoが有る限り記憶)
" TIPS: ]m で下方のメソッドの始まりへ移動。 ]M は終わりへ移動 (詳細は :help motion )
" TIPS: [m で上方のメソッドの始まりへ移動。 [M は終わりへ移動 (詳細は :help motion )
" TIPS: ]) で下方の閉じられていない ')' へ移動。 [} は '}' 版 (詳細は :help motion )
" TIPS: [( で上方の閉じられていない '(' へ移動。 [{ は '{' 版 (詳細は :help motion )
" TIPS: :setlocal autoread で tail -f のような挙動にする. refs. http://stackoverflow.com/questions/867721/tail-like-functionality-for-gvim
" Tipsを表示
command! Tips   noautocmd vimgrep /\ctips\:/g $MYVIMRC | cwindow


" ローカル環境用のファイルを読み込む
if filereadable(expand('~/.vimrc_local'))
  source ~/.vimrc_local
endif

colorscheme default
