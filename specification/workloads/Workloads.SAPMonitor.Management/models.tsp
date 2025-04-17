using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.Workloads;
/**
 * State of provisioning of the SAP monitor.
 */
union WorkloadMonitorProvisioningState {
  string,

  /** The resource request has been accepted. */
  Accepted: "Accepted",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource creation failed. */
  Failed: "Failed",

  /** The resource creation has succeeded. */
  Succeeded: "Succeeded",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource is being migrated. */
  Migrating: "Migrating",

  /** The resource operation was canceled. */
  Canceled: "Canceled",
}

/**
 * The value which indicates whether this scheduled query rule is enabled. Value should be enabled or disabled
 */
@added(Versions.v2024_02_01_preview)
union AlertRuleStatus {
  string,

  /** The scheduled query rule is enabled */
  Enabled: "Enabled",

  /** The scheduled query rule is disabled */
  Disabled: "Disabled",
}

/**
 * Result Condition Evaluation Criteria
 */
@added(Versions.v2024_02_01_preview)
union ConditionalOperator {
  string,

  /** The value is less than the specified value. */
  LessThan: "LessThan",

  /** The value is greater than the specified value. */
  GreaterThan: "GreaterThan",

  /** The value is equal to the specified value. */
  Equal: "Equal",

  /** The value is greater than or equal to the specified value. */
  GreaterThanOrEqual: "GreaterThanOrEqual",

  /** The value is less than or equal to the specified value. */
  LessThanOrEqual: "LessThanOrEqual",
}

/**
 * The value that indicates whether the alert should be automatically resolved or not. The default is Disable.
 */
@added(Versions.v2024_02_01_preview)
union AlertAutoMitigate {
  string,

  /** The alert should be automatically resolved. */
  Enable: "Enable",

  /** The alert should not be automatically resolved. */
  Disable: "Disable",
}

/**
 * Is input required for Default Threshold Value Associated with the Alert Template
 */
@added(Versions.v2024_02_01_preview)
union DefaultThresholdInputOption {
  string,

  /** The default threshold value is required. */
  Required: "Required",

  /** The default threshold value is not required. */
  NotRequired: "NotRequired",

  /** The default threshold value is optional. */
  Optional: "Optional",
}

/**
 * Metric Trigger Type Associated with the Alert Template for Metric Measurement
 */
@added(Versions.v2024_02_01_preview)
union AlertTemplateMetricTriggerType {
  string,

  /** The metric trigger type is consecutive. */
  Consecutive: "Consecutive",

  /** The metric trigger type is total. */
  Total: "Total",
}

/**
 * Type of the Query Input Parameter
 */
@added(Versions.v2024_02_01_preview)
union AlertTemplateParameterType {
  string,

  /** Log Analytics query parameter */
  LogAnalyticsQuery: "LogAnalyticsQuery",

  /** Provider property parameter */
  ProviderProperty: "ProviderProperty",

  /** Custom input parameter */
  CustomInput: "CustomInput",
}

/**
 * Selection Mode of the Query Input Parameter
 */
@added(Versions.v2024_02_01_preview)
union AlertTemplateSelectionMode {
  string,

  /** The selection mode is single. */
  Single: "Single",

  /** The selection mode is Multiple. */
  Multiple: "Multiple",
}

/**
 * Sets the routing preference of the SAP monitor.
 */
union RoutingPreference {
  string,

  /** Default routing preference. Only RFC1918 traffic is routed to the customer VNET. */
  Default: "Default",

  /** Route all traffic to the customer VNET. */
  RouteAll: "RouteAll",
}

/**
 * The App Service plan tier.
 */
union AppServicePlanTier {
  string,

  /** Elastic Premium plan */
  ElasticPremium: "ElasticPremium",

  /** Dedicated Premium V3 plan */
  PremiumV3: "PremiumV3",
}

/**
 * State of health of the provider instance
 */
union WorkloadProviderInstanceHealthState {
  string,

  /** The resource health status is Healthy */
  Healthy: "Healthy",

  /** The resource health status is Degraded */
  Degraded: "Degraded",

  /** The resource health status is Unavailable */
  Unavailable: "Unavailable",

