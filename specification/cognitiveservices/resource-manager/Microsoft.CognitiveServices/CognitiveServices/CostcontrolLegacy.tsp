/**
 * Legacy Cost Control models and operations for Cognitive Services accounts.
 * Available only in API version 2026-09-15-preview during service-gated private preview.
 * See CostControl.tsp for the models and operations introduced in 2026-11-15-preview.
 */
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/**
 * A cost control owned by a Cognitive Services account.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControl")
@parentResource(Account)
model CostControlLegacy
  is Azure.ResourceManager.ProxyResource<CostControlPropertiesLegacy> {
  ...ResourceNameParameter<
    Resource = CostControlLegacy,
    KeyName = "costControlName",
    SegmentName = "costControls",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,63}$"
  >;

  /**
   * The entity tag used for optimistic concurrency.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name — EntityTagProperty uses 'eTag'"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * The customer-authored settings of a cost control.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Cost controls are synchronously persisted proxy resources and the service contract does not expose provisioningState."
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlProperties")
model CostControlPropertiesLegacy {
  /**
   * An optional human-readable name for the cost control.
   */
  @maxLength(128)
  displayName?: string;

  /**
   * The rules enforced by the cost control.
   */
  @minItems(1)
  @maxItems(50)
  @identifiers(#["name"])
  rules: CostControlRule[];
}

/**
 * The properties that can be changed on a cost control.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlPatchProperties")
model CostControlPatchPropertiesLegacy {
  /**
   * An optional human-readable name for the cost control. Set this property to null to clear it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service distinguishes an omitted displayName from an explicit null in PATCH so callers can clear the value."
  @maxLength(128)
  displayName?: string | null;

  /**
   * The complete replacement set of cost control rules.
   */
  @minItems(1)
  @maxItems(50)
  @identifiers(#["name"])
  rules?: CostControlRule[];
}

/**
 * The request used to update a cost control.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlPatch")
model CostControlPatchLegacy {
  /**
   * The cost control properties to update.
   */
  properties?: CostControlPatchPropertiesLegacy;
}

/**
 * Defines account-level connections used to publish cost-control telemetry and events.
 * Application Insights is optional and may be removed while policies remain attached.
 * Event Grid is required for alerts; supplied connection references must still be valid.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlConnections")
model CostControlConnectionsLegacy {
  /**
   * Gets or sets the full resource ID of the optional Application Insights connection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service distinguishes an omitted appInsightsConnectionId from an explicit null in PATCH so callers can clear the value."
  appInsightsConnectionId?:
    | Azure.Core.armResourceIdentifier<[
        {
          type: "Microsoft.CognitiveServices/accounts/connections";
        }
      ]>
    | null;

  /**
   * The full resource ID of the Event Grid connection used for cost control alerts. This connection must be configured when an attached cost control contains an alert threshold action and cannot be removed while such an action remains attached.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service distinguishes an omitted eventGridConnectionId from an explicit null in PATCH so callers can clear the value."
  eventGridConnectionId?:
    | Azure.Core.armResourceIdentifier<[
        {
          type: "Microsoft.CognitiveServices/accounts/connections";
        }
      ]>
    | null;
}

/**
 * A cost limit and the population to which it applies.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
model CostControlRule {
  /**
   * The stable rule identifier, unique within the cost control without regard to case.
   */
  @key
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,63}$")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  /**
   * Gets or sets the single built-in dimension used to partition consumption.
   * Custom dimensions are retained only for legacy reads and metadata-only updates.
   * Legacy singleton arrays are accepted on read; serialization always emits an object.
   * To track another field, create another rule.
   */
  counterKey: CostControlDimension;

  /**
   * The unit used for the cost control amount and absolute thresholds.
   */
  unit: CostControlUnit;

  /**
   * The maximum consumption allowed by this rule, expressed in the selected unit.
   */
  @minValueExclusive(0)
  amount: float64;

  /**
   * Gets or sets the calendar-aligned UTC renewal period. Authored rules support Day, Week, or Month.
   * This field is required for recurring rules and must be omitted for non-recurring rules.
   * Legacy stored minute, hour, and year periods are preserved when reading definitions.
   */
  period?: CostControlPeriod;

  /**
   * Whether the cost control renews. The default is true.
   */
  recurring?: boolean = true;

  /**
   * Gets or sets optional match arrays keyed by `agentResourceIds`, `identityObjectIds`,
   * `sessionIds`, or `projectIds`. Each array contains 1 to 20 non-empty values.
   * Agent resource IDs use /subscriptions/{subscription_guid}/accounts/{account-name}/project/{project-name}/agent/{agent_name}.
   * Legacy dotted identity, session, and project keys remain accepted, but cannot be combined with their canonical key.
   */
  match?: CostControlMatch;

  /**
   * Gets or sets optional thresholds. Omitted or empty thresholds track usage without explicit actions.
   * Authored thresholds must explicitly specify Alert or Block; Audit is retained for legacy reads.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service accepts omitted, null, or empty thresholds to track usage without synthesizing actions."
  @maxItems(10)
  // @identifiers does not accept nullable array unions.
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  thresholds?: CostControlThreshold[] | null;
}

/**
 * Gets or sets optional match arrays keyed by `agentResourceIds`, `identityObjectIds`,
 * `sessionIds`, or `projectIds`. Each array contains 1 to 20 non-empty values.
 * Agent resource IDs use /subscriptions/{subscription_guid}/accounts/{account-name}/project/{project-name}/agent/{agent_name}.
 * Legacy dotted identity, session, and project keys remain accepted, but cannot be combined with their canonical key.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
model CostControlMatch {
  /**
   * Agent resource IDs use /subscriptions/{subscription_guid}/accounts/{account-name}/project/{project-name}/agent/{agent_name}.
   */
  @minItems(1)
  @maxItems(20)
  agentResourceIds?: CostControlMatchValue[];

  /**
   * The authenticated principal object IDs to match.
   */
  @minItems(1)
  @maxItems(20)
  identityObjectIds?: CostControlMatchValue[];

  /**
   * The Foundry session IDs to match.
   */
  @minItems(1)
  @maxItems(20)
  sessionIds?: CostControlMatchValue[];

  /**
   * The Foundry project resource IDs to match.
   */
  @minItems(1)
  @maxItems(20)
  projectIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/projects";
    }
  ]>[];
}

