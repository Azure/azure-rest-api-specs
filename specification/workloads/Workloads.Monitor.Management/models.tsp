using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Workloads;

/** The resource name pattern */
const ResourceNamePattern: string = "^[a-zA-Z0-9-_]{3,64}$";

/**
 * State of provisioning of the SAP monitor.
 */
@lroStatus
union WorkloadMonitorProvisioningState {
  ResourceProvisioningState,

  /** The resource request has been accepted. */
  Accepted: "Accepted",

  /** The resource is being created. */
  Creating: "Creating",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource is being migrated. */
  Migrating: "Migrating",

  string,
}

/**
 * The value which indicates whether this scheduled query rule is enabled. Value should be enabled or disabled
 */
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
 * Gets or sets job configuration type.
 */
union JobConfigurationType {
  string,

  /** BuiltIn job configuration type. */
  BuiltIn: "BuiltIn",

  /** Custom job configuration type. */
  Custom: "Custom",
}

/** The health model state. */
union HealthModelState {
  /** The health model is in an unknown state */
  Unknown: "Unknown",

  /** The health model is in enabled state */
  Enabled: "Enabled",

  /** The health model is in disabled state */
  Disabled: "Disabled",

  string,
}

/** The recommended signals options */
union RecommendedSignalsOptions {
  /** The recommended signals will be enabled on the applicable resource entities */
  Enabled: "Enabled",

  /** The recommended signals won't be enabled on the entities */
  Disabled: "Disabled",

  string,
}

/** The health signal kind. */
union SignalKind {
  /** The signal is a Azure resource metric */
  AzureResourceMetric: "AzureResourceMetric",

  string,
}

/** The signal operator. */
union SignalOperator {
  /** The signal operator is equal */
  Equal: "Equal",

  /** The signal operator is contains */
  Contains: "Contains",

  /** The signal operator is greater than */
  GreaterThan: "GreaterThan",

  /** The signal operator is greater or equal */
  GreaterOrEquals: "GreaterOrEquals",

  /** The signal operator is less than */
  LowerThan: "LowerThan",

  /** The signal operator is lower or equal */
  LowerOrEquals: "LowerOrEquals",

  string,
}

/** The metric aggregation type */
union MetricsAggregationType {
  /** The metric aggregation type is none */
  None: "None",

  /** The metric aggregation type is average */
  Average: "Average",

  /** The metric aggregation type is sum */
  Total: "Total",

  /** The metric aggregation type is minimum */
  Minimum: "Minimum",

  /** The metric aggregation type is maximum */
  Maximum: "Maximum",

  /** The metric aggregation type is count */
  Count: "Count",

  string,
}

/** The health states */
union HealthState {
  /** The health state is healthy */
  Healthy: "Healthy",

  /** The health state is degraded */
  Degraded: "Degraded",

  /** The health state is unhealthy */
  Unhealthy: "Unhealthy",

  /** The health state is unknown */
  Unknown: "Unknown",

  string,
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

/** The resource common properties */
model ResourceCommonProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadMonitorProvisioningState;

