# Neovim Config

This is my neovim configuration. It is used as a submodule for my main dotfiles repo [here](https://github.com/lcroberts/dotfiles). It takes heavy inspiration from [NvChad](https://github.com/NvChad/NvChad) which was my first experience with using neovim as IDE. It used [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) as a base and has been heavily refactored since. It requires a few packages for everything to work properly. Here is a list:

- lldb (debugging)
- glow (markdown preview)
- npm (package management)
- go (package management)
- A C compiler (For treesitter) - For windows use mingw
- Make (For treesitter) - For windows use GnuWin32

To install just the neovim config you can run this command:

```bash
git clone https://github.com/lcroberts/nvim-config.git ~/.config/nvim
```

For windows:

```bash
git clone https://github.com/lcroberts/nvim-config.git $HOME\AppData\Local\nvim
```

If you want to remove the installation you can run the following:

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

For windows:

```Bash
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data
```


