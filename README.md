Repository for my personal config files, such as .bashrc and .gitconfig, that don't belong in separate repositories.

Purely for my convenience, and unlikely to be of interest to anyone else.

Installation is via the Makefile.  You will need gnu-stow installed.
Make can be run as often as necessary to keep things up to date.

Reference, particularly the `--no-folding` usage, is [this post](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) (the `--no-folding` argument is to prevent `stow` from making as many directories as possible into symlinks.  Ie, if `~/.config` doesn't exist initially then `stow .` on its own would make it into a symlink.  With this argument, directories are created as needed, and only files are symlinked).
