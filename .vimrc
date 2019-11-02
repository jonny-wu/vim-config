set hlsearch "设置高亮搜索
set number "显示行号
set mouse=a "使用鼠标
set mouse=v "使用右键复制
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,gb18030,cp950,cp936 "设置文字编码自动识别
set termencoding=utf-8
set ambiwidth=double "全角字符
set showtabline=2 "显示标签栏
set laststatus=2 "状态栏在倒数第二行
set backspace=indent,eol,start
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set vb t_vb= "当vim进行编辑时，如果命令错误，会发出一个响声，该设置去掉响声
set tabstop=4 "硬TAB
set softtabstop=4 "软TAB
set shiftwidth=4 "缩进空格数
set expandtab "空格替换TAB
set completeopt=menu,longest
set updatetime=1000
set wildignore=.git
set cursorline "高亮行列
"set cursorcolumn
set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题
"set list "显示隐藏字符

"如果是terminator 等终端，需要配置color为256
if &term=="xterm"
    set t_Co=256
endif

syntax on "开启语法高亮
filetype plugin indent on "打开文件类型检测

"*****************************************************
"" vim leader map
let mapleader = ','

"*****************************************************
"" a.vim map
nnoremap <silent> <F4> :A<CR>

"*****************************************************
" Vundle设置
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/winmanager'
Plugin 'vim-scripts/a.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'moll/vim-bbye'
"color_coded always incorrect so use vim-cpp-highlight
"Plugin 'jeaye/color_coded'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rdnetto/YCM-Generator'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


nmap install:PluginInstall<CR>:!cd ~/.vim/bundle/YouCompleteMe<CR>:!./install.py --clang-completer<CR>:fc-cache -vf ~/.fonts<CR>
nmap uninstall:PluginClean<CR>
"*****************************************************
"" taglist.vim map
"let mapleader = ';'
"nmap <silent> <leader>l <ESC>:Tlist<CR>

" taglist.vim conf
let Tlist_Enable_Fold_Column = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Update = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 25

"把taglist窗口放在屏幕的右侧，缺省在左侧
"let Tlist_Use_Right_Window=1 
"显示taglist菜单
"let Tlist_Show_Menu=1
"启动vim自动打开taglist
"let Tlist_Auto_Open=1
" ctags, 指定tags文件的位置,让vim自动在当前或者上层文件夹中寻找tags文件
set tags=tags
" 添加系统调用路径
set tags+=/usr/include/tags
"键绑定，刷新tags
nmap tg :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q *<CR> :set tags+=./tags<CR>:!cscope -Rbq<CR>:cs add ./cscope.out .<CR> :YcmGenerateConfig <CR>

"*****************************************************
" Cscope 设置
if has("cscope")
    set csprg=/usr/bin/cscope   "指定用来执行cscope的命令
    set csto=0                  " 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库"
    set cst                     " 同时搜索cscope数据库和标签文件"
    set cscopequickfix=s-,c-,d-,i-,t-,e-    " 使用QuickFix窗口来显示cscope查找结果"
    set nocsverb
    if filereadable("cscope.out")    " 若当前目录下存在cscope数据库，添加该数据库到vim
        cs add cscope.out
    elseif $CSCOPE_DB != ""            " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
        cs add $CSCOPE_DB
    endif
    set csverb
endif
"map <F4>:!cscope -Rbq<CR>:cs add ./cscope.out .<CR><CR><CR> :cs reset<CR>
"对:cs find c等Cscope查找命令进行映射
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR><CR>
nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR><CR>
nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR><CR>
nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>
" 设定是否使用 quickfix 窗口来显示 cscope 结果
set cscopequickfix=s-,c-,d-,i-,t-,e-

