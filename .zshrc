# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="random"
#ZSH_THEME="miloshadzic"    # smarty
#ZSH_THEME="steeef"         # Pretty goood, double line, split between commands
#ZSH_THEME="cloud"          # Cuuuuuute ☁  foobar [master]
#ZSH_THEME="rixius"         # Colored and simple, split between commands
#ZSH_THEME="nicoulaj"       # Usefull prompt color to notify program error 
#ZSH_THEME="terminalparty"  # Left side status is so cuuuuute!!!!!
#ZSH_THEME="lukerandall"    # Right side program error notify is so benri.
#ZSH_THEME="smt"            # 福 prompt
#ZSH_THEME="af-magic"       # コマンドとコマンドの間の下線がよい
#ZSH_THEME="trapd00r"       # gitのステータスが色つきで見やすい
#ZSH_THEME="josh.zs"        # コマンドラインの色(編集業とか)がかっこいい
#ZSH_THEME="superjarin"     # colorfull!!
#ZSH_THEME="sunaku"         # simple and has RED COLRED error status

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)
#
#### my plugin setting ####
plugins+=(ruby gem rake thor rbenv rails)
plugins+=(bundler)                # for ruby http://gembundler.com/
plugins+=(cap)                    # capistrano  https://github.com/capistrano/capistrano
plugins+=(command-not-found)
plugins+=(heroku)                 # http://www.heroku.com/
plugins+=(knife)                  # chef
plugins+=(debian)                 # apt-get, aptitude
plugins+=(python pip)             # for python
plugins+=(vagrant)                # easy ready to make develop environment
plugins+=(compleat)               # completion for 
#plugins+=(autojump)               # easy to jump directory https://github.com/joelthelion/autojump
plugins+=(urltools)                 # for urlencode(), urldecode()

# custom plugins
plugins+=(z)                        # easy to jump directory https://github.com/rupa/z.git
plugins+=(show-buffer-stack)        # show previous command when stack command with Ctrl-Q 

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$HOME/perl5/bin:$HOME/.cabal/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

export PERL_CPANM_OPT="--local-lib=~/perl5"
#export PATH=$HOME/perl5/bin:$PATH;
export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB;

# 履歴を補完に使いたいので、可能な限り履歴数を増やしたい
HISTSIZE=1000000
SAVEHIST=1000000

# 意図せずCTRL-Dでログアウトしてしまうので、無視したい
setopt IGNORE_EOF

# CTRL-Sを使う場面がある(vimとか)ので、一部のフロー制御を無効化する
stty stop undef
# やっぱり全部無視する
setopt noflowcontrol

# interactive shell でも '#' 以降をコメントとして扱いたい
setopt INTERACTIVE_COMMENTS


# デフォルトのlsを変更
# --reverse --sort=time:    一番下を最新のファイルに
# --human-readable:         ファイルサイズを読みやすい形に
# --time-style=long-iso:    日付を 2000-xx-xx xx:xx の形に
# --color=auto:              色をつける
alias ls='ls --all --reverse --sort=time --human-readable --time-style=long-iso --color=auto'
#  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# 指定秒以上まったら、経過秒を報告する
REPORTTIME=3

# 最近のディレクトリに移動する(zsh 4.3.15以降？)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# Vim for Linux Desktop(Fedora)
# $ dnf install vim-x11
# ref http://vi.stackexchange.com/questions/2063/how-do-i-get-clipboard-support-in-fedora-20
if [[ -x "$(which vimx)" ]] ; then
    alias vi='vimx'
    alias vim='vimx'
fi


# for gisty
export GISTY_DIR="$HOME/dev/gists"

# for syntax highlight
alias c='pygmentize -O bg=dark -g'
alias -g HI='| pygmentize -O bg=dark -g'
alias -g LH="HI | less -R"

# フォルダとかディスクのサイズの表示
alias du="du -h"
alias df="df -h"
alias diskusage=du
alias dirsize="du -csh"
alias dirsizels="ls -lSrh"
alias dirsizesorted="du --total --summarize --human-readable * | sort --human-numeric-sort"

# refs. http://grml.org/zsh/zsh-lovers.html#_examples
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g CA="2>&1 | cat -A"
alias -g C='| wc -l'
alias -g D="DISPLAY=:0.0"
alias -g DN=/dev/null
alias -g ED="export DISPLAY=:0.0"
alias -g EG='|& egrep'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g F=' | fmt -'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g MM='| most'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g PIPE='|'
alias -g R=' > /c/aaa/tee.txt '
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g VM=/var/log/messages
alias -g X0G='| xargs -0 egrep'
alias -g X0='| xargs -0'
alias -g XG='| xargs egrep'
alias -g X='| xargs'

