import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;

/**
 * The type of managed identity that is being selected.
 */
union ManagedServiceIdentitySelectorType {
  string,

  /**
   * System assigned identity selection.
   */
  SystemAssignedIdentity: "SystemAssignedIdentity",

  /**
   * User assigned identity selection.
   */
  UserAssignedIdentity: "UserAssignedIdentity",
}

/**
 * The indicator of whether the control plane will be impacted during the upgrade.
 */
union ControlImpact {
  string,

  /**
   * The control plane will be impacted during the upgrade.
   */
  True: "True",

  /**
   * The control plane will not be impacted during the upgrade.
   */
  False: "False",
}

/**
 * The indicator of whether the workload will be impacted during the upgrade.
 */
union WorkloadImpact {
  string,

  /**
   * The workload will be impacted during the upgrade.
   */
  True: "True",

  /**
   * The workload will not be impacted during the upgrade.
   */
  False: "False",
}

/**
 * The latest heartbeat status between the cluster manager and the cluster.
 */
union ClusterConnectionStatus {
  string,

  /**
   * The latest heartbeat status is healthy.
   */
  Connected: "Connected",

  /**
   * The latest heartbeat status is unhealthy.
   */
  Disconnected: "Disconnected",

  /**
   * Too many of the latest heartbeats were missed.
   */
  Timeout: "Timeout",

  /**
   * Could not determine the latest heartbeat status.
   */
  Undefined: "Undefined",
}

/**
 * The latest connectivity status between cluster manager and the cluster.
 */
union ClusterManagerConnectionStatus {
  string,

  /**
   * The latest connectivity status is healthy.
   */
  Connected: "Connected",

  /**
   * Connectivity could not be established.
   */
  Unreachable: "Unreachable",
}

/**
 * The type of rack configuration for the cluster.
 */
union ClusterType {
  string,

  /**
   * Single rack configuration.
   */
  SingleRack: "SingleRack",

  /**
   * Multi-rack configuration.
   */
  MultiRack: "MultiRack",
}

/**
 * ClusterContinueUpdateVersionSafeguardMode represents the mode of the cluster continue update safeguards.
 */
@added(Versions.v2026_05_01_preview)
union ClusterContinueUpdateVersionSafeguardMode {
  string,

  /**
   * Run all pre‑operation validation checks before continuing the version update. If any check fails, the request is rejected and no changes are made.
   */
  All: "All",

  /**
   * Skip all safeguards and continue the version update without running pre‑operation validation checks.
   */
  None: "None",
}

/**
 * ClusterUpdateVersionSafeguardMode represents the mode of the cluster update safeguards.
 */
@added(Versions.v2026_05_01_preview)
union ClusterUpdateVersionSafeguardMode {
  string,

  /**
   * Run all pre‑operation validation checks before performing the version update. If any check fails, the request is rejected and no changes are made.
   */
  All: "All",

  /**
   * Skip all safeguards and perform the version update without running pre‑operation validation checks.
   */
  None: "None",
}

/**
 * The type of command output for the override.
 */
union CommandOutputType {
  string,

  /**
   * BareMetalMachineRunCommand output type
   */
  BareMetalMachineRunCommand: "BareMetalMachineRunCommand",

  /**
   * BareMetalMachineRunDataExtracts output type
   */
  BareMetalMachineRunDataExtracts: "BareMetalMachineRunDataExtracts",

  /**
   * BareMetalMachineRunReadCommands output type
   */
  BareMetalMachineRunReadCommands: "BareMetalMachineRunReadCommands",

  /**
   * ClusterSupportAdministrativeActions output type supporting administrative actions that can be run on a cluster for support purposes.
   */
  @added(Versions.v2026_05_01_preview)
  ClusterSupportAdministrativeActions: "ClusterSupportAdministrativeActions",

  /**
   * StorageRunReadCommands output type
   */
  StorageRunReadCommands: "StorageRunReadCommands",

  /**
   * BareMetalMachineRunDataExtractsRestricted output type
   */
  BareMetalMachineRunDataExtractsRestricted: "BareMetalMachineRunDataExtractsRestricted",
}

/**
 * Selection of how the type evaluation is applied to the cluster calculation.
 */
union ValidationThresholdGrouping {
  string,

