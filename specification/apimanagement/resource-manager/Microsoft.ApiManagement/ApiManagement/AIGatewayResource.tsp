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

/** Provisioning state of an AI Gateway resource. */
@added(Versions.v2026_09_01_preview)
union AiGatewayProvisioningState {
  string,

  /** The resource is ready. */
  Succeeded: "Succeeded",

  /** The resource operation failed. */
  Failed: "Failed",

  /** The resource operation was canceled. */
  Canceled: "Canceled",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

/** The type of an AI model provider. */
@added(Versions.v2026_09_01_preview)
union AiGatewayModelProviderKind {
  string,

  /** Azure AI Foundry provider. */
  Foundry: "Foundry",

  /** Custom model provider. */
  Custom: "Custom",
}

/** Authentication type used by an AI model provider. */
@added(Versions.v2026_09_01_preview)
union AiGatewayModelProviderAuthenticationKind {
  string,

  /** Authenticate using a managed identity. */
  ManagedIdentity: "ManagedIdentity",

  /** Authenticate using an API key. */
  ApiKey: "ApiKey",
}

/** Authentication type used by a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerCredentialKind {
  string,

  /** No credentials. */
  None: "None",

  /** Authenticate using an API key. */
  ApiKey: "ApiKey",
}

/** The type of a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
union AiGatewayToolServerEndpointKind {
  string,

  /** Connect to an MCP server URL. */
  McpUrl: "McpUrl",

  /** Create an MCP endpoint from an OpenAPI document. */
  McpFromOpenApi: "McpFromOpenApi",
}

/** Transport used to connect to an MCP server. */
@added(Versions.v2026_09_01_preview)
union AiGatewayMcpTransport {
  string,

  /** Streamable HTTP transport. */
  StreamableHttp: "StreamableHttp",
}

/** Source type for an OpenAPI document. */
@added(Versions.v2026_09_01_preview)
union AiGatewayOpenApiSpecSourceKind {
  string,

  /** The OpenAPI document is supplied inline. */
  Inline: "Inline",

  /** The OpenAPI document is loaded from a URL. */
  Url: "Url",
}

/** API key slot to regenerate. */
@added(Versions.v2026_09_01_preview)
union AiGatewayApiKeyTarget {
  string,

  /** The primary key. */
  Primary: "Primary",

  /** The secondary key. */
  Secondary: "Secondary",
}

/** Properties of an AI Gateway. */
#suppress "@azure-tools/typespec-azure-resource-manager/empty-updateable-properties" "The AI Gateway resource supports updating ARM tags; its RP-specific properties are read-only."
@added(Versions.v2026_09_01_preview)
model AiGatewayProperties {
  /** Runtime hostname used to invoke this AI Gateway. */
  @visibility(Lifecycle.Read)
  runtimeHostname?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway resource. */
@added(Versions.v2026_09_01_preview)
model AiGatewayResource is Azure.ResourceManager.TrackedResource<
  AiGatewayProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = AiGatewayResource,
    KeyName = "aiGatewayName",
    SegmentName = "aigateways",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/** Parameters for updating an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayUpdateParameters
  is Azure.ResourceManager.Foundations.TagsUpdateModel<AiGatewayResource>;

/** Properties of an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceProperties {
  /** Display name of the workspace. */
  @encodedName("application/json", "name")
  displayName: string;

  /** Description of the workspace. */
  description: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceUpdateProperties {
  /** Display name of the workspace. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the workspace. */
  description?: string;
}

/** Parameters for updating an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceUpdateParameters {
  /** Workspace properties to update. */
  properties?: AiGatewayWorkspaceUpdateProperties;
}

/** An AI Gateway workspace resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayResource)
model AiGatewayWorkspaceResource
  is Azure.ResourceManager.ProxyResource<AiGatewayWorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayWorkspaceResource,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/** API key credentials for an upstream service. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyCredential {
  /** Name of the HTTP header that carries the API key. */
  headerName: string;

  /** Secret API key value. This value is not returned by read operations. */
  @secret
  value?: string;
}

/** Authentication configuration for a Foundry model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryAuthentication {
  /** Authentication type. */
  kind: AiGatewayModelProviderAuthenticationKind;

  /** Managed identity settings. Applicable when kind is ManagedIdentity. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** API key configuration. Required when kind is ApiKey. */
  apiKey?: AiGatewayApiKeyCredential;
}

