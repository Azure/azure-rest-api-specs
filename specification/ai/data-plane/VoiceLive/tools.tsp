import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace VoiceLive;

// --- OpenAI GA Realtime tools (Foundry pattern) -----------------------------
// VoiceLive consumes OpenAI's GA Realtime function tool and tool-choice models
// while defining the MCP subset implemented by the VoiceLive runtime.
// Emitted via the openapi3 emitter, whose `oneOf` support lets these unions of
// OpenAI models emit as real `$ref`s (Swagger 2.0/autorest cannot represent this).
@@usage(OpenAI.RealtimeFunctionTool, RequestUsage);
@@usage(OpenAI.ToolChoiceOptions, RequestUsage);
@@usage(OpenAI.ToolChoiceFunction, RequestUsage);
@@usage(OpenAI.ToolChoiceMCP, RequestUsage);

/** Managed identity authorization for an MCP server. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case.
@usage(RequestUsage)
model AssignedManagedIdentity {
  type: "assigned_managed_identity";
  audience: string;
  client_id?: string;
}

/** MCP authorization accepted by VoiceLive. */
@oneOf
union VoiceLiveMcpAuthorization {
  string,
  AssignedManagedIdentity,
}

/** MCP approval modes accepted by VoiceLive. */
union VoiceLiveMcpApprovalMode {
  never_mode: "never",
  always_mode: "always",
}

/** Per-tool MCP approval rules. */
@usage(RequestUsage)
model VoiceLiveMcpApprovalRules {
  `never`?: string[];
  always?: string[];
}

/** MCP approval configuration accepted by VoiceLive. */
@oneOf
union VoiceLiveMcpRequireApproval {
  VoiceLiveMcpApprovalMode,
  VoiceLiveMcpApprovalRules,
}

/** Response scheduling after locally executed MCP calls. */
union McpResponseScheduling {
  silent: "silent",
  when_idle: "when_idle",
  interrupt: "interrupt",
  skip_if_busy: "skip_if_busy",
}

/** Remote MCP server configuration supported by VoiceLive. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case.
@usage(RequestUsage)
model VoiceLiveMcpTool {
  type: "mcp";
  server_label: string;
  server_url: string;
  authorization?: VoiceLiveMcpAuthorization;
  headers?: Record<string>;
  allowed_tools?: string[];
  require_approval?: VoiceLiveMcpRequireApproval;
  response_scheduling?: McpResponseScheduling = McpResponseScheduling.silent;
}

/**
 * A tool available to the model during a VoiceLive session.
 */
@oneOf
union VoiceLiveTool {
  OpenAI.RealtimeFunctionTool,
  VoiceLiveMcpTool,
}

/**
 * Specifies how the model selects tools during a VoiceLive session. Consumes the
 * OpenAI GA Realtime `tool_choice` models.
 */
@oneOf
union VoiceLiveToolChoice {
  OpenAI.ToolChoiceOptions,
  OpenAI.ToolChoiceFunction,

  /** Forced MCP selection is preview-only until runtime support is implemented. */
  @removed(Versions.v1)
  OpenAI.ToolChoiceMCP,
}
