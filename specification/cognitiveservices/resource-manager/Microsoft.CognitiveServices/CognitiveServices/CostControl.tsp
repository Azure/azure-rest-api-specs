import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Account.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

/** A budget that measures consumption and optionally alerts or blocks requests within an account. */
@added(Versions.v2026_11_15_preview)
@parentResource(Account)
model CostControl is ProxyResource<CostControlProperties> {
  ...ResourceNameParameter<
    Resource = CostControl,
    KeyName = "costControlName",
    SegmentName = "costControls",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,63}$"
  >;

  /** The opaque entity tag used for optimistic concurrency. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The service returns the lowercase 'etag' envelope property rather than 'eTag'."
  @visibility(Lifecycle.Read)
  etag?: string;
}

/** A budget that measures consumption and optionally alerts or blocks requests within its owning project. */
@added(Versions.v2026_11_15_preview)
@parentResource(Project)
model ProjectCostControl is ProxyResource<CostControlProperties> {
  ...ResourceNameParameter<
    Resource = ProjectCostControl,
    KeyName = "costControlName",
    SegmentName = "costControls",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,63}$"
  >;

  /** The opaque entity tag used for optimistic concurrency. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "CogSvc uses lowercase 'etag' field name — EntityTagProperty uses 'eTag'"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * The consumption budget and its traffic selection, notifications, and enforcement actions.
 * A newly created control applies within its owner's scope without attaching resource IDs.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Cost controls are synchronously persisted proxy resources; the service does not expose provisioningState."
@added(Versions.v2026_11_15_preview)
model CostControlProperties {
  /** The resource provider for this budget. Omission selects Microsoft.CognitiveServices; responses return that value. */
  provider?: "Microsoft.CognitiveServices";

  /**
   * Optional additional partitioning of consumption. Omission or an empty array uses one counter for the owning account or project.
   * Responses omit owner-default grouping. A project-owned control cannot explicitly group by projectId.
   */
  @maxItems(1)
  @identifiers(#["name"])
  grouping?: CostControlGrouping[];

  /** Whether the budget measures estimated cost in United States dollars or token consumption. This category cannot be changed after creation. */
  category: CostControlCategory;

  /**
   * The positive budget amount, in United States dollars for Cost or tokens for Tokens.
   * Token amounts must be whole numbers no greater than 9223372036854775807.
   */
  @minValueExclusive(0)
  amount: decimal128;

  /** The calendar-aligned UTC interval at which consumption counters renew within the validity window. */
  timeGrain: CostControlTimeGrain;

  /** The finite UTC validity window during which the control applies. */
  timePeriod: CostControlTimePeriod;

  /** Optional traffic selection. Omission selects all eligible traffic within the owner's scope. */
  filter?: CostControlFilter;

  /**
   * Alert notifications keyed by nonempty, case-insensitively unique names. Each notification supplies its own Event Grid connection.
   * Notifications and provider actions together are limited to ten entries. Omission creates no notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Notification names are customer-defined dictionary keys; each value has an explicit notification schema."
  notifications?: Record<CostControlNotification>;

  /** Optional provider-specific enforcement settings. Omission creates no blocking actions. */
  providerProperties?: CostControlProviderProperties;
}

