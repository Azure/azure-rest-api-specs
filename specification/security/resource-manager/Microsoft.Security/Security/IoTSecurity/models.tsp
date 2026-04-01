import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * The value type of the items in the list.
 */
union ValueType {
  string,

  /**
   * An IP range in CIDR format (e.g. '192.168.0.1/8').
   */
  IpCidr: "IpCidr",

  /**
   * Any string value.
   */
  String: "String",
}

/**
 * Assessed alert severity.
 */
union ReportedSeverity {
  string,

  /**
   * Informational
   */
  Informational: "Informational",

  /**
   * Low
   */
  Low: "Low",

  /**
   * Medium
   */
  Medium: "Medium",

  /**
   * High
   */
  High: "High",
}

/**
 * Status of the IoT Security solution.
 */
union SecuritySolutionStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union ExportData {
  string,

  /**
   * Agent raw events
   */
  RawEvents: "RawEvents",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union DataSource {
  string,

  /**
   * Devices twin data
   */
  TwinData: "TwinData",
}

/**
 * The type of IoT Security recommendation.
 */
union RecommendationType {
  string,

  /**
   * Authentication schema used for pull an edge module from an ACR repository does not use Service Principal Authentication.
   */
  IoT_ACRAuthentication: "IoT_ACRAuthentication",

  /**
   * IoT agent message size capacity is currently underutilized, causing an increase in the number of sent messages. Adjust message intervals for better utilization.
   */
  IoT_AgentSendsUnutilizedMessages: "IoT_AgentSendsUnutilizedMessages",

  /**
   * Identified security related system configuration issues.
   */
  IoT_Baseline: "IoT_Baseline",

  /**
   * You can optimize Edge Hub memory usage by turning off protocol heads for any protocols not used by Edge modules in your solution.
   */
  IoT_EdgeHubMemOptimize: "IoT_EdgeHubMemOptimize",

  /**
   * Logging is disabled for this edge module.
   */
  IoT_EdgeLoggingOptions: "IoT_EdgeLoggingOptions",

  /**
   * A minority within a device security group has inconsistent Edge Module settings with the rest of their group.
   */
  IoT_InconsistentModuleSettings: "IoT_InconsistentModuleSettings",

  /**
   * Install the Azure Security of Things Agent.
   */
  IoT_InstallAgent: "IoT_InstallAgent",

  /**
   * IP Filter Configuration should have rules defined for allowed traffic and should deny all other traffic by default.
   */
  IoT_IPFilter_DenyAll: "IoT_IPFilter_DenyAll",

  /**
   * An Allow IP Filter rules source IP range is too large. Overly permissive rules might expose your IoT hub to malicious intenders.
   */
  IoT_IPFilter_PermissiveRule: "IoT_IPFilter_PermissiveRule",

  /**
   * A listening endpoint was found on the device.
   */
  IoT_OpenPorts: "IoT_OpenPorts",

  /**
   * An Allowed firewall policy was found (INPUT/OUTPUT). The policy should Deny all traffic by default and define rules to allow necessary communication to/from the device.
   */
  IoT_PermissiveFirewallPolicy: "IoT_PermissiveFirewallPolicy",

  /**
   * A rule in the firewall has been found that contains a permissive pattern for a wide range of IP addresses or Ports.
   */
  IoT_PermissiveInputFirewallRules: "IoT_PermissiveInputFirewallRules",

  /**
   * A rule in the firewall has been found that contains a permissive pattern for a wide range of IP addresses or Ports.
   */
  IoT_PermissiveOutputFirewallRules: "IoT_PermissiveOutputFirewallRules",

  /**
   * Edge module is configured to run in privileged mode, with extensive Linux capabilities or with host-level network access (send/receive data to host machine).
   */
  IoT_PrivilegedDockerOptions: "IoT_PrivilegedDockerOptions",

  /**
   * Same authentication credentials to the IoT Hub used by multiple devices. This could indicate an illegitimate device impersonating a legitimate device. It also exposes the risk of device impersonation by an attacker.
   */
  IoT_SharedCredentials: "IoT_SharedCredentials",

  /**
   * Insecure TLS configurations detected. Immediate upgrade recommended.
   */
  IoT_VulnerableTLSCipherSuite: "IoT_VulnerableTLSCipherSuite",
}

/**
 * Recommendation status. When the recommendation status is disabled recommendations are not generated.
 */
union RecommendationConfigStatus {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Unmasked IP address logging status
 */
union UnmaskedIpLoggingStatus {
  string,

