# 🚀 Kickstart Branch

This branch contains a Kickstart-modular configuration that can be customized while staying up-to-date with upstream changes.

## Branch Workflow

This is the `kickstart` branch of a multi-configuration Neovim setup. The repository structure:
- `main` - Custom plain Neovim config (built from scratch)
- `kickstart` - Kickstart-modular reference configuration (this branch)
- `lazyvim` - LazyVim starter with custom modifications

## Staying Updated with Kickstart-Modular

### Making Your Changes
```bash
git checkout kickstart
# Edit files, customize Kickstart to your liking
git add . && git commit -m "My Kickstart customizations"
git push origin kickstart  # Saves your changes to your repo
```

### Merging Upstream Updates
```bash
git checkout kickstart
git pull kickstart-upstream master  # Pulls latest Kickstart updates
# Resolve any conflicts between your changes and upstream
git push origin kickstart  # Pushes merged result to your repo
```

### Benefits
- ✅ Your customizations are tracked in your own repository
- ✅ Kickstart updates get merged into your branch seamlessly  
- ✅ Full git history of both your changes and upstream updates
- ✅ Easy switching between different configs (`git checkout main/kickstart/lazyvim`)

---

## About Kickstart-Modular

A modular starting point for Neovim that is:
* Small & focused
* Modular structure  
* Completely documented
* **NOT** a distribution, but a starting point

### Quick Start

1. **Install Neovim** (latest stable or nightly)
2. **Install dependencies**: `git`, `make`, `unzip`, C compiler, `ripgrep`, `fd`
3. **Switch to this branch**: `git checkout kickstart`
4. **Start Neovim**: `nvim`

That's it! Lazy will install all plugins automatically.

### Key Features

- **Modular configuration** - Split into logical files
- **LSP support** - Language server integration
- **Telescope** - Fuzzy finder for files, buffers, etc.
- **Treesitter** - Better syntax highlighting
- **Git integration** - Gitsigns for change indicators
- **Auto-completion** - nvim-cmp with multiple sources

### Configuration Structure

```
lua/
├── config/
│   ├── branch-isolation.lua  # Plugin isolation per branch
│   └── ...                   # Other config modules
├── options.lua               # Neovim options
├── keymaps.lua              # Key mappings
├── lazy-bootstrap.lua       # Plugin manager setup
└── lazy-plugins.lua         # Plugin configurations
```

### Kickstart Resources

- [Kickstart-Modular GitHub](https://github.com/dam9000/kickstart-modular.nvim)
- [Original Kickstart](https://github.com/nvim-lua/kickstart.nvim)
- [Neovim Documentation](https://neovim.io/doc/)
