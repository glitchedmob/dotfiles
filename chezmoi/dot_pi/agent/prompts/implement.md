---
description: Full implementation workflow - scout gathers context, planner creates plan, worker implements
---
Use the Agent tool to execute these steps in order for: $@

1. Launch subagent_type "scout" with run_in_background: true to find the relevant code.
2. After the scout completion notification, fetch its full output once with get_subagent_result using the returned agent_id. Launch subagent_type "planner" with run_in_background: true, passing the original requirements and the scout findings in its prompt.
3. After the planner completion notification, fetch its full output once with get_subagent_result. Launch subagent_type "worker" with run_in_background: true, passing the original requirements, scout findings, and implementation plan in its prompt.
4. After the worker completion notification, fetch its full output once with get_subagent_result and summarize the changes and validation.

Give every Agent call a short description. Do not launch a dependent step before its predecessor completes. Do not poll or sleep while agents run; rely on completion notifications. Fetching each completed result also reports pending subagent usage to the parent session.