  /**
   * Unmasked IP logging is disabled
   */
  Disabled: "Disabled",

  /**
   * Unmasked IP logging is enabled
   */
  Enabled: "Enabled",
}

/**
 * Workspace type.
 */
union AdditionalWorkspaceType {
  string,

  /**
   * Sentinel
   */
  Sentinel: "Sentinel",
}

/**
 * Data types sent to workspace.
 */
union AdditionalWorkspaceDataType {
  string,

  /**
   * Alerts
   */
  Alerts: "Alerts",

  /**
   * RawEvents
   */
  RawEvents: "RawEvents",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * List of device security groups
 */
model DeviceSecurityGroupList {
  /**
   * List of device security group objects
   */
  @pageItems
  value?: DeviceSecurityGroup[];

  /**
   * The URI to fetch the next page.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * describes properties of a security group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DeviceSecurityGroupProperties {
  /**
   * The list of custom alert threshold rules.
   */
  thresholdRules?: ThresholdCustomAlertRule[];

  /**
   * The list of custom alert time-window rules.
   */
  timeWindowRules?: TimeWindowCustomAlertRule[];

  /**
   * The allow-list custom alert rules.
   */
  allowlistRules?: AllowlistCustomAlertRule[];

  /**
   * The deny-list custom alert rules.
   */
  denylistRules?: DenylistCustomAlertRule[];
}

/**
 * A custom alert rule that checks if a value (depends on the custom alert type) is within the given range.
 */
@discriminator("ruleType")
model ThresholdCustomAlertRule extends CustomAlertRule {
  /**
   * The minimum threshold.
   */
  minThreshold: int32;

  /**
   * The maximum threshold.
   */
  maxThreshold: int32;
}

/**
 * A custom alert rule.
 */
@discriminator("ruleType")
model CustomAlertRule {
  /**
   * The display name of the custom alert.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The description of the custom alert.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Status of the custom alert.
   */
  isEnabled: boolean;

  /**
   * The type of the custom alert rule.
   */
  ruleType: string;
}

/**
 * A custom alert rule that checks if the number of activities (depends on the custom alert type) in a time window is within the given range.
 */
@discriminator("ruleType")
model TimeWindowCustomAlertRule extends ThresholdCustomAlertRule {
  /**
   * The time window size in iso8601 format.
   */
  timeWindowSize: duration;
}

/**
 * A custom alert rule that checks if a value (depends on the custom alert type) is allowed.
 */
model AllowlistCustomAlertRule extends ListCustomAlertRule {
  /**
   * The values to allow. The format of the values depends on the rule type.
   */
  allowlistValues: string[];
}

/**
 * A List custom alert rule.
 */
model ListCustomAlertRule extends CustomAlertRule {
  /**
   * The value type of the items in the list.
   */
  @visibility(Lifecycle.Read)
  valueType?: ValueType;

  ruleType: "ListCustomAlertRule";
}

/**
 * A custom alert rule that checks if a value (depends on the custom alert type) is denied.
 */
model DenylistCustomAlertRule extends ListCustomAlertRule {
  /**
   * The values to deny. The format of the values depends on the rule type.
   */
  denylistValues: string[];
}

/**
 * Describes an Azure resource.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
@error
model CloudError {
  /**
   * The error object.
   */
  error?: CloudErrorBody;
}

/**
 * The error detail.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model CloudErrorBody {
  /**
   * The error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The error target.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * The error details.
   */
  @visibility(Lifecycle.Read)
  details?: CloudErrorBody[];

  /**
   * The error additional info.
   */
  @visibility(Lifecycle.Read)
  additionalInfo?: ErrorAdditionalInfo[];
}

/**
 * The resource management error additional info.
 */
model ErrorAdditionalInfo {
  /**
   * The additional info type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The additional info.
   */
  @visibility(Lifecycle.Read)
  info?: unknown;
}

/**
 * List of Security analytics of your IoT Security solution
 */
model IoTSecuritySolutionAnalyticsModelList
  is Azure.Core.Page<IoTSecuritySolutionAnalyticsModel>;

/**
 * Security analytics properties of your IoT Security solution
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecuritySolutionAnalyticsModelProperties {
  /**
   * Security analytics of your IoT Security solution.
   */
  @visibility(Lifecycle.Read)
  metrics?: IoTSeverityMetrics;

  /**
   * Number of unhealthy devices within your IoT Security solution.
   */
  @visibility(Lifecycle.Read)
  unhealthyDeviceCount?: int64;

  /**
   * List of device metrics by the aggregation date.
   */
  @visibility(Lifecycle.Read)
  devicesMetrics?: IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem[];