# tips: foobar J で pretty print for json
alias -g J='| python -mjson.tool'

# tips: foobar CL で、easy out to clipboard
alias -g CL='| xsel -ib'

# tips: foobar V で、結果をvimのreadonlyで表示
alias -g V='| view -'

# tips: HEXやBIN,BINCのglobal aliasでバイナリ表示できます 0が続くと は"*"と省略表示されます(-v)
alias hex='hexdump -C'          # バイナリを16進数表示 右に文字を表示
alias hexc='hexdump -c'         # バイナリを16進数表示 文字をそのまま表示
alias bin='od -tx1z -Ax'        # 改行コードや表示不可文字を表示
alias binc='od -tx1c -Ax'       # 下に並べて表示 表示不可文字が8進数になるのがよくわからない
alias -g HEX='| hexdump -C'     # バイナリを16進数表示 右に文字を表示
alias -g HEXC='| hexdump -c'    # バイナリを16進数表示 文字をそのまま表示
alias -g BIN='| od -tx1z -Ax'   # 改行コードや表示不可文字を表示
alias -g BINC='|  od -tx1c -Ax' # 下に並べて表示 表示不可文字が8進数になるのがよくわからない

# for anything dump
[[ -e $HOME/.zsh/aump.zsh ]] && source $HOME/.zsh/aump.zsh

# tips: curl http://example.com/ W でhtmlとしてw3mで開く(W3Mでも可能)
alias -g W="| w3m -T text/html"
alias -g W3M=W
alias -g W3MHTML=W

# tips: w http://example.com/ でhtmlとしてURIを開く(wwwでも可能)
alias www="w3m -T text/html"
alias w3mhtml=www
alias w=www

# tips: foobar A log で出力をlogに追記
alias -g A="| tee --append"
alias -g EA="|& tee --append"

# tips: s2 filename でsjisから文字コード変換して出力。S2 というグローバルエイリアスあり
# iconv: -c は エラーを無視して変換
alias -g S2='| iconv -c -f sjis'
alias -g E2='| iconv -c -f euc-jp'
alias -g S2U='| iconv -c -f sjis -t utf-8'
alias -g E2U='| iconv -c -f euc-jp -t utf-8'
alias s2='iconv -c -f sjis'
alias e2='iconv -c -f euc-jp'
alias s2u='iconv -c -f sjis -t utf-8'
alias e2u='iconv -c -f euc-jp -t utf-8'

# tips: unzip -Ocp932 で Windowsで作られたcp932(Windows 用のsjis拡張)のファイル名のzipを開く。 unzip4winにalias済み
alias unzip-win="unzip -Ocp932"
alias unzip4win=unzip-win

# github関係
function githubcd() {
  cd "$HOME/dev/github/$1"
}
alias ghcd=githubcd

# tips: ヒアドキュメント1: $ tr a-z A-Z <<-'EOD'\n$fuba_recorder = 500000yen\nEOD
# tips: ヒアドキュメント2: $ tr a-z A-Z <<<'$fuba_recorder = 500000'


# zsh の zmv を使って簡単に複数ファイルを一括リネームする http://d.hatena.ne.jp/mollifier/20101227/p1
autoload -Uz zmv
# こんな感じに簡単にかけるようなalias
# tips: $ zmv *.txt mage-*.txt, zmv
# -w: カッコ省略できるように
#   $ zmv '(*)_(*).txt' 'mage-$1_$2.txt'
#     ↓
#   $ zmv '*_*.txt' 'mage-$1_$2.txt'
# -W: $数値を省略できるように
#   $ zmv '*_*.txt' 'mage-$1_$2.txt'
#     ↓
#   $ zmv '*_*.txt' 'mage-*_*.txt'
# noglob: zshのワイルドカード展開を切れば''が要らなくなる
#   $ zmv '*_*.txt' 'mage-*_*.txt'
#     ↓
#   $ zmv *_*.txt mage-*_*.txt
alias zmv='noglob zmv -W'
#  tips: zmv -n: 実行せずに表示だけ(実行前の確認用)
alias zmv-dryrun='noglob zmv -n -W'
alias zmvn=zmv-dryrun
# etc
#  tips: zmvで-C: mvの代わりにcpする
alias zmvc='noglob zmv -C -W'
alias zmvc-dryrun='noglob zmv -n -C -W'
alias zmvcn=zmvc-dryrun
alias zcp=zmvc
alias zcpn=zmvc-dryrun
alias zcp-dryrun=zmvc-dryrun
#  tips: zmvで-C: -L -s: : mvの代わりにsymlink貼る
alias zmvlns='noglob zmv -L -s -W'
alias zmvlns-dryrun='noglob zmv -n -L -s -W'
alias zmvlnsn=zmvlns-dryrun
alias zlns=zmvlns
alias zlns-dryrun=zmvlns-dryrun
alias zlnsn=zmvlns-dryrun
# zmvのtipsを表示
function zmvhelp(){
    echo "**** zmv tips ****************************"
    grep -P -i 'tips\:.*zmv' ~/.zshrc | sed 's/#.*tips: *//g'
}
# see
#   - man zshexpn , http://zsh.sourceforge.net/Doc/Release/Expansion.html#SEC69
#   - man zshcontrib, http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC291

