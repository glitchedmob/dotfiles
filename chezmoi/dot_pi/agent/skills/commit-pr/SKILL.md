---
name: commit-pr
description: Use when creating git commits or pull requests, including commit messages, PR titles, and PR descriptions.
---

# Commits and Pull Requests

## Commits

- Use Conventional Commits.
- Do not use scopes.
- Use a single-line message only.
- Never add a body or footer.
- Example: `feat: add retry backoff to dispatch`

## Pull Requests

- Format the PR title as a Conventional Commit with no scope on a single line.
- Treat the PR description as durable change context because it may become the commit description when squash-merging.
- When useful, begin the description with one or two short sentences explaining what changed and why it was needed.
- Follow that context with a bulleted list containing one meaningful change per bullet.
- Put temporary coordination details in PR comments, not the description. This includes merge or apply order, prerequisites, merge restrictions, and draft or readiness instructions.
- Never include a `Validation` section in the PR description.
- For small or self-explanatory PRs, use a single sentence rather than padding the description.
- Omit the description when the title provides enough context.