/** Managed identity settings for a model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayManagedIdentityAuthentication {
  /** Token audience requested for managed identity authentication. */
  resource?: string;

  /** Client ID of a user-assigned managed identity. */
  clientId?: string;
}

/** Foundry model provider configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryProviderConfiguration {
  /** Foundry endpoint. */
  endpoint?: string;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds: string[];

  /** Authentication configuration. */
  authentication: AiGatewayFoundryAuthentication;
}

/** Authentication configuration for a custom model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomAuthentication {
  /** Authentication type. */
  kind: "ApiKey";

  /** API key configuration. */
  apiKey: AiGatewayApiKeyCredential;
}

/** Custom model provider configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomProviderConfiguration {
  /** Provider base endpoint. */
  endpoint: string;

  /** Authentication configuration. */
  authentication: AiGatewayCustomAuthentication;
}

/** API key credentials for updating an upstream service. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyCredentialUpdate {
  /** Name of the HTTP header that carries the API key. */
  headerName?: string;

  /** Secret API key value. */
  @secret
  value?: string;
}

/** Foundry authentication settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryAuthenticationUpdate {
  /** Authentication type. */
  kind?: AiGatewayModelProviderAuthenticationKind;

  /** Managed identity settings. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** Foundry model provider settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryProviderConfigurationUpdate {
  /** Foundry endpoint. */
  endpoint?: string;

  /** Cognitive Services account resource identifiers available to this provider. */
  resourceIds?: string[];

  /** Authentication configuration. */
  authentication?: AiGatewayFoundryAuthenticationUpdate;
}

/** Custom model provider authentication settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomAuthenticationUpdate {
  /** Authentication type. */
  kind?: "ApiKey";

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** Custom model provider settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCustomProviderConfigurationUpdate {
  /** Provider base endpoint. */
  endpoint?: string;

  /** Authentication configuration. */
  authentication?: AiGatewayCustomAuthenticationUpdate;
}

/** Properties for updating an AI Gateway model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProviderUpdateProperties {
  /** Model provider type. */
  kind?: AiGatewayModelProviderKind;

  /** Display name of the model provider. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the model provider. */
  description?: string;

  /** Foundry configuration. */
  foundry?: AiGatewayFoundryProviderConfigurationUpdate;

  /** Custom provider configuration. */
  custom?: AiGatewayCustomProviderConfigurationUpdate;
}

/** Parameters for updating an AI Gateway model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProviderUpdateParameters {
  /** Model provider properties to update. */
  properties?: AiGatewayModelProviderUpdateProperties;
}

/** Properties of an AI Gateway model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProviderProperties {
  /** Model provider type. This value cannot be changed after creation. */
  kind: AiGatewayModelProviderKind;

  /** Display name of the model provider. */
  @encodedName("application/json", "name")
  displayName: string;

  /** Description of the model provider. */
  description?: string;

  /** Foundry configuration. Required when kind is Foundry. */
  foundry?: AiGatewayFoundryProviderConfiguration;

  /** Custom provider configuration. Required when kind is Custom. */
  custom?: AiGatewayCustomProviderConfiguration;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway model provider resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayModelProviderResource
  is Azure.ResourceManager.ProxyResource<AiGatewayModelProviderProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayModelProviderResource,
    KeyName = "modelProviderName",
    SegmentName = "modelProviders",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/** Deployment details for an AI Gateway model. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelDeployment {
  /** ARM resource identifier of the provider deployment. */
  resourceId?: string;

  /** Provider-side model name. */
  modelName: string;

  /** Provider-side model version. */
  modelVersion?: string;
}

/** Deployment details to update on an AI Gateway model. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelDeploymentUpdate {
  /** ARM resource identifier of the provider deployment. */
  resourceId?: string;

  /** Provider-side model name. */
  modelName?: string;

  /** Provider-side model version. */
  modelVersion?: string;
}

/** A fallback target for a model policy. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFallbackTarget {
  /** Resource identifier of a model in the same workspace. */
  modelId: string;
}

/** A fallback target to update on a model policy. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFallbackTargetUpdate {
  /** Resource identifier of a model in the same workspace. */
  modelId?: string;
}

