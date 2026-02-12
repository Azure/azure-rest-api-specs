import "./common.tsp";
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("Network Fabric Properties defines the properties of the resource.")
model NetworkFabricProperties {
  ...AnnotationResource;

  @doc("Supported Network Fabric SKU.Example: Compute / Aggregate racks. Once the user chooses a particular SKU, only supported racks can be added to the Network Fabric. The SKU determines whether it is a single / multi rack Network Fabric.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minLength(1)
  networkFabricSku: string;

  @doc("The version of Network Fabric.")
  @minLength(1)
  fabricVersion?: string;

  @doc("Array of router IDs.")
  @visibility(Lifecycle.Read)
  routerIds?: string[];

  @doc("Bring your own storage account configurations for Network Fabric.")
  @added(Versions.v2024_06_15_preview)
  storageAccountConfiguration?: StorageAccountConfiguration;

  @doc("Network Fabric Lock details")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  @minItems(1)
  fabricLocks?: FabricLockProperties[];

  @doc("Azure resource ID for the NetworkFabricController the NetworkFabric belongs.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricControllerId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabricControllers";
    }
  ]>;

  @doc("Number of compute racks associated to Network Fabric.")
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  @doc("Number of servers.Possible values are from 1-16.")
  @maxValue(16)
  @minValue(1)
  serverCountPerRack: int32;

  @doc("IPv4Prefix for Management Network. Example: 10.1.0.0/19.")
  @minLength(1)
  ipv4Prefix: string;

  @doc("IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59")
  @minLength(1)
  ipv6Prefix?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of CE devices for CE/PE connectivity.")
  @maxValue(4294967295)
  @minValue(1)
  fabricASN: int64;

  @doc("Network and credentials configuration currently applied to terminal server.")
  terminalServerConfiguration: TerminalServerConfiguration;

  @doc("Configuration to be used to setup the management network.")
  managementNetworkConfiguration: ManagementNetworkConfigurationProperties;

  @doc("List of NetworkRack resource IDs under the Network Fabric. The number of racks allowed depends on the Network Fabric SKU.")
  @visibility(Lifecycle.Read)
  racks?: string[];

  @doc("List of L2 Isolation Domain resource IDs under the Network Fabric.")
  @visibility(Lifecycle.Read)
  l2IsolationDomains?: string[];

  @doc("List of L3 Isolation Domain resource IDs under the Network Fabric.")
  @visibility(Lifecycle.Read)
  l3IsolationDomains?: string[];

  @doc("Hardware alert threshold percentage. Possible values are from 20 to 100.")
  @added(Versions.v2024_06_15_preview)
  @maxValue(100)
  @minValue(20)
  hardwareAlertThreshold?: int32;

  @doc("Control Plane Access Control List ARM resource IDs.")
  @added(Versions.v2024_06_15_preview)
  controlPlaneAcls?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>[];

  @doc("Feature flag status information")
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  featureFlags?: FeatureFlagProperties[];

  @doc("Trusted IP Prefixes ARM resource IDs.")
  @added(Versions.v2024_06_15_preview)
  trustedIpPrefixes?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/ipPrefixes";
    }
  ]>[];

  @doc("Unique Route Distinguisher configuration")
  @added(Versions.v2024_06_15_preview)
  uniqueRdConfiguration?: UniqueRouteDistinguisherProperties;

  @doc("Number of Storage arrays associated with the Network Fabric.")
  @added(Versions.v2024_06_15_preview)
  @minValue(1)
  @maxValue(2)
  storageArrayCount?: int32;

  @doc("Active commit batch identifiers")
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  activeCommitBatches?: string[];

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Configuration state of the resource.")
  @visibility(Lifecycle.Read)
  configurationState?: ConfigurationState;

  @doc("Provides you the latest status of the NFC service, whether it is Accepted, updating, Succeeded or Failed. During this process, the states keep changing based on the status of NFC provisioning.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;
}

