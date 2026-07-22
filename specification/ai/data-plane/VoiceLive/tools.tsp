import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace VoiceLive;

// --- OpenAI GA Realtime tools (Foundry pattern) -----------------------------
// VoiceLive consumes OpenAI's GA Realtime tool + tool_choice models directly.
// Emitted via the openapi3 emitter, whose `oneOf` support lets these unions of
// OpenAI models emit as real `$ref`s (Swagger 2.0/autorest cannot represent this).
@@usage(OpenAI.RealtimeFunctionTool, RequestUsage);
@@usage(OpenAI.MCPTool, RequestUsage);
@@usage(OpenAI.ToolChoiceOptions, RequestUsage);
@@usage(OpenAI.ToolChoiceFunction, RequestUsage);
@@usage(OpenAI.ToolChoiceMCP, RequestUsage);

/**
 * A tool available to the model during a VoiceLive session. Consumes the OpenAI
 * GA Realtime tool models: `function` tools and remote `mcp` tools.
 */
@oneOf
union VoiceLiveTool {
  OpenAI.RealtimeFunctionTool,
  OpenAI.MCPTool,
}

/**
 * Specifies how the model selects tools during a VoiceLive session. Consumes the
 * OpenAI GA Realtime `tool_choice` models.
 */
@oneOf
union VoiceLiveToolChoice {
  OpenAI.ToolChoiceOptions,
  OpenAI.ToolChoiceFunction,
  OpenAI.ToolChoiceMCP,
}