  /**
   * The threshold is calculated for the whole cluster.
   */
  PerCluster: "PerCluster",

  /**
   * The threshold is calculated for each rack in the cluster.
   */
  PerRack: "PerRack",
}

/**
 * Selection of how the threshold should be evaluated.
 */
union ValidationThresholdType {
  string,

  /**
   * The threshold is evaluated based on the count of successful operations.
   */
  CountSuccess: "CountSuccess",

  /**
   * The threshold is evaluated based on the percentage of successful operations.
   */
  PercentSuccess: "PercentSuccess",
}

/**
 * The current detailed status of the cluster.
 */
union ClusterDetailedStatus {
  string,

  /**
   * The PendingDeployment status.
   */
  PendingDeployment: "PendingDeployment",

  /**
   * The Deploying status.
   */
  Deploying: "Deploying",

  /**
   * The Running status.
   */
  Running: "Running",

  /**
   * The Updating status.
   */
  Updating: "Updating",

  /**
   * The UpdatePaused status.
   */
  UpdatePaused: "UpdatePaused",

  /**
   * The Degraded status.
   */
  Degraded: "Degraded",

  /**
   * The Deleting status.
   */
  Deleting: "Deleting",

  /**
   * The Disconnected status.
   */
  Disconnected: "Disconnected",

  /**
   * The Failed status.
   */
  Failed: "Failed",
}

/**
 * The provisioning state of the cluster.
 */
union ClusterProvisioningState {
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
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Validating status.
   */
  Validating: "Validating",

  /**
   * The Updating status.
   */
  Updating: "Updating",
}

/**
 * The indicator if the specified key vault should be used to archive the secrets of the cluster.
 */
union ClusterSecretArchiveEnabled {
  string,

  /**
   * Enable the cluster secret archive with the specified key vault.
   */
  True: "True",

  /**
   * Disable use of the cluster secret archive even if a key vault is specified.
   */
  False: "False",
}

/**
 * The mode of operation for runtime protection.
 */
union ClusterUpdateStrategyType {
  string,

  /**
   * Update the cluster in rack-by-rack increments.
   */
  Rack: "Rack",

  /**
   * Pause after each rack is updated.
   */
  PauseAfterRack: "PauseAfterRack",
}

/**
 * The mode selection for container vulnerability scanning.
 */
union VulnerabilityScanningSettingsContainerScan {
  string,

  /**
   * Disable container vulnerability scanning for the cluster.
   */
  Disabled: "Disabled",

  /**
   * Enable container vulnerability scanning for the cluster.
   */
  Enabled: "Enabled",
}

/**
 * The mode by which the cluster will target the next grouping of servers to continue the update.
 */
union ClusterContinueUpdateVersionMachineGroupTargetingMode {
  string,

  /**
   * Racks will be targeted for update in alphabetical order based on the rack name.
   */
  AlphaByRack: "AlphaByRack",
}

/**
 * Additional actions supplement the default non-disruptive cluster inspection. Additional actions may be disallowed if the cluster is in a deployed and running state.
 */
@added(Versions.v2026_01_01_preview)
union ClusterInspectAdditionalAction {
  string,

  /**
   * Indicates that hardware reset should be performed during inspection.
   */
  ResetHardware: "ResetHardware",
}

/**
 * The choice of if the scan operation should run the scan.
 */
union ClusterScanRuntimeParametersScanActivity {
  string,

  /**
   * Scan the cluster.
   */
  Scan: "Scan",

  /**
   * Do not scan the cluster.
   */
  Skip: "Skip",
}

/**
 * ClusterList represents a list of clusters.
 */
model ClusterList is Azure.Core.Page<Cluster>;

/**
 * ClusterProperties represents the properties of a cluster.
 */
