import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** How a tool server is exposed. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerType {
  string,

  /** Federates one or more MCP servers. */
  Mcp: "mcp",

  /** Exposes tools generated from OpenAPI documents. */
  OpenApi: "openApi",

  /** Exposes a connector-backed tool server. */
  Connector: "connector",
}

/** Endpoint source kind. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerEndpointSourceKind {
  string,

  /** MCP server endpoint. */
  Mcp: "mcp",

  /** OpenAPI document endpoint. */
  OpenApi: "openApi",
}

/** OAuth 2.0 grant type. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerOauth2GrantType {
  string,

  /** Client credentials grant. */
  ClientCredentials: "clientCredentials",

  /** Authorization code grant. */
  AuthorizationCode: "authorizationCode",
}

/** MCP transport protocol. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerMcpTransport {
  string,

  /** Streamable HTTP transport. */
  StreamableHttp: "streamableHttp",
}

/** OpenAPI document source type. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerOpenApiSourceType {
  string,

  /** Inline OpenAPI document. */
  Inline: "inline",

  /** OpenAPI document fetched from a URL. */
  Url: "url",
}

/** Tool server access state. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerAccessState {
  string,

  /** Tool server is available. */
  Active: "active",

  /** Tool server is blocked. */
  Blocked: "blocked",
}

/** Managed identity authentication for a tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerManagedIdentityAuthentication {
  /** Token audience for managed identity authentication. */
  resource?: string;

  /** Client ID of a user-assigned managed identity. */
  clientId?: string;
}

/** An additional parameter sent to an OAuth 2.0 endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerOauth2Parameter {
  /** OAuth parameter name. */
  name: string;

  /** OAuth parameter value. */
  value: string;
}

/** Supported token-exchange profiles for a tool server endpoint. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerTokenExchangeProfile {
  string,

  /** Microsoft Entra chained on-behalf-of token exchange. */
  EntraOnBehalfOf: "entraOnBehalfOf",
}

/** Supported federation application credential types for a tool server endpoint. */
@added(Versions.v2026_11_01)
union AiGatewayToolServerFederationAppCredentialType {
  string,

  /** A user-assigned managed identity assigned to the AI Gateway. */
  UserAssignedManagedIdentity: "userAssignedManagedIdentity",
}

/** Credential used to authenticate a tool server endpoint federation application. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerFederationAppCredential {
  /** Federation application credential type. */
  type: AiGatewayToolServerFederationAppCredentialType;

  /** Client ID of a user-assigned managed identity available to this AI Gateway. */
  clientId?: string;
}

/** Customer-owned federation application identity for a tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerFederation {
  /** Application (client) ID of the customer-owned federation application. */
  applicationId?: string;

  /** Credential used to authenticate the federation application. */
  appCredential?: AiGatewayToolServerFederationAppCredential;
}

/** Chained token-exchange configuration for a tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerTokenExchange {
  /** Token-exchange profile. */
  profile: AiGatewayToolServerTokenExchangeProfile;

  /** Customer-owned federated client application identity. */
  federatedClientApplication?: AiGatewayToolServerFederation;

  /** Delegated scopes requested from the target tool server resource. */
  scopes?: string[];
}

/** OAuth 2.0 authentication for a tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerOauth2Authentication {
  /** Expected OAuth authorization-server issuer for remote MCP discovery. */
  issuer?: url;

  /** OAuth authorization endpoint. */
  authorizationEndpoint?: AiGatewayDestinationEndpoint;

  /** OAuth token endpoint. */
  tokenEndpoint?: AiGatewayDestinationEndpoint;

  /** OAuth client identifier. */
  clientId?: string;

  /** OAuth client secret. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  clientSecret?: string;

  /** OAuth scopes to request. */
  scopes?: string[];

  /** OAuth grant type. */
  grantType?: AiGatewayToolServerOauth2GrantType;

  /** Chained token-exchange configuration. */
  tokenExchange?: AiGatewayToolServerTokenExchange;

  /** Additional authorization endpoint parameters. */
  @identifiers(#["name"])
  authorizationParameters?: AiGatewayToolServerOauth2Parameter[];

  /** Additional token endpoint parameters. */
  @identifiers(#["name"])
  tokenParameters?: AiGatewayToolServerOauth2Parameter[];

  /** Current OAuth connection status. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** Login link used to complete interactive authorization. */
  @visibility(Lifecycle.Read)
  loginLink?: url;

  /** UTC timestamp of the last OAuth connection-status transition. */
  @visibility(Lifecycle.Read)
  statusUpdatedUtc?: utcDateTime;
}

/** Outbound authentication for a tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerAuthentication {
  /** Static headers injected when calling the endpoint. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeader[];

  /** OAuth 2.0 configuration. */
  oauth2?: AiGatewayToolServerOauth2Authentication;

  /** Managed identity configuration. */
  managedIdentity?: AiGatewayToolServerManagedIdentityAuthentication;
}

/** MCP endpoint configuration. */
@added(Versions.v2026_11_01)
model AiGatewayMcpUrlConfiguration {
  /** Backend MCP server endpoint. */
  endpoint: AiGatewayDestinationEndpoint;

  /** MCP transport. */
  transport?: AiGatewayToolServerMcpTransport;
}

/** Source of an OpenAPI document. */
@added(Versions.v2026_11_01)
model AiGatewayOpenApiSpecSource {
  /** Source type. */
  type: AiGatewayToolServerOpenApiSourceType;

  /** Base64-encoded OpenAPI document. Required when type is inline. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  contentBase64?: bytes;

  /** URL of the OpenAPI document. Required when type is url. */
  url?: url;
}

