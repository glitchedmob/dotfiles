---
description: Worker implements, reviewer reviews, worker applies feedback
---
Use the Agent tool to execute these steps in order for: $@

1. Launch subagent_type "worker" with run_in_background: true to implement the requirements. Keep its returned agent ID for the final step.
2. After the worker completion notification, fetch its full output once with get_subagent_result using that agent_id. Launch subagent_type "reviewer" with run_in_background: true, passing the original requirements and the worker report in its prompt.
3. After the reviewer completion notification, fetch its full output once with get_subagent_result. Resume the original worker through Agent with resume set to its agent ID, subagent_type "worker", and run_in_background: true. Ask it to apply the review feedback and validate the changes.
4. After the resumed worker completion notification, fetch its full output once with get_subagent_result and summarize the changes, validation, and any unresolved findings.

Give every Agent call a short description. Do not launch a dependent step before its predecessor completes. Do not poll or sleep while agents run; rely on completion notifications. Fetching each completed result also reports pending subagent usage to the parent session.