model ClusterProperties {
  ...ClusterSpec;
  ...ClusterStatus;

  /**
   * The provisioning state of the cluster.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterProvisioningState;
}

/**
 * ClusterSpec represents the properties that are used as an input to the operator.
 */
model ClusterSpec {
  /**
   * The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.
   */
  aggregatorOrSingleRackDefinition: RackDefinition;

  /**
   * The settings for the log analytics workspace used for output of logs from this cluster.
   */
  analyticsOutputSettings?: AnalyticsOutputSettings;

  /**
   * Field Deprecated. The resource ID of the Log Analytics Workspace that will be used for storing relevant logs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The customer-provided location information to identify where the cluster resides.
   */
  @maxLength(256)
  clusterLocation?: string;

  /**
   * Field Deprecated: Use managed identity to provide cluster privileges. The service principal to be used by the cluster during Arc Appliance installation.
   */
  clusterServicePrincipal?: ServicePrincipalInformation;

  /**
   * The type of rack configuration for the cluster.
   */
  clusterType: ClusterType;

  /**
   * The current runtime version of the cluster.
   */
  clusterVersion: string;

  /**
   * The settings for commands run in this cluster, such as bare metal machine run read only commands and data extracts.
   */
  commandOutputSettings?: CommandOutputSettings;

  /**
   * The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
   */
  computeDeploymentThreshold?: ValidationThreshold;

  /**
   * The list of rack definitions for the compute racks in a multi-rack cluster, or an empty list in a single-rack cluster.
   */
  @identifiers(#["networkRackId"])
  computeRackDefinitions?: RackDefinition[];

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The resource ID of the Network Fabric associated with the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier;

  /**
   * The settings for cluster runtime protection.
   */
  runtimeProtectionConfiguration?: RuntimeProtectionConfiguration;

  /**
   * The configuration for use of a key vault to store secrets for later retrieval by the operator.
   */
  secretArchive?: ClusterSecretArchive;

  /**
   * The settings for the secret archive used to hold credentials for the cluster.
   */
  secretArchiveSettings?: SecretArchiveSettings;

  /**
   * The strategy for updating the cluster.
   */
  updateStrategy?: ClusterUpdateStrategy;

  /**
   * The settings for how security vulnerability scanning is applied to the cluster.
   */
  vulnerabilityScanningSettings?: VulnerabilityScanningSettings;
}

/**
 * ClusterStatus represents the properties produced by the API implementing logic in the operator.
 */
model ClusterStatus {
  /**
   * The current state of any in progress or completed actions. The most recent known instance of each action type is shown.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["actionType"])
  actionStates?: ActionState[];

  /**
   * The list of cluster runtime version upgrades available for this cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["targetClusterVersion"])
  availableUpgradeVersions?: ClusterAvailableUpgradeVersion[];

  /**
   * The capacity supported by this cluster.
   */
  @visibility(Lifecycle.Read)
  clusterCapacity?: ClusterCapacity;

  /**
   * The latest heartbeat status between the cluster manager and the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterConnectionStatus?: ClusterConnectionStatus;

  /**
   * The extended location (custom location) that represents the cluster's control plane location. This extended location is used to route the requests of child objects of the cluster that are handled by the platform operator.
   */
  @visibility(Lifecycle.Read)
  clusterExtendedLocation?: Foundations.ExtendedLocation;

  /**
   * The latest connectivity status between cluster manager and the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterManagerConnectionStatus?: ClusterManagerConnectionStatus;

  /**
   * The resource ID of the cluster manager that manages this cluster. This is set by the Cluster Manager when the cluster is created.
   */
  @visibility(Lifecycle.Read)
  clusterManagerId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/clusterManagers";
    }
  ]>;

  /**
   * The current detailed status of the cluster.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: ClusterDetailedStatus;

  /**
   * The descriptive message about the detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. This field will not be populated in an upcoming version. The extended location (custom location) that represents the Hybrid AKS control plane location. This extended location is used when creating provisioned clusters (Hybrid AKS clusters).
   */
  @visibility(Lifecycle.Read)
  hybridAksExtendedLocation?: Foundations.ExtendedLocation;

  /**
   * The date and time of the end of the last successful version update for the cluster.
   */
  @added(Versions.v2026_05_01_preview)
  @visibility(Lifecycle.Read)
  lastSuccessfulVersionUpdateTime?: utcDateTime;

  /**
   * The list of credentials that are managed for the cluster and can be rotated on-demand.
   */
  @added(Versions.v2026_05_01_preview)
  @visibility(Lifecycle.Read)
  managedCredentials?: string[];

  /**
   * The count of Manual Action Taken (MAT) events that have not been validated.
   */
  @visibility(Lifecycle.Read)
  manualActionCount?: int64;

  /**
   * The support end date of the runtime version of the cluster.
   */
  @visibility(Lifecycle.Read)
  supportExpiryDate?: string;

  /**
   * The list of workload resource IDs that are hosted within this cluster.
   */
  @visibility(Lifecycle.Read)
  workloadResourceIds?: string[];
}