/** Optional edits to a budget. Omitted properties retain their existing values; no defaults are applied. */
@added(Versions.v2026_11_15_preview)
model CostControlPatchProperties {
  /** The resource provider. If supplied, it must be Microsoft.CognitiveServices and cannot be null. */
  provider?: "Microsoft.CognitiveServices";

  /** Replaces additional grouping. Omission preserves grouping; an empty array restores the owner's default counter. Null is not accepted. */
  @maxItems(1)
  @identifiers(#["name"])
  grouping?: CostControlGrouping[];

  /** The existing measurement category. Changing it after creation is not supported. */
  category?: CostControlCategory;

  /** Replaces the positive budget amount in United States dollars or whole tokens, according to category. Token amounts cannot exceed 9223372036854775807. */
  @minValueExclusive(0)
  amount?: decimal128;

  /** Replaces the calendar-aligned UTC renewal interval. */
  timeGrain?: CostControlTimeGrain;

  /** Merges supplied dates into the existing validity window; omitted dates remain unchanged. */
  timePeriod?: CostControlTimePeriodPatch;

  /** Replaces the complete traffic filter. Set to null to select all eligible traffic within the owner's scope. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "PATCH uses explicit null to remove the traffic filter; omission preserves it."
  filter?: CostControlFilter | null;

  /**
   * Merges notifications by case-insensitive name, preserving existing name casing. Null entries delete notifications; null clears the collection.
   * An empty object leaves existing notifications unchanged. New entries must supply all required notification fields after merging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "PATCH uses null dictionary entries to delete named notifications and null on the collection to clear it."
  notifications?: Record<CostControlNotificationPatch | null> | null;

  /** Merges provider-specific settings. Set to null to remove all blocking actions; omission preserves them. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "PATCH uses explicit null to remove provider-specific actions; omission preserves them."
  providerProperties?: CostControlProviderPropertiesPatch | null;
}

/** A partial budget update. An empty properties object is a no-op and retains the entity tag. */
@added(Versions.v2026_11_15_preview)
model CostControlPatch {
  /** The budget properties to merge into the existing control. */
  properties?: CostControlPatchProperties;
}

/** An additional built-in request attribute used to partition a budget into independent counters. */
@added(Versions.v2026_11_15_preview)
model CostControlGrouping {
  /** The built-in attribute to group by. projectId is available only for account-owned controls. */
  @key
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: CostControlGroupingName;

  /** The grouping kind. Only TagKey is supported. */
  type: "TagKey";
}

/** Built-in attributes supported for additional budget partitioning. */
@added(Versions.v2026_11_15_preview)
union CostControlGroupingName {
  string,

  /** Creates an independent counter for each project in the owning account. */
  ProjectId: "projectId",

  /** Creates an independent counter for each Foundry agent resource ID. */
  AgentResourceId: "agentResourceId",

  /** Creates an independent counter for each authenticated principal object ID. */
  IdentityObjectId: "identityObjectId",

  /** Creates an independent counter for each Foundry session ID. */
  SessionId: "sessionId",
}

/** The measurement used for the budget amount and absolute thresholds. */
@added(Versions.v2026_11_15_preview)
union CostControlCategory {
  string,

  /** Estimated consumption cost in United States dollars. */
  Cost: "Cost",

  /** The number of consumed tokens, optionally selected by a tokenType filter. */
  Tokens: "Tokens",
}

/** Calendar-aligned UTC renewal intervals. */
@added(Versions.v2026_11_15_preview)
union CostControlTimeGrain {
  string,

  /** Renews each day at 00:00 UTC. */
  Daily: "Daily",

  /** Renews each Monday at 00:00 UTC. */
  Weekly: "Weekly",

  /** Renews on the first day of each month at 00:00 UTC. */
  Monthly: "Monthly",
}

/** A finite validity interval, including its start and excluding its end. */
@added(Versions.v2026_11_15_preview)
model CostControlTimePeriod {
  /** The inclusive UTC start, encoded as an ISO 8601 timestamp ending in Z with up to seven fractional digits. */
  startDate: utcDateTime;

  /** The exclusive UTC end, later than startDate, encoded as an ISO 8601 timestamp ending in Z with up to seven fractional digits. */
  endDate: utcDateTime;
}

/** Partial edits to a validity interval. Supplied dates cannot be null, and the merged start must precede the merged end. */
@added(Versions.v2026_11_15_preview)
model CostControlTimePeriodPatch is OptionalProperties<CostControlTimePeriod>;

/**
 * Traffic selection using exactly one of tags or and. Tag names must be unique across the complete expression.
 * Filters narrow the owner's scope and cannot extend a project-owned control to another project.
 */
@added(Versions.v2026_11_15_preview)
model CostControlFilter {
  /** A single tag condition. Must not be combined with and on the same filter object. */
  tags?: CostControlTagFilter;

  /** A conjunction of at least two conditions. Must not be combined with tags on the same filter object. */
  @minItems(2)
  @identifiers(#[])
  and?: CostControlFilter[];
}

/** Selects traffic whose named attribute equals at least one of the supplied values. */
@added(Versions.v2026_11_15_preview)
model CostControlTagFilter {
  /**
   * The built-in attribute: agentResourceId, identityObjectId, sessionId, projectId, deploymentId, or tokenType.
   * Agent resource IDs use /subscriptions/{subscriptionId}/accounts/{accountName}/project/{projectName}/agent/{agentName}.
   * projectId values are project resource IDs. deploymentId values must be deployment resource IDs in the owning account.
   * tokenType accepts input, output, or both for a Tokens budget; omission measures overall tokens.
   */
  name: CostControlFilterName;

  /** The comparison operator. Only In is supported. */
  operator: "In";

  /** Between one and twenty nonempty, non-whitespace strings to match. */
  @minItems(1)
  @maxItems(20)
  values: CostControlFilterValue[];
}

/** Built-in request attributes supported for traffic filtering. */
@added(Versions.v2026_11_15_preview)
union CostControlFilterName {
  string,

  /** The Foundry agent resource ID. */
  AgentResourceId: "agentResourceId",

  /** The authenticated principal object ID. */
  IdentityObjectId: "identityObjectId",

  /** The Foundry session ID. */
  SessionId: "sessionId",

  /** The project resource ID. */
  ProjectId: "projectId",

  /** The deployment resource ID within the owning account. */
  DeploymentId: "deploymentId",

  /** The input or output token category. */
  TokenType: "tokenType",
}

/** A nonempty string identifying an allowed value of a request attribute. */
@added(Versions.v2026_11_15_preview)
@minLength(1)
scalar CostControlFilterValue extends string;

/** An alert notification with an explicit threshold, enabled state, and Event Grid destination. */
@added(Versions.v2026_11_15_preview)
model CostControlNotification {
  /** The full resource ID of the Cognitive Services Event Grid connection used to publish this notification. */
  eventGridConnectionId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.CognitiveServices/accounts/connections";
    }
  ]>;

  /** Whether threshold is a percentage of amount or an absolute value in the budget's unit. */
  thresholdType: CostControlThresholdType;

  /** The positive threshold. Percentages cannot exceed 100; absolute thresholds cannot exceed amount and must be whole numbers for Tokens budgets. */
  @minValueExclusive(0)
  threshold: decimal128;

  /** Whether this notification is enabled. Disabled notifications remain configured but do not publish alerts. */
  enabled: boolean;

  /** The threshold comparison. Only GreaterThanOrEqualTo is supported. */
  operator: "GreaterThanOrEqualTo";
}

/** Edits to an existing named notification. New notifications require all fields after merging; supplied fields cannot be null. */
@added(Versions.v2026_11_15_preview)
model CostControlNotificationPatch
  is OptionalProperties<CostControlNotification>;

/** The interpretation of a notification or blocking-action threshold. */
@added(Versions.v2026_11_15_preview)
union CostControlThresholdType {
  string,

  /** The threshold is a percentage of the configured budget amount. */
  Percentage: "Percentage",

  /** The threshold is expressed in United States dollars or tokens, according to the budget category. */
  Absolute: "Absolute",
}

/** Provider-specific budget enforcement settings. */
@added(Versions.v2026_11_15_preview)
model CostControlProviderProperties {
  /** Blocking actions keyed by nonempty, case-insensitively unique names. Actions and notifications together are limited to ten entries. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Action names are customer-defined dictionary keys; each value has an explicit blocking-action schema."
  actions?: Record<CostControlAction>;
}

/** Partial provider-specific edits. Named actions merge rather than replacing the complete collection. */
@added(Versions.v2026_11_15_preview)
model CostControlProviderPropertiesPatch {
  /**
   * Merges actions by case-insensitive name, preserving existing name casing. Null entries delete actions; null clears the collection.
   * An empty object leaves actions unchanged. New entries must supply all required action fields after merging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "PATCH uses null dictionary entries to delete named actions and null on the collection to clear it."
  actions?: Record<CostControlActionPatch | null> | null;
}

/** Blocks requests when consumption reaches the explicitly configured threshold. No implicit blocking action is created. */
@added(Versions.v2026_11_15_preview)
model CostControlAction {
  /** The enforcement action. Only block is supported. */
  type: "block";

  /** Whether threshold is a percentage of amount or an absolute value in the budget's unit. */
  thresholdType: CostControlThresholdType;

  /** The positive threshold. Percentages cannot exceed 100; absolute thresholds cannot exceed amount and must be whole numbers for Tokens budgets. */
  @minValueExclusive(0)
  threshold: decimal128;

  /** The threshold comparison. Only GreaterThanOrEqualTo is supported. */
  operator: "GreaterThanOrEqualTo";
}

/** Edits to an existing named blocking action. New actions require all fields after merging; supplied fields cannot be null. */
@added(Versions.v2026_11_15_preview)
model CostControlActionPatch is OptionalProperties<CostControlAction>;

/**
 * Account-level telemetry connections. Application Insights is optional and may be removed while controls exist.
 * Budget notifications specify their own Event Grid destinations; the account Event Grid connection remains a fallback for existing legacy alerts.
 */
@added(Versions.v2026_11_15_preview)
model CostControlConnections {
  /** The full resource ID of the optional Application Insights connection. Set to null in an account update to remove it. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Account PATCH uses explicit null to remove the Application Insights connection; omission preserves it."
  appInsightsConnectionId?:
    | Azure.Core.armResourceIdentifier<[
        {
          type: "Microsoft.CognitiveServices/accounts/connections";
        }
      ]>
    | null;

  /** The full resource ID of the fallback Event Grid connection for legacy alerts. It cannot be removed while legacy alerts depend on it. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Account PATCH uses explicit null to remove the fallback Event Grid connection when no legacy alert depends on it."
  eventGridConnectionId?:
    | Azure.Core.armResourceIdentifier<[
        {
          type: "Microsoft.CognitiveServices/accounts/connections";
        }
      ]>
    | null;
}

/** A page of cost controls owned by an account. */
@added(Versions.v2026_11_15_preview)
model CostControlListResult {
  /** The link used to retrieve the next page, when present. */
  @nextLink
  nextLink?: url;

  /** The cost controls in this page. */
  @pageItems
  @identifiers(#["name"])
  value: CostControl[];
}

/** A page of cost controls owned by a project. */
@added(Versions.v2026_11_15_preview)
model ProjectCostControlListResult {
  /** The link used to retrieve the next page, when present. */
  @nextLink
  nextLink?: url;

  /** The cost controls in this page. */
  @pageItems
  @identifiers(#["name"])
  value: ProjectCostControl[];
}

/** Conditional headers accepted when creating or replacing a cost control. */
@added(Versions.v2026_11_15_preview)
model CostControlCreateOrUpdateHeaders {
  /** Proceeds only if the current entity tag matches this value. */
  @header("If-Match")
  ifMatch?: string;

  /** Proceeds only if the current entity tag does not match this value. Use * to create only if absent. */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/** A conditional header accepted when updating or deleting a cost control. */
@added(Versions.v2026_11_15_preview)
model CostControlIfMatchHeader {
  /** Proceeds only if the current entity tag matches this value. */
  @header("If-Match")
  ifMatch?: string;
}

/** A conditional header accepted when reading a cost control. */
@added(Versions.v2026_11_15_preview)
model CostControlReadHeaders {
  /** Returns 304 without a body when this entity tag matches the selected representation. */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/** The entity tag returned with a cost control. */
alias CostControlEtagHeader = {
  /** The current opaque entity tag for this representation. */
  @header("ETag")
  etag: string;
};

/** A conditional read whose selected representation has not changed. */
alias CostControlNotModifiedResponse = {
  /** The HTTP status code indicating that the representation has not changed. */
  @statusCode
  statusCode: 304;

  ...CostControlEtagHeader;
};

/** A successful existence check without a response body. */
alias CostControlHeadResponse = {
  /** The HTTP status code indicating that the control exists. */
  @statusCode
  statusCode: 200;

  ...CostControlEtagHeader;
};

/**
 * Operations for account-owned cost controls. This API version accepts and returns only the budget contract.
 * A legacy definition that cannot be represented losslessly returns a compatibility conflict rather than a partial or mixed representation.
 */
@added(Versions.v2026_11_15_preview)
@armResourceOperations
interface CostControls {
  /** Gets an account-owned cost control, or returns 304 when the supplied entity tag matches. */
  get is ArmResourceRead<
    CostControl,
    Parameters = CostControlReadHeaders,
    Response =
      | (ArmResponse<CostControl> & CostControlEtagHeader)
      | CostControlNotModifiedResponse
  >;

  /** Checks whether an account-owned cost control exists without returning its body. */
  checkExistence is ArmResourceCheckExistence<
    CostControl,
    Parameters = CostControlReadHeaders,
    Response = CostControlHeadResponse | CostControlNotModifiedResponse
  >;

  /** Creates or replaces an account-owned budget synchronously. An omitted grouping selects the account's default counter. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CostControl,
    Parameters = CostControlCreateOrUpdateHeaders,
    Response =
      | (ArmResourceUpdatedResponse<CostControl> & CostControlEtagHeader)
      | (ArmResourceCreatedSyncResponse<CostControl> & CostControlEtagHeader)
  >;

  /** Updates selected budget properties synchronously. Omitted properties are preserved; an unchanged budget retains its entity tag. */
  update is ArmCustomPatchSync<
    CostControl,
    CostControlPatch,
    Parameters = CostControlIfMatchHeader,
    Response = ArmResponse<CostControl> & CostControlEtagHeader
  >;

  /** Deletes an account-owned cost control synchronously. An existing legacy attachment must be removed before its control can be deleted. */
  delete is ArmResourceDeleteSync<
    CostControl,
    Parameters = CostControlIfMatchHeader
  >;

  /** Lists account-owned cost controls using the budget representation. An unrepresentable legacy entry causes the complete list request to fail. */
  list is ArmResourceListByParent<
    CostControl,
    Response = ArmResponse<CostControlListResult>
  >;
}

/**
 * Operations for project-owned cost controls. Budgets remain confined to their owning project.
 * This API version accepts and returns only the budget contract, without attachment-ID properties.
 */
@added(Versions.v2026_11_15_preview)
@armResourceOperations
interface ProjectCostControls {
  /** Gets a project-owned cost control, or returns 304 when the supplied entity tag matches. */
  get is ArmResourceRead<
    ProjectCostControl,
    Parameters = CostControlReadHeaders,
    Response =
      | (ArmResponse<ProjectCostControl> & CostControlEtagHeader)
      | CostControlNotModifiedResponse
  >;

  /** Checks whether a project-owned cost control exists without returning its body. */
  checkExistence is ArmResourceCheckExistence<
    ProjectCostControl,
    Parameters = CostControlReadHeaders,
    Response = CostControlHeadResponse | CostControlNotModifiedResponse
  >;

  /** Creates or replaces a project-owned budget synchronously. Omitted grouping selects the project's default counter; explicit projectId grouping is rejected. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ProjectCostControl,
    Parameters = CostControlCreateOrUpdateHeaders,
    Response =
      | (ArmResourceUpdatedResponse<ProjectCostControl> & CostControlEtagHeader)
      | (ArmResourceCreatedSyncResponse<ProjectCostControl> &
          CostControlEtagHeader)
  >;

  /** Updates selected project budget properties synchronously, merging named notifications, actions, and supplied validity dates. */
  update is ArmCustomPatchSync<
    ProjectCostControl,
    CostControlPatch,
    Parameters = CostControlIfMatchHeader,
    Response = ArmResponse<ProjectCostControl> & CostControlEtagHeader
  >;

  /** Deletes a project-owned cost control synchronously. An existing legacy attachment must be removed before its control can be deleted. */
  delete is ArmResourceDeleteSync<
    ProjectCostControl,
    Parameters = CostControlIfMatchHeader
  >;

  /** Lists project-owned cost controls using the budget representation. An unrepresentable legacy entry causes the complete list request to fail. */
  list is ArmResourceListByParent<
    ProjectCostControl,
    Parameters = CostControlReadHeaders,
    Response =
      | (ArmResponse<ProjectCostControlListResult> & CostControlEtagHeader)
      | CostControlNotModifiedResponse
  >;
}

@@minLength(CostControl.name, 1);
@@maxLength(CostControl.name, 64);
@@minLength(ProjectCostControl.name, 1);
@@maxLength(ProjectCostControl.name, 64);
