# Dotfiles

Keep my shell, Git, and development-tool configuration consistent across macOS
and Fedora.

Share dotfiles through chezmoi and keep platform-specific setup separate.

## Pi

`/llm-compact` runs Pi's built-in LLM compaction for one request, leaving Fabric
in charge of ordinary compactions. It takes no arguments and requires Pi to be
idle. The extension uses Fabric 0.70.0's internal `__pi_vcc__` bypass marker.

After applying `chezmoi/dot_pi/agent/extensions/llm-compact.ts`, run `/reload` in Pi.
