# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for an Arch Linux setup. Managed with [GNU Stow](https://www.gnu.org/software/stow/) — run `stow .` from the repo root to symlink everything into `$HOME`.

## Organization

Follows XDG Base Directory conventions:
- `.config/[app]/` — per-application configs (i3, nvim, kitty, rofi, picom, starship, etc.)
- `.local/bin/` — custom scripts (git-profile, docker-start/stop, kbfix, VPN helpers)
- Root-level dotfiles: `.zshrc`, `.ideavimrc`

## Configured Applications

- **WM/Desktop:** i3wm + i3status-rust + picom + rofi
- **Terminal:** Kitty
- **Shell:** Zsh (ZINIT plugin manager, Starship prompt)
- **Editors:** Neovim (vim-plug, CoC LSP), Cursor, VS Code, IdeaVim
- **Version managers:** pyenv, nvm (lazy-loaded), jabba (Java)
- **Theme:** Catppuccin Latte everywhere (i3, rofi, kitty, nvim, Cursor), JetBrains Mono font

## Gitignore Strategy

Most of `.local/bin/` and `.config/Code/` / `.config/Cursor/` are ignored. Only specific files are tracked — check `.gitignore` before adding new paths under these directories.

## Key Details

- Neovim uses vim-plug (`:PlugInstall`) and tree-sitter (`:TSUpdate`)
- `.zshrc` auto-installs ZINIT on first run and auto-starts X11 on VT1
- `git-profile` script in `.local/bin/` manages multiple Git identities with GPG signing
- i3 config references custom scripts in `.local/bin/` for keyboard layout and VPN
