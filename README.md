# 💤 LazyVim Branch

This branch contains a LazyVim starter configuration that can be customized while staying up-to-date with upstream changes.

## Branch Workflow

This is the `lazyvim` branch of a multi-configuration Neovim setup. The repository structure:
- `main` - Custom plain Neovim config (built from scratch)
- `kickstart` - Kickstart-modular configuration  
- `lazyvim` - LazyVim starter with custom modifications (this branch)

## Customization & Updates

### Making Your Changes
```bash
git checkout lazyvim
# Edit files, customize LazyVim to your liking
git add . && git commit -m "My LazyVim customizations"
git push origin lazyvim  # Saves your changes to your repo
```

### Staying Updated with LazyVim
```bash
git checkout lazyvim
git pull lazyvim-upstream main  # Pulls latest LazyVim updates
# Resolve any conflicts between your changes and upstream
git push origin lazyvim  # Pushes merged result to your repo
```

### Benefits
- ✅ Your customizations are tracked in your own repository
- ✅ LazyVim updates get merged into your branch seamlessly  
- ✅ Full git history of both your changes and upstream updates
- ✅ Easy switching between different configs (`git checkout main/kickstart/lazyvim`)

## LazyVim Resources

- [LazyVim Documentation](https://lazyvim.github.io/installation)
- [LazyVim GitHub](https://github.com/LazyVim/LazyVim)
- [LazyVim Starter Template](https://github.com/LazyVim/starter)
