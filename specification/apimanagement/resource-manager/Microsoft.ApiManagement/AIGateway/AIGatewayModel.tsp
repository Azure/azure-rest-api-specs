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

/** Deployment details for an AI Gateway model. */
@added(Versions.v2026_11_01)
model AiGatewayModelDeployment {
  /** ARM resource identifier of the provider deployment. */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/deployments";
    }
  ]>;

  /** Provider-side model name. */
  modelName: string;

  /** Provider-side model version. */
  modelVersion?: string;
}

/** Deployment details to update on an AI Gateway model. */
@added(Versions.v2026_11_01)
model AiGatewayModelDeploymentUpdate {
  /** ARM resource identifier of the provider deployment. */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/deployments";
    }
  ]>;

  /** Provider-side model name. */
  modelName?: string;

  /** Provider-side model version. */
  modelVersion?: string;
}

/** A fallback target for a model policy. */
@added(Versions.v2026_11_01)
model AiGatewayFallbackTarget {
  /** Resource identifier of a model in the same workspace. */
  modelId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/aigateways/workspaces/modelProviders/models";
    },
    {
      type: "Microsoft.ApiManagement/service/workspaces/modelProviders/models";
    }
  ]>;
}

/** A fallback target to update on a model policy. */
@added(Versions.v2026_11_01)
model AiGatewayFallbackTargetUpdate {
  /** Resource identifier of a model in the same workspace. */
  modelId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/aigateways/workspaces/modelProviders/models";
    },
    {
      type: "Microsoft.ApiManagement/service/workspaces/modelProviders/models";
    }
  ]>;
}

/** The type of an inline AI Gateway policy. */
@added(Versions.v2026_11_01)
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

  /** Limit cumulative spending in US dollars. */
  CostLimit: "costLimit",

  /** Check tool requests and responses for threats. */
  ToolThreatProtection: "toolThreatProtection",

  /** Invoke external pre-tool-call and post-tool-call hooks when authoring is enabled. */
  AgentHooks: "agentHooks",
}

/** Counter period. Token limits support minute/hour/day; request rate limits support minute/hour/day or whole-second ISO 8601 durations (e.g., PT37S); cost limits support hour/day/week/month/year. */
@added(Versions.v2026_11_01)
union AiGatewayPolicyPeriod {
  string,

  /** One minute. */
  Minute: "minute",

  /** One hour. */
  Hour: "hour",

  /** One day. */
  Day: "day",

  /** One week, for cost limits only. */
  Week: "week",

  /** One month, for cost limits only. */
  Month: "month",

  /** One year, for cost limits only. */
  Year: "year",
}

/** Aggregation scope of an inline policy. */
@added(Versions.v2026_11_01)
union AiGatewayPolicyScope {
  string,

  /** Apply the policy to its resource. */
  Resource: "resource",

  /** Aggregate counters across the workspace. Supported for workspace counter policies only. */
  Workspace: "workspace",
}

/** Public request dimension used to partition a policy counter. */
@added(Versions.v2026_11_01)
union AiGatewayCounterDimension {
  string,

  /** Authenticated request identity. */
  Identity: "identity",

  /** Request source IP address. */
  IpAddress: "ipAddress",
}

/** An ordered cost-budget override; exactly one selector must be specified. */
@added(Versions.v2026_11_01)
model AiGatewayCostLimitOverride {
  /** Authenticated token claims that must all match; claim names are case-sensitive. */
  @identifiers(#["name"])
  claims?: AiGatewayNameValuePair[];

  /** Azure resource identifier of the API key selecting this override. */
  apiKeyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/aigateways/apiKeys";
    },
    {
      type: "Microsoft.ApiManagement/service/apiKeys";
    }
  ]>;

  /** Override budget in US dollars. */
  @minValueExclusive(0)
  amount: decimal128;
}

/** An ordered cost-budget override to update. */
@added(Versions.v2026_11_01)
model AiGatewayCostLimitOverrideUpdate {
  /** Authenticated token claims that must all match; claim names are case-sensitive. */
  @identifiers(#[])
  claims?: AiGatewayNameValuePairUpdate[];

  /** Azure resource identifier of the API key selecting this override. */
  apiKeyResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/aigateways/apiKeys";
    },
    {
      type: "Microsoft.ApiManagement/service/apiKeys";
    }
  ]>;

  /** Override budget in US dollars. */
  @minValueExclusive(0)
  amount?: decimal128;
}

