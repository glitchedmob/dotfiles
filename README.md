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

Installs Pi and applies the shared Pi and MCP configuration. Leaves AWS, SSH,
and shell settings alone. Use `/login` in Pi to sign in.
