# dotfiles

Personal dotfiles for Arch Linux. Uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.

Two desktop sessions are supported:
- **Hyprland (Wayland)** — primary daily driver
- **i3wm (X11)** — kept around for the NVIDIA box where Wayland still struggles

## Setup

Clone to your home directory and use `stow` to symlink:

```bash
cd ~
git clone <repo-url> dotfiles
cd dotfiles
stow .
```

This creates symlinks from `~/dotfiles/` into `$HOME`, mirroring the directory structure (e.g. `.config/hypr/hyprland.conf` → `~/.config/hypr/hyprland.conf`).

## What's Included

| Category | Application | Config Path |
|---|---|---|
| Compositor (Wayland) | Hyprland + hyprpaper + hyprlock + hypridle | `.config/hypr/` |
| Status Bar (Wayland) | waybar | `.config/waybar/` |
| Notifications (Wayland) | mako | `.config/mako/` |
| Window Manager (X11) | i3wm | `.config/i3/` |
| Status Bar (X11) | i3status-rust | `.config/i3status-rust/` |
| Compositor (X11) | picom | `.config/picom/` |
| Workspace Renamer (X11) | i3wsr | `.config/i3wsr/` |
| Launcher | rofi (rofi-wayland on Hyprland) | `.config/rofi/` |
| Terminal | Kitty | `.config/kitty/` |
| Shell | Zsh + ZINIT + Starship | `.zshrc` |
| Editor | Neovim (vim-plug, CoC) | `.config/nvim/` |
| Editor | Cursor / VS Code | `.config/Cursor/`, `.config/Code/` |
| Editor | IdeaVim | `.ideavimrc` |
| Fonts | fontconfig | `.config/fontconfig/` |
| Scripts | git-profile, kbfix, etc. | `.local/bin/` |

Theme: **Ayu Dark** everywhere, **JetBrains Mono Nerd Font**.

## Fresh Install

### Required Packages

Install with `yay` (or `pacman` for official repo packages):

```bash
# --- Hyprland session ---
yay -S hyprland hyprpaper hyprlock hypridle waybar mako rofi-wayland \
       grim slurp wl-clipboard hyprpicker xdg-desktop-portal-hyprland \
       polkit-gnome cliphist

# --- i3 session (kept for NVIDIA / X11 fallback) ---
yay -S i3-wm i3status-rust picom rofi dunst feh i3wsr xss-lock i3lock \
       maim xclip xcolor

# --- Shared ---
yay -S kitty zsh starship neovim nodejs npm \
       pipewire pipewire-pulse wireplumber pamixer playerctl brightnessctl \
       networkmanager network-manager-applet \
       ttf-jetbrains-mono-nerd \
       xdg-utils dex stow

# GPU (NVIDIA — note: Wayland support on NVIDIA can be flaky)
yay -S nvidia-open nvidia-utils
```

### Post-Install Steps

1. **Deploy dotfiles:**
   ```bash
   cd ~/dotfiles && stow .
   ```

2. **Drop a wallpaper** at `~/wallpapers/default.jpg` (referenced by `hyprpaper.conf`):
   ```bash
   mkdir -p ~/wallpapers && cp <some-image> ~/wallpapers/default.jpg
   ```

3. **Enable audio services:**
   ```bash
   systemctl --user enable --now pipewire pipewire-pulse wireplumber
   ```

4. **Enable NetworkManager:**
   ```bash
   sudo systemctl enable --now NetworkManager
   ```

5. **Set up Neovim plugins:**
   ```bash
   nvim +PlugInstall +qall
   nvim +"TSUpdate" +qall
   ```

6. **Shell** — ZINIT auto-installs on first `zsh` launch. Set zsh as default:
   ```bash
   chsh -s /usr/bin/zsh
   ```

7. **Pick a session at login:** use a display manager (e.g. `ly`, `sddm`) and choose either *Hyprland* or *i3* on the greeter.

8. **Version managers** (optional, install as needed):
   - [pyenv](https://github.com/pyenv/pyenv) — Python
   - [nvm](https://github.com/nvm-sh/nvm) — Node.js
   - [jabba](https://github.com/shyiko/jabba) — Java
   - [pnpm](https://pnpm.io/) — Node package manager

## Keybinds

The Hyprland config mirrors the i3 keybinds (Mod = `Super`):

| Key | Action |
|---|---|
| `$mod+Return` | Open terminal |
| `$mod+q` | Kill window |
| `$mod+space` | Launcher (rofi) |
| `$mod+Shift+p` | Color picker (hyprpicker) |
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window |
| `$mod+f` | Fullscreen |
| `$mod+Shift+space` | Toggle floating |
| `$mod+v / g / e` | Toggle split direction |
| `$mod+s / w` | Group / cycle group |
| `$mod+1..0` | Switch workspace |
| `$mod+Shift+1..0` | Move window to workspace |
| `$mod+r` | Resize submap (h/j/k/l, Esc to exit) |
| `$mod+Shift+c` | Reload config |
| `$mod+Shift+e` | Exit Hyprland |
| `Print` | Region screenshot → clipboard |
