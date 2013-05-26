# MPogoda's dotfiles

Dotfiles, gathered from pieces of other people' dotfiles all around the world.
Currently, it holds configuration files for:
  * [VIm](http://vim.org)
  * [XMonad](http://xmonad.org)
  * [XMobar](http://projects.haskell.org/xmobar)
  * [Zsh](http://zsh.org)
  * [git](http://git-scm.com)
  * [tmux](http://tmux.sourceforge.net)
  * [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode)
  * [Tig](http://jonas.nitro.dk/tig)
  * etc

Although they all present in this repo, they are (mostly) not interdependent.

## Dependencies

 * VIm 7+
 * git v1.7.11+ (for push.default = simple)
 * [kbdd](https://github.com/qnikst/kbdd).
 * [xkb-switch](https://github.com/ierton/xkb-switch). Used by vim-xkbswitch
   plugin
 * [clang](http://clang.llvm.org)
 * [Exuberant ctags 5.5](http://ctags.sourceforge.net). Used by vim/tagbar

## Submodules

Vim plugins are added as git-submodules to this repo.
To initialise them you should run
```
git submodule init && git submodule update
```
And to update them (after succesfull pull of this repo):
```
git submodule update
```

### Thanks to
  * [sunaku's .vim](https://github.com/sunaku/.vim)
  * [zsh-lovers config](http://grml.org/zsh)
