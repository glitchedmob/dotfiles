---
description: Scout gathers context, planner creates implementation plan (no implementation)
---
Use a background subagent workflow for: $@

Run scout to gather context, then planner to create a plan. Do not implement.
Compose the sequence with `runs.run`, passing the scout result's `output` to the planner task. Give each step a stable key and short label.
Write one `js workflow` fenced block, then call `subagent({ workflow: true, async: true })`.
Return control after launch; completion will arrive separately.