@doc("Network and credentials configuration currently applied to terminal server.")
model TerminalServerConfiguration {
  @doc("Username for the terminal server connection.")
  @minLength(1)
  username: string;

  @doc("Password for the terminal server connection.")
  @secret
  @minLength(1)
  password: string;

  @doc("Serial Number of Terminal server.")
  @minLength(1)
  serialNumber?: string;

  @doc("IPv4 Address Prefix.")
  primaryIpv4Prefix: string;

  @doc("IPv6 Address Prefix.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(Versions.v2024_06_15_preview, "primaryIpv6Prefix")
  primaryIpv6PrefixDeprecated?: string;

  @doc("IPv6 Address Prefix.")
  @added(Versions.v2024_06_15_preview)
  primaryIpv6Prefix?: string;

  @doc("Secondary IPv4 Address Prefix.")
  secondaryIpv4Prefix: string;

  @doc("Secondary IPv6 Address Prefix.")
  secondaryIpv6Prefix?: string;

  @doc("ARM Resource ID used for the NetworkDevice.")
  @visibility(Lifecycle.Read)
  networkDeviceId?: string;
}

@doc("Network and credential configuration currently applied on terminal server.")
model VpnConfigurationProperties {
  @doc("ARM Resource ID of the Network To Network Interconnect.")
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  @doc("Administrative state of the resource.")
  @visibility(Lifecycle.Read)
  administrativeState?: AdministrativeState;

  @doc("Peering option list.")
  peeringOption: PeeringOption;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option B properties")
  optionBProperties?: VpnOptionBProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option A properties")
  optionAProperties?: VpnOptionAProperties;
}

@doc("Configuration to be used to setup the management network.")
model ManagementNetworkConfigurationProperties {
  @doc("VPN Configuration properties.")
  infrastructureVpnConfiguration: VpnConfigurationProperties;

  @doc("VPN Configuration properties.")
  workloadVpnConfiguration: VpnConfigurationProperties;
}

@doc("Network and credential configuration currently applied on terminal server.")
model VpnConfigurationPatchableProperties {
  @doc("ARM Resource ID of the Network To Network Interconnect.")
  networkToNetworkInterconnectId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics/networkToNetworkInterconnects";
    }
  ]>;

  @doc("Peering option list.")
  peeringOption?: PeeringOption;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option B properties")
  optionBProperties?: VpnOptionBPatchProperties;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("option A properties")
  optionAProperties?: VpnOptionAPatchProperties;
}

@doc("The Network Fabric resource definition.")
model NetworkFabricPatch {
  ...TagsUpdate;

  @doc("Network Fabric Patch properties.")
  properties?: NetworkFabricPatchProperties;

  @added(Versions.v2024_06_15_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: ManagedServiceIdentityPatch;
}

@doc("Network Fabric Patch properties.")
model NetworkFabricPatchProperties {
  ...AnnotationResource;

  @doc("Number of compute racks associated to Network Fabric.")
  @maxValue(8)
  @minValue(1)
  rackCount?: int32;

  @doc("Number of servers.Possible values are from 1-16.")
  @maxValue(16)
  @minValue(1)
  serverCountPerRack?: int32;

  @doc("IPv4Prefix for Management Network. Example: 10.1.0.0/19.")
  @minLength(1)
  ipv4Prefix?: string;

  @doc("IPv6Prefix for Management Network. Example: 3FFE:FFFF:0:CD40::/59.")
  @minLength(1)
  ipv6Prefix?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("ASN of CE devices for CE/PE connectivity.")
  @maxValue(4294967295)
  @minValue(1)
  fabricASN?: int64;

  @doc("Bring your own storage account configurations for Network Fabric.")
  @added(Versions.v2024_06_15_preview)
  storageAccountConfiguration?: StorageAccountPatchConfiguration;

  @doc("Network and credentials configuration already applied to terminal server.")
  terminalServerConfiguration?: TerminalServerPatchConfiguration;

  @doc("Configuration to be used to setup the management network.")
  managementNetworkConfiguration?: ManagementNetworkPatchConfiguration;

  @doc("Hardware alert threshold percentage. Possible values are from 20 to 100.")
  @added(Versions.v2024_06_15_preview)
  @maxValue(100)
  @minValue(20)
  hardwareAlertThreshold?: int32;

  @doc("Control Plane Access Control List ARM resource IDs.")
  @added(Versions.v2024_06_15_preview)
  controlPlaneAcls?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/accessControlLists";
    }
  ]>[];

  @doc("Trusted IP Prefix ARM resource IDs.")
  @added(Versions.v2024_06_15_preview)
  trustedIpPrefixes?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/ipPrefixes";
    }
  ]>[];

  @doc("Unique Route Distinguisher configuration")
  @added(Versions.v2024_06_15_preview)
  uniqueRdConfiguration?: UniqueRouteDistinguisherPatchProperties;
}

@doc("Network and credentials configuration already applied to terminal server.")
model TerminalServerPatchConfiguration {
  @doc("Username for the terminal server connection.")
  @minLength(1)
  username?: string;

  @doc("Password for the terminal server connection.")
  @secret
  @minLength(1)
  password?: string;

  @doc("Serial Number of Terminal server.")
  @minLength(1)
  serialNumber?: string;

  @doc("IPv4 Address Prefix.")
  primaryIpv4Prefix?: string;

  @doc("IPv6 Address Prefix.")
  primaryIpv6Prefix?: string;

  @doc("Secondary IPv4 Address Prefix.")
  secondaryIpv4Prefix?: string;

  @doc("Secondary IPv6 Address Prefix.")
  secondaryIpv6Prefix?: string;
}

