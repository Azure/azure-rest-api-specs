using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
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
  @visibility("read")
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Defines the SAP monitor errors.
   */
  @visibility("read")
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
  @visibility("read")
  msiArmId?: string;

  /**
   * The ARM ID of the Storage account used for SAP monitoring.
   */
  @visibility("read")
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
  @visibility("read")
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Resource health details
   */
  @visibility("read")
  health?: Health;

  /**
   * Defines the provider instance errors.
   */
  @visibility("read")
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
  @visibility("read")
  healthState?: WorkloadProviderInstanceHealthState;

  /**
   * Reasons impacting health state
   */
  @visibility("read")
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
  @visibility("read", "create")
  providerType: ProviderType;
}

/**
 * Gets or sets the properties for Sap Landscape Monitor Dashboard.
 */
model SapLandscapeMonitorProperties {
  /**
   * State of provisioning of the SAP monitor.
   */
  @visibility("read")
  provisioningState?: SapLandscapeMonitorProvisioningState;

  /**
   * Gets or sets the SID groupings by landscape and Environment.
   */
  grouping?: SapLandscapeMonitorPropertiesGrouping;

  /**
   * Gets or sets the list Top Metric Thresholds for SAP Landscape Monitor Dashboard
   */
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
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
  @extension("x-ms-identifiers", ["name"])
  landscape?: SapLandscapeMonitorSidMapping[];

  /**
   * Gets or sets the list of Sap Applications to SID mappings.
   */
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
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
  providerType: ProviderType.SapHana;
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
  providerType: ProviderType.SapNetWeaver;
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
  providerType: ProviderType.PrometheusOS;
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
  providerType: ProviderType.Db2;
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
  providerType: ProviderType.PrometheusHaCluster;
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
  providerType: ProviderType.MsSqlServer;
}

/**
 * Gets or sets the Oracle provider properties.
 */
@added(Versions.v2024_02_01_preview)
model OracleProviderInstanceProperties extends ProviderSpecificProperties {
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
  providerType: ProviderType.Oracle;
}

/**
 * The Provider Types for Monitor.
 */
union ProviderType {
  string,

  /** SapHana Provider. */
  SapHana: "SapHana",

  /** SapNetWeaver Provider. */
  SapNetWeaver: "SapNetWeaver",

  /** PrometheusOS Provider. */
  PrometheusOS: "PrometheusOS",

  /** MsSqlServer Provider. */
  MsSqlServer: "MsSqlServer",

  /** PrometheusHaCluster Provider. */
  PrometheusHaCluster: "PrometheusHaCluster",

  /** Db2 Provider. */
  Db2: "Db2",

  /** Oracle Provider. */
  @added(Versions.v2024_02_01_preview)
  Oracle: "Oracle",
}

/**
 * Describes the properties of an Alert for SAP monitor.
 */
@added(Versions.v2024_02_01_preview)
model AlertProperties {
  /**
   * Defines the SAP monitor Alert errors.
   */
  @visibility("read")
  errors?: Azure.ResourceManager.Foundations.ErrorDetail;

  /**
   * Defines the SAP monitor Alert Template Name.
   */
  templateName?: string;

  /**
   * Defines the provider type.
   */
  providerType?: ProviderType;

  /**
   * Defines the provider names.
   */
  providerNames?: string[];

  /**
   * Defines the alert rule properties.
   */
  alertRuleProperties?: AlertRuleProperties;

  /**
   * State of provisioning of the provider instance
   */
  @visibility("read")
  provisioningState?: WorkloadMonitorProvisioningState;
}

/**
 * Defines the Alert Rule Properties.
 */
@added(Versions.v2024_02_01_preview)
model AlertRuleProperties {
  /**
   * Indicates whether the alert is in an enabled state.
   */
  status?: string;

  /**
   * Indicates the severity of the alert.
   */
  severity?: string;

  /**
   * The action group names.
   */
  actionGroups?: string[];

  /**
   * The threshold of the alert.
   */
  threshold?: int32;

  /**
   * The threshold operator of the alert.
   */
  thresholdOperator?: string;

  /**
   * The window size of the alert.
   */
  windowSize?: int32;

  /**
   * The evaluation frequency of the alert.
   */
  evaluationFrequency?: int32;

  /**
   * The number of failing periods to alert.
   */
  failingPeriodsToAlert?: int32;

  /**
   * The operator for failing periods.
   */
  failingPeriodsOperator?: string;

  /**
   * The duration to mute actions.
   */
  muteActionsDuration?: int32;

  /**
   * Indicates whether the alert is in an auto-mitigate state.
   */
  autoMitigate?: "string";

  /**
   * The alert dimension.
   */
  dimension?: "string";

  /**
   * The alert query parameters.
   */
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
  alertQueryParameters?: AlertRuleQueryParameter[];
}

/**
 * Defines the Alert Query Parameter.
 */
@added(Versions.v2024_02_01_preview)
model AlertRuleQueryParameter {
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
  @visibility("read")
  errors?: Azure.ResourceManager.Foundations.ErrorDetail;

  /**
   * State of provisioning of the Alert Template.
   */
  @visibility("read")
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Display name of the template.
   */
  templateDisplayName?: string;

  /**
   * Type of the provider.
   */
  providerType?: ProviderType;

  /**
   * Description of the template.
   */
  description?: string;

  /**
   * Severity level of the alert.
   */
  severity?: int32;

  /**
   * Query associated with the alert.
   */
  query?: string;

  /**
   * Operator used for threshold comparison.
   */
  thresholdOperator?: string;

  /**
   * Default threshold value.
   */
  defaultThreshold?: int32;

  /**
   * Lower bound for the threshold.
   */
  lowerBound?: int32;

  /**
   * Upper bound for the threshold.
   */
  upperBound?: int32;

  /**
   * Input option for the default threshold.
   */
  defaultThresholdInputOption?: string;

  /**
   * Unit of the alert.
   */
  alertUnit?: string;

  /**
   * Metric measurement details.
   */
  metricMeasurement?: AlertTemplateMetricMeasurement;

  /**
   * Parameters for the query input.
   */
  @maxItems(50)
  @extension("x-ms-identifiers", ["name"])
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
  thresholdOperator?: string;

  /**
   * Threshold value.
   */
  threshold?: int32;

  /**
   * Type of metric trigger.
   */
  metricTriggerType?: string;

  /**
   * Column associated with the metric.
   */
  metricColumn?: string;

  /**
   * Frequency of measurement in minutes.
   */
  frequencyInMinutes?: int32;

  /**
   * Time window for measurement in minutes.
   */
  timeWindowInMinutes?: int32;
}

/**
 * Defines the properties of a Query Input Parameter.
 */
@added(Versions.v2024_02_01_preview)
model AlertTemplateQueryInputParameter {
  /**
   * Name of the parameter.
   */
  name?: string;

  /**
   * Type of the parameter.
   */
  type?: string;

  /**
   * Description of the parameter.
   */
  description?: string;

  /**
   * Default value of the parameter.
   */
  defaultValue?: string;

  /**
   * Log Analytics query associated with the parameter.
   */
  laQuery?: string;

  /**
   * Selection mode for the parameter.
   */
  selectionMode?: string;

  /**
   * Display name of the parameter.
   */
  displayName?: string;
}
