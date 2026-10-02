---
description: Worker implements, reviewer reviews, worker applies feedback
---
Use a background subagent workflow for: $@

Run worker to implement, reviewer to review the changes, then worker to apply the feedback.
Compose the sequence with `runs.run`, passing each completed result's `output` to the next task. Give each step a stable key and short label.
Write one `js workflow` fenced block, then call `subagent({ workflow: true, async: true })`.
Return control after launch; completion will arrive separately.
