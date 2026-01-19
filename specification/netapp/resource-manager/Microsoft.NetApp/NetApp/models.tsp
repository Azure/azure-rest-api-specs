import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Microsoft.NetApp;

@minLength(1)
@maxLength(1024)
scalar FileName extends string;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union MetricAggregationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Average: "Average",
}

/**
 * Resource type used for verification.
 */
union CheckNameResourceTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts`: "Microsoft.NetApp/netAppAccounts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools`: "Microsoft.NetApp/netAppAccounts/capacityPools",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots",

  /**
   * ANF Backup under a volume , deprecated, use `Microsoft.NetApp/netAppAccounts/backupVaults/backups` instead.
   */
  @added(Versions.v2025_09_01)
  `Microsoft.NetApp/netAppAccounts/backupVaults/backups`: "Microsoft.NetApp/netAppAccounts/backupVaults/backups",

  /**
   * ANF Backup under a Backup Vault
   */
  @added(Versions.v2025_09_01)
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/backups`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/backups",
}

/**
 * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
 */
union InAvailabilityReasonType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Resource type used for verification.
 */
union CheckQuotaNameResourceTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts`: "Microsoft.NetApp/netAppAccounts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools`: "Microsoft.NetApp/netAppAccounts/capacityPools",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots",

  /**
   * ANF Backup under a volume , deprecated, use `Microsoft.NetApp/netAppAccounts/backupVaults/backups` instead.
   */
  @added(Versions.v2025_09_01)
  `Microsoft.NetApp/netAppAccounts/backupVaults/backups`: "Microsoft.NetApp/netAppAccounts/backupVaults/backups",

  /**
   * ANF Backup under a Backup Vault
   */
  @added(Versions.v2025_09_01)
  `Microsoft.NetApp/netAppAccounts/capacityPools/volumes/backups`: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes/backups",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Provides storage to network proximity information in the region.
 */
union RegionStorageToNetworkProximity {
  string,

  /**
   * Basic network connectivity.
   */
  Default: "Default",

  /**
   * Standard T1 network connectivity.
   */
  T1: "T1",

  /**
   * Standard T2 network connectivity.
   */
  T2: "T2",

  /**
   * Standard AcrossT2 network connectivity.
   */
  AcrossT2: "AcrossT2",

  /**
   * Standard T1 and T2 network connectivity.
   */
  T1AndT2: "T1AndT2",

  /**
   * Standard T1 and AcrossT2 network connectivity.
   */
  T1AndAcrossT2: "T1AndAcrossT2",

  /**
   * Standard T2 and AcrossT2 network connectivity.
   */
  T2AndAcrossT2: "T2AndAcrossT2",

  /**
   * Standard T1, T2 and AcrossT2 network connectivity.
   */
  T1AndT2AndAcrossT2: "T1AndT2AndAcrossT2",
}

/**
 * Network features available to the volume, or current state of update.
 */
union NetworkFeatures {
  string,

  /**
   * Basic network features.
   */
  Basic: "Basic",

  /**
   * Standard network features.
   */
  Standard: "Standard",

  /**
   * Updating from Basic to Standard network features.
   */
  Basic_Standard: "Basic_Standard",

  /**
   * Updating from Standard to Basic network features.
   */
  Standard_Basic: "Standard_Basic",
}

/**
 * Gets the status of the NetworkSiblingSet at the time the operation was called.
 */
union NetworkSiblingSetProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * Status of the Active Directory
 */
union ActiveDirectoryStatus {
  string,

  /**
   * Active Directory created but not in use
   */
  Created: "Created",

  /**
   * Active Directory in use by SMB Volume
   */
  InUse: "InUse",

  /**
   * Active Directory Deleted
   */
  Deleted: "Deleted",

  /**
   * Error with the Active Directory
   */
  Error: "Error",

  /**
   * Active Directory Updating
   */
  Updating: "Updating",
}

/**
 * The encryption keySource (provider). Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault
 */