/** The type of an inline AI Gateway policy. */
@added(Versions.v2026_09_01_preview)
union AiGatewayPolicyType {
  string,

  /** Limit consumed tokens. */
  TokenLimit: "tokenLimit",

  /** Filter unsafe content. */
  ContentSafety: "contentSafety",

  /** Route to fallback models after failures. */
  Fallback: "fallback",

  /** Filter clients by IP address. */
  IpFilter: "ipFilter",

  /** Limit requests over time. */
  RequestRateLimit: "requestRateLimit",

  /** Configure cross-origin resource sharing. */
  Cors: "cors",
}

/** Time period used by a token limit policy. */
@added(Versions.v2026_09_01_preview)
union AiGatewayTokenLimitPeriod {
  string,

  /** One minute. */
  Minute: "minute",

  /** One hour. */
  Hour: "hour",

  /** One day. */
  Day: "day",

  /** One month. */
  Month: "month",
}

/** Severity threshold used by a content safety policy. */
@added(Versions.v2026_09_01_preview)
union AiGatewayContentSafetySeverity {
  string,

  /** Low severity. */
  Low: "Low",

  /** Medium severity. */
  Medium: "Medium",

  /** High severity. */
  High: "High",

  /** Do not filter this category. */
  None: "None",
}

/** Action performed by an IP filtering policy. */
@added(Versions.v2026_09_01_preview)
union AiGatewayIpFilterAction {
  string,

  /** Allow matching addresses. */
  Allow: "Allow",

  /** Deny matching addresses. */
  Deny: "Deny",
}

/** An inline policy attached to an AI Gateway model or tool server. */
@added(Versions.v2026_09_01_preview)
model AiGatewayPolicy {
  /** Policy type. */
  type: AiGatewayPolicyType;

  /** Token count allowed during a token limit period. */
  count?: int64;

  /** Token limit period. */
  period?: AiGatewayTokenLimitPeriod;

  /** Key used to partition a token or request rate limit counter. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "The counter key selects a public request attribute and is not a credential."
  counterKey?: string;

  /** Content safety service endpoint. */
  endpoint?: string;

  /** Content safety service key. */
  @secret
  key?: string;

  /** Hate-content severity threshold. */
  hateSeverity?: AiGatewayContentSafetySeverity;

  /** Violence-content severity threshold. */
  violenceSeverity?: AiGatewayContentSafetySeverity;

  /** Sexual-content severity threshold. */
  sexualSeverity?: AiGatewayContentSafetySeverity;

  /** Self-harm-content severity threshold. */
  selfHarmSeverity?: AiGatewayContentSafetySeverity;

  /** Consecutive failure count that opens a fallback circuit. */
  threshold?: int32;

  /** Duration for which the fallback circuit remains open. */
  tripDurationSeconds?: int32;

  /** Ordered fallback model targets. */
  @identifiers(#["modelId"])
  fallbackTargets?: AiGatewayFallbackTarget[];

  /** IP filtering action. */
  action?: AiGatewayIpFilterAction;

  /** CIDR ranges to allow or deny. */
  cidrRanges?: string[];

  /** Request count allowed during the configured period. */
  callsPerPeriod?: int64;

  /** Request rate limit period in seconds. */
  periodSeconds?: int32;

  /** Origins allowed by a CORS policy. */
  allowedOrigins?: string[];

  /** HTTP methods allowed by a CORS policy. */
  allowedMethods?: string[];

  /** HTTP headers allowed by a CORS policy. */
  allowedHeaders?: string[];

  /** Browser preflight cache duration in seconds. */
  maxAgeSeconds?: int32;
}

/** An inline policy to update on an AI Gateway model or tool server. */
@added(Versions.v2026_09_01_preview)
model AiGatewayPolicyUpdate {
  /** Policy type. */
  type?: AiGatewayPolicyType;

  /** Token count allowed during a token limit period. */
  count?: int64;

  /** Token limit period. */
  period?: AiGatewayTokenLimitPeriod;

  /** Key used to partition a token or request rate limit counter. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "The counter key selects a public request attribute and is not a credential."
  counterKey?: string;

  /** Content safety service endpoint. */
  endpoint?: string;

  /** Content safety service key. */
  @secret
  key?: string;

  /** Hate-content severity threshold. */
  hateSeverity?: AiGatewayContentSafetySeverity;

  /** Violence-content severity threshold. */
  violenceSeverity?: AiGatewayContentSafetySeverity;

  /** Sexual-content severity threshold. */
  sexualSeverity?: AiGatewayContentSafetySeverity;

  /** Self-harm-content severity threshold. */
  selfHarmSeverity?: AiGatewayContentSafetySeverity;

  /** Consecutive failure count that opens a fallback circuit. */
  threshold?: int32;

  /** Duration for which the fallback circuit remains open. */
  tripDurationSeconds?: int32;

  /** Ordered fallback model targets. */
  @identifiers(#[])
  fallbackTargets?: AiGatewayFallbackTargetUpdate[];

  /** IP filtering action. */
  action?: AiGatewayIpFilterAction;

  /** CIDR ranges to allow or deny. */
  cidrRanges?: string[];

  /** Request count allowed during the configured period. */
  callsPerPeriod?: int64;

  /** Request rate limit period in seconds. */
  periodSeconds?: int32;

  /** Origins allowed by a CORS policy. */
  allowedOrigins?: string[];

  /** HTTP methods allowed by a CORS policy. */
  allowedMethods?: string[];

  /** HTTP headers allowed by a CORS policy. */
  allowedHeaders?: string[];

  /** Browser preflight cache duration in seconds. */
  maxAgeSeconds?: int32;
}

/** Properties for updating an AI Gateway model. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelUpdateProperties {
  /** Display name of the model. */
  @encodedName("application/json", "name")
  displayName?: string;

  /** Description of the model. */
  description?: string;

  /** Provider deployment details. */
  deployment?: AiGatewayModelDeploymentUpdate;

  /** Inline policies applied to this model. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];

  /** Runtime endpoints supported by this model. */
  supportedEndpoints?: string[];
}

/** Parameters for updating an AI Gateway model. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelUpdateParameters {
  /** Model properties to update. */
  properties?: AiGatewayModelUpdateProperties;
}