  /**
   * List of the 3 devices with the most alerts.
   */
  topAlertedDevices?: IoTSecurityAlertedDevice[];

  /**
   * List of the 3 most prevalent device alerts.
   */
  mostPrevalentDeviceAlerts?: IoTSecurityDeviceAlert[];

  /**
   * List of the 3 most prevalent device recommendations.
   */
  mostPrevalentDeviceRecommendations?: IoTSecurityDeviceRecommendation[];
}

/**
 * IoT Security solution analytics severity metrics.
 */
model IoTSeverityMetrics {
  /**
   * Count of high severity alerts/recommendations.
   */
  high?: int64;

  /**
   * Count of medium severity alerts/recommendations.
   */
  medium?: int64;

  /**
   * Count of low severity alerts/recommendations.
   */
  low?: int64;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecuritySolutionAnalyticsModelPropertiesDevicesMetricsItem {
  /**
   * Aggregation of IoT Security solution device alert metrics by date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * Device alert count by severity.
   */
  devicesMetrics?: IoTSeverityMetrics;
}

/**
 * Statistical information about the number of alerts per device during last set number of days.
 */
model IoTSecurityAlertedDevice {
  /**
   * Device identifier.
   */
  @visibility(Lifecycle.Read)
  deviceId?: string;

  /**
   * Number of alerts raised for this device.
   */
  @visibility(Lifecycle.Read)
  alertsCount?: int64;
}

/**
 * Statistical information about the number of alerts per alert type during last set number of days
 */
model IoTSecurityDeviceAlert {
  /**
   * Display name of the alert
   */
  @visibility(Lifecycle.Read)
  alertDisplayName?: string;

  /**
   * Assessed Alert severity.
   */
  @visibility(Lifecycle.Read)
  reportedSeverity?: ReportedSeverity;

  /**
   * Number of alerts raised for this alert type.
   */
  @visibility(Lifecycle.Read)
  alertsCount?: int64;
}

/**
 * Statistical information about the number of recommendations per device, per recommendation type.
 */
model IoTSecurityDeviceRecommendation {
  /**
   * Display name of the recommendation.
   */
  @visibility(Lifecycle.Read)
  recommendationDisplayName?: string;

  /**
   * Assessed recommendation severity.
   */
  @visibility(Lifecycle.Read)
  reportedSeverity?: ReportedSeverity;

  /**
   * Number of devices with this recommendation.
   */
  @visibility(Lifecycle.Read)
  devicesCount?: int64;
}

/**
 * List of IoT Security solution aggregated alert data.
 */
model IoTSecurityAggregatedAlertList
  is Azure.Core.Page<IoTSecurityAggregatedAlert>;

/**
 * IoT Security solution aggregated alert details.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecurityAggregatedAlertProperties {
  /**
   * Name of the alert type.
   */
  @visibility(Lifecycle.Read)
  alertType?: string;

  /**
   * Display name of the alert type.
   */
  @visibility(Lifecycle.Read)
  alertDisplayName?: string;

  /**
   * Date of detection.
   */
  @visibility(Lifecycle.Read)
  aggregatedDateUtc?: plainDate;

  /**
   * Name of the organization that raised the alert.
   */
  @visibility(Lifecycle.Read)
  vendorName?: string;

  /**
   * Assessed alert severity.
   */
  @visibility(Lifecycle.Read)
  reportedSeverity?: ReportedSeverity;

  /**
   * Recommended steps for remediation.
   */
  @visibility(Lifecycle.Read)
  remediationSteps?: string;

  /**
   * Description of the suspected vulnerability and meaning.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Number of alerts occurrences within the aggregated time window.
   */
  @visibility(Lifecycle.Read)
  count?: int64;

  /**
   * Azure resource ID of the resource that received the alerts.
   */
  @visibility(Lifecycle.Read)
  effectedResourceType?: string;

  /**
   * The type of the alerted resource (Azure, Non-Azure).
   */
  @visibility(Lifecycle.Read)
  systemSource?: string;

  /**
   * IoT Security solution alert response.
   */
  @visibility(Lifecycle.Read)
  actionTaken?: string;

  /**
   * Log analytics query for getting the list of affected devices/alerts.
   */
  @visibility(Lifecycle.Read)
  logAnalyticsQuery?: string;

  /**
   * 10 devices with the highest number of occurrences of this alert type, on this day.
   */
  @visibility(Lifecycle.Read)
  topDevicesList?: IoTSecurityAggregatedAlertPropertiesTopDevicesListItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecurityAggregatedAlertPropertiesTopDevicesListItem {
  /**
   * Name of the device.
   */
  @visibility(Lifecycle.Read)
  deviceId?: string;

  /**
   * Number of alerts raised for this device.
   */
  @visibility(Lifecycle.Read)
  alertsCount?: int64;

  /**
   * Most recent time this alert was raised for this device, on this day.
   */
  @visibility(Lifecycle.Read)
  lastOccurrence?: string;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags.
 */
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * IoT Security solution aggregated recommendation information
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecurityAggregatedRecommendationProperties {
  /**
   * Name of the recommendation.
   */
  recommendationName?: string;

  /**
   * Display name of the recommendation type.
   */
  @visibility(Lifecycle.Read)
  recommendationDisplayName?: string;

  /**
   * Description of the suspected vulnerability and meaning.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Recommendation-type GUID.
   */
  @visibility(Lifecycle.Read)
  recommendationTypeId?: string;

  /**
   * Name of the organization that made the recommendation.
   */
  @visibility(Lifecycle.Read)
  detectedBy?: string;

  /**
   * Recommended steps for remediation
   */
  @visibility(Lifecycle.Read)
  remediationSteps?: string;

  /**
   * Assessed recommendation severity.
   */
  @visibility(Lifecycle.Read)
  reportedSeverity?: ReportedSeverity;

  /**
   * Number of healthy devices within the IoT Security solution.
   */
  @visibility(Lifecycle.Read)
  healthyDevices?: int64;

  /**
   * Number of unhealthy devices within the IoT Security solution.
   */
  @visibility(Lifecycle.Read)
  unhealthyDeviceCount?: int64;

  /**
   * Log analytics query for getting the list of affected devices/alerts.
   */
  @visibility(Lifecycle.Read)
  logAnalyticsQuery?: string;
}

/**
 * List of IoT Security solution aggregated recommendations.
 */
model IoTSecurityAggregatedRecommendationList
  is Azure.Core.Page<IoTSecurityAggregatedRecommendation>;

/**
 * List of IoT Security solutions.
 */
model IoTSecuritySolutionsList is Azure.Core.Page<IoTSecuritySolutionModel>;

/**
 * Security Solution setting data
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IoTSecuritySolutionProperties {
  /**
   * Workspace resource ID
   */
  workspace?: string;

  /**
   * Resource display name.
   */
  displayName: string;

  /**
   * Status of the IoT Security solution.
   */
  status?: SecuritySolutionStatus = SecuritySolutionStatus.Enabled;

  /**
   * List of additional options for exporting to workspace data.
   */
  export?: ExportData[];

  /**
   * Disabled data sources. Disabling these data sources compromises the system.
   */
  disabledDataSources?: DataSource[];

  /**
   * IoT Hub resource IDs
   */
  iotHubs: string[];

  /**
   * Properties of the IoT Security solution's user defined resources.
   */
  userDefinedResources?: UserDefinedResourcesProperties;

  /**
   * List of resources that were automatically discovered as relevant to the security solution.
   */
  @visibility(Lifecycle.Read)
  autoDiscoveredResources?: string[];

  /**
   * List of the configuration status for each recommendation type.
   */
  recommendationsConfiguration?: RecommendationConfigurationProperties[];

  /**
   * Unmasked IP address logging status
   */
  unmaskedIpLoggingStatus?: UnmaskedIpLoggingStatus = UnmaskedIpLoggingStatus.Disabled;

  /**
   * List of additional workspaces
   */
  additionalWorkspaces?: AdditionalWorkspacesProperties[];
}

/**
 * Properties of the IoT Security solution's user defined resources.
 */
model UserDefinedResourcesProperties {
  /**
   * Azure Resource Graph query which represents the security solution's user defined resources. Required to start with "where type != "Microsoft.Devices/IotHubs""
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  query: string | null;

  /**
   * List of Azure subscription ids on which the user defined resources query should be executed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  querySubscriptions: UserDefinedResourcesPropertiesConstrainedString[] | null;
}

@pattern("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$")
scalar UserDefinedResourcesPropertiesConstrainedString extends string;
/**
 * The type of IoT Security recommendation.
 */
model RecommendationConfigurationProperties {
  /**
   * The type of IoT Security recommendation.
   */
  recommendationType: RecommendationType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Recommendation status. When the recommendation status is disabled recommendations are not generated.
   */
  status: RecommendationConfigStatus = RecommendationConfigStatus.Enabled;
}

/**
 * Properties of the additional workspaces.
 */
model AdditionalWorkspacesProperties {
  /**
   * Workspace resource id
   */
  workspace?: string;

  /**
   * Workspace type.
   */
  type?: AdditionalWorkspaceType = AdditionalWorkspaceType.Sentinel;

  /**
   * List of data types sent to workspace
   */
  dataTypes?: AdditionalWorkspaceDataType[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UpdateIotSecuritySolutionData extends TagsResource {
  /**
   * Security Solution data
   */
  properties?: UpdateIoTSecuritySolutionProperties;
}

/**
 * Update Security Solution setting data
 */
model UpdateIoTSecuritySolutionProperties {
  /**
   * Properties of the IoT Security solution's user defined resources.
   */
  userDefinedResources?: UserDefinedResourcesProperties;

  /**
   * List of the configuration status for each recommendation type.
   */
  recommendationsConfiguration?: RecommendationConfigurationProperties[];
}

/**
 * Outbound connection to an ip that isn't allowed. Allow list consists of ipv4 or ipv6 range in CIDR notation.
 */
model ConnectionToIpNotAllowed extends AllowlistCustomAlertRule {}

/**
 * Inbound connection from an ip that isn't allowed. Allow list consists of ipv4 or ipv6 range in CIDR notation.
 */
model ConnectionFromIpNotAllowed extends AllowlistCustomAlertRule {}

/**
 * Login by a local user that isn't allowed. Allow list consists of login names to allow.
 */
model LocalUserNotAllowed extends AllowlistCustomAlertRule {}

/**
 * Execution of a process that isn't allowed. Allow list consists of process names to allow.
 */
model ProcessNotAllowed extends AllowlistCustomAlertRule {}

/**
 * Number of active connections is not in allowed range.
 */
model ActiveConnectionsNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "ActiveConnectionsNotInAllowedRange";
}

/**
 * Number of cloud to device messages (AMQP protocol) is not in allowed range.
 */
model AmqpC2DMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "AmqpC2DMessagesNotInAllowedRange";
}

/**
 * Number of cloud to device messages (MQTT protocol) is not in allowed range.
 */
model MqttC2DMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "MqttC2DMessagesNotInAllowedRange";
}

/**
 * Number of cloud to device messages (HTTP protocol) is not in allowed range.
 */
model HttpC2DMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "HttpC2DMessagesNotInAllowedRange";
}

