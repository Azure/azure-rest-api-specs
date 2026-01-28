import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

/**
 * The supported tool type discriminators for voicelive tools.
 * Currently, only 'function' tools are supported.
 */
union ToolType {
  string,
  function: "function",
  mcp: "mcp",
  foundry_agent: "foundry_agent",
}

/**
 * The base representation of a voicelive tool definition.
 */
@discriminator("type")
@usage(RequestUsage)
model Tool {
  type: ToolType;
}

/**
 * The definition of a function tool as used by the voicelive endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/no-unknown" // parameters are JSON schema format.
@usage(RequestUsage)
model FunctionTool extends Tool {
  type: ToolType.function;
  name: string;
  description?: string;
  parameters?: unknown;
}

/**
 * The combined set of available representations for a voicelive tool_choice parameter, encompassing both string
 * literal options like 'auto' as well as structured references to defined tools.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" // This is how it's represented OpeAI Style.
union ToolChoice {
  ToolChoiceLiteral,
  ToolChoiceObject,
}

/**
 * The available set of mode-level, string literal tool_choice options for the voicelive endpoint.
 */
union ToolChoiceLiteral {
  string,

  /** Specifies that the model should freely determine which tool or tools, if any, to call. */
  auto: "auto",

  /** Specifies that the model should call no tools whatsoever. */
  none: "none",

  /** Specifies that the model should call at least one tool. */
  required: "required",
}

/**
 * A base representation for a voicelive tool_choice selecting a named tool.
 */
@discriminator("type")
@usage(RequestUsage)
model ToolChoiceObject {
  type: ToolType;
}

/**
 * The representation of a voicelive tool_choice selecting a named function tool.
 */
@usage(RequestUsage)
model ToolChoiceFunctionObject extends ToolChoiceObject {
  type: ToolType.function;
  name: string;
}

/**
 * The definition of an MCP server as used by the voicelive endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model MCPServer extends Tool {
  type: ToolType.mcp;
  server_label: string;
  server_url: string;
  authorization?: string;
  headers?: Record<string>;
  allowed_tools?: string[];
  #suppress "@azure-tools/typespec-autorest/union-unsupported" "require_approval is represented this way in OpenAI style."
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  require_approval?: MCPApprovalType | Record<string[]>;
}

/**
 * The available set of MCP approval types.
 */
union MCPApprovalType {
  string,

  /** Approval is never required. */
  Never: "never",

  /** Approval is always required. */
  Always: "always",
}

/**
 * The available set of Foundry agent context types.
 */
union FoundryAgentContextType {
  string,

  /** Only the current user input is sent, no context maintained. */
  no_context: "no_context",

  /** Agent maintains its own context (thread), only current input sent per call. */
  agent_context: "agent_context",
}

/**
 * The definition of a Foundry agent tool as used by the voicelive endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model FoundryAgentTool extends Tool {
  type: ToolType.foundry_agent;

  /** The name of the Foundry agent to call. */
  agent_name: string;

  /** The version of the Foundry agent to call. */
  agent_version?: string;

  /** The name of the Foundry project containing the agent. */
  project_name: string;

  /** The client ID associated with the Foundry agent. */
  client_id?: string;

  /** An optional description for the Foundry agent tool. If this is provided, it will be used instead of the agent's description in foundry portal. */
  description?: string;

  /** An optional override for the Foundry resource used to execute the agent. */
  foundry_resource_override?: string;

  /** The context type to use when invoking the Foundry agent. Defaults to 'agent_context'. */
  agent_context_type?: FoundryAgentContextType = FoundryAgentContextType.agent_context;

  /** Whether to return the agent's response directly in the VoiceLive response. Set to false means to ask the voice live to rewrite the response. */
  return_agent_response_directly?: boolean = true;
}