  /** The resource health status is Unknown */
  Unknown: "Unknown",
}

/**
 * State of provisioning of the SAP monitor.
 */
union SapLandscapeMonitorProvisioningState {
  string,

  /** The resource request has been accepted. */
  Accepted: "Accepted",

  /** The resource has been created. */
  Created: "Created",

  /** The resource operation has failed. */
  Failed: "Failed",

  /** The resource operation has succeeded. */
  Succeeded: "Succeeded",

  /** The resource operation was canceled. */
  Canceled: "Canceled",
}

/**
 * Gets or sets certificate preference if secure communication is enabled.
 */
union SslPreference {
  string,

  /** Secure communication is disabled. */
  Disabled: "Disabled",

  /** Secure communication is enabled with root certificate. */
  RootCertificate: "RootCertificate",

  /** Secure communication is enabled with server certificate. */
  ServerCertificate: "ServerCertificate",
}

/**
 * Describes the properties of a SAP monitor.
 */
model MonitorProperties {
  /**
   * State of provisioning of the SAP monitor.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Defines the SAP monitor errors.
   */
  @visibility(Lifecycle.Read)
  errors?: ErrorDetail;

  /**
   * The SAP monitor resources will be deployed in the SAP monitoring region. The subnet region should be same as the SAP monitoring region.
   */
  appLocation?: string;

  /**
   * Sets the routing preference of the SAP monitor. By default only RFC1918 traffic is routed to the customer VNET.
   */
  routingPreference?: RoutingPreference;

  /**
   * Sets the preference for zone redundancy on resources created for the SAP monitor. By default resources will be created which do not support zone redundancy.
   */
  zoneRedundancyPreference?: string;

  /**
   * Managed resource group configuration
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The ARM ID of the Log Analytics Workspace that is used for SAP monitoring.
   */
  logAnalyticsWorkspaceArmId?: string;

  /**
   * The subnet which the SAP monitor will be deployed in
   */
  monitorSubnet?: string;

  /**
   * App service plan configuration
   */
  appServicePlanConfiguration?: AppServicePlanConfiguration;

  /**
   * The ARM ID of the MSI used for SAP monitoring.
   */
  @visibility(Lifecycle.Read)
  msiArmId?: string;

  /**
   * The ARM ID of the Storage account used for SAP monitoring.
   */
  @visibility(Lifecycle.Read)
  storageAccountArmId?: string;
}

/**
 * Managed resource group configuration
 */
model ManagedResourceGroupConfiguration {
  /**
   * Managed resource group name
   */
  name?: string;
}

/**
 * Configuration details of app service plan
 */
model AppServicePlanConfiguration {
  /**
   * The App Service plan tier.
   */
  tier?: AppServicePlanTier;

  /**
   * The number of workers in app service plan. If this is not set or set to 0, auto scale will be configured for the app service plan, otherwise, instance count is set to this number.
   */
  @minValue(0)
  capacity?: int32;
}

/**
 * Defines the request body for updating SAP monitor resource.
 */
model UpdateMonitorRequest {
  ...ArmTagsProperty;
  ...ManagedServiceIdentityProperty;
}

/**
 * Describes the properties of a provider instance.
 */
model ProviderInstanceProperties {
  /**
   * State of provisioning of the provider instance
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Resource health details
   */
  @visibility(Lifecycle.Read)
  health?: Health;

  /**
   * Defines the provider instance errors.
   */
  @visibility(Lifecycle.Read)
  errors?: ErrorDetail;

  /**
   * Defines the provider specific properties.
   */
  providerSettings?: ProviderSpecificProperties;
}

/**
 * Resource health details
 */
model Health {
  /**
   * Health state of the resource
   */
  @visibility(Lifecycle.Read)
  healthState?: WorkloadProviderInstanceHealthState;

  /**
   * Reasons impacting health state
   */
  @visibility(Lifecycle.Read)
  impactingReasons?: string;
}

/**
 * Gets or sets the provider specific properties.
 */
