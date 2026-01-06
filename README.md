# Dotfiles

My personal Linux dotfiles for a consistent development environment.

#### Screenshots
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/06dcc6ef-62e8-4a06-998c-bd4b3cab6b95" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/abc703c9-b095-4b03-9692-9b2a49a74e02" />

## Includes

| Tool       | Purpose            |
|------------|--------------------|
| Alacritty  | Terminal emulator  |
| Bash       | Shell config       |
| Neovim     | Code editor        |
| Waybar     | Status bar         |
| Fastfetch  | System info tool   |
| Ghostty    | Terminal over SSH  |
| qBittorrent| Torrent client     |

## Setup (using GNU Stow)

```bash
git clone https://github.com/Ajay1812/dotfiles.git ~/dotfiles
cd ~/dotfiles
```
**Install stow and apply configs:**

```
stow bash nvim alacritty waybar fastfetch
```

Stow creates symlinks in your home directory automatically.

Notes:
- Run stow -D <package> to remove configs
- Add or remove packages as needed
