import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ConnectorGateway.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

@added(Versions.v2026_05_01_preview)
@doc("MCP server config kind. Controls how the runtime serves MCP requests.")
union McpServerConfigKind {
  string,

  @doc("Standard MCP server config behavior.")
  NotSpecified: "NotSpecified",

  @doc("The runtime forwards all MCP requests to a downstream managed MCP server via the API connection.")
  ManagedMcpServer: "ManagedMcpServer",

  @doc("The gateway provisions and manages the MCP server container via ADC. Requires properties.hostedMcpServer.")
  HostedMcpServer: "HostedMcpServer",
}

@added(Versions.v2026_05_01_preview)
@doc("The state of an MCP server config.")
union McpServerConfigState {
  string,

  @doc("The MCP server config is enabled.")
  Enabled: "Enabled",

  @doc("The MCP server config is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_05_01_preview)
@doc("Authentication mode applied to tool calls served by an MCP server config.")
union McpAuthenticationMode {
  string,

  @doc("Treated as DeveloperConnection.")
  NotSpecified: "NotSpecified",

  @doc("All tool calls execute under the connection owner's identity.")
  DeveloperConnection: "DeveloperConnection",

  @doc("Per-user dynamic connection — tool calls execute under the calling user's identity.")
  OnBehalfOfUser: "OnBehalfOfUser",

  @doc("OBO via a federated identity credential issued by the gateway managed identity against an admin app registration. Requires resourceAuth.")
  OnBehalfOfUserWithApp: "OnBehalfOfUserWithApp",

  @doc("Client-credentials against an admin app registration via FIC. Requires resourceAuth.")
  AppOnly: "AppOnly",
}

@added(Versions.v2026_05_01_preview)
@doc("Operation parameter definition shared between MCP server configs and trigger configs.")
model OperationParameter {
  @doc("Parameter name.")
  name?: string;

  @doc("Parameter display name.")
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Free-form parameter value; backend accepts any JSON primitive or complex shape."
  @doc("Default parameter value. May be a primitive (string, boolean, integer, number) or a complex type (array, object).")
  value?: unknown;

  @doc("Human-readable rendering of value, when applicable.")
  displayValue?: string;

  @doc("When true, the parameter name is added to the top-level inputSchema.required[] in the MCP tools/list response.")
  isRequired?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form JSON Schema for the parameter."
  @doc("JSON Schema for this parameter, typically extracted from the connector swagger.")
  schema?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("A single operation exposed by an MCP server config connector.")
model McpServerConfigOperation {
  @doc("Source swagger operation ID used for API Hub invocation.")
  name: string;

  @doc("Operation display name.")
  displayName: string;

  @doc("Operation description.")
  description: string;

  @doc("Connector-local identity used as the MCP-visible tool name instead of name. The backend prefixes the connector name and normalizes special characters to produce the final MCP tool name.")
  toolName?: string;

  @doc("Parameters with fixed values set by the user.")
  userParameters?: OperationParameter[];

  @doc("Parameters filled by the AI agent at runtime.")
  agentParameters?: OperationParameter[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form MCP-compatible metadata."
  @doc("Arbitrary JSON object for MCP-compatible metadata (e.g., x-relatedTools). Passed through to tools/list when present.")
  annotations?: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form JSON Schema for the tool output."
  @doc("Optional JSON Schema describing the tool's successful response shape. Passed through to tools/list when present.")
  outputSchema?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("A connector exposed by an MCP server config.")
model McpServerConfigConnector {
  @doc("Managed API connector name (e.g., office365).")
  name?: string;

  @doc("Name of the connection to use.")
  connectionName?: string;

  @doc("Connector display name.")
  displayName?: string;

  @doc("Connector description.")
  description?: string;

  @doc("Operations exposed by this connector.")
  operations?: McpServerConfigOperation[];
}

@added(Versions.v2026_05_01_preview)
@doc("Specifies which connector, operation, or parameter a policy applies to.")
model PolicyTarget {
  @doc("The connector name. When omitted, the policy applies to all connectors.")
  connectorName?: string;

  @doc("The operation name. When omitted, the policy applies to all operations.")
  operationName?: string;

  @doc("The parameter name. Required for parameter-level policies.")
  parameterName: string;

  @doc("Dot-separated property path for targeting nested properties within complex parameter values. When omitted, the policy applies to the whole parameter value.")
  propertyPath?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Rules for restricting parameter values.")
model ParameterValueRestrictionRules {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Allowed values are arbitrary JSON primitives or complex shapes."
  @doc("When specified, the parameter value must be in this list.")
  allowedValues?: unknown[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Denied values are arbitrary JSON primitives or complex shapes."
  @doc("When specified, the parameter value must not be in this list.")
  deniedValues?: unknown[];
}

@added(Versions.v2026_05_01_preview)
@doc("The type of an MCP server config policy.")
union McpServerConfigPolicyType {
  string,

  @doc("Restricts the value of a parameter on operations exposed by the MCP server config.")
  ParameterValueRestriction: "ParameterValueRestriction",
}

@added(Versions.v2026_05_01_preview)
@doc("A policy that restricts parameter values for operations in an MCP server config.")
model McpServerConfigPolicy {
  @doc("The policy name.")
  name: string;

  @doc("The policy type.")
  type: McpServerConfigPolicyType;

  @doc("Optional description of the policy.")
  description?: string;

  @doc("Target of the policy.")
  target: PolicyTarget;

  @doc("Restriction rules for the policy.")
  rules: ParameterValueRestrictionRules;
}

@added(Versions.v2026_05_01_preview)
@doc("Settings for an MCP server config.")
model McpServerConfigSettings {
  @doc("When true, all tool call responses use TextContent regardless of actual content type. When false or null (default), rich content types are used.")
  textOnlyContent?: boolean;

  @doc("When true, the MCP runtime asks the calling client for explicit consent (via the MCP elicitation/create request) before invoking tools that require user authorization.")
  enableConsentElicitation?: boolean;
}

@added(Versions.v2026_05_01_preview)
@doc("Properties for an ADC-hosted MCP server. Used when McpServerConfig.kind = HostedMcpServer.")
model HostedMcpServerProperties {
  @doc("Hosted MCP server identifier from the managed hosted-MCP-server registry.")
  hostedMcpServerId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Configuration values are arbitrary strings or base64-encoded file content."
  @doc("Configuration key-value pairs for the hosted MCP server. Values are strings for regular inputs and base64-encoded content for file-type inputs.")
  configuration?: Record<unknown>;
}

@added(Versions.v2026_05_01_preview)
@doc("Admin Entra ID application registration backing OBO/AppOnly auth.")
model AdminAppRegistrationDefinition {
  @doc("Entra ID application (client) ID.")
  clientId?: Azure.Core.uuid;

  @doc("Entra ID tenant ID.")
  tenantId?: Azure.Core.uuid;

  @doc("Display name of the application registration.")
  name?: string;
}

@added(Versions.v2026_05_01_preview)
@doc("Managed identity type used by resource auth.")
union ResourceAuthIdentityType {
  string,

  @doc("No managed identity.")
  None: "None",

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",

  @doc("Both system-assigned and user-assigned managed identities.")
  SystemAssignedUserAssigned: "SystemAssigned, UserAssigned",
}

@added(Versions.v2026_05_01_preview)
@doc("Identity configuration used to acquire downstream resource tokens.")
model ResourceAuthIdentityDefinition {
  @doc("Managed identity type used for token acquisition.")
  type?: ResourceAuthIdentityType;

  @doc("ARM resource ID of the user-assigned managed identity. Required when type is UserAssigned (or SystemAssigned, UserAssigned).")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@added(Versions.v2026_05_01_preview)
@doc("Federated identity credential issued by the gateway managed identity. Read-only — returned on GET only and must not be sent on PUT.")
model FederatedIdentityCredentialDefinition {
  @doc("Token issuer URL.")
  @visibility(Lifecycle.Read)
  issuer?: url;

  @doc("Subject identifier of the managed identity.")
  @visibility(Lifecycle.Read)
  subject?: string;

  @doc("Accepted audiences for the federated identity credential.")
  @visibility(Lifecycle.Read)
  audiences?: string[];
}

@added(Versions.v2026_05_01_preview)
@doc("Resource authentication configuration for MCP server configs that broker downstream access via an admin application registration and a federated identity credential. Required when authenticationMode is OnBehalfOfUserWithApp or AppOnly.")
model ResourceAuthDefinition {
  @doc("Admin Entra ID application registration.")
  adminAppRegistration?: AdminAppRegistrationDefinition;

  @doc("Target Azure resource URI for token acquisition.")
  targetResource?: string;

  @doc("Managed identity configuration.")
  identity?: ResourceAuthIdentityDefinition;

  @doc("Federated identity credential details computed from the gateway managed identity. Returned on GET responses; must not be sent on PUT (server-managed).")
  @visibility(Lifecycle.Read)
  federatedIdentityCredential?: FederatedIdentityCredentialDefinition;
}

@added(Versions.v2026_05_01_preview)
@doc("The properties of an MCP server config.")
model ConnectorGatewayMcpServerConfigProperties {
  @doc("The provisioning state of the MCP server config.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("The state of the MCP server config.")
  state?: McpServerConfigState;

  @doc("MCP server description for tool discovery.")
  description?: string;

  @doc("Connectors exposed by this MCP server config.")
  connectors?: McpServerConfigConnector[];

  @doc("Policies that restrict parameter values for operations in this MCP server config.")
  policies?: McpServerConfigPolicy[];

  @doc("MCP server config settings.")
  settings?: McpServerConfigSettings;

  @doc("Authentication mode applied to tool calls served by this MCP server config.")
  authenticationMode?: McpAuthenticationMode;

  @doc("When true, the MCP runtime endpoint rejects API-key authentication and only accepts Entra ID Bearer tokens.")
  disableApiKeyAuth?: boolean;

  @doc("Resource authentication configuration. Required when authenticationMode is OnBehalfOfUserWithApp or AppOnly.")
  resourceAuth?: ResourceAuthDefinition;

  @doc("Properties for an ADC-hosted MCP server. Used when kind = HostedMcpServer.")
  hostedMcpServer?: HostedMcpServerProperties;

  @doc("The MCP protocol endpoint URL.")
  @visibility(Lifecycle.Read)
  mcpEndpointUrl?: url;
}

@added(Versions.v2026_05_01_preview)
@parentResource(ConnectorGateway)
@doc("An MCP server config under a connector gateway.")
model ConnectorGatewayMcpServerConfig
  is Azure.ResourceManager.ProxyResource<ConnectorGatewayMcpServerConfigProperties> {
  @key("mcpServerConfigName")
  @segment("mcpServerConfigs")
  @doc("The name of the MCP server config.")
  @path
  @pattern("^[a-zA-Z0-9_.()-]{1,79}$")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "MCP server config kind selects between standard, managed, and hosted MCP server behaviors and must remain on the envelope to mirror the backend resource shape."
  @doc("MCP server config kind. Controls how the runtime serves MCP requests.")
  kind?: McpServerConfigKind;
}

@added(Versions.v2026_05_01_preview)
@armResourceOperations
@doc("The operations of MCP server configs.")
interface ConnectorGatewayMcpServerConfigs {
  get is ArmResourceRead<ConnectorGatewayMcpServerConfig>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConnectorGatewayMcpServerConfig>;
  delete is ArmResourceDeleteSync<ConnectorGatewayMcpServerConfig>;
  listByConnectorGateway is ArmResourceListByParent<ConnectorGatewayMcpServerConfig>;
}
