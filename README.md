# dotfiles

Personal machine setup for macOS.

## Quick Start

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles/mac
./bootstrap.sh
```

After bootstrap completes:
1. Sign into 1Password desktop app
2. Authenticate 1Password CLI: `eval $(op signin)`
3. Run: `./install.sh`

## Structure

```
dotfiles/
├── mac/
│   ├── bootstrap.sh          # Xcode, Homebrew, 1Password
│   ├── install.sh           # Packages, defaults, chezmoi
│   └── config/
│       ├── brew.sh           # Homebrew packages
│       ├── defaults.sh       # macOS system defaults
│       └── Brewfile          # Package list
├── dotfiles/                 # chezmoi source files
└── .chezmoi.yaml.tmpl       # chezmoi configuration
```

## Bootstrap vs Install

| Script | Purpose | Requires 1Password |
|--------|---------|-------------------|
| `bootstrap.sh` | Minimal tools: Xcode, Homebrew, 1Password | No |
| `install.sh` | Packages, macOS defaults, dotfiles | Yes |