/**
 * Number of rejected cloud to device messages (AMQP protocol) is not in allowed range.
 */
model AmqpC2DRejectedMessagesNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "AmqpC2DRejectedMessagesNotInAllowedRange";
}

/**
 * Number of rejected cloud to device messages (MQTT protocol) is not in allowed range.
 */
model MqttC2DRejectedMessagesNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "MqttC2DRejectedMessagesNotInAllowedRange";
}

/**
 * Number of rejected cloud to device messages (HTTP protocol) is not in allowed range.
 */
model HttpC2DRejectedMessagesNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "HttpC2DRejectedMessagesNotInAllowedRange";
}

/**
 * Number of device to cloud messages (AMQP protocol) is not in allowed range.
 */
model AmqpD2CMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "AmqpD2CMessagesNotInAllowedRange";
}

/**
 * Number of device to cloud messages (MQTT protocol) is not in allowed range.
 */
model MqttD2CMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "MqttD2CMessagesNotInAllowedRange";
}

/**
 * Number of device to cloud messages (HTTP protocol) is not in allowed range.
 */
model HttpD2CMessagesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "HttpD2CMessagesNotInAllowedRange";
}

/**
 * Number of direct method invokes is not in allowed range.
 */
model DirectMethodInvokesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "DirectMethodInvokesNotInAllowedRange";
}

/**
 * Number of failed local logins is not in allowed range.
 */
model FailedLocalLoginsNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "FailedLocalLoginsNotInAllowedRange";
}

/**
 * Number of file uploads is not in allowed range.
 */
model FileUploadsNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "FileUploadsNotInAllowedRange";
}

/**
 * Number of device queue purges is not in allowed range.
 */
model QueuePurgesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "QueuePurgesNotInAllowedRange";
}

/**
 * Number of twin updates is not in allowed range.
 */
model TwinUpdatesNotInAllowedRange extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "TwinUpdatesNotInAllowedRange";
}

/**
 * Number of unauthorized operations is not in allowed range.
 */
model UnauthorizedOperationsNotInAllowedRange
  extends TimeWindowCustomAlertRule {
  /**
   * The type of the custom alert rule.
   */
  ruleType: "UnauthorizedOperationsNotInAllowedRange";
}