/** Properties of an AI Gateway model. */
@added(Versions.v2026_09_01_preview)
model AiGatewayModelProperties {
  /** Display name of the model. */
  @encodedName("application/json", "name")
  displayName: string;

  /** Description of the model. */
  description?: string;

  /** Parent model provider type. */
  @visibility(Lifecycle.Read)
  providerKind?: AiGatewayModelProviderKind;

  /** Provider deployment details. */
  deployment: AiGatewayModelDeployment;

  /** Runtime endpoints supported by this model. */
  supportedEndpoints: string[];

  /** Inline policies applied to this model. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway model resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayModelProviderResource)
model AiGatewayModelResource
  is Azure.ResourceManager.ProxyResource<AiGatewayModelProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayModelResource,
    KeyName = "modelName",
    SegmentName = "models",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

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

/** Properties of an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyProperties {
  /** Display name of the key. */
  displayName?: string;

  /** Subscription state. */
  state?: string;

  /** Creation time. */
  @visibility(Lifecycle.Read)
  createdDate?: utcDateTime;

  /** Optional expiration time. */
  expirationDate?: utcDateTime;

  /** Primary key value. Omitted from ordinary read responses. */
  @secret
  primaryKey?: string;

  /** Secondary key value. Omitted from ordinary read responses. */
  @secret
  secondaryKey?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyUpdateProperties {
  /** Display name of the key. */
  displayName?: string;

  /** Subscription state. */
  state?: string;

  /** Optional expiration time. */
  expirationDate?: utcDateTime;
}

/** Parameters for updating an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyUpdateParameters {
  /** API key properties to update. */
  properties?: AiGatewayApiKeyUpdateProperties;
}

/** An AI Gateway API key resource. */
@added(Versions.v2026_09_01_preview)
@parentResource(AiGatewayResource)
model AiGatewayApiKeyResource
  is Azure.ResourceManager.ProxyResource<AiGatewayApiKeyProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayApiKeyResource,
    KeyName = "apiKeyName",
    SegmentName = "apiKeys",
    NamePattern = "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

/** Credential returned for a model provider. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCredentialValue {
  /** Stored credential value. */
  @secret
  value?: string;
}

