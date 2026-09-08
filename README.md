# Dotfiles

Run these commands from this checkout.

## Mac

```bash
./mac/bootstrap.sh
```

Sign into the 1Password desktop app, then run:

```bash
eval "$(op signin)"
./mac/install.sh
```

Installs applications, development tools, and dotfiles.

## Fedora

Requires Node.js 24+, npm, and curl on an already configured machine.

```bash
./fedora/install.sh
pi
```

Installs Pi and applies all shared dotfiles, installing chezmoi if needed.
Pi installs its configured packages on startup. Use `/login` in Pi to sign in.

The AWS template currently requires 1Password CLI authentication.
