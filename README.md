# NeoVim Configuration

Requires `nvim` version 0.12+.

## Install

```bash
rm -rf ~/.config/nvim ~/.cache/nvim ~/.local/share/nvim
git clone git@github.com:micha/nvim-config ~/.config/nvim
```

## Tree Sitter

Install desired parsers from the [list of parsers][1]:

```lua
plugin('nvim-treesitter/nvim-treesitter', {}, function(m)
  m.install({
    "bash",
    "c",
    "clojure",
  })
end)
```

## LSP

Download, build, and install LSP servers interactively:

```vim
:Mason
```

Then enable them, using their [`lspconfig` names][2]:

```lua
plugin('neovim/nvim-lspconfig', function()
  vim.lsp.enable({
    "clojure_lsp",
    "coffeesense",
    "lua_ls",
  })
end)
```

[1]: https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
[2]: https://github.com/neovim/nvim-lspconfig/tree/master/lsp
