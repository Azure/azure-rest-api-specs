import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * The configuration to set whether network access from public internet to the endpoints are allowed.
 */
union KnownPublicNetworkAccessOptions {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * SecuredByPerimeter
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * The resource provisioning state. This property is READ-ONLY.
 */
union KnownDataCollectionEndpointProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The resource provisioning state in this location.
 */
union KnownLocationSpecProvisioningStatus {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The kind of the resource.
 */
union KnownDataCollectionEndpointResourceKind {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
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
 * The resource provisioning state.
 */
union KnownDataCollectionRuleAssociationProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The type of lookup to perform on the blob
 */
union KnownStorageBlobLookupType {
  string,

  /**
   * String
   */
  String: "String",

  /**
   * Cidr
   */
  Cidr: "Cidr",
}

/**
 * The name of the setting.
 * Must be part of the list of supported settings
 */
union KnownAgentSettingName {
  string,

  /**
   * MaxDiskQuotaInMB
   */
  MaxDiskQuotaInMB: "MaxDiskQuotaInMB",

  /**
   * UseTimeReceivedForForwardedEvents
   */
  UseTimeReceivedForForwardedEvents: "UseTimeReceivedForForwardedEvents",

  /**
   * Tags
   */
  Tags: "Tags",
}

/**
 * The type of the column data.
 */
union KnownColumnDefinitionType {
  string,

  /**
   * string
   */
  string: "string",

  /**
   * int
   */
  int: "int",

  /**
   * long
   */
  long: "long",

  /**
   * real
   */
  real: "real",

  /**
   * boolean
   */
  boolean: "boolean",

  /**
   * datetime
   */
  datetime: "datetime",

