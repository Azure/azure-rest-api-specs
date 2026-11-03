import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace PurviewDataEstateHealth;

// ============================================================================
// Common / Shared Models
// ============================================================================

@doc("A paged collection of results.")
model PagedResults<T> {
  @doc("The collection of items.")
  value: T[];

  @doc("The total count of items.")
  count: int32;

  @doc("Continuation token for the next page of results.")
  continuationToken?: string;
}

@doc("Ordering specification for query results.")
model OrderBy {
  @doc("The field name to order by.")
  field?: string;

  @doc("The order direction: 'asc' or 'desc'.")
  direction?: string;
}

@doc("Base request for paginated queries.")
model QueryBaseRequest {
  @doc("Continuation token from a previous response.")
  continuationToken?: string;

  @doc("The number of results per page.")
  pageSize?: int32 = 100;

  @doc("Ordering specifications.")
  orderBy?: OrderBy[];
}

@doc("Result of a storage configuration connectivity test.")
model StorageConfigConnectivityResult {
  @doc("Whether the connectivity test was successful.")
  succeeded: boolean;

  @doc("Diagnostic message describing the connectivity test outcome. Empty string when the test succeeded.")
  message: string;
}

// ============================================================================
// Analytics Schedule Models
// ============================================================================

@doc("Frequency for analytics schedule.")
union AnalyticsScheduleFrequency {
  @doc("Hourly frequency.")
  Hour: "Hour",

  @doc("Daily frequency.")
  Day: "Day",

  @doc("Weekly frequency.")
  Week: "Week",

  @doc("Monthly frequency.")
  Month: "Month",

  string,
}

@doc("State of a schedule.")
union ScheduleState {
  @doc("The schedule is enabled.")
  Enabled: "Enabled",

  @doc("The schedule is disabled.")
  Disabled: "Disabled",

  string,
}

@doc("System metadata for a resource.")
model SystemData {
  @doc("The unique identifier of the user who created the resource.")
  createdBy?: uuid;

  @doc("The timestamp when the resource was created.")
  createdAt?: utcDateTime;

  @doc("The unique identifier of the user who last modified the resource.")
  lastModifiedBy?: uuid;

  @doc("The timestamp when the resource was last modified.")
  lastModifiedAt?: utcDateTime;
}

@doc("Request to create or update an analytics schedule.")
model AnalyticsScheduleRequest {
  @doc("The frequency of the analytics schedule.")
  frequency: AnalyticsScheduleFrequency;

  @doc("The interval between schedule runs.")
  interval: int32;

  @doc("The status of the schedule.")
  status?: ScheduleState;

  @doc("The start time of the schedule.")
  startTime: utcDateTime;

  @doc("The end time of the schedule.")
  endTime?: utcDateTime;

  @doc("System metadata.")
  systemData?: SystemData;

  @doc("The time zone for the schedule.")
  timeZone?: string;
}

@doc("Analytics job log entry.")
model AnalyticsJobLogs {
  @doc("The unique identifier of the job.")
  jobId?: string;

  @doc("The status of the job.")
  jobStatus?: string;

  @doc("Error message if the job failed.")
  errorMessage?: string;

  @doc("The timestamp of the log entry.")
  timeStamp?: string;
}

// ============================================================================
// Assessment Models
// ============================================================================

@doc("Target entity kind evaluated by an assessment.")
union AssessmentTargetEntityType {
  DataAsset: "DataAsset",
  DataProduct: "DataProduct",
  BusinessDomain: "BusinessDomain",
  CriticalDataElement: "CriticalDataElement",
  string,
}

@doc("Quality dimension evaluated by an assessment.")
union AssessmentTargetQualityType {
  @doc("Metadata quality assessment.")
  MetadataQuality: "MetadataQuality",

  @doc("Data quality assessment.")
  DataQuality: "DataQuality",

  string,
}

@doc("Severity classification for an assessment rule's action.")
union AssessmentRuleSeverity {
  Low: "Low",
  Medium: "Medium",
  High: "High",
  string,
}

@doc("Action metadata applied when an assessment rule fires (e.g. for health alerts).")
model AssessmentRuleActionProperties {
  @doc("Human-readable name for the resulting action.")
  name: string;

  @doc("Severity of the resulting action.")
  severity: AssessmentRuleSeverity;

  @doc("Why the rule fired, surfaced to end users.")
  reason: string;

  @doc("Recommended remediation surfaced to end users.")
  recommendation: string;
}

