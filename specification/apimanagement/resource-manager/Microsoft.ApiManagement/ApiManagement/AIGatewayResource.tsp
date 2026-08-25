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

  /** ETag of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AI Gateway resources expose an ETag for optimistic concurrency."
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

/** Parameters for updating an AI Gateway. */
@added(Versions.v2026_09_01_preview)
model AiGatewayUpdateParameters {
  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "ARM resource tags are represented as a string map."
  tags?: Record<string>;
}

/** Properties of an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceProperties {
  /** Display name of the workspace. */
  displayName?: string;

  /** Description of the workspace. */
  description?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway workspace. */
@added(Versions.v2026_09_01_preview)
model AiGatewayWorkspaceUpdateProperties {
  /** Display name of the workspace. */
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

  /** ETag of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AI Gateway resources expose an ETag for optimistic concurrency."
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
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
  kind: "ManagedIdentity";
}

/** Foundry model provider configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayFoundryProviderConfiguration {
  /** Foundry endpoint. */
  endpoint: string;

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
  kind?: "ManagedIdentity";
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
  displayName?: string;

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

  /** ETag of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AI Gateway resources expose an ETag for optimistic concurrency."
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
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
  /** Description of the model. */
  description?: string;

  /** Provider deployment details. */
  deployment?: AiGatewayModelDeploymentUpdate;

  /** Inline policies applied to this model. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];
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
  /** Description of the model. */
  description?: string;

  /** Parent model provider type. */
  @visibility(Lifecycle.Read)
  providerKind?: AiGatewayModelProviderKind;

  /** Provider deployment details. */
  deployment: AiGatewayModelDeployment;

  /** Runtime endpoints supported by this model. */
  @visibility(Lifecycle.Read)
  supportedEndpoints?: string[];

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

  /** ETag of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AI Gateway resources expose an ETag for optimistic concurrency."
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

/** Credentials for a tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerCredentials {
  /** Credential type. */
  kind: AiGatewayToolServerCredentialKind;

  /** API key configuration. Required when kind is ApiKey. */
  apiKey?: AiGatewayApiKeyCredential;
}

/** MCP URL endpoint configuration. */
@added(Versions.v2026_09_01_preview)
model AiGatewayMcpUrlConfiguration {
  /** Backend MCP server endpoint. */
  endpoint: string;

  /** MCP transport. */
  transport: AiGatewayMcpTransport;
}

/** Source of an OpenAPI document. */
@added(Versions.v2026_09_01_preview)
model AiGatewayOpenApiSpecSource {
  /** Source type. */
  kind: AiGatewayOpenApiSpecSourceKind;

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
  /** Runtime path exposed for this endpoint. */
  url: string;

  /** Endpoint type. */
  kind: AiGatewayToolServerEndpointKind;

  /** Backend MCP URL configuration. Required when kind is McpUrl. */
  @clientName("mcpUri", "csharp")
  mcpUrl?: AiGatewayMcpUrlConfiguration;

  /** OpenAPI configuration. Required when kind is McpFromOpenApi. */
  openApi?: AiGatewayOpenApiConfiguration;

  /** Backend credentials. */
  credentials: AiGatewayToolServerCredentials;
}

/** Tool server credentials to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerCredentialsUpdate {
  /** Credential type. */
  kind?: AiGatewayToolServerCredentialKind;

  /** API key configuration. */
  apiKey?: AiGatewayApiKeyCredentialUpdate;
}

/** MCP URL endpoint settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayMcpUrlConfigurationUpdate {
  /** Backend MCP server endpoint. */
  endpoint?: string;

  /** MCP transport. */
  transport?: AiGatewayMcpTransport;
}

/** OpenAPI document source settings to update. */
@added(Versions.v2026_09_01_preview)
model AiGatewayOpenApiSpecSourceUpdate {
  /** Source type. */
  kind?: AiGatewayOpenApiSpecSourceKind;

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
  /** Runtime path exposed for this endpoint. */
  url?: string;

  /** Endpoint type. */
  kind?: AiGatewayToolServerEndpointKind;

  /** Backend MCP URL configuration. */
  @clientName("mcpUri", "csharp")
  mcpUrl?: AiGatewayMcpUrlConfigurationUpdate;

  /** OpenAPI configuration. */
  openApi?: AiGatewayOpenApiConfigurationUpdate;

  /** Backend credentials. */
  credentials?: AiGatewayToolServerCredentialsUpdate;
}