/**
 * A non-empty value used to match a trusted request attribute.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@minLength(1)
scalar CostControlMatchValue extends string;

/**
 * A request dimension used to partition cost control consumption.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
model CostControlDimension {
  /**
   * The kind of request dimension.
   */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: CostControlDimensionType;

  /**
   * Gets or sets the attribute path retained for legacy Custom counters.
   * Authored rules cannot select Custom; built-in dimensions must omit this property.
   */
  @visibility(Lifecycle.Read)
  attribute?: string;
}

/**
 * Cost control counter dimensions, including Custom retained for legacy read compatibility.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
union CostControlDimensionType {
  string,

  /**
   * Consumption is partitioned by the stable Foundry agent ID.
   */
  Agent: "Agent",

  /**
   * Consumption is partitioned by the authenticated principal object ID.
   */
  Identity: "Identity",

  /**
   * Consumption is partitioned by the Foundry session ID.
   */
  Session: "Session",

  /**
   * Consumption is partitioned by the Foundry project resource ID.
   */
  Project: "Project",

  /**
   * Consumption is partitioned by the owning Cognitive Services account.
   */
  Account: "Account",

  /**
   * Legacy read-only dimension using `CostControlDimension.Attribute`.
   * New Custom counter authoring is reserved for future support.
   */
  Custom: "Custom",
}

/**
 * The supported unit for cost control amounts and thresholds.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
union CostControlUnit {
  string,

  /**
   * Estimated cost in United States dollars.
   */
  Usd: "Usd",
}

/**
 * Calendar-aligned UTC renewal periods, including legacy values retained for read compatibility.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
union CostControlPeriod {
  string,

  /** Legacy read-only period renewing at the start of the next UTC minute. */
  Minute: "Minute",

  /** Legacy read-only period renewing at the start of the next UTC hour. */
  Hour: "Hour",

  /**
   * Renews daily at 00:00 UTC.
   */
  Day: "Day",

  /**
   * Renews Monday at 00:00 UTC.
   */
  Week: "Week",

  /**
   * Renews on the first day of each month at 00:00 UTC.
   */
  Month: "Month",

  /** Legacy read-only period renewing January 1 at 00:00 UTC. */
  Year: "Year",
}