@discriminator("providerType")
model ProviderSpecificProperties {
  /**
   * The provider type. For example, the value can be SapHana.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Existing"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  providerType: string;
}

/**
 * Gets or sets the properties for Sap Landscape Monitor Dashboard.
 */
model SapLandscapeMonitorProperties {
  /**
   * State of provisioning of the SAP monitor.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: SapLandscapeMonitorProvisioningState;

  /**
   * Gets or sets the SID groupings by landscape and Environment.
   */
  grouping?: SapLandscapeMonitorPropertiesGrouping;

  /**
   * Gets or sets the list Top Metric Thresholds for SAP Landscape Monitor Dashboard
   */
  @maxItems(50)
  @extension("x-ms-identifiers", #["name"])
  topMetricsThresholds?: SapLandscapeMonitorMetricThresholds[];
}

/**
 * Gets or sets the SID groupings by landscape and Environment.
 */
model SapLandscapeMonitorPropertiesGrouping {
  /**
   * Gets or sets the list of landscape to SID mappings.
   */
  @maxItems(50)
  @extension("x-ms-identifiers", #["name"])
  landscape?: SapLandscapeMonitorSidMapping[];

  /**
   * Gets or sets the list of Sap Applications to SID mappings.
   */
  @maxItems(50)
  @extension("x-ms-identifiers", #["name"])
  sapApplication?: SapLandscapeMonitorSidMapping[];
}

/**
 * Gets or sets the mapping for SID to Environment/Applications.
 */
model SapLandscapeMonitorSidMapping {
  /**
   * Gets or sets the name of the grouping.
   */
  name?: string;

  /**
   * Gets or sets the list of SID's.
   */
  @maxItems(50)
  topSid?: string[];
}

/**
 * Gets or sets the Threshold Values for Top Metrics Health.
 */
model SapLandscapeMonitorMetricThresholds {
  /**
   * Gets or sets the name of the threshold.
   */
  name?: string;

  /**
   * Gets or sets the threshold value for Green.
   */
  green?: float32;

  /**
   * Gets or sets the threshold value for Yellow.
   */
  yellow?: float32;

  /**
   * Gets or sets the threshold value for Red.
   */
  red?: float32;
}

/**
 * Gets or sets the provider properties.
 */
model HanaDbProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the target virtual machine size.
   */
  hostname?: string;

  /**
   * Gets or sets the hana database name.
   */
  dbName?: string;

  /**
   * Gets or sets the database sql port.
   */
  sqlPort?: string;

  /**
   * Gets or sets the database instance number.
   */
  instanceNumber?: string;

  /**
   * Gets or sets the database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the database password.
   */
  @secret
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the blob URI to SSL certificate for the DB.
   */
  sslCertificateUri?: string;

  /**
   * Gets or sets the hostname(s) in the SSL certificate.
   */
  sslHostNameInCertificate?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the SAP System Identifier.
   */
  sapSid?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "SapHana";
}

/**
 * Gets or sets the provider properties.
 */
model SapNetWeaverProviderInstanceProperties
  extends ProviderSpecificProperties {
  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets the target virtual machine IP Address/FQDN.
   */
  sapHostname?: string;

  /**
   * Gets or sets the instance number of SAP NetWeaver.
   */
  sapInstanceNr?: string;

  /**
   * Gets or sets the list of HostFile Entries
   */
  sapHostFileEntries?: string[];

  /**
   * Gets or sets the SAP user name.
   */
  sapUsername?: string;

  /**
   * Sets the SAP password.
   */
  @secret
  sapPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the SAP password.
   */
  sapPasswordUri?: string;

  /**
   * Gets or sets the SAP Client ID.
   */
  sapClientId?: string;

  /**
   * Gets or sets the SAP HTTP port number.
   */
  sapPortNumber?: string;

  /**
   * Gets or sets the blob URI to SSL certificate for the SAP system.
   */
  sslCertificateUri?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "SapNetWeaver";
}

/**
 * Gets or sets the PrometheusOS provider properties.
 */
model PrometheusOsProviderInstanceProperties
  extends ProviderSpecificProperties {
  /**
   * URL of the Node Exporter endpoint
   */
  prometheusUrl?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the prometheus node exporter.
   */
  sslCertificateUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "PrometheusOS";
}

/**
 * Gets or sets the DB2 provider properties.
 */
model Db2ProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the target virtual machine name.
   */
  hostname?: string;

  /**
   * Gets or sets the db2 database name.
   */
  dbName?: string;

  /**
   * Gets or sets the db2 database sql port.
   */
  dbPort?: string;

  /**
   * Gets or sets the db2 database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the db2 database password.
   */
  @secret
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the DB2 Database.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "Db2";
}

/**
 * Gets or sets the PrometheusHaCluster provider properties.
 */
model PrometheusHaClusterProviderInstanceProperties
  extends ProviderSpecificProperties {
  /**
   * URL of the Node Exporter endpoint.
   */
  prometheusUrl?: string;

  /**
   * Gets or sets the target machine name.
   */
  hostname?: string;

  /**
   * Gets or sets the cluster sid.
   */
  sid?: string;

  /**
   * Gets or sets the clusterName.
   */
  clusterName?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the HA cluster exporter.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "PrometheusHaCluster";
}

/**
 * Gets or sets the SQL server provider properties.
 */
model MsSqlServerProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the SQL server host name.
   */
  hostname?: string;

  /**
   * Gets or sets the database sql port.
   */
  dbPort?: string;

  /**
   * Gets or sets the database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the database password.
   */
  @secret
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the SQL Database.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "MsSqlServer";
}

/**
 * Gets or sets the Oracle provider properties.
 */
@added(Versions.v2024_02_01_preview)
model OracleProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the target virtual machine name.
   */
  hostname?: string;

  /**
   * Gets or sets the oracle database sql port.
   */
  dbPort?: string;

  /**
   * Gets or sets the oracle database name.
   */
  dbName?: string;

  /**
   * Gets or sets the oracle database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the oracle database password.
   */
  @secret
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the Oracle Database.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "Oracle";
}

