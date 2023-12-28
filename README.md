# Neovim Config

This is my neovim configuration. It is used as a submodule for my main dotfiles repo [here](https://github.com/lcroberts/dotfiles). It takes heavy inspiration from [NvChad](https://github.com/NvChad/NvChad) which was my first experience with using neovim as IDE. [LazyVim](https://github.com/LazyVim/LazyVim) has also had a good amount of influence as well. Folke's work on it and many of the plugins in this config is amazing. It used [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) as a base and has been heavily refactored since. It requires a few packages for everything to work properly. Here is a list:

- lldb (debugging)
- glow (markdown preview)
- npm (package management)
- Python (package management)
- A C compiler (For treesitter) - For windows use mingw
- Make (For treesitter) - For windows use GnuWin32
- RipGrep (For telescope)

To install just the neovim config you can run this command:

```bash
git clone https://github.com/lcroberts/nvim-config ~/.config/nvim
```

For windows:

```bash
git clone https://github.com/lcroberts/nvim-config $HOME\AppData\Local\nvim
```

If you want to remove the installation you can run the following:

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

For windows:

```Bash
rd -Recurse -Force ~\AppData\Local\nvim
rd -Recurse -Force ~\AppData\Local\nvim-data
```

You can find my main dotfiles repo [here.](https://github.com/lcroberts/dotfiles)

