# Dotfiles

My personal Linux dotfiles for a consistent development environment.

## Includes

- Alacritty
- Bash
- Neovim
- Waybar
- Fastfetch
- Ghostty
- qBittorrent

## Setup (using GNU Stow)

```bash
git clone https://github.com/Ajay1812/dotfiles.git ~/dotfiles
cd ~/dotfiles
```
Install stow and apply configs:

```
stow bash nvim alacritty waybar fastfetch
```

Stow creates symlinks in your home directory automatically.

Notes:
- Run stow -D <package> to remove configs
- Add or remove packages as needed