/**
 * RackDefinition represents details regarding the rack.
 */
model RackDefinition {
  /**
   * The zone name used for this rack when created. Availability zones are used for workload placement.
   */
  @pattern("^[a-zA-Z0-9]{1,10}$")
  availabilityZone?: string;

  /**
   * The unordered list of bare metal machine configuration.
   */
  @identifiers(#[])
  bareMetalMachineConfigurationData?: BareMetalMachineConfigurationData[];

  /**
   * The resource ID of the network rack that matches this rack definition.
   */
  networkRackId: Azure.Core.armResourceIdentifier;

  /**
   * The free-form description of the rack's location.
   */
  @maxLength(256)
  rackLocation?: string;

  /**
   * The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.
   */
  @maxLength(64)
  @minLength(1)
  rackSerialNumber: string;

  /**
   * The resource ID of the sku for the rack being added.
   */
  rackSkuId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/rackSkus";
    }
  ]>;

  /**
   * The list of storage appliance configuration data for this rack.
   */
  @identifiers(#[])
  storageApplianceConfigurationData?: StorageApplianceConfigurationData[];
}

/**
 * BareMetalMachineConfigurationData represents configuration for the bare metal machine.
 */
model BareMetalMachineConfigurationData {
  /**
   * The connection string for the baseboard management controller including IP address and protocol.
   */
  @visibility(Lifecycle.Read)
  bmcConnectionString?: string;

  /**
   * The credentials of the baseboard management controller on this bare metal machine. The password field is expected to be an Azure Key Vault key URL. Until the cluster is converted to utilize managed identity by setting the secret archive settings, the actual password value should be provided instead.
   */
  bmcCredentials: AdministrativeCredentials;

  /**
   * The MAC address of the BMC for this machine.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress: string;

  /**
   * The MAC address associated with the PXE NIC card.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress: string;

  /**
   * The free-form additional information about the machine, e.g. an asset tag.
   */
  @maxLength(256)
  machineDetails?: string;

  /**
   * The user-provided name for the bare metal machine created from this specification. If not provided, the machine name will be generated programmatically.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName?: string;

  /**
   * The slot the physical machine is in the rack based on the BOM configuration.
   */
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The serial number of the machine. Hardware suppliers may use an alternate value. For example, service tag.
   */
  @maxLength(64)
  serialNumber: string;
}

/**
 * StorageApplianceConfigurationData represents configuration for the storage application.
 */
