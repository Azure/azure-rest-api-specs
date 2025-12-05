import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MonitorService {
  string,

  /**
   * Application Insights
   */
  `Application Insights`: "Application Insights",

  /**
   * ActivityLog Administrative
   */
  `ActivityLog Administrative`: "ActivityLog Administrative",

  /**
   * ActivityLog Security
   */
  `ActivityLog Security`: "ActivityLog Security",

  /**
   * ActivityLog Recommendation
   */
  `ActivityLog Recommendation`: "ActivityLog Recommendation",

  /**
   * ActivityLog Policy
   */
  `ActivityLog Policy`: "ActivityLog Policy",

  /**
   * ActivityLog Autoscale
   */
  `ActivityLog Autoscale`: "ActivityLog Autoscale",

  /**
   * Log Analytics
   */
  `Log Analytics`: "Log Analytics",

  /**
   * Nagios
   */
  Nagios: "Nagios",

  /**
   * Platform
   */
  Platform: "Platform",

  /**
   * SCOM
   */
  SCOM: "SCOM",

  /**
   * ServiceHealth
   */
  ServiceHealth: "ServiceHealth",

  /**
   * SmartDetector
   */
  SmartDetector: "SmartDetector",

  /**
   * VM Insights
   */
  `VM Insights`: "VM Insights",

  /**
   * Zabbix
   */
  Zabbix: "Zabbix",

  /**
   * Resource Health
   */
  `Resource Health`: "Resource Health",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union MonitorCondition {
  string,

  /**
   * Fired
   */
  Fired: "Fired",

  /**
   * Resolved
   */
  Resolved: "Resolved",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Severity {
  string,

  /**
   * Sev0
   */
  Sev0: "Sev0",

  /**
   * Sev1
   */
  Sev1: "Sev1",

  /**
   * Sev2
   */
  Sev2: "Sev2",

  /**
   * Sev3
   */
  Sev3: "Sev3",

  /**
   * Sev4
   */
  Sev4: "Sev4",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AlertState {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Acknowledged
   */
  Acknowledged: "Acknowledged",

  /**
   * Closed
   */
  Closed: "Closed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AlertsSortByFields {
  string,

  /**
   * name
   */
  name: "name",

  /**
   * severity
   */
  severity: "severity",

  /**
   * alertState
   */
  alertState: "alertState",

  /**
   * monitorCondition
   */
  monitorCondition: "monitorCondition",

  /**
   * targetResource
   */
  targetResource: "targetResource",

  /**
   * targetResourceName
   */
  targetResourceName: "targetResourceName",

  /**
   * targetResourceGroup
   */
  targetResourceGroup: "targetResourceGroup",

  /**
   * targetResourceType
   */
  targetResourceType: "targetResourceType",

  /**
   * startDateTime
   */
  startDateTime: "startDateTime",

  /**
   * lastModifiedDateTime
   */
  lastModifiedDateTime: "lastModifiedDateTime",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SortOrder {
  string,

  /**
   * asc
   */
  asc: "asc",

  /**
   * desc
   */
  desc: "desc",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TimeRange {
  string,

  /**
   * 1h
   */
  `1h`: "1h",

  /**
   * 1d
   */
  `1d`: "1d",

  /**
   * 7d
   */
  `7d`: "7d",

  /**
   * 30d
   */
  `30d`: "30d",
}

/**
 * The type of signal the alert is based on, which could be metrics, logs or activity logs.
 */
union SignalType {
  string,

  /**
   * Metric
   */
  Metric: "Metric",

  /**
   * Log
   */
  Log: "Log",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Type of modification details
 */
union AlertModificationType {
  string,

  /**
   * PropertyChange
   */
  PropertyChange: "PropertyChange",

  /**
   * ActionsSuppressed
   */
  ActionsSuppressed: "ActionsSuppressed",

  /**
   * ActionsTriggered
   */
  ActionsTriggered: "ActionsTriggered",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union Identifier {
  string,

  /**
   * MonitorServiceList
   */
  MonitorServiceList: "MonitorServiceList",
}

/**
 * Identification of the information to be retrieved by API call
 */
union MetadataIdentifier {
  string,

  /**
   * MonitorServiceList
   */
  MonitorServiceList: "MonitorServiceList",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union AlertsSummaryGroupByFields {
  string,

  /**
   * severity
   */
  severity: "severity",

  /**
   * alertState
   */
  alertState: "alertState",

  /**
   * monitorCondition
   */
  monitorCondition: "monitorCondition",

  /**
   * monitorService
   */
  monitorService: "monitorService",

  /**
   * signalType
   */
  signalType: "signalType",

  /**
   * alertRule
   */
  alertRule: "alertRule",
}

/**
 * The status of the evaluation of the enrichment.
 */
union Status {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The enrichment type.
 */
union Type {
  string,

  /**
   * PrometheusInstantQuery
   */
  PrometheusInstantQuery: "PrometheusInstantQuery",

  /**
   * PrometheusRangeQuery
   */
  PrometheusRangeQuery: "PrometheusRangeQuery",
}

/**
 * The rule type
 */
union RuleType {
  string,

  /**
   * AlertRule
   */
  AlertRule: "AlertRule",

  /**
   * ActionRule
   */
  ActionRule: "ActionRule",
}

/**
 * The status of the notification
 */
union ResultStatus {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Inline
   */
  Inline: "Inline",

  /**
   * Throttled
   */
  Throttled: "Throttled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * ThrottledByAlertRule
   */
  ThrottledByAlertRule: "ThrottledByAlertRule",

  /**
   * ThrottledBySubscription
   */
  ThrottledBySubscription: "ThrottledBySubscription",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ApiVersion {
  /**
   * 2019-03-01
   */
  `2019-03-01`,

  /**
   * 2025-05-25-preview
   */
  `2025-05-25-preview`,
}

/**
 * Reason for the modification
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AlertModificationEvent {
  /**
   * AlertCreated
   */
  AlertCreated,

  /**
   * StateChange
   */
  StateChange,

  /**
   * SeverityChange
   */
  SeverityChange,

  /**
   * MonitorConditionChange
   */
  MonitorConditionChange,

  /**
   * ActionsTriggered
   */
  ActionsTriggered,

  /**
   * ActionsSuppressed
   */
  ActionsSuppressed,
}

/**
 * List the alerts.
 */
model AlertsList is Azure.Core.Page<Alert>;

/**
 * Alert property bag
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertProperties {
  /**
   * This object contains consistent fields across different monitor services.
   */
  essentials?: Essentials;

  /**
   * Information specific to the monitor service that gives more contextual details about the alert.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  context?: unknown;

  /**
   * Config which would be used for displaying the data in portal.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  egressConfig?: unknown;

  /**
   * Custom properties that can hold any user defined key-value pairs
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customProperties?: Record<string>;
}

/**
 * This object contains consistent fields across different monitor services.
 */
model Essentials {
  /**
   * Severity of alert Sev0 being highest and Sev4 being lowest.
   */
  @visibility(Lifecycle.Read)
  severity?: Severity;

  /**
   * The type of signal the alert is based on, which could be metrics, logs or activity logs.
   */
  @visibility(Lifecycle.Read)
  signalType?: SignalType;

  /**
   * Alert object state, which can be modified by the user.
   */
  @visibility(Lifecycle.Read)
  alertState?: AlertState;

  /**
   * Can be 'Fired' or 'Resolved', which represents whether the underlying conditions have crossed the defined alert rule thresholds.
   */
  @visibility(Lifecycle.Read)
  monitorCondition?: MonitorCondition;

  /**
   * Target ARM resource, on which alert got created.
   */
  targetResource?: string;

  /**
   * Name of the target ARM resource name, on which alert got created.
   */
  targetResourceName?: string;

  /**
   * Resource group of target ARM resource, on which alert got created.
   */
  targetResourceGroup?: string;

  /**
   * Resource type of target ARM resource, on which alert got created.
   */
  targetResourceType?: string;

  /**
   * Monitor service on which the rule(monitor) is set.
   */
  @visibility(Lifecycle.Read)
  monitorService?: MonitorService;

  /**
   * Rule(monitor) which fired alert instance. Depending on the monitor service,  this would be ARM id or name of the rule.
   */
  @visibility(Lifecycle.Read)
  alertRule?: string;

  /**
   * Unique Id created by monitor service for each alert instance. This could be used to track the issue at the monitor service, in case of Nagios, Zabbix, SCOM etc.
   */
  @visibility(Lifecycle.Read)
  sourceCreatedId?: string;

  /**
   * Unique Id of the smart group
   */
  @visibility(Lifecycle.Read)
  smartGroupId?: string;

  /**
   * Verbose reason describing the reason why this alert instance is added to a smart group
   */
  @visibility(Lifecycle.Read)
  smartGroupingReason?: string;

  /**
   * Creation time(ISO-8601 format) of alert instance.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * Last modification time(ISO-8601 format) of alert instance.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * Resolved time(ISO-8601 format) of alert instance. This will be updated when monitor service resolves the alert instance because the rule condition is no longer met.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  monitorConditionResolvedDateTime?: utcDateTime;

  /**
   * User who last modified the alert, in case of monitor service updates user would be 'system', otherwise name of the user.
   */
  @visibility(Lifecycle.Read)
  lastModifiedUserName?: string;

  /**
   * Action status
   */
  actionStatus?: ActionStatus;

  /**
   * Alert description.
   */
  description?: string;
}

/**
 * Action status
 */
model ActionStatus {
  /**
   * Value indicating whether alert is suppressed.
   */
  isSuppressed?: boolean;
}

/**
 * An azure resource object
 */
model ProxyResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * An error response from the service.
 */
@error
model AlertsManagementErrorResponse {
  /**
   * Details of error response.
   */
  error?: ErrorResponseBody;
}

/**
 * Details of error response.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model ErrorResponseBody {
  /**
   * Error code, intended to be consumed programmatically.
   */
  code?: string;

  /**
   * Description of the error, intended for display in user interface.
   */
  message?: string;

  /**
   * Target of the particular error, for example name of the property.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  @identifiers(#[])
  details?: ErrorResponseBody[];
}

/**
 * Alert Modification details
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertModification extends ProxyResource {
  /**
   * Alert modification history properties.
   */
  properties?: AlertModificationProperties;
}

/**
 * Alert modification history properties.
 */
model AlertModificationProperties {
  /**
   * Unique identifier of the alert.
   */
  @visibility(Lifecycle.Read)
  alertId?: string;

  /**
   * Array of alert modification events.
   */
  @identifiers(#[])
  modifications?: AlertModificationItem[];
}

/**
 * Alert modification item.
 */
model AlertModificationItem {
  /**
   * Reason for the modification
   */
  modificationEvent?: AlertModificationEvent;

  /**
   * Old value
   */
  oldValue?: string;

  /**
   * New value
   */
  newValue?: string;

  /**
   * Modified date and time
   */
  modifiedAt?: string;

  /**
   * Modified user details (Principal client name)
   */
  modifiedBy?: string;

  /**
   * Modification comments
   */
  comments?: string;

  /**
   * Description of the modification
   */
  description?: string;

  /**
   * Base details class.
   */
  details?: BaseDetails;
}

/**
 * Base details class.
 */
@discriminator("type")
model BaseDetails {
  /**
   * Type of modification details
   */
  type: AlertModificationType;
}

/**
 * Change alert state reason
 */
model Comments {
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  comments?: string;
}

/**
 * Operation provided by provider
 */
model Operation {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Properties of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;
}

/**
 * Properties of the operation
 */
model OperationDisplay {
  /**
   * Provider name
   */
  provider?: string;

  /**
   * Resource name
   */
  resource?: string;

  /**
   * Operation name
   */
  operation?: string;

  /**
   * Description of the operation
   */
  description?: string;
}

/**
 * alert meta data information.
 */
model AlertsMetaData {
  /**
   * alert meta data property bag
   */
  properties?: AlertsMetaDataProperties;
}

/**
 * alert meta data property bag
 */
@discriminator("metadataIdentifier")
model AlertsMetaDataProperties {
  /**
   * Identification of the information to be retrieved by API call
   */
  metadataIdentifier: MetadataIdentifier;
}

/**
 * Summary of alerts based on the input filters and 'groupby' parameters.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertsSummary extends ProxyResource {
  /**
   * Group the result set.
   */
  properties?: AlertsSummaryGroup;
}

/**
 * Group the result set.
 */
model AlertsSummaryGroup {
  /**
   * Total count of the result set.
   */
  total?: int64;

  /**
   * Total count of the smart groups.
   */
  smartGroupsCount?: int64;

  /**
   * Name of the field aggregated
   */
  groupedby?: string;

  /**
   * List of the items
   */
  values?: AlertsSummaryGroupItem[];
}

/**
 * Alerts summary group item
 */
model AlertsSummaryGroupItem {
  /**
   * Value of the aggregated field
   */
  name?: string;

  /**
   * Count of the aggregated field
   */
  count?: int64;

  /**
   * Name of the field aggregated
   */
  groupedby?: string;

  /**
   * List of the items
   */
  values?: AlertsSummaryGroupItem[];
}

/**
 * List the alert's enrichments.
 */
model AlertEnrichmentsList is Azure.Core.Page<AlertEnrichmentResponse>;

/**
 * The alert's enrichments.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AlertEnrichmentResponse
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Properties of the alert enrichment item.
   */
  properties?: AlertEnrichmentProperties;
}

/**
 * Properties of the alert enrichment item.
 */
model AlertEnrichmentProperties {
  /**
   * Unique Id (GUID) of the alert for which the enrichments are being retrieved.
   */
  @visibility(Lifecycle.Read)
  alertId?: string;

  /**
   * Enrichment details
   */
  @identifiers(#[])
  enrichments?: AlertEnrichmentItem[];
}

/**
 * Alert enrichment item.
 */
@discriminator("type")
model AlertEnrichmentItem {
  /**
   * The enrichment title.
   */
  title: string;

  /**
   * The enrichment description.
   */
  description: string;

  /**
   * The status of the evaluation of the enrichment.
   */
  status: Status;

  /**
   * The error message. Will be present only if the status is 'Failed'.
   */
  errorMessage?: string;

  /**
   * The enrichment type.
   */
  type: Type;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PropertyChangeDetails extends BaseDetails {
  /**
   * The value before the change
   */
  oldValue?: string;

  /**
   * The value after the change
   */
  newValue?: string;

  /**
   * The comment
   */
  comment?: string;

  /**
   * Type of modification details
   */
  type: "PropertyChange";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ActionSuppressedDetails extends BaseDetails {
  /**
   * List of suppression action rules
   */
  suppressionActionRules?: string[];

  /**
   * List of suppressed action groups
   */
  @identifiers(#[])
  suppressedActionGroups?: TriggeredRule[];

  /**
   * Type of modification details
   */
  type: "ActionsSuppressed";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model TriggeredRule {
  /**
   * The action group ID
   */
  actionGroupId?: string;

  /**
   * The rule ID
   */
  ruleId?: string;

  /**
   * The rule type
   */
  ruleType?: RuleType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ActionTriggeredDetails extends BaseDetails {
  /**
   * The action group that was triggered
   */
  actionGroup?: TriggeredRule;

  /**
   * The result of the notification delivery
   */
  notificationResult?: NotificationResult;

  /**
   * Type of modification details
   */
  type: "ActionsTriggered";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NotificationResult {
  /**
   * URL endpoint for checking notification delivery status. Only populated when status is 'Inline'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  statusURL?: string;

  /**
   * The status of the notification
   */
  status?: ResultStatus;
}

/**
 * Monitor service details
 */
model MonitorServiceList extends AlertsMetaDataProperties {
  /**
   * Array of operations
   */
  data: MonitorServiceDetails[];

  /**
   * Identification of the information to be retrieved by API call
   */
  metadataIdentifier: "MonitorServiceList";
}

/**
 * Details of a monitor service
 */
model MonitorServiceDetails {
  /**
   * Monitor service name
   */
  name?: string;

  /**
   * Monitor service display name
   */
  displayName?: string;
}

/**
 * Prometheus enrichment object.
 */
model PrometheusEnrichmentItem is AlertEnrichmentItem {
  /**
   * Link to Prometheus query API (Url format).
   */
  linkToApi: string;

  /**
   * An array of the azure monitor workspace resource ids.
   */
  datasources: string[];

  /**
   * Partial link to the Grafana explore API.
   */
  grafanaExplorePath: string;

  /**
   * The Prometheus expression query.
   */
  query: string;
}

alias PrometheusEnrichmentItemProperties = {
  /**
   * Link to Prometheus query API (Url format).
   */
  linkToApi: string;

  /**
   * An array of the azure monitor workspace resource ids.
   */
  datasources: string[];

  /**
   * Partial link to the Grafana explore API.
   */
  grafanaExplorePath: string;

  /**
   * The Prometheus expression query.
   */
  query: string;
};

/**
 * Prometheus instant query enrichment object.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(PrometheusEnrichmentItem)
model PrometheusInstantQuery extends AlertEnrichmentItem {
  ...PrometheusEnrichmentItemProperties;

  /**
   * The date and the time of the evaluation.
   */
  time: string;

  /**
   * The enrichment type.
   */
  type: "PrometheusInstantQuery";
}

/**
 * Prometheus instant query enrichment object.
 */
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(PrometheusEnrichmentItem)
model PrometheusRangeQuery extends AlertEnrichmentItem {
  ...PrometheusEnrichmentItemProperties;

  /**
   * The start evaluation date and time in ISO8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start: utcDateTime;

  /**
   * The end evaluation date and time in ISO8601 format.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end: utcDateTime;

  /**
   * Query resolution step width in ISO8601 format.
   */
  step: string;

  /**
   * The enrichment type.
   */
  type: "PrometheusRangeQuery";
}