union KeySource {
  string,

  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`: "Microsoft.NetApp",

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * The encryption keySource (provider) for ANF Elastic resources. Possible values (case-insensitive):  Microsoft.NetApp, Microsoft.KeyVault
 */
@added(Versions.v2025_09_01_preview)
union ElasticKeySource {
  string,

  /**
   * Microsoft-managed key encryption
   */
  `Microsoft.NetApp`: "Microsoft.NetApp",

  /**
   * Customer-managed key encryption
   */
  `Microsoft.KeyVault`: "Microsoft.KeyVault",
}

/**
 * Gets the status of the VolumeQuotaRule at the time the operation was called.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union NetAppProvisioningState {
  string,

  /**
   * Resource has been Accepted
   */
  Accepted: "Accepted",

  /**
   * Resource is being Created
   */
  Creating: "Creating",

  /**
   * Resource is being Patched
   */
  Patching: "Patching",

  /**
   * Resource is updating
   */
  @added(Versions.v2025_09_01)
  Updating: "Updating",

  /**
   * Resource is being Deleted
   */
  Deleting: "Deleting",

  /**
   * Resource is being Moved
   */
  Moving: "Moving",

  /**
   * Resource has Failed
   */
  Failed: "Failed",

  /**
   * Resource has Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * Microsoft.NetApp REST API operation definition.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * The origin of operations.
   */
  origin?: string;

  /**
   * Properties of operation, include metric specifications.
   */
  properties?: OperationProperties;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft NetApp.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed etc.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Operation description.
   */
  description?: string;
}

/**
 * Properties of operation, include metric specifications.
 */
model OperationProperties {
  /**
   * One property of operation, include metric specifications.
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * One property of operation, include metric specifications.
 */
model ServiceSpecification {
  /**
   * Metric specifications of operation.
   */
  @identifiers(#["name"])
  metricSpecifications?: MetricSpecification[];

  /**
   * Log specification of operation.
   */
  @identifiers(#["name"])
  logSpecifications?: LogSpecification[];
}

/**
 * Metric specification of operation.
 */
model MetricSpecification {
  /**
   * Name of metric specification.
   */
  name?: string;

  /**
   * Display name of metric specification.
   */
  displayName?: string;

  /**
   * Display description of metric specification.
   */
  displayDescription?: string;

  /**
   * Unit could be Bytes or Count.
   */
  unit?: string;

  /**
   * Support metric aggregation type.
   */
  supportedAggregationTypes?: MetricAggregationType[];

  /**
   * The supported time grain types for the metrics.
   */
  supportedTimeGrainTypes?: string[];

  /**
   * The internal metric name.
   */
  internalMetricName?: string;

  /**
   * Whether or not the service is using regional MDM accounts.
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * The source MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * The source MDM namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * Dimensions of blobs, including blob type and access tier.
   */
  @identifiers(#["name"])
  dimensions?: Dimension[];

  /**
   * Aggregation type could be Average.
   */
  aggregationType?: string;

  /**
   * The property to decide fill gap with zero or not.
   */
  fillGapWithZero?: boolean;

  /**
   * The category this metric specification belong to, could be Capacity.
   */
  category?: string;

  /**
   * Account Resource Id.
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * Whether the metric is internal.
   */
  isInternal?: boolean;
}

/**
 * Dimension of blobs, possibly be blob type or access tier.
 */
model Dimension {
  /**
   * Display name of dimension.
   */
  name?: string;

  /**
   * Display name of dimension.
   */
  displayName?: string;
}

/**
 * Log Definition of a single resource metric.
 */
model LogSpecification {
  /**
   * Name of log specification.
   */
  name?: string;

  /**
   * Display name of log specification.
   */
  displayName?: string;
}

/**
 * Resource name availability request content.
 */
model ResourceNameAvailabilityRequest {
  /**
   * Resource name to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: CheckNameResourceTypes;

  /**
   * Resource group name.
   */
  resourceGroup: string;
}

/**
 * Information regarding availability of a resource.
 */
model CheckAvailabilityResponse {
  /**
   * <code>true</code> indicates name is valid and available. <code>false</code> indicates the name is invalid, unavailable, or both.
   */
  isAvailable?: boolean;

  /**
   * <code>Invalid</code> indicates the name provided does not match Azure App Service naming requirements. <code>AlreadyExists</code> indicates that the name is already in use and is therefore unavailable.
   */
  reason?: InAvailabilityReasonType;

  /**
   * If reason == invalid, provide the user with the reason why the given name is invalid, and provide the resource naming requirements so that the user can select a valid name. If reason == AlreadyExists, explain that resource name is already in use, and direct them to select a different name.
   */
  message?: string;
}

/**
 * File path availability request content - availability is based on the name and the subnetId.
 */
model FilePathAvailabilityRequest {
  /**
   * File path to verify.
   */
  name: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes
   */
  subnetId: string;

  /**
   * The Azure Resource logical availability zone which is used within zone mapping lookup for the subscription and region. The lookup will retrieve the physical zone where volume is placed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "For backward compatibility"
  availabilityZone?: string | null;
}

/**
 * Quota availability request content.
 */
model QuotaAvailabilityRequest {
  /**
   * Name of the resource to verify.
   */
  name: string;

  /**
   * Resource type used for verification.
   */
  type: CheckQuotaNameResourceTypes;

  /**
   * Resource group name.
   */
  resourceGroup: string;
}

/**
 * Usages result
 */
model UsagesListResult is Azure.Core.Page<UsageResult>;

/**
 * Usages entity model
 */
model UsageResult {
  /**
   * The id of the usage.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the usage.
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;

  /**
   * Usage properties
   */
  properties?: UsageProperties;
}

/**
 * The name of the usage.
 */
model UsageName {
  /**
   * The name of the usage.
   */
  value?: string;

  /**
   * The localized name of the usage.
   */
  localizedValue?: string;
}

/**
 * Usage properties
 */
model UsageProperties {
  /**
   * The current usage value for the subscription.
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * The limit of the usage.
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * The unit of the usage.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * Provides region specific information.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RegionInfo {
  /**
   * Provides storage to network proximity information in the region.
   */
  storageToNetworkProximity?: RegionStorageToNetworkProximity;

  /**
   * Provides logical availability zone mappings for the subscription for a region.
   */
  @identifiers(#["availabilityZone"])
  availabilityZoneMappings?: RegionInfoAvailabilityZoneMappingsItem[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
@clientName("AvailabilityZoneMapping", "csharp")
model RegionInfoAvailabilityZoneMappingsItem {
  /**
   * Logical availability zone.
   */
  availabilityZone?: string;

  /**
   * Available availability zone
   */
  isAvailable?: boolean;
}

/**
 * Network sibling set query.
 */
model QueryNetworkSiblingSetRequest {
  /**
   * Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/**
 * Describes the contents of a network sibling set.
 */
model NetworkSiblingSet {
  /**
   * Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId?: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Network sibling set state Id identifying the current state of the sibling set.
   */
  networkSiblingSetStateId?: string;

  /**
   * Network features available to the volume, or current state of update.
   */
  networkFeatures?: NetworkFeatures = NetworkFeatures.Basic;

  /**
   * Gets the status of the NetworkSiblingSet at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NetworkSiblingSetProvisioningState;

  /**
   * List of NIC information
   */
  @identifiers(#[])
  nicInfoList?: NicInfo[];
}

/**
 * NIC information and list of volumes for which the NIC has the primary mount IP Address.
 */
model NicInfo {
  /**
   * IP Address
   */
  @visibility(Lifecycle.Read)
  ipAddress?: string;

  /**
   * Volume resource Ids
   */
  volumeResourceIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetApp/netAppAccounts/capacityPools/volumes";
    }
  ]>[];
}

/**
 * Network sibling set update.
 */
model UpdateNetworkSiblingSetRequest {
  /**
   * Network Sibling Set ID for a group of volumes sharing networking resources in a subnet.
   */
  @maxLength(36)
  @minLength(36)
  @pattern("^[a-fA-F0-9]{8}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{4}-[a-fA-F0-9]{12}$")
  networkSiblingSetId: string;

  /**
   * The Azure Resource URI for a delegated subnet. Must have the delegation Microsoft.NetApp/volumes. Example /subscriptions/subscriptionId/resourceGroups/resourceGroup/providers/Microsoft.Network/virtualNetworks/testVnet/subnets/{mySubnet}
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Network sibling set state Id identifying the current state of the sibling set.
   */
  networkSiblingSetStateId: string;

  /**
   * Network features available to the volume.
   */
  networkFeatures: NetworkFeatures = NetworkFeatures.Basic;
}

/**
 * Encryption transition request
 */
model EncryptionTransitionRequest {
  /**
   * Identifier for the virtual network
   */
  virtualNetworkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * Identifier of the private endpoint to reach the Azure Key Vault
   */
  privateEndpointId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

/**
 * Result of getKeyVaultStatus with information about how volumes under NetApp account are encrypted.
 */
model GetKeyVaultStatusResponse {
  /**
   * Represents the properties of the getKeyVaultStatus.
   */
  properties?: GetKeyVaultStatusResponseProperties;
}

/**
 * Properties which represents Change key vault status.
 */
model GetKeyVaultStatusResponseProperties {
  /**
   * The URI of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultUri?: url;

  /**
   * The name of the key that should be used for encryption.
   */
  keyName?: string;

  /**
   * Azure resource ID of the key vault/managed HSM that should be used for encryption.
   */
  keyVaultResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * Pairs of virtual network ID and private endpoint ID. Every virtual network that has volumes encrypted with customer-managed keys needs its own key vault private endpoint.
   */
  @identifiers(#["virtualNetworkId"])
  keyVaultPrivateEndpoints?: KeyVaultPrivateEndpoint[];
}

/**
 * Pairs of virtual network ID and private endpoint ID. Every virtual network that has volumes encrypted with customer-managed keys needs its own key vault private endpoint.
 */
model KeyVaultPrivateEndpoint {
  /**
   * Identifier for the virtual network id
   */
  virtualNetworkId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks";
    }
  ]>;

  /**
   * Identifier of the private endpoint to reach the Azure Key Vault
   */
  privateEndpointId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

/**
 * A list of REST API operations supported by an Azure Resource Provider. It contains an URL link to get the next set of results.
 */
model OperationListResult is Azure.Core.Page<Operation>;