/** Properties for updating an AI Gateway tool server. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerUpdateProperties {
  /** Display name of the tool server. */
  displayName?: string;

  /** Description of the tool server. */
  description?: string;

  /** Endpoint configurations exposed by this tool server. */
  @identifiers(#[])
  endpoints?: AiGatewayToolServerEndpointUpdate[];

  /** Inline policies applied to this tool server. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];
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
  displayName?: string;

  /** Description of the tool server. */
  description?: string;

  /** Endpoint configurations exposed by this tool server. */
  @identifiers(#["url"])
  endpoints: AiGatewayToolServerEndpoint[];

  /** Inline policies applied to this tool server. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

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

  /** ETag of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AI Gateway resources expose an ETag for optimistic concurrency."
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

/** Properties of an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyProperties {
  /** Display name of the key. */
  displayName?: string;

  /** Hint containing the final characters of the primary key. */
  @visibility(Lifecycle.Read)
  primaryKeyHint?: string;

  /** Hint containing the final characters of the secondary key. */
  @visibility(Lifecycle.Read)
  secondaryKeyHint?: string;

  /** Primary key value returned only when it is initially issued. */
  @secret
  primaryValue?: string;

  /** Secondary key value returned only when it is initially issued. */
  @secret
  secondaryValue?: string;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties for updating an AI Gateway API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyUpdateProperties {
  /** Display name of the key. */
  displayName?: string;
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

  /** ETag of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AI Gateway resources expose an ETag for optimistic concurrency."
  @visibility(Lifecycle.Read)
  etag?: Azure.Core.eTag;
}

/** Metadata returned for model provider credentials. */
@added(Versions.v2026_09_01_preview)
model AiGatewayCredentialMetadata {
  /** Whether credentials have been configured. */
  configured: boolean;
}

/** Secret values configured on tool server endpoints. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerSecrets {
  /** Endpoint secret values. */
  @identifiers(#["url"])
  endpoints: AiGatewayToolServerSecret[];
}

/** Secret value configured on one tool server endpoint. */
@added(Versions.v2026_09_01_preview)
model AiGatewayToolServerSecret {
  /** Runtime endpoint path. */
  url: string;

  /** Secret value, when one is configured. */
  @secret
  value?: string;
}

/** Primary and secondary API key values. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyValues {
  /** Primary API key value. */
  @secret
  primaryValue: string;

  /** Secondary API key value. */
  @secret
  secondaryValue: string;
}

/** Request to regenerate one API key slot. */
@added(Versions.v2026_09_01_preview)
@clientName("AiGatewayApiKeyRegenerateContent", "csharp")
model AiGatewayApiKeyRegenerateRequest {
  /** Key slot to regenerate. */
  target: AiGatewayApiKeyTarget;
}

/** Result of regenerating an API key. */
@added(Versions.v2026_09_01_preview)
model AiGatewayApiKeyRegenerateResult {
  /** Regenerated key slot. */
  target: AiGatewayApiKeyTarget;

  /** Newly generated secret value. */
  @secret
  value: string;
}

alias AiGatewayIfMatchOptional = {
  /** ETag of the resource. Required for an update. */
  @header("If-Match")
  ifMatch?: string;
};

alias AiGatewayIfMatchRequired = {
  /** ETag of the resource, or * for an unconditional operation. */
  @header("If-Match")
  ifMatch: string;
};

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface AiGatewayResources {
  get is ArmResourceRead<AiGatewayResource>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AiGatewayResource>;
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    AiGatewayResource,
    PatchModel = AiGatewayUpdateParameters,
    Parameters = AiGatewayIfMatchRequired
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayResource,
    Parameters = AiGatewayIfMatchRequired
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
    Parameters = AiGatewayIfMatchRequired
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayWorkspaceResource,
    Parameters = AiGatewayIfMatchRequired
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
    Parameters = AiGatewayIfMatchRequired
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayModelProviderResource,
    Parameters = AiGatewayIfMatchRequired
  >;
  listByWorkspace is ArmResourceListByParent<AiGatewayModelProviderResource>;

  /** Gets credential metadata for a model provider. Secret values are not returned. */
  @post
  @action("listCredentials")
  listCredentials is ArmResourceActionSync<
    AiGatewayModelProviderResource,
    void,
    ArmResponse<AiGatewayCredentialMetadata>
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
    Parameters = AiGatewayIfMatchRequired
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayModelResource,
    Parameters = AiGatewayIfMatchRequired
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
    Parameters = AiGatewayIfMatchRequired
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayToolServerResource,
    Parameters = AiGatewayIfMatchRequired
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
    Parameters = AiGatewayIfMatchRequired
  >;
  delete is ArmResourceDeleteWithoutOkAsync<
    AiGatewayApiKeyResource,
    Parameters = AiGatewayIfMatchRequired
  >;
  listByAiGateway is ArmResourceListByParent<AiGatewayApiKeyResource>;

  /** Returns primary and secondary key values once. */
  @post
  @action("listValues")
  listValues is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    void,
    ArmResponse<AiGatewayApiKeyValues>
  >;

  /** Regenerates the selected API key value. */
  @post
  @action("regenerate")
  regenerate is ArmResourceActionSync<
    AiGatewayApiKeyResource,
    AiGatewayApiKeyRegenerateRequest,
    ArmResponse<AiGatewayApiKeyRegenerateResult>
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