@doc("A rule attached to an assessment. The `rule` payload uses the shared Rule discriminated union.")
model AssessmentRule {
  @doc("The unique identifier of the rule within the assessment.")
  id: string;

  @doc("The rule definition (simple, group, or expression).")
  rule: Rule;

  @doc("Optional metadata describing what to do when the rule fires.")
  actionProperties?: AssessmentRuleActionProperties;
}

@doc("An assessment resource.")
model Assessment {
  @doc("The unique identifier of the assessment.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("System metadata for the assessment.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("The assessment's display name.")
  name: string;

  @doc("The kind of entity this assessment evaluates.")
  targetEntityType?: AssessmentTargetEntityType;

  @doc("The quality dimension this assessment evaluates.")
  targetQualityType?: AssessmentTargetQualityType;

  @doc("The rules that constitute this assessment.")
  rules?: AssessmentRule[];
}

// ============================================================================
// Control Models
// ============================================================================

@doc("Status of a governance control.")
union ControlStatus {
  @doc("The control is enabled.")
  Enabled: "Enabled",

  @doc("The control is disabled.")
  Disabled: "Disabled",

  @doc("The control is in development.")
  InDevelopment: "InDevelopment",

  string,
}

@doc("Discriminator for governance control variants.")
union ControlType {
  @doc("A control group that aggregates child controls.")
  ControlGroup: "ControlGroup",

  @doc("A leaf control that performs evaluations.")
  ControlNode: "ControlNode",

  string,
}

@doc("Discriminator for governance rule variants.")
union RuleType {
  @doc("A logical group combining nested rules.")
  RuleGroup: "RuleGroup",

  @doc("A simple checkPoint/operator/operand rule.")
  SimpleRule: "SimpleRule",

  @doc("An expression-based rule.")
  ExpressionRule: "ExpressionRule",

  string,
}

@doc("Logical combinator for a rule group.")
union RuleGroupOperator {
  And: "And",
  Or: "Or",
  Not: "Not",
  string,
}

@doc("Comparison operator for a simple rule.")
union RuleOperator {
  Equal: "Equal",
  NotEqual: "NotEqual",
  GreaterThan: "GreaterThan",
  GreaterThanOrEqual: "GreaterThanOrEqual",
  LessThan: "LessThan",
  LessThanOrEqual: "LessThanOrEqual",
  Contains: "Contains",
  StartsWith: "StartsWith",
  EndsWith: "EndsWith",
  InRange: "InRange",
  IsNull: "IsNull",
  IsEmpty: "IsEmpty",
  IsTrue: "IsTrue",
  IsNullOrEmpty: "IsNullOrEmpty",
  IsNotNullOrEmpty: "IsNotNullOrEmpty",
  Normalize: "Normalize",
  RegexMatch: "RegexMatch",
  string,
}

@doc("Identifier of a checkable property within a rule.")
union RuleCheckPoint {
  Score: "Score",
  DataProductDescriptionContent: "DataProductDescriptionContent",
  DataProductDescriptionLength: "DataProductDescriptionLength",
  string,
}

@doc("Type-specific properties for a simple rule.")
model SimpleRuleTypeProperties {
  @doc("The data point to evaluate.")
  checkPoint?: RuleCheckPoint;

  @doc("The comparison operator.")
  operator?: RuleOperator;

  @doc("The operand to compare against. Optional for operators that take no operand (e.g. IsNull).")
  operand?: string;
}

@doc("Type-specific properties for a rule group.")
model RuleGroupTypeProperties {
  @doc("How nested rules are combined.")
  groupOperator?: RuleGroupOperator;

  @doc("The nested rules combined by groupOperator.")
  rules?: Rule[];
}

@doc("Type-specific properties for an expression rule.")
model ExpressionRuleTypeProperties {
  @doc("The data point evaluated by the expression.")
  checkPoint: RuleCheckPoint;

  @doc("The expression to evaluate.")
  expression: string;
}

@doc("Base shape for a governance rule. Use the `type` discriminator to determine which concrete rule variant is present.")
@discriminator("type")
model Rule {
  @doc("Discriminates the rule variant.")
  type: RuleType;
}

@doc("A leaf rule that compares a checkPoint against an operand using an operator.")
model SimpleRule extends Rule {
  @doc("The rule type discriminator value for simple rules.")
  type: RuleType.SimpleRule;

  @doc("The simple rule's type-specific properties.")
  typeProperties?: SimpleRuleTypeProperties;
}

@doc("A rule that combines nested rules with a logical operator.")
model RuleGroup extends Rule {
  @doc("The rule type discriminator value for rule groups.")
  type: RuleType.RuleGroup;

  @doc("The group's type-specific properties (groupOperator + nested rules).")
  typeProperties?: RuleGroupTypeProperties;
}

@doc("A rule whose evaluation is driven by an expression string.")
model ExpressionRule extends Rule {
  @doc("The rule type discriminator value for expression rules.")
  type: RuleType.ExpressionRule;

  @doc("The expression rule's type-specific properties.")
  typeProperties?: ExpressionRuleTypeProperties;
}

@doc("A single status palette assignment based on a rule. When the rule evaluates true the referenced palette is applied.")
model ControlStatusPaletteRule {
  @doc("The palette to apply when the rule matches.")
  statusPaletteId?: string;

  @doc("The rule that drives the palette assignment.")
  rule: Rule;
}

@doc("Configuration for selecting a status palette for a control.")
model ControlStatusPaletteConfig {
  @doc("The palette to apply when no rule matches.")
  fallbackStatusPaletteId?: string;

  @doc("The target score used by certain palette rules.")
  targetScore?: float64;

  @doc("Rules evaluated in order to select a palette.")
  statusPaletteRules?: ControlStatusPaletteRule[];
}

@doc("A single contact reference on a governance entity.")
model ContactItem {
  @doc("The contact principal id.")
  id: string;

  @doc("Free-form description of the contact's relationship to the entity.")
  description?: string;
}

@doc("Contacts grouped by role for a governance entity.")
model Contacts {
  @doc("Principals identified as owners of the entity.")
  owner?: ContactItem[];

  @doc("Principals identified as subject-matter experts on the entity.")
  expert?: ContactItem[];
}

@doc("A status palette definition (color label).")
model StatusPalette {
  @doc("The unique identifier of the palette.")
  id: string;

  @doc("System metadata for the palette.")
  systemData?: SystemData;

  @doc("The palette name.")
  name: string;

  @doc("The palette color (typically a hex code).")
  color: string;
}

@doc("An individual score record returned with control responses.")
model ControlScore {
  @doc("The time the score was recorded.")
  time: utcDateTime;

  @doc("The numeric score value.")
  score: float64;

  @doc("The owning control group id, when scored at group level.")
  controlGroupId?: string;

  @doc("The owning control id, when scored at node level.")
  controlId?: string;

  @doc("System metadata for the score record.")
  systemData?: SystemData;

  @doc("Identifier of the computing job that produced this score.")
  computingJobId?: string;
}

@doc("Type-specific properties present on ControlNode variants.")
model ControlNodeTypeProperties {
  @doc("The parent control group id.")
  groupId?: string;

  @doc("Business domain ids this control applies to.")
  domains?: string[];

  @doc("The assessment id evaluated by this control, when applicable.")
  assessmentId?: string;
}

@doc("A governance control resource. Use the `type` discriminator to determine whether this is a ControlGroup or ControlNode.")
@discriminator("type")
model Control {
  @doc("The unique identifier of the control.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("System metadata for the control.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("The control's display name.")
  name: string;

  @doc("Free-form description of the control.")
  description?: string;

  @doc("Contacts associated with the control, grouped by role.")
  contacts?: Contacts;

  @doc("True when the control is reserved (system-managed).")
  reserved?: boolean;

  @doc("Configuration for selecting a status palette for the control.")
  statusPaletteConfig?: ControlStatusPaletteConfig;

  @doc("Discriminates between control group and control node variants.")
  type: ControlType;

  @doc("The control's lifecycle status.")
  status?: ControlStatus;

  @doc("The system template name used to seed this control.")
  systemTemplate?: string;

  @doc("The system template entity id used to seed this control.")
  systemTemplateEntityId?: string;

  @doc("Current score for the control (server-computed).")
  @visibility(Lifecycle.Read)
  score?: float64;

  @doc("Recent score history for the control (server-computed).")
  @visibility(Lifecycle.Read)
  scores?: ControlScore[];

  @doc("Target score for the control (server-computed).")
  @visibility(Lifecycle.Read)
  targetScore?: float64;

  @doc("Timestamp of the last server-side refresh of computed fields.")
  @visibility(Lifecycle.Read)
  lastRefreshed?: utcDateTime;

  @doc("Resolved status palette currently applied to the control (server-computed).")
  @visibility(Lifecycle.Read)
  statusPalette?: StatusPalette;

  @doc("Resolved parent group name (server-computed from typeProperties.groupId).")
  @visibility(Lifecycle.Read)
  group?: string;
}

@doc("A control group aggregating child controls.")
model ControlGroup extends Control {
  @doc("The control type discriminator value for control groups.")
  type: ControlType.ControlGroup;
}

@doc("A leaf control that performs evaluations.")
model ControlNode extends Control {
  @doc("The control type discriminator value for control nodes.")
  type: ControlType.ControlNode;

  @doc("Type-specific properties for this control node.")
  typeProperties?: ControlNodeTypeProperties;
}

// ============================================================================
// Schedule Models
// ============================================================================

@doc("Trigger type for a schedule callback.")
union ScheduleCallbackTriggerType {
  @doc("Manual trigger.")
  Manually: "Manually",

  @doc("Scheduled trigger.")
  Schedule: "Schedule",

  string,
}

@doc("Frequency for a control schedule.")
union ScheduleFrequency {
  @doc("Monthly frequency.")
  Month: "Month",

  @doc("Weekly frequency.")
  Week: "Week",

  @doc("Daily frequency.")
  Day: "Day",

  string,
}

@doc("Day of the week used by control schedule recurrence.")
union ScheduleWeekDay {
  Sunday: "Sunday",
  Monday: "Monday",
  Tuesday: "Tuesday",
  Wednesday: "Wednesday",
  Thursday: "Thursday",
  Friday: "Friday",
  Saturday: "Saturday",
  string,
}

@doc("A monthly occurrence specification for a control schedule (e.g. the 2nd Tuesday of each month).")
model ScheduleMonthlyOccurrence {
  @doc("The day of the week.")
  day: ScheduleWeekDay;

  @doc("The ordinal occurrence within the month (e.g. 1 for first, 2 for second).")
  occurrence: int32;
}

@doc("Fine-grained recurrence pattern for a control schedule.")
model Recurrence {
  @doc("Hours of the day at which to run (0 through 23).")
  hours: int32[];

  @doc("Minutes of the hour at which to run (0 through 59).")
  minutes: int32[];

  @doc("Days of the month on which to run (1 through 31).")
  monthDays: int32[];

  @doc("Days of the week on which to run.")
  weekDays: ScheduleWeekDay[];

  @doc("Monthly occurrence specifications (e.g. 2nd Tuesday).")
  monthlyOccurrences: ScheduleMonthlyOccurrence[];
}

@doc("A control schedule resource.")
model Schedule {
  @doc("The unique identifier of the schedule.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("System metadata for the schedule.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("The frequency of the schedule.")
  frequency?: ScheduleFrequency;

  @doc("The status of the schedule.")
  status?: ScheduleState;

  @doc("The interval between schedule runs, expressed in the unit defined by frequency.")
  interval?: int32;

  @doc("The start time of the schedule.")
  startTime?: utcDateTime;

  @doc("The end time of the schedule.")
  endTime?: utcDateTime;

  @doc("Fine-grained recurrence pattern within the chosen frequency.")
  recurrence?: Recurrence;

  @doc("The time zone (IANA name) used to interpret startTime, endTime, and recurrence.")
  timeZone?: string;
}

// ============================================================================
// Score Models
// ============================================================================

@doc("Time range for score queries.")
model QueryScoresRequestTimeRange {
  @doc("The start of the time range.")
  start: utcDateTime;

  @doc("The end of the time range.")
  end: utcDateTime;
}

@doc("Unified request for querying scores. When type=ControlNode, provide controlIds. When type=ControlGroup, provide controlGroupIds.")
model QueryScoresRequest {
  @doc("Filter by domain IDs.")
  domainIds?: string[];

  @doc("Number of latest score records to return.")
  recordLatestCounts?: int32;

  @doc("Time range filter for scores.")
  recordTimeRange?: QueryScoresRequestTimeRange;

  @doc("Filter by control status.")
  status?: string;

  @doc("The control IDs to query scores for. Required when type=ControlNode.")
  controlIds?: string[];

  @doc("The control group IDs to query scores for. Required when type=ControlGroup.")
  controlGroupIds?: string[];
}

@doc("Score data aggregated by control or control group. The shape of items depends on the `type` query parameter used in the request: when `type=ControlNode`, `controlId` and `computingJobId` are populated; when `type=ControlGroup`, those fields are omitted.")
model AggregatedScore {
  @doc("The control group ID.")
  controlGroupId: string;

  @doc("The schedule run ID.")
  scheduleRunId: string;

  @doc("The timestamp of the score.")
  time: utcDateTime;

  @doc("The score value.")
  score: float64;

  @doc("The control ID. Present only when the query was issued with `type=ControlNode`.")
  controlId?: string;

  @doc("The computing job ID. Present only when the query was issued with `type=ControlNode`.")
  computingJobId?: string;
}

// ============================================================================
// Settings Models
// ============================================================================

@doc("Type of storage backing a Purview Data Estate Health storage configuration.")
union StorageType {
  @doc("Microsoft Fabric storage.")
  Fabric: "Fabric",

  @doc("Azure Data Lake Storage Gen2 storage.")
  ADLSGen2: "ADLSGen2",

  string,
}

@doc("Status of a Purview Data Estate Health storage configuration.")
union StorageStatus {
  @doc("The storage configuration is disabled.")
  Disabled: "Disabled",

  @doc("The storage configuration is enabled.")
  Enabled: "Enabled",

  string,
}

@doc("""
  Type-specific properties for the storage configuration. The actual fields
  populated depend on the parent StorageConfig.type: `locationURL` is set when
  type is `Fabric`; `endpoint` is set when type is `ADLSGen2`.
  """)
model StorageConfigTypeProperties {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name matches existing service wire format `locationURL` defined by DGCatalogStorageConfigFabricTypeProperties."
  @doc("Fabric workspace location URL. Required when StorageConfig.type is `Fabric`.")
  locationURL?: string;

  @doc("Azure Data Lake Storage Gen2 endpoint URL. Required when StorageConfig.type is `ADLSGen2`.")
  endpoint?: string;
}

@doc("Network properties associated with a storage configuration, including managed virtual network and managed private endpoint information.")
model StorageConfigNetworkProperties {
  @doc("Whether managed virtual network is enabled for this storage configuration.")
  isManagedVnetEnabled?: boolean;

  @doc("The Azure resource ID of the target storage resource.")
  targetResourceId?: string;

  @doc("The managed private endpoint identifier.")
  mpeId?: string;

  @doc("The status of the managed private endpoint. Possible values include `Approved`, `Rejected`, `Pending`, `Provisioning`, or an empty string when no endpoint exists.")
  mpeStatus?: string;

  @doc("Whether the managed private endpoint is marked for deletion.")
  markedForDeletion?: boolean;
}

@doc("Storage configuration for Purview Data Estate Health.")
model StorageConfig {
  @doc("Unique identifier of the storage configuration.")
  id: string;

  @doc("Type of storage backing this configuration.")
  type: StorageType;

  @doc("Status of the storage configuration.")
  status: StorageStatus;

  @doc("System data envelope for the storage configuration.")
  systemData: SystemData;

  @doc("Type-specific properties whose shape depends on the storage `type`.")
  typeProperties: StorageConfigTypeProperties;

  @doc("Network properties associated with the storage configuration.")
  networkProperties?: StorageConfigNetworkProperties;
}

@doc("Partial storage configuration payload used when updating the configuration or testing its connectivity. All properties are optional so callers can supply only the fields they want to change or validate.")
model StorageConfigUpdate is OptionalProperties<StorageConfig>;

@doc("Supported data source types for managed private endpoints.")
union DataSourceType {
  @doc("Microsoft Fabric data source.")
  Fabric: "Fabric",

  @doc("Azure Data Lake Storage Gen2 data source.")
  ADLSGen2: "ADLSGen2",

  string,
}

@doc("Request to check or create a managed private endpoint.")
model ManagedPrivateEndpointRequest {
  @doc("The Azure resource ID of the target resource.")
  targetResourceId: string;

  @doc("The data source type.")
  dataSourceType: DataSourceType;
}

@doc("Response indicating whether a managed private endpoint exists.")
model ManagedPrivateEndpointExistsResponse {
  @doc("The status of the managed private endpoint.")
  mpeStatus?: string;

  @doc("The managed private endpoint ID.")
  mpeId?: string;

  @doc("The Azure resource ID of the target resource.")
  targetResourceId?: string;

  @doc("The data source type.")
  dataSourceType?: string;
}

@doc("Network properties including managed private endpoint information.")
model NetworkProperties {
  @doc("Whether managed virtual network is enabled.")
  isManagedVnetEnabled?: boolean;

  @doc("The Azure resource ID of the target resource.")
  targetResourceId?: string;

  @doc("The data source type.")
  dataSourceType?: string;

  @doc("The status of the managed private endpoint.")
  mpeStatus?: string;

  @doc("The managed private endpoint ID.")
  mpeId?: string;

  @doc("Whether the endpoint is marked for deletion.")
  markedForDeletion?: boolean;
}
