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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name — EntityTagProperty uses 'eTag'"
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
  properties?: CostControlPatchProperties;
}

/**
 * Account-level connections used to publish cost control telemetry and events.
 */
@added(Versions.v2026_09_15_preview)
model CostControlConnections {
  /**
   * The full resource ID of the Application Insights connection used for cost control audit telemetry. This connection is optional for creation, attachment, accounting, and enforcement, and can be configured later or removed while policies remain attached. Customer audit delivery requires this connection.
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
   * The full resource ID of the Event Grid connection used for cost control alerts. This connection must be configured when a cost control attached to an account or deployment contains an alert threshold action and cannot be removed while such an action remains attached.
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
   * The single dimension used to partition consumption. Canonical requests and responses use an object. The service accepts legacy singleton arrays on input and when reading stored definitions, but serializes the dimension as an object. New rules support only built-in dimensions; Custom is retained for legacy reads.
   */
  counterKey: CostControlDimension;

  /**
   * The unit used for the cost control amount and absolute thresholds. The unit cannot change for a retained rule name; use a new rule name for a different unit.
   */
  unit: CostControlUnit;

  /**
   * The maximum consumption allowed by this rule, expressed in the selected unit. Token amounts must be positive whole counts no greater than 9223372036854775807. USD amounts may be fractional. Selected token types share this single amount.
   */
  @minValueExclusive(0)
  amount: float64;

  /**
   * The token measurements included in a Tokens budget. New rules accept input, output, or both, without duplicates; output includes reasoning. Omission selects overall tokens. This property must be omitted for other units and cannot change for a retained rule name. Readers preserve unknown future names, but new authored rules accept only the currently supported names.
   */
  @minItems(1)
  tokenTypes?: CostControlTokenType[];

  /**
   * The calendar-aligned UTC renewal period. New recurring rules require Day, Week, or Month; non-recurring rules must omit it. Stored legacy periods remain readable and are preserved by PATCH requests that omit rules.
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
   * The optional actions evaluated as consumption approaches the configured amount. Omitted, null, or empty thresholds track usage without explicit actions; no thresholds are synthesized. Supplied thresholds require an explicit Alert or Block action. Audit is retained only for legacy reads. Only an explicit Block threshold enforces a limit.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service accepts omitted, null, or empty thresholds to track usage without synthesizing actions."
  @maxItems(10)
  // @identifiers does not accept nullable array unions.
  @TypeSpec.OpenAPI.extension("x-ms-identifiers", #[])
  thresholds?: CostControlThreshold[] | null;
}

/**
 * Up to four trusted request attributes and their allowed values used to select matching requests. A canonical attribute and its legacy alias cannot be supplied together.
 */
@added(Versions.v2026_09_15_preview)
model CostControlMatch {
  /**
   * The full Foundry agent resource IDs to match, in the form /subscriptions/{subscription_guid}/accounts/{account-name}/project/{project-name}/agent/{agent_name}. These are not conventional Azure Resource Manager IDs. Short agent IDs and the old agentIds or dotted agent filter keys are not accepted.
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

  /**
   * The legacy alias of identityObjectIds, preserved for existing definitions and accepted for compatibility. Prefer the canonical property for new rules; do not supply both names.
   */
  @encodedName("application/json", "foundry.caller.identity.oid")
  @minItems(1)
  @maxItems(20)
  legacyIdentityObjectIds?: CostControlMatchValue[];

  /**
   * The legacy alias of sessionIds, preserved for existing definitions and accepted for compatibility. Prefer the canonical property for new rules; do not supply both names.
   */
  @encodedName("application/json", "foundry.caller.session.id")
  @minItems(1)
  @maxItems(20)
  legacySessionIds?: CostControlMatchValue[];

  /**
   * The legacy alias of projectIds, preserved for existing definitions and accepted for compatibility. Legacy values may use opaque project identifiers. Prefer the canonical property for new rules; do not supply both names.
   */
  @encodedName("application/json", "foundry.project.id")
  @minItems(1)
  @maxItems(20)
  legacyProjectIds?: CostControlMatchValue[];
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
   * The attribute retained in a stored legacy Custom dimension. This is read-only metadata; new Custom authoring is not supported and built-in dimensions must omit it. Readers preserve existing strings without applying new authoring constraints.
   */
  @visibility(Lifecycle.Read)
  attribute?: string;
}

/**
 * The supported cost control counter dimensions.
 */
@added(Versions.v2026_09_15_preview)
union CostControlDimensionType {
  string,

  /**
   * Consumption is partitioned by the Foundry agent resource ID.
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
   * A legacy read-only dimension using the stored attribute. New Custom authoring is reserved for future support. New or replacement rules must use a supported built-in dimension; PATCH requests that omit rules preserve existing Custom dimensions.
   */
  Custom: "Custom",
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
  Usd: "Usd",

  /**
   * Overall tokens or the selected token measurements, counted as a positive whole-number budget.
   */
  Tokens: "Tokens",
}

/**
 * Token measurement names used by the service. These wire names are canonical lowercase strings; known input names are normalized by the service while readers retain unknown future names.
 */
@added(Versions.v2026_09_15_preview)
union CostControlTokenType {
  string,

  /** Inclusive input tokens. */
  Input: "input",

  /** Inclusive output tokens, including reasoning. */
  Output: "output",
}

/**
 * The calendar-aligned UTC renewal periods for recurring cost control rules.
 */
@added(Versions.v2026_09_15_preview)
union CostControlPeriod {
  string,

  /** Legacy read-only period renewing at the start of the next UTC minute. Not accepted in new or replacement rules. */
  Minute: "Minute",

  /** Legacy read-only period renewing at the start of the next UTC hour. Not accepted in new or replacement rules. */
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

  /** Legacy read-only period renewing January 1 at 00:00 UTC. Not accepted in new or replacement rules. */
  Year: "Year",
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
   * The threshold value. New Alert and Block thresholds must be greater than zero. Percentage values cannot exceed 100, and absolute values cannot exceed the rule amount. Absolute Tokens thresholds must be whole counts representable by Int64. Stored legacy Audit values are preserved, rather than normalized to zero.
   */
  @minValue(0)
  value: float64;

  /**
   * The action taken when the threshold is reached. New thresholds must explicitly specify Alert or Block; there is no authoring default. Audit is retained for legacy reads, including stored definitions that omitted action and deserialize as Audit.
   */
  action: CostControlThresholdAction;
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
union CostControlThresholdAction {
  string,

  /**
   * Legacy read-only action retained for existing definitions. It cannot be authored in new or replacement thresholds. To track usage without an action, omit thresholds instead.
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
model CostControlListResult {
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
  value: CostControl[];
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
alias CostControlEtagHeader = {
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
   * Updates selected properties of a cost control. Omitting rules preserves existing rules, including legacy Custom dimensions, periods and Audit thresholds. Supplying rules replaces the entire array and applies current authoring restrictions; it does not merge individual rules or repair legacy values automatically.
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
  delete is ArmResourceDeleteSync<
    CostControl,
    Parameters = CostControlIfMatchHeader
  >;

  /**
   * Lists the cost controls owned by an account.
   */
  list is ArmResourceListByParent<
    CostControl,
    Response = CostControlListResult
  >;
}
