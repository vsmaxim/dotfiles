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

Two parallel desktop sessions are configured — Hyprland is primary, i3 is kept for the NVIDIA box where Wayland is unreliable. Both stay in sync visually.

- **Wayland session:** Hyprland + waybar + mako + rofi-wayland + hyprpaper/hyprlock/hypridle
- **X11 session:** i3wm + i3status-rust + picom + rofi + dunst + i3wsr + feh
- **Shared:** Kitty terminal, Zsh (ZINIT + Starship), Neovim (vim-plug, CoC), Cursor/VS Code, IdeaVim
- **Version managers:** pyenv, nvm (lazy-loaded), jabba (Java)
- **Theme:** Ayu Dark everywhere (Hyprland, i3, waybar, i3status-rust, rofi, kitty, mako), JetBrains Mono Nerd Font

When changing the theme, update *all* of these in lockstep so both sessions stay coherent.

## Gitignore Strategy

Most of `.local/bin/` and `.config/Code/` / `.config/Cursor/` are ignored. Only specific files are tracked — check `.gitignore` before adding new paths under these directories.

## Key Details

- Neovim uses vim-plug (`:PlugInstall`) and tree-sitter (`:TSUpdate`)
- `.zshrc` auto-installs ZINIT on first run and auto-starts X11 on VT1 (Hyprland is launched from a display manager)
- `git-profile` script in `.local/bin/` manages multiple Git identities with GPG signing
- i3 config references custom scripts in `.local/bin/` for keyboard layout (`kbfix`, X11-only — Hyprland handles `us,ru` + `caps_toggle` natively in `input { kb_options }`)
- `hyprpaper.conf` expects a wallpaper at `~/wallpapers/default.jpg` — drop one there before first launch
- Hyprland keybinds intentionally mirror i3 (Mod = Super, hjkl focus/move, 1-0 workspaces, etc.) so muscle memory carries over