/** OpenAPI-backed MCP endpoint configuration. */
@added(Versions.v2026_11_01)
model AiGatewayOpenApiConfiguration {
  /** OpenAPI document source. */
  specSource: AiGatewayOpenApiSpecSource;
}

/** A tool server endpoint. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerEndpoint {
  /** Stable endpoint identifier. Up to 64 alphanumeric characters or hyphens, starting and ending with an alphanumeric character. Generated when omitted. */
  id?: string;

  /** Optional namespace used to prefix tool names. */
  `namespace`?: string;

  /** Endpoint type. */
  kind: AiGatewayToolServerEndpointSourceKind;

  /** Backend MCP configuration. Required when kind is mcp. */
  mcp?: AiGatewayMcpUrlConfiguration;

  /** OpenAPI configuration. Required when kind is openApi. */
  openApi?: AiGatewayOpenApiConfiguration;

  /** Backend authentication configuration. */
  authentication?: AiGatewayToolServerAuthentication;

  /** Upstream tool names or glob patterns to expose. */
  tools?: string[];

  /** Failure mode when the endpoint fails. Defaults to failOpen. */
  mode?: AiGatewayFailureMode = AiGatewayFailureMode.FailOpen;
}

/** Tool server authentication settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerAuthenticationUpdate {
  /** Static headers injected when calling the endpoint. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeaderUpdate[];

  /** OAuth 2.0 configuration. */
  oauth2?: AiGatewayToolServerOauth2Authentication;

  /** Managed identity configuration. */
  managedIdentity?: AiGatewayToolServerManagedIdentityAuthentication;
}

/** MCP endpoint settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayMcpUrlConfigurationUpdate {
  /** Backend MCP server endpoint. */
  endpoint?: AiGatewayDestinationEndpointUpdate;

  /** MCP transport. */
  transport?: AiGatewayToolServerMcpTransport;
}

/** OpenAPI document source settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayOpenApiSpecSourceUpdate {
  /** Source type. */
  type?: AiGatewayToolServerOpenApiSourceType;

  /** Base64-encoded OpenAPI document. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  contentBase64?: bytes;

  /** URL of the OpenAPI document. */
  url?: url;
}

/** OpenAPI-backed MCP endpoint settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayOpenApiConfigurationUpdate {
  /** OpenAPI document source. */
  specSource?: AiGatewayOpenApiSpecSourceUpdate;
}

/** A tool server endpoint to update. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerEndpointUpdate {
  /** Stable endpoint identifier. */
  id?: string;

  /** Optional namespace used to prefix tool names. */
  `namespace`?: string;

  /** Endpoint type. */
  kind?: AiGatewayToolServerEndpointSourceKind;

  /** Backend MCP configuration. */
  mcp?: AiGatewayMcpUrlConfigurationUpdate;

  /** OpenAPI configuration. */
  openApi?: AiGatewayOpenApiConfigurationUpdate;

  /** Backend authentication configuration. */
  authentication?: AiGatewayToolServerAuthenticationUpdate;

  /** Upstream tool names or glob patterns to expose. */
  tools?: string[];

  /** Failure mode when the endpoint fails. */
  mode?: AiGatewayFailureMode;
}

/** Properties for updating an AI Gateway tool server. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerUpdateProperties {
  /** Display name of the tool server. */
  displayName?: string;

  /** Description of the tool server. */
  description?: string;

  /** Whether the tool server is available to callers. */
  accessState?: AiGatewayToolServerAccessState;

  /** Tool server type. */
  toolServerType?: AiGatewayToolServerType;

  /** Runtime API versions exposed by this tool server. */
  versions?: string[];

  /** Tool names or patterns explicitly allowed. */
  allowList?: string[];

  /** Tool names or patterns explicitly blocked. */
  blockList?: string[];

  /** Endpoint configurations exposed by this tool server. */
  @identifiers(#[])
  endpoints?: AiGatewayToolServerEndpointUpdate[];

  /** Inline policies applied to this tool server. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];

  /** Runtime path for the tool server. */
  path?: string;

  /** Whether a subscription is required to invoke the tool server. */
  subscriptionRequired?: boolean;
}

/** Parameters for updating an AI Gateway tool server. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerUpdateParameters {
  /** Tool server properties to update. */
  properties?: AiGatewayToolServerUpdateProperties;
}

/** Properties of an AI Gateway tool server. */
@added(Versions.v2026_11_01)
model AiGatewayToolServerProperties {
  /** Display name of the tool server. */
  displayName?: string;

  /** Description of the tool server. */
  description?: string;

  /** Whether the tool server is available to callers. */
  accessState?: AiGatewayToolServerAccessState;

  /** Tool server type. */
  toolServerType: AiGatewayToolServerType;

  /** Runtime API versions exposed by this tool server. */
  versions?: string[];

  /** Tool names or patterns explicitly allowed. */
  allowList?: string[];

  /** Tool names or patterns explicitly blocked. */
  blockList?: string[];

  /** Endpoint configurations exposed by this tool server. */
  @identifiers(#["id"])
  endpoints?: AiGatewayToolServerEndpoint[];

  /** Inline policies applied to this tool server. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

  /** Runtime path for the tool server. */
  path?: string;

  /** Whether a subscription is required to invoke the tool server. */
  subscriptionRequired?: boolean;

  /** Read-only invocation URLs, with optional SDK metadata when endpoint enrichment is enabled. */
  @visibility(Lifecycle.Read)
  @identifiers(#["url"])
  gatewayEndpoints?: AiGatewayEndpoint[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway tool server resource. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayToolServerResource
  is Azure.ResourceManager.ProxyResource<AiGatewayToolServerProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayToolServerResource,
    KeyName = "toolServerName",
    SegmentName = "toolServers",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
}