/** Secret values configured on tool server endpoints. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerSecrets {
  /** Endpoint secret values. */
  @identifiers(#["id"])
  endpoints: AiGatewayToolServerSecret[];
}

/** Secret value configured on one tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerSecret {
  /** Stable endpoint identifier. */
  id: string;

  /** Endpoint authentication including secret values. */
  credentials?: AiGatewayToolServerCredentials;

  /** OpenAPI configuration including inline content. */
  openApi?: AiGatewayOpenApiConfiguration;
}

/** Primary and secondary API key values. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyValues {
  /** Primary API key value. */
  @secret
  primaryKey: string;

  /** Secondary API key value. */
  @secret
  secondaryKey: string;
}

alias AiGatewayIfMatchOptional = {
  /** ETag of the resource. Required for an update. */
  @header("If-Match")
  ifMatch?: string;
};

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayResources {
  get is ArmResourceRead<AiGatewayResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayResource,
    PatchModel = AiGatewayUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByResourceGroup is ArmResourceListByParent<AiGatewayResource>;
  listBySubscription is ArmListBySubscription<AiGatewayResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayWorkspaceResources {
  get is ArmResourceRead<AiGatewayWorkspaceResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayWorkspaceResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayWorkspaceResource,
    PatchModel = AiGatewayWorkspaceUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayWorkspaceResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByAiGateway is ArmResourceListByParent<AiGatewayWorkspaceResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayModelProviderResources {
  get is ArmResourceRead<AiGatewayModelProviderResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayModelProviderResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayModelProviderResource,
    PatchModel = AiGatewayModelProviderUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayModelProviderResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayModelProviderResource>;

  /** Gets credential metadata for a model provider. Secret values are not returned. */
  @post
  @action("listCredentials")
  listCredentials is ArmResourceActionSync<
    AiGatewayModelProviderResource,
    void,
    ArmResponse<AiGatewayCredentialValue>
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayModelResources {
  get is ArmResourceRead<AiGatewayModelResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayModelResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayModelResource,
    PatchModel = AiGatewayModelUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayModelResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByModelProvider is ArmResourceListByParent<AiGatewayModelResource>;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayToolServerResources {
  get is ArmResourceRead<AiGatewayToolServerResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayToolServerResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayToolServerResource,
    PatchModel = AiGatewayToolServerUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayToolServerResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayToolServerResource>;

  /** Lists secret values configured on tool server endpoints. */
  @post
  @action("listSecrets")
  listSecrets is ArmResourceActionSync<
    AiGatewayToolServerResource,
    void,
    ArmResponse<AiGatewayToolServerSecrets>
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayApiKeyResources {
  get is ArmResourceRead<AiGatewayApiKeyResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AiGatewayApiKeyResource,
    Parameters = AiGatewayIfMatchOptional
  >;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayApiKeyResource,
    PatchModel = AiGatewayApiKeyUpdateParameters,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayApiKeyResource,
    Parameters = Azure.ResourceManager.CommonTypes.IfMatchHeader
  >;
  listByAiGateway is ArmResourceListByParent<AiGatewayApiKeyResource>;

  /** Returns primary and secondary key values. */
  @post
  @action("listSecrets")
  listSecrets is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmResponse<AiGatewayApiKeyValues>
  >;

  /** Regenerates the primary API key value. */
  @post
  @action("regeneratePrimaryKey")
  regeneratePrimaryKey is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmNoContentResponse
  >;

  /** Regenerates the secondary API key value. */
  @post
  @action("regenerateSecondaryKey")
  regenerateSecondaryKey is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmNoContentResponse
  >;
}

/** Cross-provider model listing operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "This operation returns models across all providers in one workspace."
@added(Versions.v2026_09_01_preview)
interface AiGatewayWorkspaceModelOperations {
  /** Lists models from every model provider in an AI Gateway workspace. */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/aigateways/{aiGatewayName}/workspaces/{workspaceName}/models")
  @get
  @list
  listByWorkspace(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** AI Gateway resource name. */
    @pattern("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$")
    @path
    aiGatewayName: string,

    /** Workspace resource name. */
    @pattern("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$")
    @path
    workspaceName: string,
  ): ArmResponse<ResourceListResult<AiGatewayModelResource>> | ErrorResponse;
}