# like xargs
autoload zargs

# zaw - zsh anything.el-like widget
# https://github.com/zsh-users/zaw
# TIPS: Ctrl-X ; to anything.el-like widget via zaw
if [[ -e $HOME/.zsh/zaw/zaw.zsh ]]; then
  source $HOME/.zsh/zaw/zaw.zsh

  # TIPS: Ctrl-X ; to anything.el-like widget via zaw
  # replace CTRL-R
  bindkey '^R' zaw-history

  # TIPS: CTRL-@ でディレクトリ移動
  # [zaw.zshで最近移動したディレクトリに移動する - $shibayu36->blog;](http://shibayu36.hatenablog.com/entry/20120130/1327937835)
  zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitiveに
  bindkey '^@' zaw-cdr # zaw-cdrをbindkey
fi

# for vagrant
[[ -e "$HOME/.zsh/vagrant.zsh" ]] && source "$HOME/.zsh/vagrant.zsh"
#
# for git
[[ -e "$HOME/.zsh/git-aliases.zsh" ]] && source "$HOME/.zsh/git-aliases.zsh"

# for gitignore
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}


# TIPS: see oh-my-zsh cheatsheet https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet"

# コマンドとコマンドの間に区切りを付ける
# Add separating line between commands
# cf. oh-my-zsh af-magic theme https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
if [[ ! ( $PROMPT =~ '-----------------------------------------' ) ]]; then
    PROMPT='$FG[237]------------------------------------------------------------%{$reset_color%}
'"$PROMPT"
fi

# load local env
# refs. .zshrc.localのススメ http://qiita.com/items/1d5cd440ce58ef4fb8ae
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Show like DAILY TIPS
[[ -x $(which tips-english-random.rb) ]] && tips-english-random.rb
[[ -x $(which tipsrandom.zsh) ]] && tipsrandom.zsh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Added for node-js
if [[ -d $HOME/.ndenv ]]; then
    export PATH="$HOME/.ndenv/bin:$PATH"
    eval "$(ndenv init -)"
fi


### Added for SML nj http://www.smlnj.org/install/
if [[ -d "$HOME/opt/sml/bin" ]]; then
    export PATH="$HOME/opt/sml/bin:$PATH"
fi

### For android studio
if [[ -d "$HOME/opt/android-studio/bin" ]]; then
    export PATH="$HOME/opt/android-studio/bin:$PATH"
fi

### Added for ADT Bundle(Android SDK)
# ref. http://note.chiebukuro.yahoo.co.jp/detail/n173086
if [[ -d "$HOME/opt/adt-bundle/sdk" ]]; then
    export PATH="$HOME/opt/adt-bundle/sdk/tools/:$HOME/opt/adt-bundle/sdk/platform-tools/:$PATH"
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/opt/adt-bundle/sdk/tools/lib
fi

# added by travis gem
if [[ -x "$HOME/.travis/travis.sh" ]]; then
    source "$HOME/.travis/travis.sh"
fi

# Add for golang
if [[ -d "$HOME/.go/" ]]; then
    export GOPATH=$HOME/.go
    export PATH="$PATH:$GOPATH/bin"
fi

# OPAM configuration
. "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null || true

# Added for Anaconda
if [[ -d "$HOME/opt/anaconda3/bin" ]]; then
    export PATH="$PATH:$HOME/opt/anaconda3/bin"
fi

# For stack on haskell
# refs. http://docs.haskellstack.org/en/stable/shell_autocompletion.html
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

if which stack >/dev/null 2>&1 ; then
    eval "$(stack --bash-completion-script stack)"
fi
