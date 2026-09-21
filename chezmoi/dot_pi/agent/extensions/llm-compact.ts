import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Fabric skips compaction only when instructions match this marker exactly.
const FABRIC_BYPASS = "__pi_vcc__";

export default function (pi: ExtensionAPI) {
  let running = false;

  pi.registerCommand("llm-compact", {
    description: "Run Pi's built-in LLM compaction instead of Fabric",
    handler: async (args, ctx) => {
      if (args.trim()) {
        ctx.ui.notify("Usage: /llm-compact (no arguments)", "warning");
        return;
      }
      if (running || !ctx.isIdle()) {
        ctx.ui.notify("Wait for Pi to finish before running /llm-compact.", "warning");
        return;
      }

      running = true;
      const onError = (error: Error) => {
        running = false;
        ctx.ui.notify(`LLM compaction failed: ${error.message}`, "error");
      };

      try {
        ctx.ui.notify("Starting Pi's built-in LLM compaction...", "info");
        ctx.compact({
          customInstructions: FABRIC_BYPASS,
          onComplete: () => {
            running = false;
            ctx.ui.notify("LLM compaction completed.", "info");
          },
          onError,
        });
      } catch (error) {
        onError(error instanceof Error ? error : new Error(String(error)));
      }
    },
  });
}
