# Neovim Config

This is my neovim configuration. It allows for selecting which languages are
available by creating a file called languages.lua in the lua directory of the
config. The file should return a table of languages out of the supported
options. The languages-example.lua file contains all valid languages in the
correct format. Additional languages can be added by copying the template file
in the lua/language\_configs directory. The one caveat is that to add null\_ls
builtins to the sources you do have to modify the null\_ls config file.


General Dependencies:
- lldb (debugging)
- A C compiler (For treesitter) - For windows use mingw
- Make (For treesitter) - For windows use GnuWin32
- RipGrep (For telescope)

## Installation 

To install just the neovim config you can run this command:

```bash
git clone https://github.com/lcroberts/nvim-config ~/.config/nvim
```

For windows:

```bash
git clone https://github.com/lcroberts/nvim-config $HOME\AppData\Local\nvim
```

## Removal

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

## Supported Languages

### Defaults

Stylua (formatter), Selene (linter), and lua language server are provided for lua support.

Language servers are also provided for yaml, json, and toml.

### Bash

Provides: shfmt (formatter) and bash language server.

### Python

Dependencies: python/pip for package management
Provides: python language server


### C & C++

Provides: clangd (language server w/ formatter), and clangd\_extensions.nvim (plugin)

### Go

Dependencies: go

Provides: gofmt (formatter), gopls (language server), and golangci\_lint (linter)

### PHP

Dependencies: php and composer

Provides: Intelephense (language server), pint (php formatter), blade\_formatter (blade template formatter), laravel.nvim (plugin) and phpactor (vim plugin for refactoring)

### Javascript

Includes typescript and jsx support.

Dependencies: npm

Provides: tsserver (lsp), and typescript-tools.nvim (configures tsserver and adds refactoring tools)

### HTML & CSS

Includes tailwind completions, as well as html with emmet.

### SQL

Provides: sql language server

### Rust

Dependencies: Cargo/rust

Provides: rustaceanvim (basic language support plugin), crates.nvim (crates support), rust.vim (more rust features)

### Zig

Dependencies: zig

Provides: zls (zig language server)