model StorageApplianceConfigurationData {
  /**
   * The credentials of the administrative interface on this storage appliance. The password field is expected to be an Azure Key Vault key URL. Until the cluster is converted to utilize managed identity by setting the secret archive settings, the actual password value should be provided instead.
   */
  adminCredentials: AdministrativeCredentials;

  /**
   * The slot that storage appliance is in the rack based on the BOM configuration.
   */
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The serial number of the appliance.
   */
  serialNumber: string;

  /**
   * The user-provided name for the storage appliance that will be created from this specification.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  storageApplianceName?: string;
}

/**
 * AnalyticsOutputSettings represents the settings for the log analytics workspace used for output of logs from this cluster.
 */
model AnalyticsOutputSettings {
  /**
   * The resource ID of the analytics workspace that is to be used by the specified identity.
   */
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The selection of the managed identity to use with this analytics workspace. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;
}

/**
 * IdentitySelector represents the selection of a managed identity for use.
 */
model IdentitySelector {
  /**
   * The type of managed identity that is being selected.
   */
  identityType?: ManagedServiceIdentitySelectorType;

  /**
   * The user assigned managed identity resource ID to use. Mutually exclusive with a system assigned identity type.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * ClusterAvailableUpgradeVersion represents the various cluster upgrade parameters.
 */
model ClusterAvailableUpgradeVersion {
  /**
   * The indicator of whether the control plane will be impacted during the upgrade.
   */
  @visibility(Lifecycle.Read)
  controlImpact?: ControlImpact;

  /**
   * The expected duration needed for this upgrade.
   */
  @visibility(Lifecycle.Read)
  expectedDuration?: string;

  /**
   * The impact description including the specific details and release notes.
   */
  @visibility(Lifecycle.Read)
  impactDescription?: string;

  /**
   * The last date the version of the platform is supported.
   */
  @visibility(Lifecycle.Read)
  supportExpiryDate?: string;

  /**
   * The target version this cluster will be upgraded to.
   */
  @visibility(Lifecycle.Read)
  targetClusterVersion?: string;

  /**
   * The indicator of whether the workload will be impacted during the upgrade.
   */
  @visibility(Lifecycle.Read)
  workloadImpact?: WorkloadImpact;
}

/**
 * ClusterCapacity represents various details regarding compute capacity.
 */
model ClusterCapacity {
  /**
   * The remaining appliance-based storage in GB available for workload use. Measured in gibibytes.
   */
  @clientName("availableApplianceStorageGB")
  @encodedName("application/json", "availableApplianceStorageGB")
  availableApplianceStorageGb?: int64;

  /**
   * The remaining number of cores that are available in this cluster for workload use.
   */
  availableCoreCount?: int64;

  /**
   * The remaining machine or host-based storage in GB available for workload use. Measured in gibibytes.
   */
  @clientName("availableHostStorageGB")
  @encodedName("application/json", "availableHostStorageGB")
  availableHostStorageGb?: int64;

  /**
   * The remaining memory in GB that are available in this cluster for workload use. Measured in gibibytes.
   */
  @clientName("availableMemoryGB")
  @encodedName("application/json", "availableMemoryGB")
  availableMemoryGb?: int64;

  /**
   * The total appliance-based storage in GB supported by this cluster for workload use. Measured in gibibytes.
   */
  @clientName("totalApplianceStorageGB")
  @encodedName("application/json", "totalApplianceStorageGB")
  totalApplianceStorageGb?: int64;

  /**
   * The total number of cores that are supported by this cluster for workload use.
   */
  totalCoreCount?: int64;

  /**
   * The total machine or host-based storage in GB supported by this cluster for workload use. Measured in gibibytes.
   */
  @clientName("totalHostStorageGB")
  @encodedName("application/json", "totalHostStorageGB")
  totalHostStorageGb?: int64;

  /**
   * The total memory supported by this cluster for workload use. Measured in gibibytes.
   */
  @clientName("totalMemoryGB")
  @encodedName("application/json", "totalMemoryGB")
  totalMemoryGb?: int64;
}

/**
 * ServicePrincipalInformation represents the details of the service principal to be used by the cluster during Arc Appliance installation.
 */
model ServicePrincipalInformation {
  /**
   * The application ID, also known as client ID, of the service principal.
   */
  applicationId: string;

  /**
   * The password of the service principal.
   */
  @secret
  password: string;

  /**
   * The principal ID, also known as the object ID, of the service principal.
   */
  principalId: string;

  /**
   * The tenant ID, also known as the directory ID, of the tenant in which the service principal is created.
   */
  tenantId: string;
}

/**
 * CommandOutputSettings represents the settings for commands run within the cluster such as bare metal machine run read-only commands.
 */
model CommandOutputSettings {
  /**
   * The selection of the managed identity to use with this storage account container. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;

  /**
   * The URL of the storage account container that is to be used by the specified identities.
   */
  containerUrl?: url;

  /**
   * The list of optional overrides allowing for association of storage containers and identities to specific types of command output. If a type is not overridden, the default identity and storage container will be utilized.
   */
  @identifiers(#["commandOutputType"])
  overrides?: CommandOutputOverride[];
}

/**
 * CommandOutputOverride represents an overridden value for the command output settings.
 */
model CommandOutputOverride {
  /**
   * The selection of the managed identity to use with this storage account container. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;

  /**
   * The type of command output for the override.
   */
  commandOutputType?: CommandOutputType;

  /**
   * The URL of the storage account container that is to be used by the specified identities.
   */
  containerUrl?: url;
}

/**
 * ValidationThreshold indicates allowed machine and node hardware and deployment failures.
 */
model ValidationThreshold {
  /**
   * Selection of how the type evaluation is applied to the cluster calculation.
   */
  grouping: ValidationThresholdGrouping;

  /**
   * Selection of how the threshold should be evaluated.
   */
  type: ValidationThresholdType;

  /**
   * The numeric threshold value.
   */
  @minValue(0)
  value: int64;
}

/**
 * RuntimeProtectionConfiguration represents the runtime protection configuration for the cluster.
 */
model RuntimeProtectionConfiguration {
  /**
   * The definition update mode for runtime protection.
   */
  @added(Versions.v2026_01_01_preview)
  definitionUpdateMode?: RuntimeProtectionDefinitionUpdateMode = RuntimeProtectionDefinitionUpdateMode.None;

  /**
   * The mode of operation for runtime protection.
   */
  enforcementLevel?: RuntimeProtectionEnforcementLevel = RuntimeProtectionEnforcementLevel.Disabled;
}

/**
 * ClusterSecretArchive configures the key vault to archive the secrets of the cluster for later retrieval.
 */
model ClusterSecretArchive {
  /**
   * The resource ID of the key vault to archive the secrets of the cluster.
   */
  keyVaultId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * The indicator if the specified key vault should be used to archive the secrets of the cluster.
   */
  useKeyVault?: ClusterSecretArchiveEnabled = ClusterSecretArchiveEnabled.False;
}

/**
 * SecretArchiveSettings represents the settings for the secret archive used to hold credentials for the cluster.
 */
model SecretArchiveSettings {
  /**
   * The selection of the managed identity to use with this vault URI. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;

  /**
   * The URI for the key vault used as the secret archive.
   */
  vaultUri?: url;
}

/**
 * ClusterUpdateStrategy represents the strategy for updating the cluster.
 */
model ClusterUpdateStrategy {
  /**
   * The maximum number of worker nodes that can be offline within the increment of update, e.g., rack-by-rack. Limited by the maximum number of machines in the increment. Defaults to the whole increment size.
   */
  @minValue(1)
  maxUnavailable?: int64;

  /**
   * The mode of operation for runtime protection.
   */
  strategyType: ClusterUpdateStrategyType;

  /**
   * Selection of how the threshold should be evaluated.
   */
  thresholdType: ValidationThresholdType;

  /**
   * The numeric threshold value.
   */
  @minValue(0)
  thresholdValue: int64;

  /**
   * The time to wait between the increments of update defined by the strategy.
   */
  @minValue(0)
  @maxValue(60)
  waitTimeMinutes?: int64 = 15;
}

/**
 * VulnerabilityScanningSettings represents the settings for how security vulnerability scanning is applied to the cluster.
 */
model VulnerabilityScanningSettings {
  /**
   * The mode selection for container vulnerability scanning.
   */
  containerScan?: VulnerabilityScanningSettingsContainerScan = VulnerabilityScanningSettingsContainerScan.Enabled;
}

/**
 * ClusterPatchParameters represents the body of the request to patch the cluster properties.
 */
model ClusterPatchParameters {
  /**
   * The identity for the resource.
   */
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The list of the resource properties.
   */
  properties?: ClusterPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * ClusterPatchProperties represents the properties of the cluster for patching.
 */
model ClusterPatchProperties {
  /**
   * The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.
   */
  aggregatorOrSingleRackDefinition?: RackDefinition;

  /**
   * The settings for the log analytics workspace used for output of logs from this cluster.
   */
  analyticsOutputSettings?: AnalyticsOutputSettings;

  /**
   * The customer-provided location information to identify where the cluster resides.
   */
  clusterLocation?: string;

  /**
   * Field Deprecated: Use managed identity to provide cluster privileges. The service principal to be used by the cluster during Arc Appliance installation.
   */
  clusterServicePrincipal?: ServicePrincipalInformation;

  /**
   * The settings for commands run in this cluster, such as bare metal machine run read only commands and data extracts.
   */
  commandOutputSettings?: CommandOutputSettings;

  /**
   * The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
   */
  computeDeploymentThreshold?: ValidationThreshold;

  /**
   * The list of rack definitions for the compute racks in a multi-rack cluster, or an empty list in a single-rack cluster.
   */
  @identifiers(#["networkRackId"])
  computeRackDefinitions?: RackDefinition[];

  /**
   * The settings for cluster runtime protection.
   */
  runtimeProtectionConfiguration?: RuntimeProtectionConfiguration;

  /**
   * The configuration for use of a key vault to store secrets for later retrieval by the operator.
   */
  secretArchive?: ClusterSecretArchive;

  /**
   * The settings for the secret archive used to hold credentials for the cluster.
   */
  secretArchiveSettings?: SecretArchiveSettings;

  /**
   * The strategy for updating the cluster.
   */
  updateStrategy?: ClusterUpdateStrategy;

  /**
   * The settings for how security vulnerability scanning is applied to the cluster.
   */
  vulnerabilityScanningSettings?: VulnerabilityScanningSettingsPatch;
}

/**
 * VulnerabilityScanningSettingsPatch represents the settings for how security vulnerability scanning is applied to the cluster.
 */
model VulnerabilityScanningSettingsPatch {
  /**
   * The mode selection for container vulnerability scanning.
   */
  containerScan?: VulnerabilityScanningSettingsContainerScan;
}

/**
 * ClusterContinueUpdateVersionParameters represents the body of the request to continue the update of a cluster version.
 */
model ClusterContinueUpdateVersionParameters {
  /**
   * The mode by which the cluster will target the next grouping of servers to continue the update.
   */
  machineGroupTargetingMode?: ClusterContinueUpdateVersionMachineGroupTargetingMode = ClusterContinueUpdateVersionMachineGroupTargetingMode.AlphaByRack;

  /**
   * Specifies how safeguards are applied during the continue update version operation. Use All to run all pre‑operation validation checks. Use None to bypass safeguards. If not specified, the default is All.
   */
  @added(Versions.v2026_05_01_preview)
  safeguardMode?: ClusterContinueUpdateVersionSafeguardMode;
}

/**
 * ClusterDeployParameters represents the body of the request to deploy cluster.
 */
model ClusterDeployParameters {
  /**
   * The names of bare metal machines in the cluster that should be skipped during environment validation.
   */
  skipValidationsForMachines?: string[];
}

/**
 * ClusterInspectParameters represents the body of the request to inspect the cluster.
 */
@added(Versions.v2026_01_01_preview)
model ClusterInspectParameters {
  /**
   * Additional actions supplement the default non-disruptive cluster inspection. Additional actions may be disallowed if the cluster is in a deployed and running state.
   */
  additionalActions?: ClusterInspectAdditionalAction[];

  /**
   * Indicates which devices are included in the inspection. By default, all devices that can be targeted will be included in the inspection.
   */
  filterDevices?: FilterDevices;
}

/**
 * FilterDevices defines the filtered target of the inspection.
 */
@added(Versions.v2026_01_01_preview)
model FilterDevices {
  /**
   * The list of bare metal machine names to include in the inspection.
   */
  bareMetalMachineNames?: string[];

  /**
   * The list of rack names to include in the inspection.
   */
  rackNames?: string[];
}

/**
 * ClusterRotateCredentialParameters represents the body of the request to rotate cluster credentials.
 */
@added(Versions.v2026_05_01_preview)
model ClusterRotateCredentialParameters {
  /**
   * The list of credential names for the credentials to rotate.
   */
  credentials: string[];
}

/**
 * ClusterScanRuntimeParameters defines the parameters for the cluster scan runtime operation.
 */
model ClusterScanRuntimeParameters {
  /**
   * The choice of if the scan operation should run the scan.
   */
  scanActivity?: ClusterScanRuntimeParametersScanActivity = ClusterScanRuntimeParametersScanActivity.Scan;
}

/**
 * ClusterUpdateVersionParameters represents the body of the request to update cluster version.
 */
model ClusterUpdateVersionParameters {
  /**
   * Specifies how safeguards are applied during the update version operation. Use All to run all pre‑operation validation checks. Use None to bypass safeguards. If not specified, the default is All.
   */
  @added(Versions.v2026_05_01_preview)
  safeguardMode?: ClusterUpdateVersionSafeguardMode;

  /**
   * The version to be applied to the cluster during update.
   */
  targetClusterVersion: string;
}
