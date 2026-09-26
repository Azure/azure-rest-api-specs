import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** How a tool server is exposed. */
@added(Versions.v2026_09_01_preview)
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
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerEndpointSourceKind {
  string,

  /** MCP server endpoint. */
  Mcp: "mcp",

  /** OpenAPI document endpoint. */
  OpenApi: "openApi",
}

/** Endpoint authentication type. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerAuthenticationType {
  string,

  /** No authentication. */
  None: "none",

  /** Static HTTP header authentication. */
  Header: "header",

  /** OAuth 2.0 authentication. */
  OAuth2: "oauth2",

  /** Managed identity authentication. */
  ManagedIdentity: "managedIdentity",
}

/** OAuth 2.0 grant type. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerOauth2GrantType {
  string,

  /** Client credentials grant. */
  ClientCredentials: "clientCredentials",

  /** Authorization code grant. */
  AuthorizationCode: "authorizationCode",
}

/** MCP transport protocol. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerMcpTransport {
  string,

  /** Streamable HTTP transport. */
  StreamableHttp: "streamableHttp",
}

/** OpenAPI document source type. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerOpenApiSourceType {
  string,

  /** Inline OpenAPI document. */
  Inline: "inline",

  /** OpenAPI document fetched from a URL. */
  Url: "url",
}

/** Tool server access state. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerAccessState {
  string,

  /** Tool server is available. */
  Active: "active",

  /** Tool server is blocked. */
  Blocked: "blocked",
}

/** Managed identity authentication for a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerManagedIdentityAuthentication {
  /** Token audience for managed identity authentication. */
  resource: string;

  /** Client ID of a user-assigned managed identity. */
  clientId?: string;
}

/** OAuth 2.0 authentication for a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerOauth2Authentication {
  /** OAuth authorization endpoint. */
  @clientName("authorizationUri", "csharp")
  authorizationUrl?: string;

  /** OAuth token endpoint. */
  @clientName("tokenUri", "csharp")
  tokenUrl?: string;

  /** OAuth client identifier. */
  clientId?: string;

  /** OAuth client secret. */
  @secret
  clientSecret?: string;

  /** OAuth scopes to request. */
  scopes?: string[];

  /** OAuth grant type. */
  grantType?: AiGatewayToolServerOauth2GrantType;

  /** Additional authorization endpoint parameters. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The implemented OAuth contract supports arbitrary provider-specific authorization parameters."
  authorizationParameters?: Record<string>;

  /** Additional token endpoint parameters. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The implemented OAuth contract supports arbitrary provider-specific token parameters."
  tokenParameters?: Record<string>;

  /** Current OAuth connection status. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** Login link used to complete interactive authorization. */
  @visibility(Lifecycle.Read)
  loginLink?: string;
}

/** Credentials for a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerCredentials {
  /** Authentication type. */
  type: AiGatewayToolServerAuthenticationType;

  /** Static headers injected when calling the endpoint. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The implemented header credential contract supports arbitrary HTTP header names."
  @secret
  headers?: Record<string[]>;

  /** OAuth 2.0 configuration. */
  oauth2?: AiGatewayToolServerOauth2Authentication;

  /** Managed identity configuration. */
  managedIdentity?: AiGatewayToolServerManagedIdentityAuthentication;
}

/** MCP URL endpoint configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayMcpUrlConfiguration {
  /** Backend MCP server endpoint. */
  url: string;

  /** MCP transport. */
  transport?: AiGatewayToolServerMcpTransport;
}

/** Source of an OpenAPI document. */
@added(Versions.v2026_09_01_preview)
model AiGatewayOpenApiSpecSource {
  /** Source type. */
  type: AiGatewayToolServerOpenApiSourceType;

  /** Base64-encoded OpenAPI document. Required when kind is Inline. */
  contentBase64?: bytes;

  /** URL of the OpenAPI document. Required when kind is Url. */
  url?: string;
}

