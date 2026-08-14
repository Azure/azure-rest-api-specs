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
 * A budget policy owned by a Cognitive Services account.
 */
@added(Versions.v2026_08_31_preview)
@parentResource(Account)
model BudgetPolicy
  is Azure.ResourceManager.ProxyResource<BudgetPolicyProperties> {
  ...ResourceNameParameter<
    Resource = BudgetPolicy,
    KeyName = "budgetPolicyName",
    SegmentName = "budgetPolicies",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,63}$"
  >;

  /**
   * The entity tag used for optimistic concurrency.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The service returns etag on the budget policy resource envelope and uses it for conditional updates and deletes."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * The customer-authored settings of a budget policy.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Budget policies are synchronously persisted proxy resources and the service contract does not expose provisioningState."
@added(Versions.v2026_08_31_preview)
model BudgetPolicyProperties {
  /**
   * An optional human-readable name for the policy.
   */
  @maxLength(128)
  displayName?: string;

  /**
   * The budget rules enforced by the policy.
   */
  @minItems(1)
  @maxItems(50)
  @identifiers(#["name"])
  rules: BudgetRule[];
}

/**
 * The properties that can be changed on a budget policy.
 */
@added(Versions.v2026_08_31_preview)
model BudgetPolicyPatchProperties {
  /**
   * An optional human-readable name for the policy. Set this property to null to clear it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service distinguishes an omitted displayName from an explicit null in PATCH so callers can clear the value."
  @maxLength(128)
  displayName?: string | null;

  /**
   * The complete replacement set of budget rules.
   */
  @minItems(1)
  @maxItems(50)
  @identifiers(#["name"])
  rules?: BudgetRule[];
}

/**
 * The request used to update a budget policy.
 */
@added(Versions.v2026_08_31_preview)
model BudgetPolicyPatch {
  /**
   * The budget policy properties to update.
   */
  properties: BudgetPolicyPatchProperties;
}

/**
 * A budget limit and the population to which it applies.
 */
@added(Versions.v2026_08_31_preview)
model BudgetRule {
  /**
   * The stable rule identifier, unique within the policy without regard to case.
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
  counterKey: BudgetDimension[];

  /**
   * The unit used for the budget amount and absolute thresholds.
   */
  unit: BudgetUnit;

  /**
   * The maximum consumption allowed by this rule, expressed in the selected unit.
   */
  @minValueExclusive(0)
  amount: float64;

  /**
   * The calendar-aligned UTC renewal period. This property is required for recurring rules and omitted for non-recurring rules.
   */
  period?: BudgetPeriod;

  /**
   * Whether the budget renews. The default is true.
   */
  recurring?: boolean = true;

  /**
   * Trusted request attributes and allowed values used to select matching requests.
   */
  match?: BudgetMatch;

  /**
   * The actions evaluated as consumption approaches the configured amount.
   */
  @minItems(1)
  @maxItems(10)
  @identifiers(#[])
  thresholds: BudgetThreshold[];
}

/**
 * Trusted request attributes and allowed values used to select matching requests.
 */
@added(Versions.v2026_08_31_preview)
model BudgetMatch {
  /**
   * The stable Foundry agent IDs to match.
   */
  @encodedName("application/json", "foundry.caller.agent.id")
  @minItems(1)
  @maxItems(20)
  agentIds?: BudgetMatchValue[];

  /**
   * The authenticated principal object IDs to match.
   */
  @encodedName("application/json", "foundry.caller.identity.oid")
  @minItems(1)
  @maxItems(20)
  identityObjectIds?: BudgetMatchValue[];

  /**
   * The Foundry session IDs to match.
   */
  @encodedName("application/json", "foundry.caller.session.id")
  @minItems(1)
  @maxItems(20)
  sessionIds?: BudgetMatchValue[];

  /**
   * The Foundry project resource IDs to match.
   */
  @encodedName("application/json", "foundry.caller.project.id")
  @minItems(1)
  @maxItems(20)
  projectIds?: BudgetMatchValue[];
}

/**
 * A non-empty value used to match a trusted request attribute.
 */
@added(Versions.v2026_08_31_preview)
@minLength(1)
scalar BudgetMatchValue extends string;

/**
 * A built-in request dimension used to partition budget consumption.
 */
@added(Versions.v2026_08_31_preview)
model BudgetDimension {
  /**
   * The kind of request dimension.
   */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  type: BudgetDimensionType;
}

/**
 * The supported budget counter dimensions.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service rejects unknown counter dimensions, so the public contract is intentionally closed."
@added(Versions.v2026_08_31_preview)
union BudgetDimensionType {
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
}

/**
 * The supported unit for budget amounts and thresholds.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service rejects unknown budget units, so the public contract is intentionally closed."
@added(Versions.v2026_08_31_preview)
union BudgetUnit {
  /**
   * Estimated cost in United States dollars.
   */
  Usd: "usd",
}

/**
 * The calendar-aligned UTC renewal periods for recurring budget rules.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service rejects unknown renewal periods, so the public contract is intentionally closed."
@added(Versions.v2026_08_31_preview)
union BudgetPeriod {
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
 * An action evaluated when budget consumption reaches a threshold.
 */
@added(Versions.v2026_08_31_preview)
model BudgetThreshold {
  /**
   * How the threshold value is interpreted.
   */
  type: BudgetThresholdType;

  /**
   * The threshold value. Percentage values range from 0 through 100, and absolute values cannot exceed the rule amount.
   */
  @minValue(0)
  value: float64;

  /**
   * The action taken when the threshold is reached. The default is audit.
   */
  action?: BudgetThresholdAction = BudgetThresholdAction.Audit;
}

/**
 * The supported threshold value interpretations.
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service rejects unknown threshold types, so the public contract is intentionally closed."
@added(Versions.v2026_08_31_preview)
union BudgetThresholdType {
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
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "The service rejects unknown threshold actions, so the public contract is intentionally closed."
@added(Versions.v2026_08_31_preview)
union BudgetThresholdAction {
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
 * A page of budget policies.
 */
@added(Versions.v2026_08_31_preview)
model BudgetPolicyListResult {
  /**
   * The link used to get the next page of budget policies.
   */
  @nextLink
  nextLink?: string;

  /**
   * The budget policies in this page.
   */
  @pageItems
  @identifiers(#["name"])
  value?: BudgetPolicy[];
}

/**
 * Conditional request headers accepted when creating or replacing a budget policy.
 */
@added(Versions.v2026_08_31_preview)
model BudgetPolicyCreateOrUpdateHeaders {
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
 * The conditional request header accepted when updating or deleting a budget policy.
 */
@added(Versions.v2026_08_31_preview)
model BudgetPolicyIfMatchHeader {
  /**
   * Proceeds only when the current entity tag matches this value.
   */
  @header("If-Match")
  ifMatch?: string;
}

/**
 * The entity tag returned with a budget policy.
 */
@added(Versions.v2026_08_31_preview)
model BudgetPolicyEtagHeader {
  /**
   * The current entity tag for the budget policy.
   */
  @header("ETag")
  eTag: string;
}

/**
 * Operations for managing budget policies owned by an account.
 */
@added(Versions.v2026_08_31_preview)
@armResourceOperations
interface BudgetPolicies {
  /**
   * Gets a budget policy.
   */
  get is ArmResourceRead<
    BudgetPolicy,
    Response = ArmResponse<BudgetPolicy> & BudgetPolicyEtagHeader
  >;

  /**
   * Creates or replaces a budget policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BudgetPolicy,
    Parameters = BudgetPolicyCreateOrUpdateHeaders,
    Response =
      | (ArmResourceUpdatedResponse<BudgetPolicy> & BudgetPolicyEtagHeader)
      | (ArmResourceCreatedSyncResponse<BudgetPolicy> & BudgetPolicyEtagHeader)
  >;

  /**
   * Updates selected properties of a budget policy.
   */
  update is ArmCustomPatchSync<
    BudgetPolicy,
    BudgetPolicyPatch,
    Parameters = BudgetPolicyIfMatchHeader,
    Response = ArmResponse<BudgetPolicy> & BudgetPolicyEtagHeader
  >;

  /**
   * Deletes a budget policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The synchronous service endpoint returns 200 on successful deletion and does not return 204."
  delete is ArmResourceDeleteSync<
    BudgetPolicy,
    Parameters = BudgetPolicyIfMatchHeader,
    Response = ArmDeletedResponse
  >;

  /**
   * Lists the budget policies owned by an account.
   */
  list is ArmResourceListByParent<
    BudgetPolicy,
    Response = BudgetPolicyListResult
  >;
}
