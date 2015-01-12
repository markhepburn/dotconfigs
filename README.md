Repository for my personal config files, such as .bashrc and .gitconfig, that don't belong in separate repositories.

Purely for my convenience, and unlikely to be of interest to anyone else.

Installation is via the shell script create_links.sh.  Alternatively, you can run [`stow --no-folding .`](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) (the `--no-folding` argument is to prevent `stow` from making as many directories as possible into symlinks.  Ie, if `~/.config` doesn't exist initially then `stow .` on its own would make it into a symlink.  With this argument, directories are created as needed, and only files are symlinked).
