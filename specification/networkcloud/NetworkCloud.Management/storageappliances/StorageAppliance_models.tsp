import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;

/**
 * The detailed status of the storage appliance.
 */
union StorageApplianceDetailedStatus {
  string,

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Degraded status.
   */
  Degraded: "Degraded",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the storage appliance.
 */
union StorageApplianceProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",
}

/**
 * The indicator of whether the storage appliance supports remote vendor management.
 */
union RemoteVendorManagementFeature {
  string,

  /**
   * Remote vendor management is supported.
   */
  Supported: "Supported",

  /**
   * Remote vendor management is unsupported.
   */
  Unsupported: "Unsupported",
}

/**
 * The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
 */
union RemoteVendorManagementStatus {
  string,

  /**
   * Remote vendor management is enabled.
   */
  Enabled: "Enabled",

  /**
   * Remote vendor management is disabled.
   */
  Disabled: "Disabled",

  /**
   * Remote vendor management is unsupported.
   */
  Unsupported: "Unsupported",
}

/**
 * The log level for the monitoring configuration status of the storage appliance.
 */
@added(Versions.v2026_05_01_preview)
union StorageApplianceMetricsConfigurationStatusLogLevel {
  string,

  /**
   * Logs are emitted at the default log level.
   */
  Default: "Default",

  /**
   * Logs are emitted at the Nexus log level.
   */
  Nexus: "Nexus",
}

/**
 * The metrics level for the monitoring configuration status of the storage appliance.
 */
@added(Versions.v2026_05_01_preview)
union StorageApplianceMetricsConfigurationStatusMetricsLevel {
  string,

  /**
   * Metrics are emitted at the default metrics level.
   */
  Default: "Default",

  /**
   * Metrics are emitted at the Nexus metrics level.
   */
  Nexus: "Nexus",
}

/**
 * StorageApplianceList represents a list of storage appliances.
 */
model StorageApplianceList is Azure.Core.Page<StorageAppliance>;

/**
 * StorageApplianceProperties represents the properties of the storage appliance.
 */
model StorageApplianceProperties {
  ...StorageApplianceSpec;
  ...StorageApplianceStatus;

  /**
   * The provisioning state of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: StorageApplianceProvisioningState;
}

/**
 * StorageApplianceSpec represents the properties that are used as an input to the operator.
 */
model StorageApplianceSpec {
  /**
   * The resource ID of the rack where this storage appliance resides.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  rackId: Azure.Core.armResourceIdentifier;

  /**
   * The SKU for the storage appliance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageApplianceSkuId: string;

  /**
   * The slot the storage appliance is in the rack based on the BOM configuration.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The serial number for the storage appliance.
   */
  serialNumber: string;

  /**
   * The credentials of the administrative interface on this storage appliance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorCredentials: AdministrativeCredentials;
}

/**
 * StorageApplianceStatus represents the observed status of the storage appliance.
 */
model StorageApplianceStatus {
  /**
   * The CA certificate information issued by the platform for connecting to TLS interfaces for the storage appliance. Callers add this certificate to their trusted CA store to allow secure communication with the storage appliance.
   */
  @visibility(Lifecycle.Read)
  caCertificate?: CertificateInfo;

  /**
   * The total capacity of the storage appliance. Measured in GiB.
   */
  @visibility(Lifecycle.Read)
  capacity?: int64;

  /**
   * The amount of storage consumed. Measured in GiB.
   */
  @visibility(Lifecycle.Read)
  capacityUsed?: int64;

  /**
   * The resource ID of the cluster this storage appliance is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The detailed status of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: StorageApplianceDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The list of expansion shelves connected to the storage appliance.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  expansionShelves?: StorageApplianceExpansionShelf[];

  /**
   * The endpoint for the management interface of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  managementIpv4Address?: string;

  /**
   * The manufacturer of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * The model of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The monitoring configuration status of the storage appliance.
   */
  @added(Versions.v2026_05_01_preview)
  @visibility(Lifecycle.Read)
  monitoringConfigurationStatus?: StorageApplianceMonitoringConfigurationStatus;

  /**
   * The indicator of whether the storage appliance supports remote vendor management.
   */
  @visibility(Lifecycle.Read)
  remoteVendorManagementFeature?: RemoteVendorManagementFeature;

  /**
   * The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
   */
  @visibility(Lifecycle.Read)
  remoteVendorManagementStatus?: RemoteVendorManagementStatus;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["secretType"])
  secretRotationStatus?: SecretRotationStatus[];

  /**
   * The version of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * StorageApplianceExpansionShelf represents an expansion shelf connected to a storage appliance.
 */
@added(Versions.v2026_01_01_preview)
model StorageApplianceExpansionShelf {
  /**
   * The model of the expansion shelf.
   */
  `model`?: string;

  /**
   * The version of the expansion shelf.
   */
  version?: string;
}

/**
 * StorageAppliancePatchParameters represents the body of the request to patch storage appliance properties.
 */
model StorageAppliancePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: StorageAppliancePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * StorageAppliancePatchProperties represents the properties of the storage appliance that can be patched.
 */
model StorageAppliancePatchProperties {
  /**
   * The serial number for the storage appliance.
   */
  serialNumber?: string;
}

/**
 * StorageApplianceEnableRemoteVendorManagementParameters represents the body of the request to enable remote vendor management of a storage appliance.
 */
model StorageApplianceEnableRemoteVendorManagementParameters {
  /**
   * Field Deprecated. This field is not used and will be rejected if provided. The list of IPv4 subnets (in CIDR format), IPv6 subnets (in CIDR format), or hostnames that the storage appliance needs accessible in order to turn on the remote vendor management.
   */
  supportEndpoints?: string[];
}

/**
 * StorageApplianceRunReadCommandsParameters represents the body of request containing list of read-only commands to run on the storage appliance.
 */
model StorageApplianceRunReadCommandsParameters {
  /**
   * The list of read-only commands to be executed directly against the target storage appliance.
   */
  @identifiers(#[])
  @minItems(1)
  commands: StorageApplianceCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run.
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;
}

/**
 * StorageApplianceCommandSpecification represents the command and optional arguments to run.
 */
model StorageApplianceCommandSpecification {
  /**
   * The list of strings that will be passed to the script in order as separate arguments.
   */
  arguments?: string[];

  /**
   * The command to execute.
   */
  command: string;
}

/**
 * The monitoring configuration status of the storage appliance.
 */
@added(Versions.v2026_05_01_preview)
model StorageApplianceMonitoringConfigurationStatus {
  /**
   * The log level for the monitoring configuration status of the storage appliance.
   */
  logLevel?: StorageApplianceMetricsConfigurationStatusLogLevel;

  /**
   * The metrics level for the monitoring configuration status of the storage appliance.
   */
  metricsLevel?: StorageApplianceMetricsConfigurationStatusMetricsLevel;
}
