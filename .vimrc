set encoding=utf-8
scriptencoding utf-8

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" Install Plugin
call vundle#begin()

Plugin 'gmarik/vundle.vim' " プラグインマネージャ
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'itchyny/lightline.vim' " 編集してるファイルの詳細情報を表示
Plugin 'tomasr/molokai' "molokaiで配色をカラフルにする
Plugin 'bronson/vim-trailing-whitespace' " 末尾の全角と半角の空白文字をハイライト :FixWhitespace で全て削除
Plugin 'Yggdroot/indentLine' " インデントの可視化
Plugin 'ctrlpvim/ctrlp.vim' " 多機能セレクタ ファイルの検索やバッファの検索などの機能を提供
Plugin 'tacahiroy/ctrlp-funky' " CtrlPの拡張プラグイン. 関数検索
Plugin 'suy/vim-ctrlp-commandline' " CtrlPの拡張プラグイン. コマンド履歴検索

call vundle#end() " required
filetype plugin indent on " required

" unite.vim設定
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

"----------------------------------------------------------
" カラースキーム
"----------------------------------------------------------
colorscheme molokai
set t_Co=256 " iTerm2など既に256色環境なら無くても良い
syntax enable " 構文に色を付ける

"----------------------------------------------------------
" ステータスライン
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id()) " CtrlPCommandLineの有効化
let g:ctrlp_funky_matchtype = 'path' " CtrlPFunkyの有効化

set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号表示
set cursorline " カーソルラインをハイライト

"----------------------------------------------------------
" 文字
"----------------------------------------------------------
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,mac,dos " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

"----------------------------------------------------------
" タブ・インデント
"----------------------------------------------------------
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=4 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=4 " smartindentで増減する幅

"----------------------------------------------------------
" 文字列検索
"----------------------------------------------------------
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set showmatch " 括弧の対応関係を一瞬表示する

"----------------------------------------------------------
" コマンドモード
"----------------------------------------------------------
set wildmenu " コマンドモードの補完
set history=3000 " 保存するコマンド履歴の数

"----------------------------------------------------------
" マウスによるカーソル移動とスクロールを有効
"----------------------------------------------------------
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

"----------------------------------------------------------
" クリップボードからペーストする時だけインデント禁止
"----------------------------------------------------------
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"---------------------------------------------------------
" Yank to Clipboard
"---------------------------------------------------------
set clipboard=unnamed,autoselect
set backspace=indent,eol,start
" No Yank
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