  /**
   * dynamic
   */
  dynamic: "dynamic",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownPerfCounterDataSourceStreams {
  string,

  /**
   * Microsoft-Perf
   */
  `Microsoft-Perf`: "Microsoft-Perf",

  /**
   * Microsoft-InsightsMetrics
   */
  `Microsoft-InsightsMetrics`: "Microsoft-InsightsMetrics",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownPerformanceCountersOTelDataSourceStreams {
  string,

  /**
   * Microsoft-OtelPerfMetrics
   */
  `Microsoft-OtelPerfMetrics`: "Microsoft-OtelPerfMetrics",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownWindowsEventLogDataSourceStreams {
  string,

  /**
   * Microsoft-WindowsEvent
   */
  `Microsoft-WindowsEvent`: "Microsoft-WindowsEvent",

  /**
   * Microsoft-Event
   */
  `Microsoft-Event`: "Microsoft-Event",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownSyslogDataSourceStreams {
  string,

  /**
   * Microsoft-Syslog
   */
  `Microsoft-Syslog`: "Microsoft-Syslog",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownSyslogDataSourceFacilityNames {
  string,

  /**
   * *
   */
  Asterisk: "*",

  /**
   * alert
   */
  alert: "alert",

  /**
   * audit
   */
  audit: "audit",

  /**
   * auth
   */
  auth: "auth",

  /**
   * authpriv
   */
  authpriv: "authpriv",

  /**
   * clock
   */
  clock: "clock",

  /**
   * cron
   */
  cron: "cron",

  /**
   * daemon
   */
  daemon: "daemon",

  /**
   * ftp
   */
  ftp: "ftp",

  /**
   * kern
   */
  kern: "kern",

  /**
   * local0
   */
  local0: "local0",

  /**
   * local1
   */
  local1: "local1",

  /**
   * local2
   */
  local2: "local2",

  /**
   * local3
   */
  local3: "local3",

  /**
   * local4
   */
  local4: "local4",

  /**
   * local5
   */
  local5: "local5",

  /**
   * local6
   */
  local6: "local6",

  /**
   * local7
   */
  local7: "local7",

  /**
   * lpr
   */
  lpr: "lpr",

  /**
   * mail
   */
  mail: "mail",

  /**
   * mark
   */
  mark: "mark",

  /**
   * news
   */
  news: "news",

  /**
   * nopri
   */
  nopri: "nopri",

  /**
   * ntp
   */
  ntp: "ntp",

  /**
   * syslog
   */
  syslog: "syslog",

  /**
   * user
   */
  user: "user",

  /**
   * uucp
   */
  uucp: "uucp",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownSyslogDataSourceLogLevels {
  string,

  /**
   * Debug
   */
  Debug: "Debug",

  /**
   * Info
   */
  Info: "Info",

  /**
   * Notice
   */
  Notice: "Notice",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Alert
   */
  Alert: "Alert",

  /**
   * Emergency
   */
  Emergency: "Emergency",

  /**
   * *
   */
  Asterisk: "*",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownExtensionDataSourceStreams {
  string,

  /**
   * Microsoft-Event
   */
  `Microsoft-Event`: "Microsoft-Event",

  /**
   * Microsoft-InsightsMetrics
   */
  `Microsoft-InsightsMetrics`: "Microsoft-InsightsMetrics",

  /**
   * Microsoft-Perf
   */
  `Microsoft-Perf`: "Microsoft-Perf",

  /**
   * Microsoft-Syslog
   */
  `Microsoft-Syslog`: "Microsoft-Syslog",

  /**
   * Microsoft-WindowsEvent
   */
  `Microsoft-WindowsEvent`: "Microsoft-WindowsEvent",
}

/**
 * The data format of the log files
 */
union KnownLogFilesDataSourceFormat {
  string,

  /**
   * json
   */
  json: "json",

  /**
   * text
   */
  text: "text",
}

/**
 * One of the supported timestamp formats
 */
union KnownLogFileTextSettingsRecordStartTimestampFormat {
  string,

  /**
   * ISO 8601
   */
  `ISO 8601`: "ISO 8601",

  /**
   * YYYY-MM-DD HH:MM:SS
   */
  `YYYY-MM-DD HH:MM:SS`: "YYYY-MM-DD HH:MM:SS",

  /**
   * M/D/YYYY HH:MM:SS AM/PM
   */
  `M/D/YYYY HH:MM:SS AM/PM`: "M/D/YYYY HH:MM:SS AM/PM",

  /**
   * Mon DD, YYYY HH:MM:SS
   */
  `Mon DD, YYYY HH:MM:SS`: "Mon DD, YYYY HH:MM:SS",

  /**
   * yyMMdd HH:mm:ss
   */
  `yyMMdd HH:mm:ss`: "yyMMdd HH:mm:ss",

  /**
   * ddMMyy HH:mm:ss
   */
  `ddMMyy HH:mm:ss`: "ddMMyy HH:mm:ss",

  /**
   * MMM d hh:mm:ss
   */
  `MMM d hh:mm:ss`: "MMM d hh:mm:ss",

  /**
   * dd/MMM/yyyy:HH:mm:ss zzz
   */
  `dd/MMM/yyyy:HH:mm:ss zzz`: "dd/MMM/yyyy:HH:mm:ss zzz",

  /**
   * yyyy-MM-ddTHH:mm:ssK
   */
  `yyyy-MM-ddTHH:mm:ssK`: "yyyy-MM-ddTHH:mm:ssK",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownWindowsFirewallLogsDataSourceProfileFilter {
  string,

  /**
   * Domain
   */
  Domain: "Domain",

  /**
   * Private
   */
  Private: "Private",

  /**
   * Public
   */
  Public: "Public",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownPrometheusForwarderDataSourceStreams {
  string,

  /**
   * Microsoft-PrometheusMetrics
   */
  `Microsoft-PrometheusMetrics`: "Microsoft-PrometheusMetrics",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownOtelLogsDataSourceStreams {
  string,

  /**
   * Microsoft-OTel-Logs
   */
  `Microsoft-OTel-Logs`: "Microsoft-OTel-Logs",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownOtelTracesDataSourceStreams {
  string,

  /**
   * Microsoft-OTel-Traces-Spans
   */
  `Microsoft-OTel-Traces-Spans`: "Microsoft-OTel-Traces-Spans",

  /**
   * Microsoft-OTel-Traces-Events
   */
  `Microsoft-OTel-Traces-Events`: "Microsoft-OTel-Traces-Events",

  /**
   * Microsoft-OTel-Traces-Resources
   */
  `Microsoft-OTel-Traces-Resources`: "Microsoft-OTel-Traces-Resources",
}

/**
 * Provider type specification: By Manifest GUID or by Event Source name
 */
union KnownEtwProviderType {
  string,

  /**
   * EventSource
   */
  EventSource: "EventSource",

  /**
   * Manifest
   */
  Manifest: "Manifest",
}

/**
 * Minimal level of detail to be logged
 */
union KnownEtwProviderDataSourceLogLevel {
  string,

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Informational
   */
  Informational: "Informational",

  /**
   * Verbose
   */
  Verbose: "Verbose",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownOtelLogsDirectDataSourceStreams {
  string,

  /**
   * Microsoft-OTel-Logs
   */
  `Microsoft-OTel-Logs`: "Microsoft-OTel-Logs",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownOtelTracesDirectDataSourceStreams {
  string,

  /**
   * Microsoft-OTel-Traces-Spans
   */
  `Microsoft-OTel-Traces-Spans`: "Microsoft-OTel-Traces-Spans",

  /**
   * Microsoft-OTel-Traces-Events
   */
  `Microsoft-OTel-Traces-Events`: "Microsoft-OTel-Traces-Events",

  /**
   * Microsoft-OTel-Traces-Resources
   */
  `Microsoft-OTel-Traces-Resources`: "Microsoft-OTel-Traces-Resources",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union KnownDataFlowStreams {
  string,

  /**
   * Microsoft-Event
   */
  `Microsoft-Event`: "Microsoft-Event",

  /**
   * Microsoft-InsightsMetrics
   */
  `Microsoft-InsightsMetrics`: "Microsoft-InsightsMetrics",

  /**
   * Microsoft-Perf
   */
  `Microsoft-Perf`: "Microsoft-Perf",

  /**
   * Microsoft-Syslog
   */
  `Microsoft-Syslog`: "Microsoft-Syslog",

  /**
   * Microsoft-WindowsEvent
   */
  `Microsoft-WindowsEvent`: "Microsoft-WindowsEvent",
}

/**
 * The resource provisioning state.
 */
union KnownDataCollectionRuleProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The kind of the resource.
 */
union KnownDataCollectionRuleResourceKind {
  string,

  /**
   * Linux
   */
  Linux: "Linux",

  /**
   * Windows
   */
  Windows: "Windows",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union IdentityType {
  string,

  /**
   * none
   */
  none: "none",

  /**
   * systemAssigned
   */
  systemAssigned: "systemAssigned",

  /**
   * userAssigned
   */
  userAssigned: "userAssigned",

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointResourceProperties extends DataCollectionEndpoint {}

/**
 * Definition of data collection endpoint.
 */
model DataCollectionEndpoint {
  /**
   * Description of the data collection endpoint.
   */
  description?: string;

  /**
   * The immutable ID of this data collection endpoint resource. This property is READ-ONLY.
   */
  immutableId?: string;

  /**
   * The endpoint used by clients to access their configuration.
   */
  configurationAccess?: DataCollectionEndpointConfigurationAccess;

  /**
   * The endpoint used by clients to ingest logs.
   */
  logsIngestion?: DataCollectionEndpointLogsIngestion;

  /**
   * The endpoint used by clients to ingest metrics.
   */
  metricsIngestion?: DataCollectionEndpointMetricsIngestion;

  /**
   * Network access control rules for the endpoints.
   */
  networkAcls?: DataCollectionEndpointNetworkAcls;

  /**
   * The resource provisioning state. This property is READ-ONLY.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KnownDataCollectionEndpointProvisioningState;

  /**
   * List of Azure Monitor Private Link Scope Resources to which this data collection endpoint resource is associated. This property is READ-ONLY.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  /**
   * Metadata for the resource. This property can only be updated by Log Analytics Control Plane for Data Collection Endpoint with Log Analytics Destination.
   */
  @visibility(Lifecycle.Read)
  failoverConfiguration?: DataCollectionEndpointFailoverConfiguration;

  /**
   * Metadata for the resource. This property can only be updated by Log Analytics Control Plane for Data Collection Endpoint with Log Analytics Destination.
   */
  @visibility(Lifecycle.Read)
  metadata?: DataCollectionEndpointMetadata;
}

/**
 * The endpoint used by clients to access their configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointConfigurationAccess
  extends ConfigurationAccessEndpointSpec {}

/**
 * Definition of the endpoint used for accessing configuration.
 */
model ConfigurationAccessEndpointSpec {
  /**
   * The endpoint. This property is READ-ONLY.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * The endpoint used by clients to ingest logs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointLogsIngestion extends LogsIngestionEndpointSpec {}

/**
 * Definition of the endpoint used for ingesting logs.
 */
model LogsIngestionEndpointSpec {
  /**
   * The endpoint. This property is READ-ONLY.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * The endpoint used by clients to ingest metrics.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointMetricsIngestion
  extends MetricsIngestionEndpointSpec {}

/**
 * Definition of the endpoint used for ingesting metrics.
 */
model MetricsIngestionEndpointSpec {
  /**
   * The endpoint. This property is READ-ONLY.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * Network access control rules for the endpoints.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointNetworkAcls extends NetworkRuleSet {}

/**
 * Definition of the network rules.
 */
model NetworkRuleSet {
  /**
   * The configuration to set whether network access from public internet to the endpoints are allowed.
   */
  publicNetworkAccess?: KnownPublicNetworkAccessOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkScopedResource {
  /**
   * The resourceId of the Azure Monitor Private Link Scope Scoped Resource through which this DCE is associated with a Azure Monitor Private Link Scope.
   */
  resourceId?: string;

  /**
   * The immutableId of the Azure Monitor Private Link Scope Resource to which the association is.
   */
  scopeId?: string;
}

/**
 * Metadata for the resource. This property can only be updated by Log Analytics Control Plane for Data Collection Endpoint with Log Analytics Destination.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointFailoverConfiguration
  extends FailoverConfigurationSpec {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model FailoverConfigurationSpec {
  /**
   * Active location where data flow will occur.
   */
  activeLocation?: string;

  /**
   * Locations that are configured for failover.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  locations?: LocationSpec[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LocationSpec {
  /**
   * Name of location.
   */
  location?: string;

  /**
   * The resource provisioning state in this location.
   */
  provisioningStatus?: KnownLocationSpecProvisioningStatus;
}

/**
 * Metadata for the resource. This property can only be updated by Log Analytics Control Plane for Data Collection Endpoint with Log Analytics Destination.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointMetadata extends Metadata {}

/**
 * Metadata about the resource
 */
model Metadata {
  /**
   * Azure offering managing this resource on-behalf-of customer.
   */
  @visibility(Lifecycle.Read)
  provisionedBy?: string;

  /**
   * Resource Id of azure offering managing this resource on-behalf-of customer.
   */
  @visibility(Lifecycle.Read)
  provisionedByResourceId?: string;

  /**
   * Immutable Id of azure offering managing this resource on-behalf-of customer.
   */
  @visibility(Lifecycle.Read)
  provisionedByImmutableId?: string;
}

/**
 * The SKU of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointResourceSku
  extends Azure.ResourceManager.CommonTypes.Sku {}

/**
 * Managed service identity of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointResourceIdentity
  extends Azure.ResourceManager.CommonTypes.ManagedServiceIdentity {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionEndpointResourceSystemData extends SystemData {}

/**
 * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
 */
@error
model ErrorResponseCommonV2 {
  /**
   * The error object.
   */
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Definition of ARM tracked top level resource properties for update operation.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceForUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Managed Service Identity.
   */
  identity?: ResourceForUpdateIdentity;
}

/**
 * Managed Service Identity.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceForUpdateIdentity
  extends Azure.ResourceManager.CommonTypes.ManagedServiceIdentity {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleAssociationProxyOnlyResourceProperties
  extends DataCollectionRuleAssociation {}

/**
 * Definition of association of a data collection rule with a monitored Azure resource.
 */
model DataCollectionRuleAssociation {
  /**
   * Description of the association.
   */
  description?: string;

  /**
   * The resource ID of the data collection rule that is to be associated.
   */
  dataCollectionRuleId?: string;

  /**
   * The resource ID of the data collection endpoint that is to be associated.
   */
  dataCollectionEndpointId?: string;

  /**
   * The resource provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KnownDataCollectionRuleAssociationProvisioningState;

  /**
   * Metadata about the resource
   */
  @visibility(Lifecycle.Read)
  metadata?: DataCollectionRuleAssociationMetadata;
}

/**
 * Metadata about the resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleAssociationMetadata extends Metadata {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleAssociationProxyOnlyResourceSystemData
  extends SystemData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleResourceProperties extends DataCollectionRule {}

/**
 * Definition of what monitoring data to collect and where that data should be sent.
 */
model DataCollectionRule {
  /**
   * Description of the data collection rule.
   */
  description?: string;

  /**
   * The immutable ID of this data collection rule. This property is READ-ONLY.
   */
  @visibility(Lifecycle.Read)
  immutableId?: string;

  /**
   * The resource ID of the data collection endpoint that this rule can be used with.
   */
  dataCollectionEndpointId?: string;

  /**
   * Metadata about the resource
   */
  @visibility(Lifecycle.Read)
  metadata?: DataCollectionRuleMetadata;

  /**
   * Defines the ingestion endpoints to send data to via this rule.
   */
  @visibility(Lifecycle.Read)
  endpoints?: DataCollectionRuleEndpoints;

  /**
   * Defines all the references that may be used in other sections of the DCR
   */
  references?: DataCollectionRuleReferences;

  /**
   * Agent settings used to modify agent behavior on a given host
   */
  agentSettings?: DataCollectionRuleAgentSettings;

  /**
   * Declaration of custom streams used in this rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  streamDeclarations?: Record<StreamDeclaration>;

  /**
   * The specification of data sources.
   *  This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.
   */
  dataSources?: DataCollectionRuleDataSources;

  /**
   * The specification of direct data sources.
   *  This property is optional and can be omitted.
   */
  directDataSources?: DataCollectionRuleDirectDataSources;

  /**
   * The specification of destinations.
   */
  destinations?: DataCollectionRuleDestinations;

  /**
   * The specification of data flows.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  dataFlows?: DataFlow[];

  /**
   * The specification for ingestion limits
   */
  @visibility(Lifecycle.Read)
  ingestionQuotas?: DataCollectionRuleIngestionQuotas;

  /**
   * The resource provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KnownDataCollectionRuleProvisioningState;
}

/**
 * Metadata about the resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleMetadata extends Metadata {}

/**
 * Defines the ingestion endpoints to send data to via this rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleEndpoints extends EndpointsSpec {}

/**
 * This defines all the ingestion endpoints that can be used by this rule
 */
model EndpointsSpec {
  /**
   * The ingestion endpoint for logs
   */
  @visibility(Lifecycle.Read)
  logsIngestion?: string;

  /**
   * The ingestion endpoint for metrics
   */
  @visibility(Lifecycle.Read)
  metricsIngestion?: string;
}

/**
 * Defines all the references that may be used in other sections of the DCR
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleReferences extends ReferencesSpec {}

/**
 * This section defines all the references that may be used in other sections of the DCR
 */
model ReferencesSpec {
  /**
   * All the enrichment data sources referenced in data flows
   */
  enrichmentData?: ReferencesSpecEnrichmentData;

  /**
   * Application Insights references to be used on OTel metrics/logs enrichment
   */
  applicationInsights?: ApplicationInsights[];
}

/**
 * All the enrichment data sources referenced in data flows
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReferencesSpecEnrichmentData extends EnrichmentData {}

/**
 * All the enrichment data sources referenced in data flows
 */
model EnrichmentData {
  /**
   * All the storage blobs used as enrichment data sources
   */
  storageBlobs?: StorageBlob[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageBlob {
  /**
   * Resource Id of the storage account that hosts the blob
   */
  resourceId?: string;

  /**
   * Url of the storage blob
   */
  blobUrl?: string;

  /**
   * The type of lookup to perform on the blob
   */
  lookupType?: KnownStorageBlobLookupType;

  /**
   * The name of the enrichment data source used as an alias when referencing this data source in data flows
   */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationInsights {
  /**
   * Id of the application insights resource
   */
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The name of the reference used as an alias when referencing this application insights in Otel data sources
   */
  name: string;
}

/**
 * Agent settings used to modify agent behavior on a given host
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleAgentSettings extends AgentSettingsSpec {}

/**
 * An agent setting
 */
model AgentSettingsSpec {
  /**
   * All the settings that are applicable to the logs agent (AMA)
   */
  logs?: AgentSetting[];
}

/**
 * A setting used to control an agent behavior on a host machine
 */
model AgentSetting {
  /**
   * The name of the setting.
   * Must be part of the list of supported settings
   */
  name?: KnownAgentSettingName;

  /**
   * The value of the setting
   */
  value?: string;
}

/**
 * Declaration of a custom stream.
 */
model StreamDeclaration {
  /**
   * List of columns used by data in this stream.
   */
  columns?: ColumnDefinition[];
}

/**
 * Definition of custom data column.
 */
model ColumnDefinition {
  /**
   * The name of the column.
   */
  name?: string;

  /**
   * The type of the column data.
   */
  type?: KnownColumnDefinitionType;
}

/**
 * The specification of data sources.
 *  This property is optional and can be omitted if the rule is meant to be used via direct calls to the provisioned endpoint.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleDataSources extends DataSourcesSpec {}

/**
 * Specification of data sources that will be collected.
 */
model DataSourcesSpec {
  /**
   * The list of performance counter data source configurations.
   */
  performanceCounters?: PerfCounterDataSource[];

  /**
   * The list of Open Telemetry performance counter data source configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  performanceCountersOTel?: PerformanceCountersOTelDataSource[];

  /**
   * The list of Windows Event Log data source configurations.
   */
  windowsEventLogs?: WindowsEventLogDataSource[];

  /**
   * The list of Syslog data source configurations.
   */
  syslog?: SyslogDataSource[];

  /**
   * The list of Azure VM extension data source configurations.
   */
  extensions?: ExtensionDataSource[];

  /**
   * The list of Log files source configurations.
   */
  logFiles?: LogFilesDataSource[];

  /**
   * The list of IIS logs source configurations.
   */
  iisLogs?: IisLogsDataSource[];

  /**
   * The list of Windows Firewall logs source configurations.
   */
  windowsFirewallLogs?: WindowsFirewallLogsDataSource[];

  /**
   * The list of Prometheus forwarder data source configurations.
   */
  prometheusForwarder?: PrometheusForwarderDataSource[];

  /**
   * The list of platform telemetry configurations
   */
  platformTelemetry?: PlatformTelemetryDataSource[];

  /**
   * Specifications of pull based data sources
   */
  dataImports?: DataSourcesSpecDataImports;

  /**
   * The list of Otel Logs data source configurations.
   */
  otelLogs?: OtelLogsDataSource[];

  /**
   * The list of Otel traces data source configurations.
   */
  otelTraces?: OtelTracesDataSource[];

  /**
   * The list of OTel metrics data source configurations.
   */
  otelMetrics?: OtelMetricsDataSource[];

  /**
   * The list of ETW providers data source configurations.
   */
  etwProviders?: EtwProviderDataSource[];
}

/**
 * Definition of which performance counters will be collected and how they will be collected by this data collection rule.
 * Collected from both Windows and Linux machines where the counter is present.
 */
model PerfCounterDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownPerfCounterDataSourceStreams[];

  /**
   * The number of seconds between consecutive counter measurements (samples).
   */
  samplingFrequencyInSeconds?: int32;

  /**
   * A list of specifier names of the performance counters you want to collect.
   * Use a wildcard (*) to collect a counter for all instances.
   * To get a list of performance counters on Windows, run the command 'typeperf'.
   */
  counterSpecifiers?: string[];

  /**
   * The KQL query to transform the data source. This is a deprecated property and will be removed in future versions.
   */
  transformKql?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which Open Telemetry performance counters will be collected and how they will be collected by this data collection rule.
 * Collected from both Windows and Linux machines where the counter is present.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PerformanceCountersOTelDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownPerformanceCountersOTelDataSourceStreams[];

  /**
   * The number of seconds between consecutive counter measurements (samples).
   */
  samplingFrequencyInSeconds?: int32;

  /**
   * A list of specifier names of the performance counters you want to collect.
   */
  counterSpecifiers?: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which Windows Event Log events will be collected and how they will be collected.
 * Only collected from Windows machines.
 */
model WindowsEventLogDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownWindowsEventLogDataSourceStreams[];

  /**
   * A list of Windows Event Log queries in XPATH format.
   */
  xPathQueries?: string[];

  /**
   * The KQL query to transform the data source. This is a deprecated property and will be removed in future versions.
   */
  transformKql?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which syslog data will be collected and how it will be collected.
 * Only collected from Linux machines.
 */
model SyslogDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownSyslogDataSourceStreams[];

  /**
   * The list of facility names.
   */
  facilityNames?: KnownSyslogDataSourceFacilityNames[];

  /**
   * The log levels to collect.
   */
  logLevels?: KnownSyslogDataSourceLogLevels[];

  /**
   * The KQL query to transform the data source. This is a deprecated property and will be removed in future versions.
   */
  transformKql?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which data will be collected from a separate VM extension that integrates with the Azure Monitor Agent.
 * Collected from either Windows and Linux machines, depending on which extension is defined.
 */
model ExtensionDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams?: KnownExtensionDataSourceStreams[];

  /**
   * The name of the VM extension.
   */
  extensionName: string;

  /**
   * The extension settings. The format is specific for particular extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extensionSettings?: unknown;

  /**
   * The list of data sources this extension needs data from.
   */
  inputDataSources?: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which custom log files will be collected by this data collection rule
 */
model LogFilesDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data source
   */
  streams: string[];

  /**
   * File Patterns where the log files are located
   */
  filePatterns: string[];

  /**
   * The data format of the log files
   */
  format: KnownLogFilesDataSourceFormat;

  /**
   * The log files specific settings.
   */
  settings?: LogFilesDataSourceSettings;

  /**
   * The KQL query to transform the data source. This is a deprecated property and will be removed in future versions.
   */
  transformKql?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * The log files specific settings.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogFilesDataSourceSettings extends LogFileSettings {}

/**
 * Settings for different log file formats
 */
model LogFileSettings {
  /**
   * Text settings
   */
  text?: LogFileSettingsText;
}

/**
 * Text settings
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogFileSettingsText extends LogFileTextSettings {}

/**
 * Settings for text log files
 */
model LogFileTextSettings {
  /**
   * One of the supported timestamp formats
   */
  recordStartTimestampFormat: KnownLogFileTextSettingsRecordStartTimestampFormat;
}

/**
 * Enables IIS logs to be collected by this data collection rule.
 */
model IisLogsDataSource {
  /**
   * IIS streams
   */
  streams: string[];

  /**
   * Absolute paths file location
   */
  logDirectories?: string[];

  /**
   * The KQL query to transform the data source. This is a deprecated property and will be removed in future versions.
   */
  transformKql?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Enables Firewall logs to be collected by this data collection rule.
 */
model WindowsFirewallLogsDataSource {
  /**
   * Firewall logs streams
   */
  streams: string[];

  /**
   * Firewall logs profile filter
   */
  profileFilter?: KnownWindowsFirewallLogsDataSourceProfileFilter[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of Prometheus metrics forwarding configuration.
 */
model PrometheusForwarderDataSource {
  /**
   * List of streams that this data source will be sent to.
   */
  streams?: KnownPrometheusForwarderDataSourceStreams[];

  /**
   * The list of label inclusion filters in the form of label "name-value" pairs.
   * Currently only one label is supported: 'microsoft_metrics_include_label'.
   * Label values are matched case-insensitively.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  labelIncludeFilter?: Record<string>;

  /**
   * Custom VM Scrape Config that defines scrape jobs
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customVMScrapeConfig?: unknown[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of platform telemetry data source configuration
 */
model PlatformTelemetryDataSource {
  /**
   * List of platform telemetry streams to collect
   */
  streams: string[];

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Specifications of pull based data sources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataSourcesSpecDataImports extends DataImportSources {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataImportSources {
  /**
   * Definition of Event Hub configuration.
   */
  eventHub?: DataImportSourcesEventHub;
}

/**
 * Definition of Event Hub configuration.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataImportSourcesEventHub extends EventHubDataSource {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventHubDataSource {
  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;

  /**
   * Event Hub consumer group name
   */
  consumerGroup?: string;

  /**
   * The stream to collect from EventHub
   */
  stream?: string;
}

/**
 * Enables Otel logs to be collected by this data collection rule.
 */
model OtelLogsDataSource {
  /**
   * List of streams that this data source will be sent to.
   */
  streams: KnownOtelLogsDataSourceStreams[];

  /**
   * Specifies the routing policy based on OTLP payload resource attributes to route subset of the payload according to matching resource attribute.
   */
  resourceAttributeRouting?: OtelLogsDataSourceResourceAttributeRouting;

  /**
   * Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.
   */
  enrichWithResourceAttributes?: string[];

  /**
   * Specifies the reference alias to enrich the telemetry signal with.
   */
  enrichWithReference?: string;

  /**
   * Specifies whether to replace the default resourceId in the log record with the resourceId of the referenced resource being used for enrichment.
   */
  replaceResourceIdWithReference?: boolean;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Specifies the routing policy based on OTLP payload resource attributes to route subset of the payload according to matching resource attribute.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OtelLogsDataSourceResourceAttributeRouting
  extends OtelDataSourceResourceAttributeRouting {}

/**
 * Enables OTLP (logs, traces, and metrics) payload routing
 */
model OtelDataSourceResourceAttributeRouting {
  /**
   * The name of the resource attribute to match.
   */
  attributeName?: string;

  /**
   * The value of the resource attribute to match.
   */
  attributeValue?: string;
}

/**
 * Enables Otel Traces to be collected by this data collection rule.
 */
model OtelTracesDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams: KnownOtelTracesDataSourceStreams[];

  /**
   * Specifies the routing policy based on OTLP payload resource attributes to route subset of the payload according to matching resource attribute.
   */
  resourceAttributeRouting?: OtelTracesDataSourceResourceAttributeRouting;

  /**
   * Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.
   */
  enrichWithResourceAttributes?: string[];

  /**
   * Specifies the reference to enrich the telemetry signal with.
   */
  enrichWithReference?: string;

  /**
   * Specifies whether to replace the default resourceId in the log record with the resourceId of the referenced resource being used for enrichment.
   */
  replaceResourceIdWithReference?: boolean;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Specifies the routing policy based on OTLP payload resource attributes to route subset of the payload according to matching resource attribute.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OtelTracesDataSourceResourceAttributeRouting
  extends OtelDataSourceResourceAttributeRouting {}

/**
 * Definition of OTel metrics configuration.
 */
model OtelMetricsDataSource {
  /**
   * List of streams that this data source will be sent to.
   */
  streams: string[];

  /**
   * Specifies the routing policy based on OTLP payload resource attributes to route subset of the payload according to matching resource attribute.
   */
  resourceAttributeRouting?: OtelMetricsDataSourceResourceAttributeRouting;

  /**
   * Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.
   */
  enrichWithResourceAttributes?: string[];

  /**
   * Specifies the reference to enrich the telemetry signal with.
   */
  enrichWithReference?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Specifies the routing policy based on OTLP payload resource attributes to route subset of the payload according to matching resource attribute.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OtelMetricsDataSourceResourceAttributeRouting
  extends OtelDataSourceResourceAttributeRouting {}

/**
 * Enables an ETW provider logs to be collected by this data collection rule.
 */
model EtwProviderDataSource {
  /**
   * List of streams that this data source will be sent to
   */
  streams: string[];

  /**
   * The provider GUID or class name for event source
   */
  provider: string;

  /**
   * Provider type specification: By Manifest GUID or by Event Source name
   */
  providerType: KnownEtwProviderType;

  /**
   * Minimal level of detail to be logged
   */
  logLevel?: KnownEtwProviderDataSourceLogLevel;

  /**
   * Events Ids to collect
   */
  eventIds?: string[];

  /**
   * Event's membership in a set of event categories
   */
  keyword?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * The specification of direct data sources.
 *  This property is optional and can be omitted.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleDirectDataSources extends DirectDataSourcesSpec {}

/**
 * Specification of direct data sources that will be collected.
 */
model DirectDataSourcesSpec {
  /**
   * The list of OTel metrics data source configurations.
   */
  otelMetrics?: OtelMetricsDirectDataSource[];

  /**
   * The list of OTel logs data source configurations.
   */
  otelLogs?: OtelLogsDirectDataSource[];

  /**
   * The list of OTel traces data source configurations.
   */
  otelTraces?: OtelTracesDirectDataSource[];
}

/**
 * Definition of OTel metrics configuration.
 */
model OtelMetricsDirectDataSource {
  /**
   * List of streams that this data source will be sent to.
   */
  streams: string[];

  /**
   * Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.
   */
  enrichWithResourceAttributes?: string[];

  /**
   * Specifies the reference to enrich the telemetry signal with.
   */
  enrichWithReference?: string;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OtelLogsDirectDataSource {
  /**
   * List of streams that this data source will be sent to.
   */
  streams: KnownOtelLogsDirectDataSourceStreams[];

  /**
   * Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.
   */
  enrichWithResourceAttributes?: string[];

  /**
   * Specifies the reference to enrich the telemetry signal with.
   */
  enrichWithReference?: string;

  /**
   * Specifies whether to replace the default resourceId in the log record with the resourceId of the referenced resource being used for enrichment.
   */
  replaceResourceIdWithReference?: boolean;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Enables Otel Traces to be collected by this data collection rule.
 */
model OtelTracesDirectDataSource {
  /**
   * List of streams that this data source will be sent to.
   * A stream indicates what schema will be used for this data and usually what table in Log Analytics the data will be sent to.
   */
  streams: KnownOtelTracesDirectDataSourceStreams[];

  /**
   * Specifies the list of resource attributes that need to be added as labels/dimensions to the telemetry data for further enrichment.
   */
  enrichWithResourceAttributes?: string[];

  /**
   * Specifies the reference to enrich the telemetry signal with.
   */
  enrichWithReference?: string;

  /**
   * Specifies whether to replace the default resourceId in the log record with the resourceId of the referenced resource being used for enrichment.
   */
  replaceResourceIdWithReference?: boolean;

  /**
   * A friendly name for the data source.
   * This name should be unique across all data sources (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * The specification of destinations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleDestinations extends DestinationsSpec {}

/**
 * Specification of destinations that can be used in data flows.
 */
model DestinationsSpec {
  /**
   * List of Log Analytics destinations.
   */
  logAnalytics?: LogAnalyticsDestination[];

  /**
   * List of monitoring account destinations.
   */
  monitoringAccounts?: MonitoringAccountDestination[];

  /**
   * Azure Monitor Metrics destination.
   */
  azureMonitorMetrics?: DestinationsSpecAzureMonitorMetrics;

  /**
   * List of Event Hubs destinations.
   */
  eventHubs?: EventHubDestination[];

  /**
   * List of Event Hubs Direct destinations.
   */
  eventHubsDirect?: EventHubDirectDestination[];

  /**
   * List of Storage Blob Direct destinations. To be used only for sending data directly to store from the agent.
   */
  storageBlobsDirect?: StorageBlobDestination[];

  /**
   * List of Storage Table Direct destinations.
   */
  storageTablesDirect?: StorageTableDestination[];

  /**
   * List of storage accounts destinations.
   */
  storageAccounts?: StorageBlobDestination[];

  /**
   * List of Microsoft Fabric destinations.
   */
  microsoftFabric?: MicrosoftFabricDestination[];

  /**
   * List of Azure Data Explorer destinations.
   */
  azureDataExplorer?: AdxDestination[];
}

/**
 * Log Analytics destination.
 */
model LogAnalyticsDestination {
  /**
   * The resource ID of the Log Analytics workspace.
   */
  workspaceResourceId?: string;

  /**
   * The Customer ID of the Log Analytics workspace.
   */
  @visibility(Lifecycle.Read)
  workspaceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Monitoring account destination.
 */
model MonitoringAccountDestination {
  /**
   * The resource ID of the monitoring account.
   */
  accountResourceId?: string;

  /**
   * The immutable ID of the account.
   */
  @visibility(Lifecycle.Read)
  accountId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Azure Monitor Metrics destination.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DestinationsSpecAzureMonitorMetrics
  extends AzureMonitorMetricsDestination {}

/**
 * Azure Monitor Metrics destination.
 */
model AzureMonitorMetricsDestination {
  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventHubDestination {
  /**
   * The resource ID of the event hub.
   */
  eventHubResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EventHubDirectDestination {
  /**
   * The resource ID of the event hub.
   */
  eventHubResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageBlobDestination {
  /**
   * The container name of the Storage Blob.
   */
  containerName?: string;

  /**
   * The resource ID of the storage account.
   */
  storageAccountResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model StorageTableDestination {
  /**
   * The name of the Storage Table.
   */
  tableName?: string;

  /**
   * The resource ID of the storage account.
   */
  storageAccountResourceId?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Microsoft Fabric destination (non-Azure).
 */
model MicrosoftFabricDestination {
  /**
   * The tenant id of the Microsoft Fabric resource.
   */
  tenantId?: string;

  /**
   * The artifact id of the Microsoft Fabric resource.
   */
  artifactId?: string;

  /**
   * The name of the database to which data will be ingested.
   */
  databaseName?: string;

  /**
   * The ingestion uri of the Microsoft Fabric resource.
   */
  ingestionUri?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Azure Data Explorer (Adx) destination.
 */
model AdxDestination {
  /**
   * The ARM resource id of the Adx resource.
   */
  resourceId?: string;

  /**
   * The name of the database to which data will be ingested.
   */
  databaseName?: string;

  /**
   * The ingestion uri of the Adx resource.
   */
  @visibility(Lifecycle.Read)
  ingestionUri?: string;

  /**
   * A friendly name for the destination.
   * This name should be unique across all destinations (regardless of type) within the data collection rule.
   */
  name?: string;
}

/**
 * Definition of which streams are sent to which destinations.
 */
model DataFlow {
  /**
   * List of streams for this data flow.
   */
  streams?: KnownDataFlowStreams[];

  /**
   * List of destinations for this data flow.
   */
  destinations?: string[];

  /**
   * The KQL query to transform stream data.
   */
  transformKql?: string;

  /**
   * The output stream of the transform. Only required if the transform changes data to a different stream.
   */
  outputStream?: string;

  /**
   * The builtIn transform to transform stream data
   */
  builtInTransform?: string;

  /**
   * Flag to enable overflow column in LA destinations
   */
  captureOverflow?: boolean;
}

/**
 * The specification for ingestion limits
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleIngestionQuotas extends IngestionQuotas {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IngestionQuotas {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  logs?: IngestionQuotasLogs;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model IngestionQuotasLogs extends LogsQuotaSpec {}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model LogsQuotaSpec {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxSizePerMinuteInGB?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  maxRequestsPerMinute?: string;
}

/**
 * The SKU of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleResourceSku
  extends Azure.ResourceManager.CommonTypes.Sku {}

/**
 * Managed service identity of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleResourceIdentity
  extends Azure.ResourceManager.CommonTypes.ManagedServiceIdentity {}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DataCollectionRuleResourceSystemData extends SystemData {}