/** OpenAPI-backed MCP endpoint configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayOpenApiConfiguration {
  /** OpenAPI document source. */
  specSource: AiGatewayOpenApiSpecSource;
}

/** A tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerEndpoint {
  /** Stable endpoint identifier. Generated when omitted. */
  id?: string;

  /** Optional namespace used to prefix tool names. */
  `namespace`?: string;

  /** Endpoint type. */
  kind: AiGatewayToolServerEndpointSourceKind;

  /** Backend MCP configuration. Required when kind is mcp. */
  mcp?: AiGatewayMcpUrlConfiguration;

  /** OpenAPI configuration. Required when kind is McpFromOpenApi. */
  openApi?: AiGatewayOpenApiConfiguration;

  /** Backend credentials. */
  credentials?: AiGatewayToolServerCredentials;

  /** Upstream tool names or glob patterns to expose. */
  tools?: string[];

  /** Whether endpoint failure fails the whole federation. */
  required: boolean;
}

/** Tool server credentials to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerCredentialsUpdate {
  /** Authentication type. */
  type?: AiGatewayToolServerAuthenticationType;

  /** Static headers injected when calling the endpoint. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The implemented header credential contract supports arbitrary HTTP header names."
  @secret
  headers?: Record<string[]>;

  /** OAuth 2.0 configuration. */
  oauth2?: AiGatewayToolServerOauth2Authentication;

  /** Managed identity configuration. */
  managedIdentity?: AiGatewayToolServerManagedIdentityAuthentication;
}

/** MCP URL endpoint settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayMcpUrlConfigurationUpdate {
  /** Backend MCP server endpoint. */
  url?: string;

  /** MCP transport. */
  transport?: AiGatewayToolServerMcpTransport;
}

/** OpenAPI document source settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayOpenApiSpecSourceUpdate {
  /** Source type. */
  type?: AiGatewayToolServerOpenApiSourceType;

  /** Base64-encoded OpenAPI document. */
  contentBase64?: bytes;

  /** URL of the OpenAPI document. */
  url?: string;
}

/** OpenAPI-backed MCP endpoint settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayOpenApiConfigurationUpdate {
  /** OpenAPI document source. */
  specSource?: AiGatewayOpenApiSpecSourceUpdate;
}

/** A tool server endpoint to update. */
@added(Versions.v2026_09_01_preview)
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

  /** Backend credentials. */
  credentials?: AiGatewayToolServerCredentialsUpdate;

  /** Upstream tool names or glob patterns to expose. */
  tools?: string[];

  /** Whether endpoint failure fails the whole federation. */
  required?: boolean;
}

/** Properties for updating an AI Gateway tool server. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerUpdateProperties {
  /** Display name of the tool server. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the tool server. */
  description?: string;

  /** Whether the tool server is available to callers. */
  accessState?: AiGatewayToolServerAccessState;

  /** Tool server type. */
  @encodedName("application/json", "type")
  toolServerType?: AiGatewayToolServerType;

  /** Tool names or patterns explicitly allowed. */
  allowList?: string[];

  /** Tool names or patterns explicitly blocked. */
  blocked?: string[];

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
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerUpdateParameters {
  /** Tool server properties to update. */
  properties?: AiGatewayToolServerUpdateProperties;
}

/** Properties of an AI Gateway tool server. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerProperties {
  /** Display name of the tool server. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the tool server. */
  description?: string;

  /** Whether the tool server is available to callers. */
  accessState?: AiGatewayToolServerAccessState;

  /** Tool server type. */
  @encodedName("application/json", "type")
  toolServerType: AiGatewayToolServerType;

  /** Tool names or patterns explicitly allowed. */
  allowList?: string[];

  /** Tool names or patterns explicitly blocked. */
  blocked?: string[];

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

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway tool server resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayToolServerResource
  is Azure.ResourceManager.ProxyResource<AiGatewayToolServerProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayToolServerResource,
    KeyName = "toolServerName",
    SegmentName = "toolServers",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}
