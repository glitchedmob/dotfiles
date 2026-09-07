import {
  createReadToolDefinition,
  createWriteToolDefinition,
  type ExtensionAPI,
} from "@earendil-works/pi-coding-agent";
import {
  FABRIC_PROVIDER_DISCOVER_EVENT,
  FABRIC_PROVIDER_REGISTER_EVENT,
  type FabricActionDescriptor,
  type FabricInvocationContext,
  type FabricProvider,
  type FabricProviderDiscovery,
} from "pi-fabric/protocol";

const toolText = (result: { content: Array<{ type: string; text?: string }> }): string =>
  result.content
    .filter((part): part is { type: "text"; text: string } =>
      part.type === "text" && typeof part.text === "string",
    )
    .map((part) => part.text)
    .join("\n");

const descriptor = (
  actionName: string,
  context: FabricInvocationContext,
): FabricActionDescriptor | undefined => {
  const tool = actionName === "read"
    ? createReadToolDefinition(context.cwd)
    : actionName === "write"
      ? createWriteToolDefinition(context.cwd)
      : undefined;
  if (!tool) return undefined;

  return {
    name: actionName,
    description: tool.description,
    inputSchema: tool.parameters as unknown as Record<string, unknown>,
    risk: actionName === "read" ? "read" : "write",
  };
};

export default function fabricLocalFiles(pi: ExtensionAPI): void {
  const provider: FabricProvider = {
    name: "localfs",
    description: "Local file access using Pi's built-in read and write implementations",

    async list(request, context) {
      const query = request.query?.toLowerCase();
      const actions = ["read", "write"]
        .map((name) => descriptor(name, context))
        .filter((action): action is FabricActionDescriptor => action !== undefined)
        .filter((action) =>
          query
            ? `${action.name} ${action.description}`.toLowerCase().includes(query)
            : true,
        );
      return actions.slice(0, request.limit ?? actions.length);
    },

    async describe(actionName, context) {
      return descriptor(actionName, context);
    },

    async invoke(actionName, args, context) {
      const tool = actionName === "read"
        ? createReadToolDefinition(context.cwd)
        : actionName === "write"
          ? createWriteToolDefinition(context.cwd)
          : undefined;
      if (!tool) throw new Error(`Unknown localfs action: ${actionName}`);

      const prepared = tool.prepareArguments?.(args) ?? args;
      const result = await tool.execute(
        context.nestedToolCallId,
        prepared as never,
        context.signal,
        (partial) => context.update(toolText(partial)),
        context.extensionContext,
      );
      const output = toolText(result);
      return actionName === "read"
        ? output
        : { ok: true, output, details: result.details ?? null };
    },
  };

  const register = (): void => {
    pi.events.emit(FABRIC_PROVIDER_REGISTER_EVENT, {
      version: 1,
      provider,
      overwrite: true,
    });
  };

  register();
  pi.events.on(FABRIC_PROVIDER_DISCOVER_EVENT, (event: FabricProviderDiscovery) => {
    event.register(provider, { overwrite: true });
  });
}
