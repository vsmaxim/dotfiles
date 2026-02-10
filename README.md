# dotfiles

Personal dotfiles for Arch Linux. Uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.

## Setup

Clone to your home directory and use `stow` to symlink:

```bash
cd ~
git clone <repo-url> dotfiles
cd dotfiles
stow .
```

This creates symlinks from `~/dotfiles/` into `$HOME`, mirroring the directory structure (e.g. `.config/i3/config` -> `~/.config/i3/config`).

## What's Included

| Category | Application | Config Path |
|---|---|---|
| Window Manager | i3wm | `.config/i3/` |
| Status Bar | i3status-rust | `.config/i3status-rust/` |
| Compositor | picom | `.config/picom/` |
| Launcher | rofi | `.config/rofi/` |
| Terminal | Kitty | `.config/kitty/` |
| Shell | Zsh + ZINIT + Starship | `.zshrc` |
| Editor | Neovim (vim-plug, CoC) | `.config/nvim/` |
| Editor | Cursor / VS Code | `.config/Cursor/`, `.config/Code/` |
| Editor | IdeaVim | `.ideavimrc` |
| Workspace Renamer | i3wsr | `.config/i3wsr/` |
| Fonts | fontconfig | `.config/fontconfig/` |
| Scripts | git-profile, kbfix, etc. | `.local/bin/` |

Theme: **Catppuccin Latte** everywhere, **JetBrains Mono Nerd Font**.

## Fresh Install

### Required Packages

Install with `yay` (or `pacman` for official repo packages):

```bash
# Core desktop
yay -S i3-wm i3status-rust picom rofi dunst feh i3wsr xss-lock i3lock

# Terminal & shell
yay -S kitty zsh starship

# Editor
yay -S neovim nodejs npm

# Audio
yay -S pipewire pipewire-pulse wireplumber pamixer

# Networking
yay -S networkmanager nm-applet

# Fonts
yay -S ttf-jetbrains-mono-nerd

# Utilities
yay -S maim xclip xcolor xdg-utils dex stow

# GPU (NVIDIA)
yay -S nvidia-open nvidia-utils
```

### Post-Install Steps

1. **Deploy dotfiles:**
   ```bash
   cd ~/dotfiles && stow .
   ```

2. **Enable audio services:**
   ```bash
   systemctl --user enable --now pipewire pipewire-pulse wireplumber
   ```

3. **Enable NetworkManager:**
   ```bash
   sudo systemctl enable --now NetworkManager
   ```

4. **Set up Neovim plugins:**
   ```bash
   nvim +PlugInstall +qall
   nvim +"TSUpdate" +qall
   ```

5. **Shell** - ZINIT auto-installs on first `zsh` launch. Set zsh as default:
   ```bash
   chsh -s /usr/bin/zsh
   ```

6. **Version managers** (optional, install as needed):
   - [pyenv](https://github.com/pyenv/pyenv) - Python
   - [nvm](https://github.com/nvm-sh/nvm) - Node.js
   - [jabba](https://github.com/shyiko/jabba) - Java
   - [pnpm](https://pnpm.io/) - Node package manager