@doc("Configuration to be used to setup the management network.")
model ManagementNetworkPatchConfiguration {
  @doc("VPN Configuration properties.")
  infrastructureVpnConfiguration?: VpnConfigurationPatchableProperties;

  @doc("VPN Configuration properties.")
  workloadVpnConfiguration?: VpnConfigurationPatchableProperties;
}

@doc("Model used for Upgrade Network Fabric Properties")
model UpgradeNetworkFabricProperties {
  ...UpdateVersion;

  @doc("Action to be performed while upgrading the fabric.")
  action?: NetworkFabricUpgradeAction;
}

@doc("Validation configuration properties.")
model ValidateConfigurationProperties {
  @doc("Validate action that to be performed")
  validateAction?: ValidateAction;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("option A properties")
model VpnOptionAProperties {
  @doc("MTU to use for option A peering.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32 = 1500;

  @doc("Vlan Id.Example : 501")
  @maxValue(4094)
  @minValue(501)
  vlanId: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Peer ASN number.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN: int64;

  @doc("BFD Configuration properties.")
  bfdConfiguration?: BfdConfiguration;

  ...Layer3IpPrefixProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Peering optionA properties")
model VpnOptionAPatchProperties {
  @doc("MTU to use for option A peering.")
  @maxValue(9200)
  @minValue(64)
  mtu?: int32;

  @doc("Vlan Id.Example : 501")
  @maxValue(4094)
  @minValue(501)
  vlanId?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
  @doc("Peer ASN number.Example : 28")
  @maxValue(4294967295)
  @minValue(1)
  peerASN?: int64;

  @doc("BFD Configuration properties.")
  bfdConfiguration?: BfdPatchConfiguration;

  ...Layer3IpPrefixPatchProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Option B configuration to be used for Management VPN.")
model VpnOptionBProperties {
  @doc("Route Targets to be applied for incoming routes into CE. This is for backward compatibility.")
  importRouteTargets?: string[];

  @doc("Route Targets to be applied for outgoing routes from CE. This is for backward compatibility.")
  exportRouteTargets?: string[];

  @doc("Route Targets to be applied.")
  routeTargets?: RouteTargetInformation;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "This is a valid resource name."
@doc("Option B configuration to be used for Management VPN.")
model VpnOptionBPatchProperties {
  @doc("Route Targets to be applied for incoming routes into CE. This is for backward compatibility.")
  importRouteTargets?: string[];

  @doc("Route Targets to be applied for outgoing routes from CE. This is for backward compatibility.")
  exportRouteTargets?: string[];

  @doc("Route Targets to be applied.")
  routeTargets?: RouteTargetPatchInformation;
}

@doc("Validate action that to be performed")
union ValidateAction {
  @doc("ValidateAction-Cabling")
  Cabling: "Cabling",

  @doc("ValidateAction-Configuration")
  Configuration: "Configuration",

  @doc("ValidateAction-Connectivity")
  Connectivity: "Connectivity",

  string,
}

@doc("Action to be performed while upgrading the fabric.")
union NetworkFabricUpgradeAction {
  @doc("UpgradeAction-Start")
  Start: "Start",

  @doc("UpgradeAction -Complete")
  Complete: "Complete",

  string,
}

@doc("Network Fabric Lock Request.")
@added(Versions.v2024_06_15_preview)
model NetworkFabricLockRequest {
  @doc("Type of lock to be applied")
  lockType?: NetworkFabricLockType;

  @doc("Action to be performed on the lock")
  action?: NetworkFabricLockAction;
}

@doc("Storage account configuration.")
@added(Versions.v2024_06_15_preview)
model StorageAccountConfiguration {
  @doc("Network Fabric storage account resource identifier.")
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The selection of the managed identity to use with this storage account. The identity type must be either system assigned or user assigned.")
  storageAccountIdentity?: IdentitySelector;
}

@doc("Storage account configuration.")
@added(Versions.v2024_06_15_preview)
model StorageAccountPatchConfiguration {
  @doc("Network Fabric storage account resource identifier.")
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The selection of the managed identity to use with this storage account. The identity type must be either system assigned or user assigned.")
  storageAccountIdentity?: IdentitySelectorPatch;
}

@doc("Network Fabric Lock Configuration.")
@added(Versions.v2024_06_15_preview)
model FabricLockProperties {
  @doc("NetworkFabric Lock State.")
  lockState?: LockConfigurationState;

  @doc("NetworkFabric Lock Type.")
  lockType?: NetworkFabricLockType;
}

@doc("Lock Configuration State.")
@added(Versions.v2024_06_15_preview)
union LockConfigurationState {
  @doc("LockConfigurationState Enabled")
  Enabled: "Enabled",

  @doc("LockConfigurationState Disabled")
  Disabled: "Disabled",

  string,
}

@doc("Network fabric lock action")
@added(Versions.v2024_06_15_preview)
union NetworkFabricLockAction {
  @doc("Perform lock operation")
  Lock: "Lock",

  @doc("Perform unlock operation")
  Unlock: "Unlock",

  string,
}

@doc("Network fabric lock type")
@added(Versions.v2024_06_15_preview)
union NetworkFabricLockType {
  @doc("A administrative lock/unlock operation will be performed")
  Administrative: "Administrative",

  @doc("A lock/unlock operation will be performed on the configuration")
  Configuration: "Configuration",

  string,
}

@doc("Feature flag properties.")
@added(Versions.v2024_06_15_preview)
model FeatureFlagProperties {
  @doc("Feature flag name.")
  featureFlagName?: string;

  @doc("Feature flag value.")
  featureFlagValue?: string;
}

@doc("Arm Configuration Diff Response.")
@added(Versions.v2024_06_15_preview)
model ArmConfigurationDiffResponse {
  @doc("Storage URL to the diff file.")
  configurationDiffUrl?: string;

  ...ErrorResponse;
}

@doc("View Device Configuration Response.")
@added(Versions.v2024_06_15_preview)
model ViewDeviceConfigurationResponse {
  @doc("Storage URL to the device configuration file.")
  deviceConfigurationUrl?: string;

  ...ErrorResponse;
}

@doc("Unique Route Distinguisher properties.")
@added(Versions.v2024_06_15_preview)
model UniqueRouteDistinguisherProperties {
  @doc("Unique Route Distinguisher configuration state. Default is Enabled.")
  @added(Versions.v2024_06_15_preview)
  uniqueRdConfigurationState?: UniqueRouteDistinguisherConfigurationState = UniqueRouteDistinguisherConfigurationState.Enabled;

  @doc("List of Unique Route Distinguisher addresses.")
  @added(Versions.v2024_06_15_preview)
  @visibility(Lifecycle.Read)
  uniqueRds?: string[];

  @doc("NNI derived unique Route Distinguisher state. Default is Disabled.")
  @added(Versions.v2024_06_15_preview)
  nniDerivedUniqueRdConfigurationState?: NNIDerivedUniqueRouteDistinguisherConfigurationState = NNIDerivedUniqueRouteDistinguisherConfigurationState.Disabled;
}

@doc("Unique Route Distinguisher configuration properties.")
@added(Versions.v2024_06_15_preview)
model UniqueRouteDistinguisherPatchProperties {
  @doc("Unique Route Distinguisher configuration state. Default is Enabled.")
  @added(Versions.v2024_06_15_preview)
  uniqueRdConfigurationState?: UniqueRouteDistinguisherConfigurationState;

  @doc("NNI derived unique Route Distinguisher state. Default is Disabled.")
  @added(Versions.v2024_06_15_preview)
  nniDerivedUniqueRdConfigurationState?: NNIDerivedUniqueRouteDistinguisherConfigurationState;
}

@doc("Commit Batch Status Request.")
@added(Versions.v2024_06_15_preview)
model CommitBatchStatusRequest {
  @doc("Commit Batch Identifier. If not provided, the latest commit batch status will be returned.")
  commitBatchId?: string;
}

@doc("Commit Batch Status Response.")
@added(Versions.v2024_06_15_preview)
model CommitBatchStatusResponse {
  @doc("Commit Batch Identifier.")
  commitBatchId?: string;

  @doc("Commit Batch State.")
  commitBatchState?: CommitBatchState;

  @doc("Commit Batch Details.")
  commitBatchDetails?: CommitBatchDetails;

  ...ErrorResponse;
}

@doc("Discard Commit Batch Request.")
@added(Versions.v2024_06_15_preview)
model DiscardCommitBatchRequest {
  @doc("Commit Batch Identifier. If not provided, the latest commit batch status will be returned.")
  commitBatchId?: string;
}

@doc("Discard Commit Batch Response.")
@added(Versions.v2024_06_15_preview)
model DiscardCommitBatchResponse {
  @doc("Commit Batch Identifier.")
  commitBatchId?: string;

  ...ErrorResponse;
}

@doc("Commit Batch State.")
@added(Versions.v2024_06_15_preview)
union CommitBatchState {
  @doc("CommitBatchState-PartialSuccess")
  Processing: "Processing",

  @doc("CommitBatchState-Succeeded")
  Succeeded: "Succeeded",

  @doc("CommitBatchState-Failed")
  Failed: "Failed",

  string,
}

@doc("Commit Batch Details.")
@added(Versions.v2024_06_15_preview)
model CommitBatchDetails {
  @doc("List of devices for which the commit operation failed.")
  failedDevices?: string[];
}
