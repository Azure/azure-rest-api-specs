using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Workloads.Monitor;

/**
 * SAP monitor info on Azure (ARM properties and SAP monitor properties)
 */
model Monitor is TrackedResource<Properties> {
  /**
   * Name of the SAP monitor resource.
   */
  @pattern("^[a-zA-Z0-9-_]+$")
  @path
  @key("monitorName")
  @segment("monitors")
  @visibility("read")
  name: string;

  ...ManagedServiceIdentityProperty;
}

/**
 * Describes the properties of a SAP monitor.
 */
model Properties {
  /**
   * State of provisioning of the SAP monitor.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Defines the SAP monitor errors.
   */
  @visibility("read")
  errors?: Azure.ResourceManager.Foundations.ErrorDetail;

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
 * Defines the request body for updating SAP monitor resource.
 */
model UpdateMonitorRequest {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedServiceIdentityProperty;
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
 * The App Service plan tier.
 */
union AppServicePlanTier {
  string,

  /** Elastic Premium plan */
  ElasticPremium: "ElasticPremium",

  /** Dedicated Premium V3 plan */
  PremiumV3: "PremiumV3",
}