"*****************************************************
"" NERD_tree.vim conf
"let loaded_netrwPlugin = 0
"let loaded_nerd_tree=1
let NERDTreeHijackNetrw = 0
let NERDTreeChDirMode = 2
let NERDTreeCaseSensitiveSort = 1
let NERDTreeIgnore = [ '^\.svn$', '^\.git$', '\~$', '\.o$', '\.lo$', '\.la$', '\.d$']
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
"let NERDTreeBookmarksFile=$VIM.'\bundle\nerdtree\data\nerdbookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
"let NERDTreeWinPos='left'
"let NERDTreeWinSize=31

"" NERD_tree.vim map
nmap <silent> <leader>e <ESC>:NERDTreeToggle<CR>
nmap <silent> <leader>f <ESC>:NERDTreeFind<CR>

" NERD_comment.vim map
"let mapleader = ','

"****************************************************
" WinManager设置
" NERD_Tree集成到WinManager
let g:NERDTree_title="[NERDTree]" 
function! NERDTree_Start()
    exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
    return 1
endfunction

"在进入vim时自动打开winmanager
let g:AutoOpenWinManager = 1

" 键盘映射，同时加入防止因winmanager和nerdtree冲突而导致空白页的语句
nmap wm :if IsWinManagerVisible() <BAR> WMToggle<CR> <BAR> else <BAR> WMToggle<CR>:q<CR> endif <CR><CR>
" 设置winmanager的宽度，默认为25
let g:winManagerWidth=30 
" 窗口布局
let g:winManagerWindowLayout='NERDTree|TagList'
" 如果所有编辑文件都关闭了，退出vim
let g:persistentBehaviour=0

"*****************************************************
" airline设置
set laststatus=2
" 使用powerline打过补丁的字体
let g:airline_powerline_fonts = 1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

"*****************************************************
" Bbye设置
" 由于原生的:bd在删除当前buffer时会将整个窗口关闭，故使用Bbye的:Bd
nnoremap bd :Bd<CR>

"*****************************************************
"vim-cpp-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1

"*****************************************************
"YouCompleteMe
"
"let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.c = ['->', '.', '(', '[', '&']

let g:ycm_max_constructives_to_display = 0

" YouCompleteMe 功能  
" 补全功能在注释中同样有效  
let g:ycm_complete_in_comments=0
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示  
let g:ycm_confirm_extra_conf=0
" 开启 YCM 基于标签引擎  
let g:ycm_collect_identifiers_from_tags_files=1  
" 引入 C++ 标准库tags，这个没有也没关系，只要.ycm_extra_conf.py文件中指定了正确的标准库路径  
"set tags+=/data/misc/software/misc./vim/stdcpp.tags  
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键  
inoremap <leader>; <C-x><C-o>  
" 补全内容不以分割子窗口形式出现，只显示补全列表  
set completeopt-=preview  
" 从第一个键入字符就开始罗列匹配项  
let g:ycm_min_num_of_chars_for_completion=3
" 禁止缓存匹配项，每次都重新生成匹配项  
"let g:ycm_cache_omnifunc=0  
" 语法关键字补全              
let g:ycm_seed_identifiers_with_syntax=1  
" 设置转到定义处的快捷键为ALT + G，这个功能非常赞  
nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>  
" 设置按哪个键上屏
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']

"*****************************************************
"自动添加文件头
"
:autocmd FileWritePre,BufNewFile *.[ch],*.hpp,*.cpp,*.c++,*.h++ exec ":call SetComment()"

function! SetComment()
    call setline(1,"/*")
    call append(line("."),"* @file:".expand("%:t"))
    call append(line(".")+1,"* @brief:")
    call append(line(".")+2,"* @version: 0.0")
    call append(line(".")+3,"* @author: wugengchen")
    call append(line(".")+4,"* @data:".strftime("%Y/%m/%d"))
    call append(line(".")+5,"*/")
    call append(line(".")+6,"/******************************************************************************")
    call append(line(".")+7,"@note")
    call append(line(".")+8,"      Copyright 2017, Megvii Corporation, Limited")
    call append(line(".")+9,"                              ALL RIGHTS RESERVED")
    call append(line(".")+10,"******************************************************************************/")
endfunction

"insert comment 
nmap <leader>ih:call SetCommnet()<CR>




