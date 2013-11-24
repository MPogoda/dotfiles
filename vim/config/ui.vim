set cursorline      " highlight currently focused line
set relativenumber  " show line numbers relative to cursor
set novisualbell    " don't flash the screen
set laststatus=2    " always show status line
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildmenu        " tab-completion menu for command mode
set wildmode=list:longest,full
set list            " display otherwise invisible characters
set listchars=tab:\\_,extends:>,precedes:<,nbsp:%
set noshowmode
set lazyredraw      " don't redraw screen while macros are executing
