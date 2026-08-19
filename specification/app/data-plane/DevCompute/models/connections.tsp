using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

model AddConnectionRequest {
  connectionId: ConnectionId;
}

model AuthorizeConnectionRequest {
  parameterValues: Record<string>;
}

model ConnectionCreateRequest {
  name: string;
  type: string;
  labels?: Record<string>;
  parameterValueSetName?: null | string;

  @secret
  parameterValueSetValues?: null | Record<string>;

  policyRules?: null | McpPolicyRule[];
  enabledToolGroups?: null | string[];
}

/**
 *             Strongly-typed connection identifier.
 *             ConnectionId is intentionally string-based rather than Guid-based because existing
 * Cosmos DB documents contain connection IDs in mixed formats — some with hyphens
 * (Guid "D" format: a1b2c3d4-e5f6-...) and some without (Guid "N" format:
 * a1b2c3d4e5f6...). Converting to a Guid-backed typed ID would normalize all
 * lookups to the "D" format via Guid.ToString(), breaking reads/deletes of
 * documents stored with the "N" format since Cosmos DB performs exact string matching
 * on document IDs.
 */
scalar ConnectionId;

model ConnectionResponseView {
  id: ConnectionId;
  name: string;
  type: string;
  state: string;
  labels?: Record<string>;
  createdAt?: null | utcDateTime;
  deletable?: boolean;
  usedBySandboxIds?: null | unknown[];
  policyRules?: null | McpPolicyRule[];
  enabledToolGroups?: null | string[];
}

/** Represents the state of a connection. */
union ConnectionState {
  "Creating",
  "Ready",
  "Error",
}

model ConnectionsListResponse {
  connectionIds: unknown[];
}

/** Authentication configuration for a gateway connection (CosmosDB storage). */
model GatewayConnectionAuthRecord {
  type: GatewayConnectionAuthType;
  identityResourceId?: null | string;
}

/** The type of managed identity to use for a gateway connection. */
union GatewayConnectionAuthType {
  "SystemAssignedManagedIdentity",
  "UserAssignedManagedIdentity",
}

/** Authentication configuration specifying which managed identity to use for a connection at runtime. */
model GatewayConnectionAuthView {
  /** The type of managed identity to use: "SystemAssignedManagedIdentity" or "UserAssignedManagedIdentity". */
  type: GatewayConnectionAuthType;

  /**
   * ARM resource ID of the user-assigned managed identity.
   * Required when GatewayConnectionAuthType GatewayConnectionAuthView.Type is GatewayConnectionAuthType.UserAssignedManagedIdentity,
   * omitted when GatewayConnectionAuthType.SystemAssignedManagedIdentity.
   */
  identityResourceId?: null | string;
}

/**
 * Represents an AI Gateway connection to associate with a sandbox (3P flow).
 * On sandbox requests: only string GatewayConnectionView.ResourceId is required; full details are resolved from the parent sandbox group.
 * On sandbox responses: legacy sandboxes include all fields; new sandboxes include only string GatewayConnectionView.ResourceId.
 */
model GatewayConnectionView {
  /**
   * ARM resource ID of the AI Gateway MCP server config or connection.
   * Format: /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Web/aigateways/{gw}/mcpServerConfigs/{config}
   * or: /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Web/connectorGateways/{gw}/connections/{conn}
   */
  resourceId: string;

  /**
   * Optional user-friendly name for this connection.
   * Used as the key in mcp-config.json and connections.json.
   * When not provided, derived from the last segment of string GatewayConnectionView.ResourceId.
   */
  name?: null | string;

  /**
   * MCP server endpoint URL for invoking the connection (agent discovery).
   * Resolved from the parent sandbox group; not required on sandbox requests.
   */
  mcpRuntimeUrl?: null | string;

  /**
   * Direct API Hub connection endpoint URL for app invocation (non-MCP).
   * Resolved from the parent sandbox group; not required on sandbox requests.
   */
  connectionRuntimeUrl?: null | string;

  @oneOf authentication?: null | GatewayConnectionAuthView;
}

/**
 * A runtime policy rule that activates a declared PolicyHookBinding.
 * Supplied per-sandbox at creation time (e.g., "block mail to ceo\@corp.com").
 */
model McpPolicyRule {
  /** References string PolicyHookBinding.Id on a tool. Must match a declared hook. */
  hookId: string;

  /**
   * Glob patterns to match against extracted field values.
   * For PolicyHookType.FieldValueDenyList: if ANY value matches ANY pattern, the call is blocked.
   * For PolicyHookType.FieldValueAllowList: if ANY value matches NO pattern, the call is blocked.
   */
  patterns: string[];
}

/** Connector Namespace reference details required by egress HookRef resolution. */
model SandboxGroupCredentialConnectionRefDetails {
  authentication: GatewayConnectionAuthRecord;
  tokenExchangeEndpoint: string;
}
