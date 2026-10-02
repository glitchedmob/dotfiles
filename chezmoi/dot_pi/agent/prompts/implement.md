---
description: Full implementation workflow - scout gathers context, planner creates plan, worker implements
---
Use a background subagent workflow for: $@

Run scout to gather context, then planner to create a plan, then worker to implement it.
Compose the sequence with `runs.run`, passing each completed result's `output` to the next task. Give each step a stable key and short label.
Write one `js workflow` fenced block, then call `subagent({ workflow: true, async: true })`.
Return control after launch; completion will arrive separately.
