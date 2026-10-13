# Dotfiles

Keep my shell, Git, and development-tool configuration consistent across macOS
and Fedora.

Share dotfiles through chezmoi and keep platform-specific setup separate.

## Pi

Pi uses built-in MCP and codemode, plus
[`@tintinweb/pi-subagents`](https://github.com/tintinweb/pi-subagents).
The package version is pinned in `chezmoi/dot_pi/agent/settings.json`.

Subagents run in the background by default and stop when Pi exits. The existing
scout, planner, worker, and reviewer roles inherit the active model. Workflow
prompts use `Agent` and retrieve each completed result with `get_subagent_result`.

`chezmoi/dot_pi/agent/subagents.json` enables usage reporting and cost display.
Background spend reaches Pi's session totals on the next subagent tool result,
not on the completion notification. Fetch completed results before exiting for
up-to-date totals.

Restart Pi after installing or updating the package. Use `/agents` to inspect,
steer, or stop agents.