  /** The error details of last operation on the resource */
  @visibility(Lifecycle.Read)
  errors?: ErrorDetail;
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
 * DB2 job configurations properties.
 */
model Db2JobConfigurationsProperties {
  /**
   * State of provisioning of the DB2 job configurations.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Gets or sets the name of the DB2 job configurations.
   */
  metricName?: string;

  /**
   * Gets or sets the list of dimensions for the DB2 job configurations.
   */
  metricDimensions?: string[];

  /**
   * Gets or sets the name of the custom log table used to store data in log Analytics.
   */
  customLogTable?: string;

  /**
   * Gets or sets the value of the default frequency of execution for the job.
   */
  @maxValue(86400)
  defaultFrequencyInSecs?: int32;

  /**
   * Gets or sets the type for the job configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Purpose of this type is different from resource type property"
  type?: JobConfigurationType;

  /**
   * Gets or sets the list of Configuration parameters.
   */
  @Azure.ResourceManager.identifiers(#[])
  parameters?: ConfigurationParameter[];

  /**
   * Gets or sets the list of actions
   */
  @Azure.ResourceManager.identifiers(#[])
  actions?: ActionsParameter[];
}

/**
 * Gets or sets list of configuration Parameter
 */
model ConfigurationParameter {
  /**
   * Gets or sets name of configuration
   */
  name?: string;

  /**
   * Gets or sets value of configuration parameter
   */
  value?: string;
}

/**
 * Gets or sets the list of action parameter
 */
model ActionsParameter {
  /**
   * Gets or sets the function Name
   */
  functionName?: string;

  /**
   * Gets or sets the list of function Name.
   */
  @Azure.ResourceManager.identifiers(#[])
  parameters?: ConfigurationParameter[];
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
  @identifiers(#["name"])
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
  @identifiers(#["name"])
  landscape?: SapLandscapeMonitorSidMapping[];

  /**
   * Gets or sets the list of Sap Applications to SID mappings.
   */
  @maxItems(50)
  @identifiers(#["name"])
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
  @identifiers(#["name"])
  alertQueryParameters?: AlertQueryParameter[];
}

/**
 * Defines the Alert Query Parameter.
 */
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
  @identifiers(#["name"])
  queryInputParameters?: AlertTemplateQueryInputParameter[];
}

/**
 * Defines the Alert Template MetricMeasurement Properties.
 */
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

/** The discovery configuration */
model DiscoveryConfiguration {
  /** The scope(s) for a discovery configuration. */
  scopes?: string[];

  /** The ARG filter query that should be applied on the discovery scope. */
  filterQuery?: string;
}

/** The group configuration */
model GroupConfiguration {
  /** The group by property name. Allowed values are: resource top level properties. */
  groupBy: string;
}

/** Health definition details */
model HealthDefinitionDetails {
  /** The health definition resource version. This will be used to determine the drift in health definition */
  @visibility(Lifecycle.Read)
  version?: string;

  /** The health definition resource Id used for creating health model */
  id?: armResourceIdentifier<[
    {
      type: "Microsoft.Workloads/healthDefinitions";
    }
  ]>;

  /** Indicates whether to add recommended signals on the resource entities automatically in health model */
  recommendedSignals?: RecommendedSignalsOptions;
}

/** Aggregate signal definition with dependent child entities */
model DependenciesSignalDefinition {
  /** Aggregation type for child dependencies. */
  aggregationType: DependenciesAggregationType = DependenciesAggregationType.WorstOf;

  /** Degraded threshold for aggregating the propagated health state of child dependencies.
   * Can be either an absolute number that is greater than 0, or a percentage between 1-100%.
   * The entity will be considered degraded when the number of not healthy child dependents (unhealthy, degraded, unknown) is equal to or above the threshold value. Must only be set when AggregationType is 'Thresholds'. */
  degradedThreshold?: string;

  /** Unhealthy threshold for aggregating the propagated health state of child dependencies.
   * Can be either an absolute number that is greater than 0, or a percentage between 1-100%.
   * The entity will be considered unhealthy when the number of not healthy child dependents (unhealthy, degraded, unknown) is equal to or above the threshold value. Must only be set when AggregationType is 'Thresholds'. */
  unhealthyThreshold?: string;
}

/** Aggregation type for child dependencies. */
union DependenciesAggregationType {
  string,

  /** Default behavior: Worst child health state is propagated. */
  WorstOf: "WorstOf",

  /** Based on configurable thresholds. */
  Thresholds: "Thresholds",
}

/** The component health definition */
model ComponentHealthDefinition {
  /** The component type. */
  type: string;

  /** The component role. */
  role?: string;

  /** Signal definition for dependencies aggregated health */
  dependenciesSignalDefinition?: DependenciesSignalDefinition;

  /** The resource signal definition mappings. */
  @Azure.ResourceManager.identifiers(#[])
  resourceSignalDefinitionMappings?: ResourceSignalDefinitionMapping[];
}

/** The resource signal definition mapping */
model ResourceSignalDefinitionMapping {
  /** The resource signal definition Id. */
  condition: SignalDefinitionMappingCondition;

  /** The resource signal definition Ids. */
  signalDefinitionIds: armResourceIdentifier<[
    {
      type: "Microsoft.Workloads/instanceHealthDefinitions/signalDefinitions";
    }
  ]>[];
}

/** The signal definition mapping condition */
model SignalDefinitionMappingCondition {
  /** The ARM resource type. */
  resourceType: string;
}

/** The signal threshold rule */
model ThresholdRule {
  /** The signal operator. */
  operator: SignalOperator;

  /** The signal value. */
  @minLength(1)
  @maxLength(100)
  value: string;
}

/** The evaluation rule for the signal definition */
model EvaluationRule {
  /** The signal threshold rule for the degraded state. */
  degradedRule?: ThresholdRule;

  /** The signal threshold rule for the unhealthy state. */
  unhealthyRule?: ThresholdRule;
}

/** The heath status response at instance group level */
model InstanceGroupHealthStatusResponse {
  /** The snapshot id of instance group's health state. */
  healthSnapshotId: string;

  /** The instances health status. */
  @identifiers(#[])
  instances: InstanceHealthStatusResponse[];

  /** The link to the next page of results. */
  nextLink?: string;
}

/** The health status response */
model InstanceHealthStatusResponse {
  /** The virtual instance id. */
  id: armResourceIdentifier<[
    {
      type: "Microsoft.Workloads/virtualInstances";
    }
  ]>;

  /** The snapshot id of VI's health state. */
  healthSnapshotId: string;

  /** The VI health evaluation time. */
  healthEvaluationTime: utcDateTime;

  /** The VI health state. */
  healthState: HealthState;

  /** The component health status. */
  componentsHealthState: EntityStatusDetails[];
}

/** The entity status details */
model EntityStatusDetails {
  /** The entity id. */
  id: string;

  /** The entity health state. */
  healthState: HealthState;

  /** The health evaluation results will be included here in future */
  /** The dependent entities health status. */
  dependentEntitiesStatus?: EntityStatusDetails[];
}

/** The health status request body */
model HealthStatusRequestBody {
  /** The health states to include in response. */
  healthStatesIn?: HealthState[];

  /** The group by nodes to which the results will be limited to. */
  groupByNodesIn?: string[];
}
