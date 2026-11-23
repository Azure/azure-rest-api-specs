import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Routing stage in an AI Gateway alias selection order. */
@added(Versions.v2026_11_01)
union AiGatewayAliasSelectionStage {
  string,

  /** Deterministic priority and weight routing stage. */
  Priority: "priority",

  /** Automatic model selection stage. */
  AutoModelSelection: "autoModelSelection",

  /** Stateless session backend preference stage. */
  SessionBackendPreference: "sessionBackendPreference",
}

/** Quality and cost objective for automatic model selection. */
@added(Versions.v2026_11_01)
union AiGatewayModelSelectionObjective {
  string,

  /** Balance quality and cost. */
  Balanced: "Balanced",

  /** Prefer lower cost. */
  Cost: "Cost",

  /** Prefer higher quality. */
  Quality: "Quality",
}

/** Per-request behavior allowed for automatic model selection. */
@added(Versions.v2026_11_01)
union AiGatewayAllowedRequestOverride {
  string,

  /** Allow narrowing the configured selector model pool. */
  Model: "model",

  /** Allow overriding the selection objective. */
  Objective: "objective",

  /** Enable chat function-tool compatibility filtering without granting either override. */
  FilterModelsForToolCompatibility: "filterModelsForToolCompatibility",
}

/** Stateless backend preference using an existing caller session key. */
@added(Versions.v2026_11_01)
model AiGatewaySessionBackendPreference {
  /** CEL expression returning the caller session key. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "False positive: key is a CEL expression that extracts a non-secret caller session identifier for routing affinity, not a credential."
  key: string;
}

/** Stateless backend preference settings to update. */
@added(Versions.v2026_11_01)
model AiGatewaySessionBackendPreferenceUpdate {
  /** CEL expression returning the caller session key. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "False positive: key is a CEL expression that extracts a non-secret caller session identifier for routing affinity, not a credential."
  key?: string;
}

/** Automatic model selection configuration for an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayModelSelection {
  /** Configured quality/cost objective. */
  objective: AiGatewayModelSelectionObjective;

  /** Allowed per-request behaviors. Omitting the property or sending an empty array denies overrides and disables function-tool compatibility filtering. */
  allowedRequestOverrides?: AiGatewayAllowedRequestOverride[];
}

/** Automatic model selection configuration to update. */
@added(Versions.v2026_11_01)
model AiGatewayModelSelectionUpdate
  is OptionalProperties<AiGatewayModelSelection>;

/** An ordered failure rule for an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasFailureRule {
  @doc("Boolean @cel(...) expression evaluated against the current routing failure.")
  when: string;

  /** Maximum additional attempts on the same backend; defaults to zero. */
  @minValue(0)
  retryAttempts?: int32;

  @doc("Optional ISO 8601 duration or duration-valued @cel(...) expression for excluding the failed backend.")
  excludeFor?: string;
}

/** An ordered failure rule to update on an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasFailureRuleUpdate
  is OptionalProperties<AiGatewayAliasFailureRule>;

/** A model targeted by an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasTarget {
  /** Azure resource identifier of the target model in the default workspace. */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ApiManagement/aigateways/workspaces/modelProviders/models";
    },
    {
      type: "Microsoft.ApiManagement/service/workspaces/modelProviders/models";
    }
  ]>;

  /** Unversioned canonical model name grouping equivalent serving deployments. */
  @minLength(1)
  selectorModelName?: string;

  @doc("Optional Boolean CEL expression wrapped in @cel(...) controlling eligibility for new backend selections.")
  when?: string;

  /** Routing priority. Lower values are preferred; the effective default is zero. */
  @minValue(0)
  @maxValue(100)
  priority?: int32;

  /** Relative selection weight within a priority group. The effective default is one. */
  @minValue(1)
  @maxValue(100)
  weight?: int32;
}

/** A model target to update on an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasTargetUpdate is OptionalProperties<AiGatewayAliasTarget>;

/** Properties of a stable client-facing model alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasProperties {
  /** Client-facing routing name sent in the request model field. */
  aliasName?: string;

  /** Description of the alias. */
  @maxLength(1024)
  description?: string;

  /** Ordered target models used for routing. */
  @minItems(1)
  @maxItems(30)
  @identifiers(#["resourceId"])
  backendModels: AiGatewayAliasTarget[];

  /** Ordered routing stages. */
  selectionOrder?: AiGatewayAliasSelectionStage[];

  /** Stateless backend preference using an existing caller session key. */
  sessionBackendPreference?: AiGatewaySessionBackendPreference;

  /** Automatic model selection settings used with the autoModelSelection stage. */
  autoModelSelection?: AiGatewayModelSelection;

  /** Ordered failure rules; only the first matching rule is applied. */
  @identifiers(#[])
  failures?: AiGatewayAliasFailureRule[];

  /** Maximum additional backend attempts after the first request. */
  @minValue(0)
  maxRetryAttempts?: int32;

  /** Native endpoints common to every target model; translated endpoints are excluded. */
  @visibility(Lifecycle.Read)
  supportedEndpoints?: string[];

  /** Invocation endpoints, when endpoint metadata is enabled for this gateway. */
  @visibility(Lifecycle.Read)
  @identifiers(#["url"])
  gatewayEndpoints?: AiGatewayEndpoint[];

  /** Inline policies applied to requests routed through the alias. */
  @identifiers(#[])
  policies?: AiGatewayPolicy[];

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties to update on an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasUpdateProperties {
  /** Client-facing routing name sent in the request model field. */
  aliasName?: string;

  /** Description of the alias. */
  @maxLength(1024)
  description?: string;

  /** Ordered target models used for routing. */
  @minItems(1)
  @maxItems(30)
  @identifiers(#[])
  backendModels?: AiGatewayAliasTargetUpdate[];

  /** Ordered routing stages. */
  selectionOrder?: AiGatewayAliasSelectionStage[];

  /** Stateless backend preference using an existing caller session key. */
  sessionBackendPreference?: AiGatewaySessionBackendPreferenceUpdate;

  /** Automatic model selection settings used with the autoModelSelection stage. */
  autoModelSelection?: AiGatewayModelSelectionUpdate;

  /** Ordered failure rules; only the first matching rule is applied. */
  @identifiers(#[])
  failures?: AiGatewayAliasFailureRuleUpdate[];

  /** Maximum additional backend attempts after the first request. */
  @minValue(0)
  maxRetryAttempts?: int32;

  /** Inline policies applied to requests routed through the alias. */
  @identifiers(#[])
  policies?: AiGatewayPolicyUpdate[];
}

/** Parameters for updating an AI Gateway alias. */
@added(Versions.v2026_11_01)
model AiGatewayAliasUpdateParameters {
  /** Alias properties to update. */
  properties?: AiGatewayAliasUpdateProperties;
}

/** A stable client-facing model identity backed by an ordered pool of models. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayAliasResource is ProxyResource<AiGatewayAliasProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayAliasResource,
    KeyName = "aliasId",
    SegmentName = "aliases",
    NamePattern = "^[a-zA-Z0-9_.-]+$"
  >;
}
