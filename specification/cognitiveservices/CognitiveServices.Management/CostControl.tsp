import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
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
@parentResource(Account)
model CostControl
  is Azure.ResourceManager.ProxyResource<CostControlProperties> {
  ...ResourceNameParameter<
    Resource = CostControl,
    KeyName = "costControlName",
    SegmentName = "costControls",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,63}$"
  >;

  /**
   * The entity tag used for optimistic concurrency.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The service returns etag on the cost control resource envelope and uses it for conditional updates and deletes."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * The customer-authored settings of a cost control.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Cost controls are synchronously persisted proxy resources and the service contract does not expose provisioningState."
@added(Versions.v2026_09_15_preview)
model CostControlProperties {
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
model CostControlPatchProperties {
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
model CostControlPatch {
  /**
   * The cost control properties to update.
   */
  properties: CostControlPatchProperties;
}

/**
 * A cost limit and the population to which it applies.
 */
@added(Versions.v2026_09_15_preview)
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
   * The built-in dimension used to partition consumption. The initial preview supports exactly one dimension.
   */
  @minItems(1)
  @maxItems(1)
  @identifiers(#["type"])
  counterKey: CostControlDimension[];

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
   * The calendar-aligned UTC renewal period. This property is required for recurring rules and omitted for non-recurring rules.
   */
  period?: CostControlPeriod;

  /**
   * Whether the cost control renews. The default is true.
   */
  recurring?: boolean = true;

  /**
   * Trusted request attributes and allowed values used to select matching requests.
   */
  match?: CostControlMatch;

  /**
   * The actions evaluated as consumption approaches the configured amount.
   */
  @minItems(1)
  @maxItems(10)
  @identifiers(#[])
  thresholds: CostControlThreshold[];
}

/**
 * Up to four trusted request attributes and their allowed values used to select matching requests.
 */
@added(Versions.v2026_09_15_preview)
model CostControlMatch {
  /**
   * The stable Foundry agent IDs to match.
   */
  @encodedName("application/json", "foundry.caller.agent.id")
  @minItems(1)
  @maxItems(20)
  agentIds?: CostControlMatchValue[];

  /**
   * The authenticated principal object IDs to match.
   */
  @encodedName("application/json", "foundry.caller.identity.oid")
  @minItems(1)
  @maxItems(20)
  identityObjectIds?: CostControlMatchValue[];

  /**
   * The Foundry session IDs to match.
   */
  @encodedName("application/json", "foundry.caller.session.id")
  @minItems(1)
  @maxItems(20)
  sessionIds?: CostControlMatchValue[];

  /**
   * The Foundry project resource IDs to match.
   */
  @encodedName("application/json", "foundry.project.id")
  @minItems(1)
  @maxItems(20)
  projectIds?: CostControlMatchValue[];
}

/**
 * A non-empty value used to match a trusted request attribute.
 */
@added(Versions.v2026_09_15_preview)
@minLength(1)
scalar CostControlMatchValue extends string;

/**
 * A request dimension used to partition cost control consumption.
 */
@added(Versions.v2026_09_15_preview)
model CostControlDimension {
  /**
   * The kind of request dimension.
   */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: CostControlDimensionType;

  /**
   * The request attribute used by a custom dimension. This property is required for custom dimensions and must be omitted for built-in dimensions.
   */
  @maxLength(128)
  attribute?: string;
}

/**
 * The supported cost control counter dimensions.
 */
@added(Versions.v2026_09_15_preview)
union CostControlDimensionType {
  string,

  /**
   * Consumption is partitioned by the stable Foundry agent ID.
   */
  Agent: "agent",

  /**
   * Consumption is partitioned by the authenticated principal object ID.
   */
  Identity: "identity",

  /**
   * Consumption is partitioned by the Foundry session ID.
   */
  Session: "session",

  /**
   * Consumption is partitioned by the Foundry project resource ID.
   */
  Project: "project",

  /**
   * Consumption is partitioned by the owning Cognitive Services account.
   */
  Account: "account",

  /**
   * Consumption is partitioned by a custom request attribute.
   */
  Custom: "custom",
}

/**
 * The supported unit for cost control amounts and thresholds.
 */
@added(Versions.v2026_09_15_preview)
union CostControlUnit {
  string,

  /**
   * Estimated cost in United States dollars.
   */
  Usd: "usd",
}

/**
 * The calendar-aligned UTC renewal periods for recurring cost control rules.
 */
@added(Versions.v2026_09_15_preview)
union CostControlPeriod {
  string,

  /**
   * Renews at the start of the next UTC minute.
   */
  Minute: "minute",

  /**
   * Renews at the start of the next UTC hour.
   */
  Hour: "hour",

  /**
   * Renews daily at 00:00 UTC.
   */
  Day: "day",

  /**
   * Renews Monday at 00:00 UTC.
   */
  Week: "week",

  /**
   * Renews on the first day of each month at 00:00 UTC.
   */
  Month: "month",

  /**
   * Renews January 1 at 00:00 UTC.
   */
  Year: "year",
}

/**
 * An action evaluated when cost control consumption reaches a threshold.
 */
@added(Versions.v2026_09_15_preview)
model CostControlThreshold {
  /**
   * How the threshold value is interpreted.
   */
  type: CostControlThresholdType;

  /**
   * The threshold value. Percentage values range from 0 through 100, and absolute values cannot exceed the rule amount.
   */
  @minValue(0)
  value: float64;

  /**
   * The action taken when the threshold is reached. The default is audit.
   */
  action?: CostControlThresholdAction = CostControlThresholdAction.Audit;
}

/**
 * The supported threshold value interpretations.
 */
@added(Versions.v2026_09_15_preview)
union CostControlThresholdType {
  string,

  /**
   * The value is a percentage of the configured rule amount.
   */
  Percentage: "percentage",

  /**
   * The value is expressed in the rule's unit.
   */
  Absolute: "absolute",
}

/**
 * The supported actions when a threshold is reached.
 */
@added(Versions.v2026_09_15_preview)
union CostControlThresholdAction {
  string,

  /**
   * Records the threshold crossing without notifying the customer or blocking requests.
   */
  Audit: "audit",

  /**
   * Emits a customer-facing alert without blocking requests.
   */
  Alert: "alert",
}

/**
 * A page of cost controls.
 */
@added(Versions.v2026_09_15_preview)
model CostControlListResult {
  /**
   * The link used to get the next page of cost controls.
   */
  @nextLink
  nextLink?: string;

  /**
   * The cost controls in this page.
   */
  @pageItems
  @identifiers(#["name"])
  value?: CostControl[];
}

/**
 * Conditional request headers accepted when creating or replacing a cost control.
 */
@added(Versions.v2026_09_15_preview)
model CostControlCreateOrUpdateHeaders {
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
model CostControlIfMatchHeader {
  /**
   * Proceeds only when the current entity tag matches this value.
   */
  @header("If-Match")
  ifMatch?: string;
}

/**
 * The entity tag returned with a cost control.
 */
@added(Versions.v2026_09_15_preview)
model CostControlEtagHeader {
  /**
   * The current entity tag for the cost control.
   */
  @header("ETag")
  eTag: string;
}

/**
 * Operations for managing cost controls owned by an account.
 */
@added(Versions.v2026_09_15_preview)
@armResourceOperations
interface CostControls {
  /**
   * Gets a cost control.
   */
  get is ArmResourceRead<
    CostControl,
    Response = ArmResponse<CostControl> & CostControlEtagHeader
  >;

  /**
   * Creates or replaces a cost control.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CostControl,
    Parameters = CostControlCreateOrUpdateHeaders,
    Response =
      | (ArmResourceUpdatedResponse<CostControl> & CostControlEtagHeader)
      | (ArmResourceCreatedSyncResponse<CostControl> & CostControlEtagHeader)
  >;

  /**
   * Updates selected properties of a cost control.
   */
  update is ArmCustomPatchSync<
    CostControl,
    CostControlPatch,
    Parameters = CostControlIfMatchHeader,
    Response = ArmResponse<CostControl> & CostControlEtagHeader
  >;

  /**
   * Deletes a cost control.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The synchronous service endpoint returns 200 on successful deletion and does not return 204."
  delete is ArmResourceDeleteSync<
    CostControl,
    Parameters = CostControlIfMatchHeader,
    Response = ArmDeletedResponse
  >;

  /**
   * Lists the cost controls owned by an account.
   */
  list is ArmResourceListByParent<
    CostControl,
    Response = CostControlListResult
  >;
}