/** Outbound authentication settings for an external agent hook. */
@added(Versions.v2026_11_01)
model AiGatewayAgentHookAuthentication {
  /** Managed identity configuration for the hook endpoint. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** Secret HTTP headers injected when calling the hook endpoint. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeader[];
}

/** Outbound authentication settings to update on an external agent hook. */
@added(Versions.v2026_11_01)
model AiGatewayAgentHookAuthenticationUpdate {
  /** Managed identity configuration for the hook endpoint. */
  managedIdentity?: AiGatewayManagedIdentityAuthentication;

  /** Secret HTTP headers injected when calling the hook endpoint. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeaderUpdate[];
}

/** External hook settings; omitted fields inherit policy-level settings. */
@added(Versions.v2026_11_01)
model AiGatewayAgentHook {
  /** Failure mode when the hook call fails. */
  mode?: AiGatewayFailureMode;

  /** Hook destination URL. */
  endpoint?: AiGatewayDestinationEndpoint;

  /** Hook authentication settings. */
  authentication?: AiGatewayAgentHookAuthentication;

  /** Literal, non-secret HTTP headers, returned by read operations. */
  @identifiers(#["name"])
  headers?: AiGatewayNameValuePair[];
}

/** External hook settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayAgentHookUpdate {
  /** Failure mode when the hook call fails. */
  mode?: AiGatewayFailureMode;

  /** Hook destination URL. */
  endpoint?: AiGatewayDestinationEndpointUpdate;

  /** Hook authentication settings. */
  authentication?: AiGatewayAgentHookAuthenticationUpdate;

  /** Literal, non-secret HTTP headers. */
  @identifiers(#[])
  headers?: AiGatewayNameValuePairUpdate[];
}

/** Lifecycle hooks supported on models and tool servers. */
@added(Versions.v2026_11_01)
model AiGatewayAgentHooks {
  /** Hook invoked before calling a tool. */
  preToolCall?: AiGatewayAgentHook;

  /** Hook invoked after calling a tool. */
  postToolCall?: AiGatewayAgentHook;

  /** Hook invoked before calling a model. */
  preModelCall?: AiGatewayAgentHook;

  /** Hook invoked after calling a model. */
  postModelCall?: AiGatewayAgentHook;
}

/** Lifecycle hook settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayAgentHooksUpdate {
  /** Hook invoked before calling a tool. */
  preToolCall?: AiGatewayAgentHookUpdate;

  /** Hook invoked after calling a tool. */
  postToolCall?: AiGatewayAgentHookUpdate;

  /** Hook invoked before calling a model. */
  preModelCall?: AiGatewayAgentHookUpdate;

  /** Hook invoked after calling a model. */
  postModelCall?: AiGatewayAgentHookUpdate;
}

/** Severity threshold used by a content safety policy. */
@added(Versions.v2026_11_01)
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
@added(Versions.v2026_11_01)
union AiGatewayIpFilterAction {
  string,

  /** Allow matching addresses. */
  Allow: "Allow",

  /** Deny matching addresses. */
  Deny: "Deny",
}

/** An inline policy. Supported policy types and scopes depend on the parent resource. */
@added(Versions.v2026_11_01)
model AiGatewayPolicy {
  /** Policy type. */
  type: AiGatewayPolicyType;

  /** Policy scope. Workspace counter policies use workspace; other policies use resource. Agent hooks require an explicit resource scope. */
  scope?: AiGatewayPolicyScope;

  /** Stable identifier, required for costLimit and agentHooks policies. */
  id?: string;

  /** Token or request count allowed during a tokenLimit or requestRateLimit period. */
  @minValue(1)
  count?: int32;

  /** Counter period. Token limits support minute/hour/day; request rate limits support minute/hour/day or whole-second ISO 8601 durations (e.g., PT37S); cost limits support hour/day/week/month/year. */
  period?: AiGatewayPolicyPeriod;

  /** Unique public dimensions used to partition a token, cost, or request counter. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "False positive: counterKey contains public dimension selectors such as identity and ipAddress, not credentials or secret values. These selectors partition token, cost, or request counters."
  counterKey?: AiGatewayCounterDimension[];

  /** Cost budget in US dollars. */
  @minValueExclusive(0)
  amount?: decimal128;

  /** Ordered cost-budget overrides; supported only for counterKey [identity]. The first match wins. */
  @identifiers(#[])
  overrides?: AiGatewayCostLimitOverride[];

  /** Whether to check tool requests for threats. */
  preInvocation?: boolean;

  /** Whether to check tool responses for threats. */
  postInvocation?: boolean;

  /** Default failure mode for agent hooks. */
  mode?: AiGatewayFailureMode;

  /** Default destination URL for agent hooks. */
  endpoint?: AiGatewayDestinationEndpoint;

  /** Default outbound authentication for agent hooks. */
  authentication?: AiGatewayAgentHookAuthentication;

  /** Literal non-secret default HTTP headers for agent hooks. */
  @identifiers(#["name"])
  headers?: AiGatewayNameValuePair[];

  /** Lifecycle hooks; requires agent-hook authoring to be enabled on the gateway. */
  hooks?: AiGatewayAgentHooks;

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

  /** Origins allowed by a CORS policy. */
  allowedOrigins?: string[];

  /** HTTP methods allowed by a CORS policy. */
  allowedMethods?: string[];

  /** HTTP headers allowed by a CORS policy. */
  allowedHeaders?: string[];

  /** Response headers exposed to the browser. */
  exposeHeaders?: string[];

  /** Whether browsers may send credentials. */
  allowCredentials?: boolean;

  /** Whether unmatched CORS requests are terminated. */
  terminateUnmatchedRequest?: boolean;

  /** Browser preflight cache duration in seconds. */
  preflightResultMaxAge?: int32;
}

/** An inline policy to update on an AI Gateway model or tool server. */
@added(Versions.v2026_11_01)
model AiGatewayPolicyUpdate {
  /** Policy type. */
  type?: AiGatewayPolicyType;

  /** Aggregation scope supported by the policy and its parent resource. */
  scope?: AiGatewayPolicyScope;

  /** Stable identifier for costLimit or agentHooks. */
  id?: string;

  /** Token or request count allowed during a tokenLimit or requestRateLimit period. */
  @minValue(1)
  count?: int32;

  /** Counter period. Token limits support minute/hour/day; request rate limits support minute/hour/day or whole-second ISO 8601 durations (e.g., PT37S); cost limits support hour/day/week/month/year. */
  period?: AiGatewayPolicyPeriod;

  /** Public dimensions used to partition a token, cost, or request counter. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "False positive: counterKey contains public dimension selectors such as identity and ipAddress, not credentials or secret values. These selectors partition token, cost, or request counters."
  counterKey?: AiGatewayCounterDimension[];

  /** Cost budget in US dollars. */
  @minValueExclusive(0)
  amount?: decimal128;

  /** Ordered cost-budget overrides. */
  @identifiers(#[])
  overrides?: AiGatewayCostLimitOverrideUpdate[];

  /** Whether to check tool requests for threats. */
  preInvocation?: boolean;

  /** Whether to check tool responses for threats. */
  postInvocation?: boolean;

  /** Default failure mode for agent hooks. */
  mode?: AiGatewayFailureMode;

  /** Default destination URL for agent hooks. */
  endpoint?: AiGatewayDestinationEndpointUpdate;

  /** Default outbound authentication for agent hooks. */
  authentication?: AiGatewayAgentHookAuthenticationUpdate;

  /** Literal non-secret default HTTP headers for agent hooks. */
  @identifiers(#[])
  headers?: AiGatewayNameValuePairUpdate[];

  /** Lifecycle hooks to update. */
  hooks?: AiGatewayAgentHooksUpdate;

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

  /** Origins allowed by a CORS policy. */
  allowedOrigins?: string[];

  /** HTTP methods allowed by a CORS policy. */
  allowedMethods?: string[];

  /** HTTP headers allowed by a CORS policy. */
  allowedHeaders?: string[];

  /** Response headers exposed to the browser. */
  exposeHeaders?: string[];

  /** Whether browsers may send credentials. */
  allowCredentials?: boolean;

  /** Whether unmatched CORS requests are terminated. */
  terminateUnmatchedRequest?: boolean;

  /** Browser preflight cache duration in seconds. */
  preflightResultMaxAge?: int32;
}

/** Maps a canonical AI Gateway API identifier to a relative backend path served by the model provider. */
@added(Versions.v2026_11_01)
model AiGatewayModelEndpoint {
  /** Canonical AI Gateway API identifier (for example, v1/chat/completions, v1/responses, v1/messages, or v1/embeddings). */
  api: string;

  /** Backend path relative to the model provider's base endpoint, starting with '/'. */
  path: string;
}

/** A model endpoint mapping to update. */
@added(Versions.v2026_11_01)
model AiGatewayModelEndpointUpdate
  is OptionalProperties<AiGatewayModelEndpoint>;

/** Properties for updating an AI Gateway model. */
@added(Versions.v2026_11_01)
model AiGatewayModelUpdateProperties {
  /** Display name of the model. */
  displayName?: string;

  /** Description of the model. */
  description?: string;

  /** Provider deployment details. */
  deployment?: AiGatewayModelDeploymentUpdate;

  /** API-to-backend-path mappings served by this model. */
  @identifiers(#[])
  endpoints?: AiGatewayModelEndpointUpdate[];

  /** Inline policies applied to this model. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];

  /** Runtime endpoints supported by this model. */
  supportedEndpoints?: string[];
}

/** Parameters for updating an AI Gateway model. */
@added(Versions.v2026_11_01)
model AiGatewayModelUpdateParameters {
  /** Model properties to update. */
  properties?: AiGatewayModelUpdateProperties;
}

/** Properties of an AI Gateway model. */
@added(Versions.v2026_11_01)
model AiGatewayModelProperties {
  /** Display name of the model. */
  displayName: string;

  /** Description of the model. */
  description?: string;

  /** Parent model provider type. */
  @visibility(Lifecycle.Read)
  providerKind?: AiGatewayModelProviderKind;

  /** Provider deployment details. */
  deployment: AiGatewayModelDeployment;

  /** API-to-backend-path mappings served by this model. */
  @identifiers(#["api"])
  endpoints?: AiGatewayModelEndpoint[];

  /** Runtime endpoints supported by this model. */
  supportedEndpoints?: string[];

  /** Inline policies applied to this model. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** An AI Gateway model resource. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayModelProviderResource)
model AiGatewayModelResource
  is Azure.ResourceManager.ProxyResource<AiGatewayModelProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayModelResource,
    KeyName = "modelName",
    SegmentName = "models",
    NamePattern = "^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$"
  >;
}