/**
 * Describes the properties of an Alert for SAP monitor.
 */
@added(Versions.v2024_02_01_preview)
model AlertProperties {
  /**
   * Defines the alert instance errors.
   */
  @visibility(Lifecycle.Read)
  errors?: ErrorDetail;

  /**
   * ID of the alert rule resource created.
   */
  @visibility(Lifecycle.Read)
  alertRuleResourceId?: armResourceIdentifier;

  /**
   * Name of the alert template from which it was created.
   */
  templateName?: string;

  /**
   * The provider type for alert. For example, the value can be SapHana.
   */
  providerType?: string;

  /**
   * Name of provider instances associated with the alert.
   */
  providerNames?: string[];

  /**
   * Describes the properties of an alert.
   */
  alertRuleProperties?: AlertRuleProperties;

  /**
   * State of provisioning of the alert instance
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadMonitorProvisioningState;
}

/**
 * Describes the properties of an alert.
 */
@added(Versions.v2024_02_01_preview)
model AlertRuleProperties {
  /**
   * Indicates whether the alert is in an enabled state.
   */
  status?: AlertRuleStatus;

  /**
   * Severity of the alert. Should be an integer between [0-4]. Value of 0 is severest.
   */
  @minValue(0)
  @maxValue(4)
  severity?: int32;

  /**
   * Action Group resource Ids to invoke when the alert fires
   */
  actionGroups?: armResourceIdentifier[];

  /**
   * The threshold of the alert.
   */
  threshold?: int32;

  /**
   * The threshold operator of the alert.
   */
  thresholdOperator?: ConditionalOperator;

  /**
   * The period of time on which the Alert query will be executed.
   */
  windowSize?: int32;

  /**
   * How often the scheduled query rule is evaluated.
   */
  evaluationFrequency?: int32;

  /**
   * The number of failing periods to trigger an alert.
   */
  failingPeriodsToAlert?: int32;

  /**
   * The operator for failing periods.
   */
  failingPeriodsOperator?: ConditionalOperator;

  /**
   * Mute actions for the chosen period of time after the alert is fired.
   */
  muteActionsDuration?: int32;

  /**
   * The value that indicates whether the alert should be automatically resolved or not. The default is Disable.
   */
  autoMitigate?: AlertAutoMitigate;

  /**
   * Evaluation of metric on a particular column.
   */
  dimension?: string;

  /**
   * The alert query parameters.
   */
  @extension("x-ms-identifiers", #["name"])
  alertQueryParameters?: AlertQueryParameter[];
}

/**
 * Defines the Alert Query Parameter.
 */
@added(Versions.v2024_02_01_preview)
model AlertQueryParameter {
  /**
   * The name of the alert query parameter.
   */
  name?: string;

  /**
   * The value of the alert query parameter.
   */
  value?: string;
}

/**
 * Describes the properties of an Alert Template for SAP monitor.
 */
@added(Versions.v2024_02_01_preview)
model AlertTemplateProperties {
  /**
   * Defines the SAP monitor Alert Template errors.
   */
  @visibility(Lifecycle.Read)
  errors?: ErrorDetail;

  /**
   * State of provisioning of the Alert Template.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Display name of the alert template.
   */
  templateDisplayName?: string;

  /**
   * The provider type for alert template. For example, the value can be SapHana.
   */
  providerType?: string;

  /**
   * Description of the template.
   */
  description?: string;

  /**
   * Severity of the alert. Should be an integer between [0-4]. Value of 0 is most severe and value of 4 is least severe.
   */
  @minValue(0)
  @maxValue(4)
  severity?: int32;

  /**
   * Query associated with the alert template.
   */
  query?: string;

  /**
   * Operator used for threshold comparison.
   */
  thresholdOperator?: ConditionalOperator;

  /**
   * Default threshold value.
   */
  defaultThreshold?: int32;

  /**
   * Minimum possible Default Threshold Value Associated with the Alert Template.
   */
  lowerBound?: int32;

  /**
   * Maximum possible Default Threshold Value Associated with the Alert Template.
   */
  upperBound?: int32;

  /**
   * Input option for the default threshold.
   */
  defaultThresholdInputOption?: DefaultThresholdInputOption;

  /**
   * Unit of the alert.
   */
  alertUnit?: string;

  /**
   * Describes the properties for metric measurement in alerts template.
   */
  metricMeasurement?: AlertTemplateMetricMeasurement;

  /**
   * Describes the Query Input Parameter properties in alerts template.
   */
  @maxItems(50)
  @extension("x-ms-identifiers", #["name"])
  queryInputParameters?: AlertTemplateQueryInputParameter[];
}

/**
 * Defines the Alert Template MetricMeasurement Properties.
 */
@added(Versions.v2024_02_01_preview)
model AlertTemplateMetricMeasurement {
  /**
   * Operator used for threshold comparison.
   */
  thresholdOperator?: ConditionalOperator;

  /**
   * The Threshold Value Associated with the Alert Template for Metric Measurement.
   */
  threshold?: int32;

  /**
   * Metric Trigger Type Associated with the Alert Template for Metric Measurement.
   */
  metricTriggerType?: AlertTemplateMetricTriggerType;

  /**
   * Metric Column Associated with the Alert Template for Metric Measurement.
   */
  metricColumn?: string;

  /**
   * Frequency (mins) value Associated with the Alert Template for Metric Measurement.
   */
  frequencyInMinutes?: int32;

  /**
   * Time Window (mins) Value Associated with the Alert Template for Metric Measurement.
   */
  timeWindowInMinutes?: int32;
}

/**
 * Describes the Query Input Parameter properties in alerts template.
 */
@added(Versions.v2024_02_01_preview)
model AlertTemplateQueryInputParameter {
  /**
   * Name of the Query Input Parameter
   */
  name?: string;

  /**
   * Type of the Query Input Parameter
   */
  type?: AlertTemplateParameterType;

  /**
   * Description of the Query Input Parameter
   */
  description?: string;

  /**
   * Default Value of the Query Input Parameter
   */
  defaultValue?: string;

  /**
   * Log Analytics query associated with the parameter.
   */
  laQuery?: string;

  /**
   * Selection mode for the parameter.
   */
  selectionMode?: AlertTemplateSelectionMode;

  /**
   * Display Name of the Query Input Parameter.
   */
  displayName?: string;
}