/**
 * An action evaluated when cost control consumption reaches a threshold.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
model CostControlThreshold {
  /**
   * How the threshold value is interpreted.
   */
  type: CostControlThresholdTypeLegacy;

  /**
   * Gets or sets the threshold value. Legacy Audit definitions retain their stored values;
   * new thresholds support only Alert or Block.
   */
  @minValue(0)
  value: float64;

  /**
   * Gets or sets the threshold action. Authored thresholds must explicitly specify Alert or Block.
   * Legacy stored definitions with omitted actions continue to read as Audit.
   */
  action: CostControlThresholdAction;
}

/**
 * The supported threshold value interpretations.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlThresholdType")
union CostControlThresholdTypeLegacy {
  string,

  /**
   * The value is a percentage of the configured rule amount.
   */
  Percentage: "Percentage",

  /**
   * The value is expressed in the rule's unit.
   */
  Absolute: "Absolute",
}

/**
 * The supported actions when a threshold is reached.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
union CostControlThresholdAction {
  string,

  /**
   * Legacy read-only action retained to deserialize existing definitions without changing their semantics.
   */
  Audit: "Audit",

  /**
   * Emits a customer-facing alert without blocking requests.
   */
  Alert: "Alert",

  /**
   * Blocks the request without emitting a customer-facing alert.
   */
  Block: "Block",
}

/**
 * A page of cost controls.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlListResult")
model CostControlListResultLegacy {
  /**
   * The link used to get the next page of cost controls.
   */
  @nextLink
  nextLink?: url;

  /**
   * The cost controls in this page.
   */
  @pageItems
  @identifiers(#["name"])
  value: CostControlLegacy[];
}

/**
 * Conditional request headers accepted when creating or replacing a cost control.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlCreateOrUpdateHeaders")
model CostControlCreateOrUpdateHeadersLegacy {
  /**
   * Proceeds only when the current entity tag matches this value.
   */
  @header("If-Match")
  ifMatch?: string;

  /**
   * Proceeds only when the current entity tag does not match this value.
   */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/**
 * The conditional request header accepted when updating or deleting a cost control.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControlIfMatchHeader")
model CostControlIfMatchHeaderLegacy {
  /**
   * Proceeds only when the current entity tag matches this value.
   */
  @header("If-Match")
  ifMatch?: string;
}

/**
 * The entity tag returned with a cost control.
 */
alias CostControlEtagHeaderLegacy = {
  /**
   * The current entity tag for the cost control.
   */
  @header("ETag")
  etag: string;
};

/**
 * Operations for managing cost controls owned by an account.
 */
@added(Versions.v2026_09_15_preview)
@removed(Versions.v2026_11_01)
@renamedFrom(Versions.v2026_11_01, "CostControls")
@armResourceOperations
interface CostControlsLegacy {
  /**
   * Gets a cost control.
   */
  @sharedRoute
  get is ArmResourceRead<
    CostControlLegacy,
    Response = ArmResponse<CostControlLegacy> & CostControlEtagHeaderLegacy
  >;

  /**
   * Creates or replaces a cost control.
   */
  @sharedRoute
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CostControlLegacy,
    Parameters = CostControlCreateOrUpdateHeadersLegacy,
    Response =
      | (ArmResourceUpdatedResponse<CostControlLegacy> &
          CostControlEtagHeaderLegacy)
      | (ArmResourceCreatedSyncResponse<CostControlLegacy> &
          CostControlEtagHeaderLegacy)
  >;

  /**
   * Updates selected properties of a cost control.
   */
  @sharedRoute
  update is ArmCustomPatchSync<
    CostControlLegacy,
    CostControlPatchLegacy,
    Parameters = CostControlIfMatchHeaderLegacy,
    Response = ArmResponse<CostControlLegacy> & CostControlEtagHeaderLegacy
  >;

  /**
   * Deletes a cost control.
   */
  @sharedRoute
  delete is ArmResourceDeleteSync<
    CostControlLegacy,
    Parameters = CostControlIfMatchHeaderLegacy
  >;

  /**
   * Lists the cost controls owned by an account.
   */
  @sharedRoute
  list is ArmResourceListByParent<
    CostControlLegacy,
    Response = CostControlListResultLegacy
  >;
}
