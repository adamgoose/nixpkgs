{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    coc.enable = true;

    plugins = with pkgs.vimPlugins; [
      yankring
      vim-tmux-navigator
      { plugin = nord-nvim;
        config = "let g:nord_disable_background = v:true";
      }
      vim-gitgutter # Git Line Indicators
      indent-blankline-nvim
      plenary-nvim
      { plugin = telescope-nvim;
        config = ''
          nnoremap <C-P> <cmd>Telescope find_files<cr>
        '';
      }
      { plugin = vim-airline;
        config = ''
          let g:airline#extensions#tabline#enabled = 1
        '';
      }
      { plugin = vim-airline-themes;
        config = ''
          let g:airline_theme = 'nord_minimal'
        '';
      }

      # Language Servers
      { plugin = syntastic;
        config = ''
          " Syntastic Config
          set statusline+=%#warningmsg#
          set statusline+=%{SyntasticStatuslineFlag()}
          set statusline+=%*

          let g:syntastic_always_populate_loc_list = 1
          let g:syntastic_auto_loc_list = 1
          let g:syntastic_check_on_open = 1
          let g:syntastic_check_on_wq = 0
        '';
      }

      # LSP Context Statusline
      # look at https://www.reddit.com/r/neovim/comments/vv1jt3/comment/ifh49ti/?utm_source=reddit&utm_medium=web2x&context=3

      # File Tree Sidebar
      { plugin = nerdtree;
        # config = "nnoremap <C-t> :NERDTreeToggle<CR>";
        config = ''
          let NERDTreeShowHidden = 1
          " Start NERDTree when Vim starts with a directory argument.
          autocmd StdinReadPre * let s:std_in=1
          autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
              \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
          " Exit Vim if NERDTree is the only window left.
          autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
                \ quit | endif
          " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
          " autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
          "     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

          " Show/Hide NERDTree
          nnoremap <C-t> :NERDTreeToggle<CR>

          " Reveal in NERDTree
          nnoremap <leader>r :NERDTreeFind<cr>

          " Use K to show documentation in preview window
          nnoremap <silent> K :call ShowDocumentation()<CR>

          function! ShowDocumentation()
            if CocAction('hasProvider', 'hover')
              call CocActionAsync('doHover')
            else
              call feedkeys('K', 'in')
            endif
          endfunction
        '';
      }

      # Not sure
      { plugin = vim-startify;
        config = "let g:startify_change_to_vcs_root = 0";
      }
    ];

    extraConfig = ''
      colorscheme nord
      set mouse=a
      set splitbelow
      set splitright
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab

      " To open a new empty buffer
      " This replaces :tabnew which I used to bind to this mapping
      nmap <leader>T :enew<cr>

      " Move to the next buffer
      nmap <leader>l :bnext<CR>

      " Move to the previous buffer
      nmap <leader>h :bprevious<CR>

      " Close the current buffer and move to the previous one
      " This replicates the idea of closing a tab
      nmap <leader>bq :bp <BAR> bd #<CR>

      " Simulate CtrlP
      " nmap <C-P> :FZF<CR>
    '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
    GIT_EDITOR = "vim";
    VISUAL = "vim";
  };
}
