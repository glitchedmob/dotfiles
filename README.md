# Dotfiles

Keep my shell, Git, and development-tool configuration consistent across macOS
and Fedora.

Share dotfiles through chezmoi and keep platform-specific setup separate.

## Pi

`/llm-compact` runs Pi's built-in LLM compaction for one request, leaving Fabric
in charge of ordinary compactions. It takes no arguments and requires Pi to be
idle. The extension uses Fabric 0.101.1's internal `__pi_vcc__` bypass marker.

Keep `pi-fabric` before `pi-web-access` in the Pi package list. If web-access
loads first, Fabric's loadout hook runs before Fabric finishes bootstrapping.

After applying `chezmoi/dot_pi/agent/extensions/llm-compact.ts`, run `/reload` in Pi.
