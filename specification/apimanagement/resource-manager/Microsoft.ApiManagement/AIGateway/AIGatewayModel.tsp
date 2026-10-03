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
