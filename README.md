# dotfiles

Personal machine setup for macOS.

## Quick Start

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install-mac.sh
```

## Structure

```
dotfiles/
├── install-mac.sh          # Main install script
├── dotfiles/               # chezmoi source files
├── scripts/
│   └── mac/
│       ├── brew.sh         # Homebrew packages
│       └── defaults.sh     # macOS system defaults
└── .chezmoi.yaml.tmpl     # chezmoi configuration
```
