import "@azure-tools/typespec-client-generator-core";
import "./Compute/client.tsp";
import "./ComputeDisk/client.tsp";
import "./ComputeGallery/main.tsp";
import "./ComputeSku/main.tsp";

using Azure.ClientGenerator.Core;
using Common;
using Compute;
using ComputeDisk;
using ComputeGallery;
using ComputeSku;

/**
 * Compute Client
 */
@client(
  {
    name: "ComputeClient",
    service: [Compute, ComputeDisk, ComputeGallery, ComputeSku],
    autoMergeService: true,
  },
  "!(javascript, python)"
)
@client(
  {
    name: "ComputeManagementClient",
    service: [Compute, ComputeDisk, ComputeGallery, ComputeSku],
    autoMergeService: true,
  },
  "javascript, python"
)
namespace ComputeCombine;

// VirtualMachineInstanceView needs input usage for premium layer constructor and setters
@@usage(
  VirtualMachineInstanceView,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// AvailabilitySetSkuTypes needs public access and input+output usage for premium layer
@@access(AvailabilitySetSkuTypes, Access.public, "java");
@@usage(
  AvailabilitySetSkuTypes,

    | Azure.ClientGenerator.Core.Usage.input
    | Azure.ClientGenerator.Core.Usage.output,
  "java"
);

// TODO: maximumDuration type changed from String to Duration, revert to String to avoid breaking change
@@alternateType(
  VirtualMachineInstallPatchesParameters.maximumDuration,
  string,
  "java"
);

// PurchasePlan needs input usage for premium layer constructor and setters
@@usage(PurchasePlan, Azure.ClientGenerator.Core.Usage.input, "java");

// Property name changes: retain old Java names for ComputeGallery and ComputeSku models
@@clientName(AccessControlRulesIdentity.userName, "username", "java");
@@clientName(ResourceSkuCosts.meterID, "meterId", "java");

// Rename model to match old Swagger-generated name
@@clientName(
  UserAssignedIdentitiesValue,
  "VirtualMachineIdentityUserAssignedIdentities",
  "java"
);

// ── C# type renames for backward compatibility (migration from AutoRest) ──

// Common namespace types
// Common.SubResource has a writable id → maps to ComputeWriteableSubResourceData (matches old AutoRest).
// Common.SubResourceReadOnly has a read-only id → maps to ComputeSubResourceData (matches old AutoRest).
@@clientName(Common.SubResource, "ComputeWriteableSubResourceData", "csharp");
@@clientName(Common.SubResourceReadOnly, "ComputeSubResourceData", "csharp");

// SubResource/WritableSubResource properties now use Compute-local subresource models.
// Keep generated names distinct so SDK customizations can restore the old ARM common
// SubResource/WritableSubResource property names for binary compatibility.
@@clientName(
  AvailabilitySetProperties.virtualMachines,
  "VirtualMachineResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetIPConfigurationProperties.applicationGatewayBackendAddressPools,
  "ApplicationGatewayBackendAddressPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetIPConfigurationProperties.applicationSecurityGroups,
  "ApplicationSecurityGroupResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetIPConfigurationProperties.loadBalancerBackendAddressPools,
  "LoadBalancerBackendAddressPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetIPConfigurationProperties.loadBalancerInboundNatPools,
  "LoadBalancerInboundNatPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateIPConfigurationProperties.applicationGatewayBackendAddressPools,
  "ApplicationGatewayBackendAddressPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateIPConfigurationProperties.applicationSecurityGroups,
  "ApplicationSecurityGroupResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateIPConfigurationProperties.loadBalancerBackendAddressPools,
  "LoadBalancerBackendAddressPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateIPConfigurationProperties.loadBalancerInboundNatPools,
  "LoadBalancerInboundNatPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.applicationSecurityGroups,
  "ApplicationSecurityGroupResources",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.applicationGatewayBackendAddressPools,
  "ApplicationGatewayBackendAddressPoolResources",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceIPConfigurationProperties.loadBalancerBackendAddressPools,
  "LoadBalancerBackendAddressPoolResources",
  "csharp"
);
@@clientName(
  DedicatedHostGroupProperties.hosts,
  "DedicatedHostResources",
  "csharp"
);
@@clientName(
  DedicatedHostProperties.virtualMachines,
  "VirtualMachineResources",
  "csharp"
);
@@clientName(
  CapacityReservationGroupProperties.capacityReservations,
  "CapacityReservationResources",
  "csharp"
);
@@clientName(
  CapacityReservationGroupProperties.virtualMachinesAssociated,
  "AssociatedVirtualMachineResources",
  "csharp"
);
@@clientName(
  CapacityReservationProperties.virtualMachinesAssociated,
  "AssociatedVirtualMachineResources",
  "csharp"
);
@@clientName(
  ResourceSharingProfile.subscriptionIds,
  "SharingSubscriptionResources",
  "csharp"
);
@@clientName(RestorePointProperties.excludeDisks, "ExcludedDisks", "csharp");
@@clientName(
  RestartRecoveryPolicy.enabled,
  "IsRestartRecoveryPolicyEnabled",
  "csharp"
);
@@clientName(
  StartRecoveryPolicy.enabled,
  "IsStartRecoveryPolicyEnabled",
  "csharp"
);
@@clientName(
  ReimageRecoveryPolicy.enabled,
  "IsReimageRecoveryPolicyEnabled",
  "csharp"
);

// Replace Compute's local ExtendedLocation / ExtendedLocationType with ARM common types
@@alternateType(
  Common.ExtendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(
  ComputeSku.ResourceSkuLocationInfo.type,
  Azure.ResourceManager.CommonTypes.ExtendedLocationType,
  "csharp"
);

// ComputeSku namespace types
@@clientName(ComputeSku.ResourceSku, "ComputeResourceSku", "csharp");
@@clientName(
  ComputeSku.ResourceSkuCapabilities,
  "ComputeResourceSkuCapabilities",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuCapacity,
  "ComputeResourceSkuCapacity",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuCapacityScaleType,
  "ComputeResourceSkuCapacityScaleType",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuLocationInfo,
  "ComputeResourceSkuLocationInfo",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuRestrictionInfo,
  "ComputeResourceSkuRestrictionInfo",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuRestrictions,
  "ComputeResourceSkuRestrictions",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuRestrictionsReasonCode,
  "ComputeResourceSkuRestrictionsReasonCode",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuRestrictionsType,
  "ComputeResourceSkuRestrictionsType",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuZoneDetails,
  "ComputeResourceSkuZoneDetails",
  "csharp"
);

// ComputeSku property renames (C# backward compat)
@@clientName(ComputeSku.ResourceSkuCosts.meterID, "MeterId", "csharp");
@@clientName(
  ComputeSku.ResourceSkuRestrictions.type,
  "RestrictionsType",
  "csharp"
);
@@clientName(
  ComputeSku.ExtendedLocationType,
  "ComputeExtendedLocationType",
  "csharp"
);
@@clientName(
  ComputeSku.ResourceSkuLocationInfo.type,
  "ExtendedLocationType",
  "csharp"
);

// ── alternateType: SubResource.id → ResourceIdentifier for C# (migration from AutoRest) ──
@@alternateType(
  Common.SubResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// NOTE: Common.Architecture → ArchitectureType is handled by auto-rename of Compute.ArchitectureTypes → ArchitectureType

// ── Consolidate duplicate enums into the C# baseline names (G1) ──
// Baseline shipped a single ArchitectureType / HyperVGeneration / IPVersion;
// the spec splits them into multiple unions. Retype the minority-enum properties
// to the canonical union so the C# SDK exposes a single type per concept.
@@alternateType(
  ComputeDisk.SupportedCapabilities.architecture,
  Compute.ArchitectureTypes,
  "csharp"
);
@@alternateType(
  ComputeGallery.GalleryImageProperties.architecture,
  Compute.ArchitectureTypes,
  "csharp"
);
@@alternateType(
  ComputeGallery.SharedGalleryImageProperties.architecture,
  Compute.ArchitectureTypes,
  "csharp"
);
@@alternateType(
  ComputeGallery.CommunityGalleryImageProperties.architecture,
  Compute.ArchitectureTypes,
  "csharp"
);

@@alternateType(
  Compute.VirtualMachineImageProperties.hyperVGeneration,
  Common.HyperVGeneration,
  "csharp"
);
@@alternateType(
  Compute.ImageProperties.hyperVGeneration,
  Common.HyperVGeneration,
  "csharp"
);
@@alternateType(
  Compute.RestorePointSourceMetadata.hyperVGeneration,
  Common.HyperVGeneration,
  "csharp"
);
@@alternateType(
  Compute.VirtualMachineInstanceView.hyperVGeneration,
  Common.HyperVGeneration,
  "csharp"
);

@@alternateType(
  Compute.VirtualMachineNetworkInterfaceIPConfigurationProperties.privateIPAddressVersion,
  Compute.IPVersion,
  "csharp"
);
@@alternateType(
  Compute.VirtualMachinePublicIPAddressConfigurationProperties.publicIPAddressVersion,
  Compute.IPVersion,
  "csharp"
);

// ── G2: location / resourceType narrowed to string in spec; restore Azure.Core.azureLocation/armResourceType ──
@@alternateType(
  ComputeSku.ResourceSku.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(
  ComputeSku.ResourceSkuRestrictionInfo.locations,
  Azure.Core.azureLocation[],
  "csharp"
);
@@alternateType(
  ComputeSku.ResourceSkuLocationInfo.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  ComputeDisk.DiskRestorePointProperties.sourceResourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  ComputeGallery.PirResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  ComputeGallery.PirCommunityGalleryResource.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  Compute.RestorePointCollectionSourceProperties.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  Compute.RestorePointSourceMetadata.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  Compute.UpgradeOperationHistoricalStatusInfo.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  Compute.VirtualMachineScaleSetVMExtension.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  Compute.VirtualMachineScaleSetSku.resourceType,
  Azure.Core.armResourceType,
  "csharp"
);

// ── G5: rename `protectedSettingsFromKeyVault` → `keyVaultProtectedSettings` (csharp only) so the generated
//        property matches the previously-shipped name `KeyVaultProtectedSettings` of type KeyVaultSecretReference.
//        A separate partial-class shim restores the deprecated BinaryData `ProtectedSettingsFromKeyVault` member.
@@clientName(
  Compute.VirtualMachineExtensionProperties.protectedSettingsFromKeyVault,
  "keyVaultProtectedSettings",
  "csharp"
);
@@clientName(
  Compute.VirtualMachineExtensionUpdateProperties.protectedSettingsFromKeyVault,
  "keyVaultProtectedSettings",
  "csharp"
);
@@clientName(
  Compute.VirtualMachineScaleSetExtensionProperties.protectedSettingsFromKeyVault,
  "keyVaultProtectedSettings",
  "csharp"
);

// ── G7: rename `source` → `gallerySource` (csharp only) on GalleryDiskImage and GalleryImageVersionStorageProfile
//        so the generated property matches the previously-shipped name `GallerySource` of the discriminator-typed
//        property. A separate partial-class shim restores the deprecated base-typed `Source` member that backed
//        the previous AutoRest `source: GallerySource` rename-mapping directive.
@@clientName(ComputeGallery.GalleryDiskImage.source, "gallerySource", "csharp");
@@clientName(
  ComputeGallery.GalleryImageVersionStorageProfile.source,
  "gallerySource",
  "csharp"
);
// ── G7: rename GalleryDiskImageSource.uri → sourceUri (csharp only) to avoid collision with the
//        previously-shipped virtual `Uri` (System.Uri) accessor on the GalleryArtifactVersionSource base.
//        The base accessor is restored as a partial-class shim for backward compatibility with v1.14.0.
@@clientName(ComputeGallery.GalleryDiskImageSource.uri, "sourceUri", "csharp");

// ── C# operation renames for backward compatibility (migration from AutoRest) ──
// These mirror the override-operation-name entries from the deleted autorest.md.
// Operations.list is not using the standard ARM operation template, so omit it
// from the generated C# SDK surface.
@@scope(Operations.list, "!csharp");
@@clientName(Compute.VirtualMachines.start, "PowerOn", "csharp");
@@clientName(
  Compute.VirtualMachines.migrateToVMScaleSet,
  "MigrateToVirtualMachineScaleSet",
  "csharp"
);
@@clientName(Compute.VirtualMachineScaleSets.start, "PowerOn", "csharp");
@@clientName(
  Compute.VirtualMachineScaleSets.cancel,
  "CancelVirtualMachineScaleSetRollingUpgrade",
  "csharp"
);
@@clientName(
  Compute.VirtualMachineScaleSets.startExtensionUpgrade,
  "StartExtensionUpgradeVirtualMachineScaleSetRollingUpgrade",
  "csharp"
);
@@clientName(Compute.VirtualMachineScaleSetVMS.start, "PowerOn", "csharp");
@@clientName(
  ComputeGallery.Galleries.gallerySharingProfileUpdate,
  "UpdateSharingProfile",
  "csharp"
);
@@clientName(
  ComputeGallery.Galleries.listByArtifactName,
  "GetSoftDeletedResourcesByArtifactName",
  "csharp"
);

// ── C# operation rename: ResourceSkus.list emits `GetAll`; restore baseline name. ──
@@clientName(ComputeSku.ResourceSkus.list, "GetComputeResourceSkus", "csharp");
@@apiVersion(VirtualMachineScaleSetNetworkProfile.networkApiVersion, false);
@@apiVersion(
  VirtualMachineScaleSetUpdateNetworkProfile.networkApiVersion,
  false
);
@@apiVersion(NetworkProfile.networkApiVersion, false);
@@apiVersion(ResourceSku.apiVersions, false);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — ARM common-types / base-type alternateTypes (csharp)
// CommonTypes v3 defines Resource.id as string, but the .NET SDK base classes
// (ResourceData/TrackedResourceData) expect ResourceIdentifier. The per-VM
// model ids also need ResourceIdentifier for backward compat with AutoRest output.
// ════════════════════════════════════════════════════════════════════════════

// CommonTypes v3 defines Resource.id as string, but the .NET SDK base classes
// (ResourceData/TrackedResourceData) expect ResourceIdentifier. Override for csharp.
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ApiEntityReference is too generic for the public .NET SDK model surface.
@@clientName(ApiEntityReference, "ComputeApiEntityReference", "csharp");

// ApiEntityReference.id flattens to XxxId on parent models. Old AutoRest SDK
// emitted these as ResourceIdentifier; preserve that contract for csharp.
@@alternateType(
  ApiEntityReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// VirtualMachineImageResource (renamed VirtualMachineImageBase in csharp) had
// Location typed as AzureLocation in the old SDK; the spec models it as string.
@@alternateType(
  VirtualMachineImageResource.location,
  Azure.Core.azureLocation,
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — NetworkApiVersion enum member casing (csharp)
// AutoRest-based SDK generated V20201101/V20221101 names; restore baseline.
// ════════════════════════════════════════════════════════════════════════════

@@clientName(NetworkApiVersion.`2020-11-01`, "V20201101", "csharp");
@@clientName(NetworkApiVersion.`2022-11-01`, "V20221101", "csharp");

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — diskControllerType / Placement property renames (csharp)
// Restore baseline property names that differ from the TypeSpec-generated defaults.
// ════════════════════════════════════════════════════════════════════════════

@@clientName(
  Placement.zonePlacementPolicy,
  "ZonePlacementPolicyType",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetStorageProfile.diskControllerType,
  "DiskControllerKind",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateStorageProfile.diskControllerType,
  "DiskControllerKind",
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — AdditionalProperties model wrappers (csharp)
// AutoRest's swagger had `additionalProperties: true` on these models so the
// service can return undocumented private properties the SDK must round-trip.
// TypeSpec equivalent: spread Record<unknown> in a wrapper model then swap via
// @@alternateType for csharp only (other languages never had the bag).
// ════════════════════════════════════════════════════════════════════════════

/**
 * Describes an upgrade policy - automatic, manual, or rolling.
 */
model UpgradePolicyWithAdditionalProperties {
  ...UpgradePolicy;
  ...Record<unknown>;
}
@@alternateType(UpgradePolicy, UpgradePolicyWithAdditionalProperties, "csharp");
@@clientName(
  UpgradePolicyWithAdditionalProperties,
  "VirtualMachineScaleSetUpgradePolicy",
  "csharp"
);

/**
 * Describes the properties of a Virtual Machine Scale Set.
 */
model VirtualMachineScaleSetPropertiesWithAdditionalProperties {
  ...VirtualMachineScaleSetProperties;
  ...Record<unknown>;
}
@@alternateType(
  VirtualMachineScaleSetProperties,
  VirtualMachineScaleSetPropertiesWithAdditionalProperties,
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetPropertiesWithAdditionalProperties,
  "VirtualMachineScaleSetProperties",
  "csharp"
);

/**
 * Describes the properties of a virtual machine scale set virtual machine.
 */
model VirtualMachineScaleSetVMPropertiesWithAdditionalProperties {
  ...VirtualMachineScaleSetVMProperties;
  ...Record<unknown>;
}
@@alternateType(
  VirtualMachineScaleSetVMProperties,
  VirtualMachineScaleSetVMPropertiesWithAdditionalProperties,
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMPropertiesWithAdditionalProperties,
  "VirtualMachineScaleSetVmProperties",
  "csharp"
);

/**
 * Specifies VM Size Property settings on the virtual machine.
 */
model VMSizePropertiesWithAdditionalProperties {
  ...VMSizeProperties;
  ...Record<unknown>;
}
@@alternateType(
  VMSizeProperties,
  VMSizePropertiesWithAdditionalProperties,
  "csharp"
);
@@clientName(
  VMSizePropertiesWithAdditionalProperties,
  "VirtualMachineSizeProperties",
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — operation location fixes (csharp)
// Both "list" and "listAll" on the same interface produce "GetAll" collection
// result names, causing duplicate type names. Move listAll to a separate
// interface so each gets a unique collection result type name.
// ════════════════════════════════════════════════════════════════════════════

@@clientLocation(
  VirtualMachineScaleSets.listAll,
  "VirtualMachineScaleSetsSubscription",
  "csharp"
);
@@clientLocation(
  VirtualMachines.listAll,
  "VirtualMachinesSubscription",
  "csharp"
);
@@clientLocation(
  RestorePointCollections.listAll,
  "RestorePointCollectionsSubscription",
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — OperationGroup operation renames (csharp)
// Mirror the override-operation-name entries from the deleted autorest.md and
// restore names that match the previously shipped API surface.
// ════════════════════════════════════════════════════════════════════════════

// VirtualMachineImagesEdgeZoneOperationGroup ops renamed to old API names.
@@clientName(
  VirtualMachineImagesEdgeZoneOperationGroup.listPublishers,
  "GetPublishersVirtualMachineImagesEdgeZones",
  "csharp"
);
@@clientName(
  VirtualMachineImagesEdgeZoneOperationGroup.listOffers,
  "GetOffersVirtualMachineImagesEdgeZones",
  "csharp"
);
@@clientName(
  VirtualMachineImagesEdgeZoneOperationGroup.listSkus,
  "GetVirtualMachineImageEdgeZoneSkus",
  "csharp"
);
@@clientName(
  VirtualMachineImagesEdgeZoneOperationGroup.list,
  "GetVirtualMachineImagesEdgeZones",
  "csharp"
);
@@clientName(
  VirtualMachineImagesEdgeZoneOperationGroup.get,
  "GetVirtualMachineImagesEdgeZone",
  "csharp"
);

// VirtualMachineImagesOperationGroup ops renamed to old API names.
@@clientName(
  VirtualMachineImagesOperationGroup.listPublishers,
  "GetVirtualMachineImagePublishers",
  "csharp"
);
@@clientName(
  VirtualMachineImagesOperationGroup.listOffers,
  "GetVirtualMachineImageOffers",
  "csharp"
);
@@clientName(
  VirtualMachineImagesOperationGroup.listSkus,
  "GetVirtualMachineImageSkus",
  "csharp"
);
@@clientName(
  VirtualMachineImagesOperationGroup.list,
  "GetVirtualMachineImages",
  "csharp"
);
@@clientName(
  VirtualMachineImagesOperationGroup.get,
  "GetVirtualMachineImage",
  "csharp"
);
@@clientName(
  VirtualMachineImagesOperationGroup.listByEdgeZone,
  "GetVirtualMachineImagesByEdgeZone",
  "csharp"
);
@@clientName(
  VirtualMachineImagesOperationGroup.listWithProperties,
  "GetVirtualMachineImagesWithProperties",
  "csharp"
);

// Other OperationGroup ops renamed to old API names.
@@clientName(UsageOperationGroup.list, "GetUsages", "csharp");
@@clientName(
  VirtualMachineSizesOperationGroup.list,
  "GetVirtualMachineSizes",
  "csharp"
);
@@clientName(
  VirtualMachineRunCommandsOperationGroup.list,
  "GetVirtualMachineRunCommands",
  "csharp"
);
@@clientName(
  VirtualMachineRunCommandsOperationGroup.get,
  "GetVirtualMachineRunCommand",
  "csharp"
);
@@clientName(
  LogAnalyticsOperationGroup.exportThrottledRequests,
  "ExportLogAnalyticsThrottledRequests",
  "csharp"
);
@@clientName(
  LogAnalyticsOperationGroup.exportRequestRateByInterval,
  "ExportLogAnalyticsRequestRateByInterval",
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — type renames (csharp)
// Restore backward-compatible C# type names from the AutoRest migration.
// ════════════════════════════════════════════════════════════════════════════

// VM sub-model renames: prefix with "VirtualMachine" to match old C# names.
@@clientName(DataDisk, "VirtualMachineDataDisk", "csharp");
@@clientName(HardwareProfile, "VirtualMachineHardwareProfile", "csharp");
@@clientName(NetworkProfile, "VirtualMachineNetworkProfile", "csharp");
@@clientName(OSProfile, "VirtualMachineOSProfile", "csharp");
@@clientName(StorageProfile, "VirtualMachineStorageProfile", "csharp");
@@clientName(ManagedDiskParameters, "VirtualMachineManagedDisk", "csharp");

// VMSS sub-model renames.
@@clientName(UpgradePolicy, "VirtualMachineScaleSetUpgradePolicy", "csharp");
@@clientName(
  PriorityMixPolicy,
  "VirtualMachineScaleSetPriorityMixPolicy",
  "csharp"
);

// Enum singular←plural renames.
@@clientName(CachingTypes, "CachingType", "csharp");
@@clientName(DiskCreateOptionTypes, "DiskCreateOptionType", "csharp");
@@clientName(DiskDeleteOptionTypes, "DiskDeleteOptionType", "csharp");
@@clientName(DiskDetachOptionTypes, "DiskDetachOptionType", "csharp");

// RP-prefix renames.
@@clientName(Plan, "ComputePlan", "csharp");
@@clientName(SkuProfile, "ComputeSkuProfile", "csharp");
@@clientName(UpdateResource, "ComputeResourcePatch", "csharp");

// Base type rename.
@@clientName(VirtualMachineImageResource, "VirtualMachineImageBase", "csharp");

// Long enum/type renames.
@@clientName(
  ExpandTypesForGetCapacityReservationGroups,
  "CapacityReservationGroupGetExpand",
  "csharp"
);

// VM→Vm casing renames (old C# convention used lowercase "Vm").
@@clientName(
  VirtualMachineScaleSetVMInstanceIDs,
  "VirtualMachineScaleSetVmInstanceIds",
  "csharp"
);
@@clientName(ResilientVMDeletionStatus, "ResilientVmDeletionStatus", "csharp");
@@clientName(
  LinuxVMGuestPatchAutomaticByPlatformRebootSetting,
  "LinuxVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(
  WindowsVMGuestPatchAutomaticByPlatformRebootSetting,
  "WindowsVmGuestPatchAutomaticByPlatformRebootSetting",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMInstanceView,
  "VirtualMachineScaleSetVmInstanceView",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMProperties,
  "VirtualMachineScaleSetVmProperties",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMProtectionPolicy,
  "VirtualMachineScaleSetVmProtectionPolicy",
  "csharp"
);

// Enum/union plural→singular renames.
@@clientName(ArchitectureTypes, "ArchitectureType", "csharp");
@@clientName(ConsistencyModeTypes, "ConsistencyModeType", "csharp");
@@clientName(DedicatedHostLicenseTypes, "DedicatedHostLicenseType", "csharp");
@@clientName(OperatingSystemStateTypes, "OperatingSystemStateType", "csharp");
@@clientName(OrchestrationServiceNames, "OrchestrationServiceName", "csharp");
@@clientName(
  VirtualMachineEvictionPolicyTypes,
  "VirtualMachineEvictionPolicyType",
  "csharp"
);
@@clientName(
  VirtualMachinePriorityTypes,
  "VirtualMachinePriorityType",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetScaleInRules,
  "VirtualMachineScaleSetScaleInRule",
  "csharp"
);
@@clientName(
  VMGuestPatchClassificationLinux,
  "VmGuestPatchClassificationForLinux",
  "csharp"
);
@@clientName(
  VMGuestPatchClassificationWindows,
  "VmGuestPatchClassificationForWindows",
  "csharp"
);

// Model casing renames.
@@clientName(
  DedicatedHostAllocatableVM,
  "DedicatedHostAllocatableVm",
  "csharp"
);

// Resource type VM→Vm casing renames (backward compat with AutoRest output).
@@clientName(VirtualMachineScaleSetVM, "VirtualMachineScaleSetVm", "csharp");
@@clientName(
  VirtualMachineScaleSetVMExtension,
  "VirtualMachineScaleSetVmExtension",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMNetworkProfileConfiguration,
  "VirtualMachineScaleSetVmNetworkProfileConfiguration",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMInstanceRequiredIDs,
  "VirtualMachineScaleSetVmInstanceRequiredIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMExtensionsSummary,
  "VirtualMachineScaleSetVmExtensionsSummary",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMReimageParameters,
  "VirtualMachineScaleSetVmReimageContent",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMExtensionUpdate,
  "VirtualMachineScaleSetVmExtensionPatch",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMExtensionsListResult,
  "VirtualMachineScaleSetVmExtensionsListResult",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMListResult,
  "VirtualMachineScaleSetVmListResult",
  "csharp"
);

// RP-prefix renames (old AutoRest prepend-rp-prefix convention).
@@clientName(ApiError, "ComputeApiError", "csharp");
@@clientName(Placement, "VirtualMachinePlacement", "csharp");
@@clientName(ScheduledEventsProfile, "ComputeScheduledEventsProfile", "csharp");
@@clientName(
  SubResourceWithColocationStatus,
  "ComputeSubResourceDataWithColocationStatus",
  "csharp"
);
@@clientName(UsageName, "ComputeUsageName", "csharp");
// `OperatingSystemTypes` (closed enum, Windows/Linux) was named `SupportedOperatingSystemType`
// in the old SDK; the union `OperatingSystemType` kept its spec name (extensible struct).
@@clientName(OperatingSystemTypes, "SupportedOperatingSystemType", "csharp");
@@clientName(ReservationType, "CapacityReservationType", "csharp");
@@clientName(ApiErrorBase, "ComputeApiErrorBase", "csharp");
@@clientName(
  VMGalleryApplication,
  "VirtualMachineGalleryApplication",
  "csharp"
);
@@clientName(
  NetworkInterfaceReference,
  "VirtualMachineNetworkInterfaceReference",
  "csharp"
);
@@clientName(SkuProfileVMSize, "ComputeSkuProfileVmSize", "csharp");
@@clientName(
  VirtualMachineScaleSetVMProfile,
  "VirtualMachineScaleSetVmProfile",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateVMProfile,
  "VirtualMachineScaleSetUpdateVmProfile",
  "csharp"
);

// Accessibility overrides (types generated as internal that should be public).
@@access(VirtualMachineScaleSetVMProfile, Access.public, "csharp");
@@access(VirtualMachineScaleSetProperties, Access.public, "csharp");
@@access(VirtualMachineScaleSetUpdateVMProfile, Access.public, "csharp");
@@access(VirtualMachineScaleSetVMProperties, Access.public, "csharp");

// Rename listByLocation operations to avoid name collision (both map to GetByLocation).
@@clientName(
  VirtualMachinesOperationGroup.listByLocation,
  "GetVirtualMachinesByLocation",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetsOperationGroup.listByLocation,
  "GetVirtualMachineScaleSetsByLocation",
  "csharp"
);

// Rename extension property "type" to avoid conflict with base class "Type" property.
@@clientName(
  VirtualMachineScaleSetExtensionProperties.type,
  "ExtensionType",
  "csharp"
);
@@clientName(VirtualMachineExtensionProperties.type, "ExtensionType", "csharp");
@@clientName(
  VirtualMachineExtensionUpdateProperties.type,
  "ExtensionType",
  "csharp"
);

// Disable safe-flatten on AllInstancesDown / UserInitiatedRedeploy so they remain
// public types in the C# SDK (preserves backward compatibility with previously shipped surface).
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve type for public API surface"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Preserve type for public API surface"
@@clientOption(UserInitiatedRedeploy, "disable-safe-flatten", true, "csharp");
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Preserve type for public API surface"
#suppress "@azure-tools/typespec-client-generator-core/client-option-requires-scope" "Preserve type for public API surface"
@@clientOption(AllInstancesDown, "disable-safe-flatten", true, "csharp");

// Resource type rename for backward compatibility.
@@clientName(
  RollingUpgradeStatusInfo,
  "VirtualMachineScaleSetRollingUpgrade",
  "csharp"
);
@@clientName(
  RollingUpgradeStatusInfoProperties,
  "VirtualMachineScaleSetRollingUpgradeProperties",
  "csharp"
);

// ARM resource renames for backward compatibility.
// Image → DiskImage (old: DiskImageResource, DiskImageData, DiskImageCollection).
@@clientName(Image, "DiskImage", "csharp");

// RestorePointCollection → RestorePointGroup (old: RestorePointGroupResource, RestorePointGroupData).
@@clientName(RestorePointCollection, "RestorePointGroup", "csharp");
@@clientName(
  RestorePointCollectionSourceProperties,
  "RestorePointGroupSource",
  "csharp"
);

// Rename non-resource model SshPublicKey → SshPublicKeyConfiguration to free the name,
// then rename the resource model SshPublicKeyResource → SshPublicKey.
@@clientName(Compute.SshPublicKey, "SshPublicKeyConfiguration", "csharp");
@@clientName(SshPublicKeyResource, "SshPublicKey", "csharp");

// VirtualMachineScaleSetVMRunCommands interface → Vm casing.
@@clientName(
  VirtualMachineScaleSetVMRunCommands,
  "VirtualMachineScaleSetVmRunCommands",
  "csharp"
);

// Mark non-pageable list operations as pageable for backward compatibility.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve C# pageable surface from the previous SDK."
@@Legacy.markAsPageable(VirtualMachineExtensions.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve C# pageable surface from the previous SDK."
@@Legacy.markAsPageable(VirtualMachineScaleSetVMExtensions.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve C# pageable surface from the previous SDK."
@@Legacy.markAsPageable(
  VirtualMachineImagesOperationGroup.listByEdgeZone,
  "csharp"
);

// Type renames (batch).
@@clientName(PublicIPAddressSku, "ComputePublicIPAddressSku", "csharp");
@@clientName(
  SecurityPostureReference,
  "ComputeSecurityPostureReference",
  "csharp"
);
@@clientName(StatusLevelTypes, "ComputeStatusLevelType", "csharp");
@@clientName(UpgradeMode, "VirtualMachineScaleSetUpgradeMode", "csharp");
@@clientName(SettingNames, "SettingName", "csharp");
@@clientName(ProtocolTypes, "WinRMListenerProtocolType", "csharp");
@@clientName(InstanceViewTypes, "InstanceViewType", "csharp");
@@clientName(
  MaintenanceOperationResultCodeTypes,
  "MaintenanceOperationResultCodeType",
  "csharp"
);
@@clientName(OSDisk, "VirtualMachineOSDisk", "csharp");
@@clientName(
  VMDiskSecurityProfile,
  "VirtualMachineDiskSecurityProfile",
  "csharp"
);
@@clientName(VMSizeProperties, "VirtualMachineSizeProperties", "csharp");
@@clientName(
  VirtualMachineScaleSetManagedDiskParameters,
  "VirtualMachineScaleSetManagedDisk",
  "csharp"
);
@@clientName(AlternativeOption, "ImageAlternativeOption", "csharp");
@@clientName(LogAnalyticsOperationResult, "LogAnalytics", "csharp");
@@clientName(RunCommandResult, "VirtualMachineRunCommandResult", "csharp");
@@clientName(
  ConvertToVirtualMachineScaleSetInput,
  "ConvertToVirtualMachineScaleSetContent",
  "csharp"
);
@@clientName(
  MigrateVMToVirtualMachineScaleSetInput,
  "MigrateVmToVirtualMachineScaleSetContent",
  "csharp"
);
@@clientName(
  OrchestrationServiceStateInput,
  "OrchestrationServiceStateContent",
  "csharp"
);
@@clientName(
  RequestRateByIntervalInput,
  "RequestRateByIntervalContent",
  "csharp"
);
@@clientName(ThrottledRequestsInput, "ThrottledRequestsContent", "csharp");
@@clientName(
  VirtualMachineCaptureParameters,
  "VirtualMachineCaptureContent",
  "csharp"
);
@@clientName(
  VirtualMachineInstallPatchesParameters,
  "VirtualMachineInstallPatchesContent",
  "csharp"
);
@@clientName(
  VirtualMachineReimageParameters,
  "VirtualMachineReimageContent",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetReimageParameters,
  "VirtualMachineScaleSetReimageContent",
  "csharp"
);
@@clientName(
  VMScaleSetConvertToSinglePlacementGroupInput,
  "VirtualMachineScaleSetConvertToSinglePlacementGroupContent",
  "csharp"
);
@@clientName(
  VMScaleSetScaleOutInput,
  "VirtualMachineScaleSetScaleOutContent",
  "csharp"
);
@@clientName(
  SshGenerateKeyPairInputParameters,
  "SshGenerateKeyPairInputContent",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateProperties,
  "VirtualMachineScaleSetPatchProperties",
  "csharp"
);
@@clientName(ExpandTypeForListVMs, "GetVirtualMachineExpandType", "csharp");
@@clientName(
  ExpandTypesForGetVMScaleSets,
  "VirtualMachineScaleSetGetExpand",
  "csharp"
);
@@clientName(Modes, "HostEndpointSettingsMode", "csharp");

// ── Plural→singular enum renames (C# backward compat) ──
@@clientName(
  CapacityReservationGroupInstanceViewTypes,
  "CapacityReservationGroupInstanceViewType",
  "csharp"
);
@@clientName(
  CapacityReservationInstanceViewTypes,
  "CapacityReservationInstanceViewType",
  "csharp"
);
@@clientName(DiffDiskOptions, "DiffDiskOption", "csharp");
@@clientName(DiskControllerTypes, "DiskControllerType", "csharp");
@@clientName(DomainNameLabelScopeTypes, "DomainNameLabelScopeType", "csharp");
@@clientName(ExpandTypesForListVMs, "ExpandTypesForListVm", "csharp");
@@clientName(
  ResourceIdOptionsForGetCapacityReservationGroups,
  "ResourceIdOptionsForGetCapacityReservationGroup",
  "csharp"
);
@@clientName(ScriptShellTypes, "ScriptShellType", "csharp");
@@clientName(SecurityEncryptionTypes, "SecurityEncryptionType", "csharp");
@@clientName(SecurityTypes, "SecurityType", "csharp");
@@clientName(SshEncryptionTypes, "SshEncryptionType", "csharp");
@@clientName(StorageAccountTypes, "StorageAccountType", "csharp");
@@clientName(VirtualMachineSizeTypes, "VirtualMachineSizeType", "csharp");

// ── RP-prefix renames (C# backward compat) ──
@@clientName(AllocationStrategy, "ComputeAllocationStrategy", "csharp");
@@clientName(DeleteOptions, "ComputeDeleteOption", "csharp");
@@clientName(
  NetworkInterfaceAuxiliaryMode,
  "ComputeNetworkInterfaceAuxiliaryMode",
  "csharp"
);
@@clientName(
  NetworkInterfaceAuxiliarySku,
  "ComputeNetworkInterfaceAuxiliarySku",
  "csharp"
);
@@clientName(PublicIPAddressSkuName, "ComputePublicIPAddressSkuName", "csharp");
@@clientName(PublicIPAddressSkuTier, "ComputePublicIPAddressSkuTier", "csharp");

// ── VM→Vm casing renames (C# backward compat) ──
@@clientName(
  LinuxVMGuestPatchAutomaticByPlatformSettings,
  "LinuxVmGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(LinuxVMGuestPatchMode, "LinuxVmGuestPatchMode", "csharp");
@@clientName(
  VMGuestPatchRebootBehavior,
  "VmGuestPatchRebootBehavior",
  "csharp"
);
@@clientName(VMGuestPatchRebootSetting, "VmGuestPatchRebootSetting", "csharp");
@@clientName(VMGuestPatchRebootStatus, "VmGuestPatchRebootStatus", "csharp");
@@clientName(
  WindowsVMGuestPatchAutomaticByPlatformSettings,
  "WindowsVmGuestPatchAutomaticByPlatformSettings",
  "csharp"
);
@@clientName(WindowsVMGuestPatchMode, "WindowsVmGuestPatchMode", "csharp");
@@clientName(
  VMScaleSetLifecycleHookEvent,
  "VirtualMachineScaleSetLifecycleHookEvent",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventState,
  "VmScaleSetLifecycleHookEventState",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventTargetResource,
  "VirtualMachineScaleSetLifecycleHookEventTarget",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventProperties,
  "VmScaleSetLifecycleHookEventProperties",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventProperties.type,
  "EventType",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventAdditionalContext,
  "VmScaleSetLifecycleHookEventAdditionalContext",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventType,
  "VmScaleSetLifecycleHookEventType",
  "csharp"
);
@@clientName(LifecycleHook.type, "VmScaleSetLifecycleHookEventType", "csharp");
@@clientName(
  VMScaleSetLifecycleHookEventUpdate,
  "VirtualMachineScaleSetLifecycleHookEventPatch",
  "csharp"
);
@@clientName(
  VMScaleSetLifecycleHookEventListResult,
  "VmScaleSetLifecycleHookEventListResult",
  "csharp"
);

// ── ID→Id casing renames on VMSS body parameters (C# backward compat) ──
// back-compatible.tsp renames these to `vmInstanceIDs` for all languages; override to `vmInstanceIds` for C#.
@@clientName(
  VirtualMachineScaleSets.approveRollingUpgrade::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.deallocate::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.deleteInstances::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.updateInstances::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.performMaintenance::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.powerOff::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.redeploy::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.reimageAll::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.restart::parameters.body,
  "vmInstanceIds",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSets.start::parameters.body,
  "vmInstanceIds",
  "csharp"
);

// ── VM→Vm casing renames on GalleryInVMAccessControlProfile path parameters (C# backward compat) ──
// TODO: figure out the correct @@clientName target syntax for ResourceNameParameter-derived path params.
// Renaming the resource model's `.name` property does flip the path parameter casing in operations,
// but it also surfaces a new public `Name` property on the corresponding *Data model — unacceptable.
// Tracked as a "Known issue" on the SDK PR; awaiting team input.

// ── IP→Ip casing renames (C# backward compat) ──
@@clientName(VirtualMachineIpTag, "VirtualMachineIPTag", "csharp");
@@clientName(
  VirtualMachineScaleSetIpTag,
  "VirtualMachineScaleSetIPTag",
  "csharp"
);

// ── Other renames (C# backward compat) ──
@@clientName(AlternativeType, "ImageAlternativeType", "csharp");
@@clientName(RestorePointExpandOptions, "RestorePointExpand", "csharp");
@@clientName(
  RestorePointCollectionExpandOptions,
  "RestorePointGroupExpand",
  "csharp"
);
@@clientName(
  RestorePointSourceVMDataDisk,
  "RestorePointSourceVmDataDisk",
  "csharp"
);
@@clientName(
  RestorePointSourceVMOSDisk,
  "RestorePointSourceVmOSDisk",
  "csharp"
);
@@clientName(
  RestorePointSourceVMStorageProfile,
  "RestorePointSourceVmStorageProfile",
  "csharp"
);
@@clientName(RebalanceBehavior, "VmssRebalanceBehavior", "csharp");
@@clientName(RebalanceStrategy, "VmssRebalanceStrategy", "csharp");
@@clientName(VmDiskTypes, "VirtualMachineDiskType", "csharp");

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — property renames (csharp)
// ════════════════════════════════════════════════════════════════════════════

// ── Os→OS property casing renames (C# backward compat) ──
@@clientName(VirtualMachineSize.osDiskSizeInMB, "OSDiskSizeInMB", "csharp");
@@clientName(
  AutomaticOSUpgradePolicy.osRollingUpgradeDeferral,
  "OSRollingUpgradeDeferral",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMProfile.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineScaleSetStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(VirtualMachineScaleSetOSDisk.osType, "OSType", "csharp");
@@clientName(
  ScheduledEventsProfile.osImageNotificationProfile,
  "OSImageNotificationProfile",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateVMProfile.osProfile,
  "OSProfile",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateStorageProfile.osDisk,
  "OSDisk",
  "csharp"
);
@@clientName(VirtualMachineReimageParameters.osProfile, "OSProfile", "csharp");
@@clientName(
  VirtualMachineScaleSetVMProperties.osProfile,
  "OSProfile",
  "csharp"
);
@@clientName(VirtualMachineScaleSetVMInstanceView.osName, "OSName", "csharp");
@@clientName(
  VirtualMachineScaleSetVMInstanceView.osVersion,
  "OSVersion",
  "csharp"
);
@@clientName(StorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(OSDisk.osType, "OSType", "csharp");
@@clientName(VirtualMachineProperties.osProfile, "OSProfile", "csharp");
@@clientName(VirtualMachineInstanceView.osName, "OSName", "csharp");
@@clientName(VirtualMachineInstanceView.osVersion, "OSVersion", "csharp");
@@clientName(
  VirtualMachineImageProperties.osDiskImage,
  "OSDiskImage",
  "csharp"
);
@@clientName(ImageStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(ImageOSDisk.osType, "OSType", "csharp");
@@clientName(ImageOSDisk.osState, "OSState", "csharp");
@@clientName(RestorePointSourceMetadata.osProfile, "OSProfile", "csharp");
@@clientName(RestorePointSourceVMStorageProfile.osDisk, "OSDisk", "csharp");
@@clientName(RestorePointSourceVMOSDisk.osType, "OSType", "csharp");
@@clientName(RunCommandDocumentBase.osType, "OSType", "csharp");

// ── Property casing renames: acronym case normalization (C# backward compat) ──
@@clientName(
  AdditionalCapabilities.ultraSSDEnabled,
  "UltraSsdEnabled",
  "csharp"
);
@@clientName(
  DedicatedHostGroupPropertiesAdditionalCapabilities.ultraSSDEnabled,
  "UltraSsdEnabled",
  "csharp"
);
@@clientName(
  HostEndpointSettings.inVMAccessControlProfileReferenceId,
  "InVmAccessControlProfileReferenceId",
  "csharp"
);
@@clientName(
  LinuxConfiguration.enableVMAgentPlatformUpdates,
  "IsVmAgentPlatformUpdatesEnabled",
  "csharp"
);
@@clientName(
  LinuxConfiguration.disablePasswordAuthentication,
  "IsPasswordAuthenticationDisabled",
  "csharp"
);
@@clientName(LinuxConfiguration.provisionVMAgent, "ProvisionVmAgent", "csharp");
@@clientName(
  WindowsConfiguration.enableAutomaticUpdates,
  "IsAutomaticUpdatesEnabled",
  "csharp"
);
// Rename the nested-model parent properties so the auto-flattened C# names
// become ResilientVm... instead of ResilientVM... (matches v1.14.0 baseline).
@@clientName(
  ResiliencyPolicy.resilientVMCreationPolicy,
  "resilientVmCreationPolicy",
  "csharp"
);
@@clientName(
  ResiliencyPolicy.resilientVMDeletionPolicy,
  "resilientVmDeletionPolicy",
  "csharp"
);
@@clientName(
  WindowsConfiguration.provisionVMAgent,
  "ProvisionVmAgent",
  "csharp"
);
@@clientName(
  ScaleInPolicy.prioritizeUnhealthyVMs,
  "PrioritizeUnhealthyVms",
  "csharp"
);
@@clientName(DataDisk.diskIOPSReadWrite, "DiskIopsReadWrite", "csharp");
@@clientName(
  VirtualMachineInstanceView.isVMInStandbyPool,
  "IsVmInStandbyPool",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetDataDisk.diskIOPSReadWrite,
  "DiskIopsReadWrite",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateProperties.doNotRunExtensionsOnOverprovisionedVMs,
  "DoNotRunExtensionsOnOverprovisionedVms",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetProperties.doNotRunExtensionsOnOverprovisionedVMs,
  "DoNotRunExtensionsOnOverprovisionedVms",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetVMProperties.resilientVMDeletionStatus,
  "ResilientVmDeletionStatus",
  "csharp"
);
@@clientName(VMSizeProperties.vCPUsAvailable, "VCpusAvailable", "csharp");
@@clientName(VMSizeProperties.vCPUsPerCore, "VCpusPerCore", "csharp");
@@clientName(
  StorageProfile.alignRegionalDisksToVMZone,
  "AlignRegionalDisksToVmZone",
  "csharp"
);
@@clientName(
  MigrateVMToVirtualMachineScaleSetInput.targetVMSize,
  "TargetVmSize",
  "csharp"
);
@@clientName(
  VirtualMachineExtensionImageProperties.vmScaleSetEnabled,
  "VirtualMachineScaleSetEnabled",
  "csharp"
);

// ── IP→Ip property casing renames (C# backward compat) ──
@@clientName(VirtualMachineIpTag.ipTagType, "IPTagType", "csharp");
@@clientName(VirtualMachineScaleSetIpTag.ipTagType, "IPTagType", "csharp");
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);
@@clientName(
  VirtualMachinePublicIPAddressConfigurationProperties.ipTags,
  "IPTags",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetNetworkConfigurationProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetPublicIPAddressConfigurationProperties.ipTags,
  "IPTags",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateNetworkConfigurationProperties.ipConfigurations,
  "IPConfigurations",
  "csharp"
);

// ── Is* prefix / verb prefix property renames (C# backward compat) ──
@@clientName(EventGridAndResourceGraph.enable, "IsEnabled", "csharp");
@@clientName(RollingUpgradePolicy.maxSurge, "IsMaxSurgeEnabled", "csharp");
@@clientName(UefiSettings.secureBootEnabled, "IsSecureBootEnabled", "csharp");
@@clientName(UefiSettings.vTpmEnabled, "IsVirtualTpmEnabled", "csharp");
@@clientName(
  VirtualMachineScaleSetProperties.constrainedMaximumCapacity,
  "IsMaximumCapacityConstrained",
  "csharp"
);
@@clientName(
  WindowsConfiguration.enableVMAgentPlatformUpdates,
  "IsVmAgentPlatformUpdatesEnabled",
  "csharp"
);
@@clientName(
  VirtualMachineNetworkInterfaceConfigurationProperties.disableTcpStateTracking,
  "IsTcpStateTrackingDisabled",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetNetworkConfigurationProperties.disableTcpStateTracking,
  "IsTcpStateTrackingDisabled",
  "csharp"
);
@@clientName(
  VirtualMachineScaleSetUpdateNetworkConfigurationProperties.disableTcpStateTracking,
  "IsTcpStateTrackingDisabled",
  "csharp"
);

// ── Qualified property name renames (C# backward compat) ──
@@clientName(AlternativeOption.type, "AlternativeType", "csharp");
@@clientName(RestorePointEncryption.type, "EncryptionType", "csharp");
@@clientName(
  RunCommandParameterDefinition.type,
  "RunCommandParameterDefinitionType",
  "csharp"
);
@@clientName(
  UpgradeOperationHistoricalStatusInfo.type,
  "UpgradeOperationHistoricalStatusInfoType",
  "csharp"
);
@@clientName(
  VirtualMachineExtensionHandlerInstanceView.type,
  "VirtualMachineExtensionHandlerInstanceViewType",
  "csharp"
);
@@clientName(
  VirtualMachineExtensionInstanceView.type,
  "VirtualMachineExtensionInstanceViewType",
  "csharp"
);

// ── Other property renames (C# backward compat) ──
@@clientName(
  ImageReference.sharedGalleryImageId,
  "SharedGalleryImageUniqueId",
  "csharp"
);
@@clientName(
  OrchestrationServiceSummary.lastStatusChangeTime,
  "LastStatusChangedOn",
  "csharp"
);
@@clientName(
  RestorePointCollectionProperties.restorePointCollectionId,
  "RestorePointGroupId",
  "csharp"
);
@@clientName(
  VMScaleSetScaleOutInputProperties.zone,
  "VmScaleSetScaleOutInputZone",
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — alternateType remappings (csharp)
// ════════════════════════════════════════════════════════════════════════════

// ── alternateType: string → ResourceIdentifier (C# backward compat) ──

// Wrapper model id properties → ResourceIdentifier.
@@alternateType(
  ServiceArtifactReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecurityPostureReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SshPublicKeyGenerateKeyPairResult.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RestorePointCollectionSourceProperties.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Direct string properties → ResourceIdentifier.
@@alternateType(
  VirtualMachineScaleSetVMInstanceView.assignedHost,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ── alternateType: string → Uri (C# backward compat) ──
@@alternateType(BootDiagnostics.storageUri, url, "csharp");
@@alternateType(
  BootDiagnosticsInstanceView.consoleScreenshotBlobUri,
  url,
  "csharp"
);
@@alternateType(
  BootDiagnosticsInstanceView.serialConsoleLogBlobUri,
  url,
  "csharp"
);
@@alternateType(ImageDisk.blobUri, url, "csharp");
@@alternateType(KeyVaultKeyReference.keyUrl, url, "csharp");
@@alternateType(KeyVaultSecretReference.secretUrl, url, "csharp");
@@useSystemTextJsonConverter(KeyVaultSecretReference, "csharp");
@@clientName(
  AutomaticSkuMigrationPolicy.enabled,
  "isAutomaticSkuMigrationPolicyEnabled",
  "csharp"
);
@@alternateType(LogAnalyticsInputBase.blobContainerSasUri, url, "csharp");
@@alternateType(
  RetrieveBootDiagnosticsDataResult.consoleScreenshotBlobUri,
  url,
  "csharp"
);
@@alternateType(
  RetrieveBootDiagnosticsDataResult.serialConsoleLogBlobUri,
  url,
  "csharp"
);
@@alternateType(VaultCertificate.certificateUrl, url, "csharp");
@@alternateType(VirtualHardDisk.uri, url, "csharp");
@@alternateType(
  VirtualMachineRunCommandProperties.outputBlobUri,
  url,
  "csharp"
);
@@alternateType(VirtualMachineRunCommandProperties.errorBlobUri, url, "csharp");
@@alternateType(VirtualMachineRunCommandScriptSource.scriptUri, url, "csharp");
@@alternateType(WinRMListener.certificateUrl, url, "csharp");

// ── alternateType: Identity types → ManagedServiceIdentity (C# backward compat) ──
@@alternateType(
  VirtualMachineScaleSet.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  VirtualMachineScaleSetUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  VirtualMachineScaleSetVM.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  VirtualMachine.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  VirtualMachineUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — extensible enum wrappers (csharp)
// The old SDK had these as extensible enums (readonly struct). TypeSpec defines
// them as closed unions, which would generate fixed enums. Define extensible
// wrappers and use @@alternateType to replace all usages automatically.
// ════════════════════════════════════════════════════════════════════════════

/**
 * The component name. Currently, the only allowable value is Microsoft-Windows-Shell-Setup.
 */
union ComponentName {
  ComponentNames,
  string,
}

/**
 * The pass name. Currently, the only allowable value is OobeSystem.
 */
union PassName {
  PassNames,
  string,
}

@@alternateType(ComponentNames, ComponentName, "csharp");
@@alternateType(PassNames, PassName, "csharp");

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — VirtualMachineSizeType member casing (csharp)
// The generator lowercases size suffixes (s, m, r) differently from old SDK.
// ════════════════════════════════════════════════════════════════════════════

@@clientName(
  VirtualMachineSizeTypes.Standard_A2m_v2,
  "StandardA2MV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_A4m_v2,
  "StandardA4MV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_A8m_v2,
  "StandardA8MV2",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_B1ms, "StandardB1Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_B1s, "StandardB1S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_B2ms, "StandardB2Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_B2s, "StandardB2S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_B4ms, "StandardB4Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_B8ms, "StandardB8Ms", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_D16s_v3,
  "StandardD16SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_D2s_v3,
  "StandardD2SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_D32s_v3,
  "StandardD32SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_D4s_v3,
  "StandardD4SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_D64s_v3,
  "StandardD64SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_D8s_v3,
  "StandardD8SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_E16s_v3,
  "StandardE16SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_E2s_v3,
  "StandardE2SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_E32-8s_v3`,
  "StandardE328SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_E32s_v3,
  "StandardE32SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_E4s_v3,
  "StandardE4SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_E64-16s_v3`,
  "StandardE6416SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_E64-32s_v3`,
  "StandardE6432SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_E64s_v3,
  "StandardE64SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_E8s_v3,
  "StandardE8SV3",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_F16s, "StandardF16S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_F16s_v2,
  "StandardF16SV2",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_F1s, "StandardF1S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_F2s, "StandardF2S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_F2s_v2,
  "StandardF2SV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_F32s_v2,
  "StandardF32SV2",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_F4s, "StandardF4S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_F4s_v2,
  "StandardF4SV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_F64s_v2,
  "StandardF64SV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_F72s_v2,
  "StandardF72SV2",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_F8s, "StandardF8S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_F8s_v2,
  "StandardF8SV2",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_H16m, "StandardH16M", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_H16mr, "StandardH16Mr", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_H16r, "StandardH16R", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_H8m, "StandardH8M", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_L16s, "StandardL16S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_L32s, "StandardL32S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_L4s, "StandardL4S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_L8s, "StandardL8S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.`Standard_M128-32ms`,
  "StandardM12832Ms",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_M128-64ms`,
  "StandardM12864Ms",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_M128ms,
  "StandardM128Ms",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_M128s, "StandardM128S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.`Standard_M64-16ms`,
  "StandardM6416Ms",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.`Standard_M64-32ms`,
  "StandardM6432Ms",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_M64ms, "StandardM64Ms", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_M64s, "StandardM64S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_NC12s_v2,
  "StandardNC12SV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_NC12s_v3,
  "StandardNC12SV3",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_NC24r, "StandardNC24R", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_NC24rs_v2,
  "StandardNC24RsV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_NC24rs_v3,
  "StandardNC24RsV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_NC24s_v2,
  "StandardNC24SV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_NC24s_v3,
  "StandardNC24SV3",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_NC6s_v2,
  "StandardNC6SV2",
  "csharp"
);
@@clientName(
  VirtualMachineSizeTypes.Standard_NC6s_v3,
  "StandardNC6SV3",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_ND12s, "StandardND12S", "csharp");
@@clientName(
  VirtualMachineSizeTypes.Standard_ND24rs,
  "StandardND24Rs",
  "csharp"
);
@@clientName(VirtualMachineSizeTypes.Standard_ND24s, "StandardND24S", "csharp");
@@clientName(VirtualMachineSizeTypes.Standard_ND6s, "StandardND6S", "csharp");

// ════════════════════════════════════════════════════════════════════════════
// region: Compute — ComputeUsageUnit extensible enum + Usage.input (csharp)
// The spec narrows Usage.unit to string literal "Count"; retype to a union so
// the C# emitter generates the extensible-enum struct used in v1.13.1 baseline.
// ════════════════════════════════════════════════════════════════════════════

/** The unit for Compute usage values. */
union ComputeUsageUnit {
  string,

  /** The unit of measurement is a count. */
  Count: "Count",
}
@@alternateType(Compute.Usage.unit, ComputeUsageUnit, "csharp");

// .NET back-compat: restore previously shipped acronym/casing for extensible-enum members.
@@clientName(StorageAccountTypes.Standard_LRS, "StandardLrs", "csharp");
@@clientName(StorageAccountTypes.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(StorageAccountTypes.StandardSSD_LRS, "StandardSsdLrs", "csharp");
@@clientName(StorageAccountTypes.UltraSSD_LRS, "UltraSsdLrs", "csharp");
@@clientName(StorageAccountTypes.Premium_ZRS, "PremiumZrs", "csharp");
@@clientName(StorageAccountTypes.StandardSSD_ZRS, "StandardSsdZrs", "csharp");
@@clientName(StorageAccountTypes.PremiumV2_LRS, "PremiumV2Lrs", "csharp");

@@clientName(SecurityTypes.ConfidentialVM, "ConfidentialVm", "csharp");

@@clientName(
  SecurityEncryptionTypes.VMGuestStateOnly,
  "VmGuestStateOnly",
  "csharp"
);
@@clientName(
  SecurityEncryptionTypes.DiskWithVMGuestState,
  "DiskWithVmGuestState",
  "csharp"
);

@@clientName(DiskControllerTypes.SCSI, "Scsi", "csharp");

@@clientName(VirtualMachineScaleSetScaleInRules.OldestVM, "OldestVm", "csharp");
@@clientName(VirtualMachineScaleSetScaleInRules.NewestVM, "NewestVm", "csharp");

@@clientName(
  ExpandTypesForGetCapacityReservationGroups.`virtualMachineScaleSetVMs/$ref`,
  "VirtualMachineScaleSetVmsRef",
  "csharp"
);
@@clientName(
  ExpandTypesForGetCapacityReservationGroups.`virtualMachines/$ref`,
  "VirtualMachinesRef",
  "csharp"
);

// ── Azure.ClientGenerator.Core.Usage.input forces public ctor + property setters on output-only models ──
// .NET back-compat: these models previously shipped (via AutoRest) with a public
// parameterless ctor and writable properties. TypeSpec's default Output-only usage
// removes both. Force Azure.ClientGenerator.Core.Usage.input for csharp to restore the legacy surface.
@@usage(VirtualMachineImage, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  VirtualMachineImageResource,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  VirtualMachineExtensionImage,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  VirtualMachineImageFeature,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  ImageDeprecationStatus,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(AlternativeOption, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(PurchasePlan, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@usage(
  SubResourceWithColocationStatus,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
@@usage(
  RollingUpgradeStatusInfo,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: ComputeDisk — type/property renames (csharp)
// Restore backward-compatible C# names for the Disk RP during TypeSpec migration.
// ════════════════════════════════════════════════════════════════════════════

// ── Os→OS property casing renames (C# backward compat) ──
@@clientName(DiskProperties.osType, "OSType", "csharp");
@@clientName(DiskUpdateProperties.osType, "OSType", "csharp");
@@clientName(DiskRestorePointProperties.osType, "OSType", "csharp");
@@clientName(SnapshotProperties.osType, "OSType", "csharp");
@@clientName(SnapshotUpdateProperties.osType, "OSType", "csharp");

// C# renames for backward compatibility (migration from AutoRest).
@@clientName(CreationData, "DiskCreationData", "csharp");
@@clientName(FileFormat, "DiskImageFileFormat", "csharp");
@@clientName(PublicNetworkAccess, "DiskPublicNetworkAccess", "csharp");
@@clientName(EncryptionSettingsCollection, "EncryptionSettingsGroup", "csharp");
@@clientName(Encryption, "DiskEncryption", "csharp");

// ARM resource renames for backward compatibility.
// Disk → ManagedDisk (old: ManagedDiskResource, ManagedDiskData, ManagedDiskCollection).
@@clientName(Disk, "ManagedDisk", "csharp");

// PrivateEndpointConnection → ComputePrivateEndpointConnection (old RP-prefix convention).
@@clientName(
  PrivateEndpointConnection,
  "ComputePrivateEndpointConnection",
  "csharp"
);

// Type rename for backward compatibility.
@@clientName(PrivateLinkResource, "ComputePrivateLinkResourceData", "csharp");

// ── Plural→singular enum renames (C# backward compat) ──
@@clientName(DiskSecurityTypes, "DiskSecurityType", "csharp");
@@clientName(DiskStorageAccountTypes, "DiskStorageAccountType", "csharp");
@@clientName(
  SnapshotStorageAccountTypes,
  "SnapshotStorageAccountType",
  "csharp"
);

// ── RP-prefix renames (C# backward compat) ──
@@clientName(EncryptionType, "ComputeEncryptionType", "csharp");

// ── Property casing renames: acronym case normalization (C# backward compat) ──
@@clientName(AccessUri.accessSAS, "AccessSas", "csharp");
@@clientName(
  AccessUri.securityDataAccessSAS,
  "SecurityDataAccessSas",
  "csharp"
);
@@clientName(
  AccessUri.securityMetadataAccessSAS,
  "SecurityMetadataAccessSas",
  "csharp"
);
@@clientName(
  DiskSecurityProfile.secureVMDiskEncryptionSetId,
  "SecureVmDiskEncryptionSetId",
  "csharp"
);
@@clientName(
  GrantAccessData.getSecureVMGuestStateSAS,
  "GetSecureVmGuestStateSas",
  "csharp"
);
@@clientName(DiskProperties.diskIOPSReadOnly, "DiskIopsReadOnly", "csharp");
@@clientName(DiskProperties.diskIOPSReadWrite, "DiskIopsReadWrite", "csharp");
@@clientName(
  DiskUpdateProperties.diskIOPSReadOnly,
  "DiskIopsReadOnly",
  "csharp"
);
@@clientName(
  DiskUpdateProperties.diskIOPSReadWrite,
  "DiskIopsReadWrite",
  "csharp"
);

// ── Is* prefix property renames (C# backward compat) ──
@@clientName(
  CreationData.performancePlus,
  "IsPerformancePlusEnabled",
  "csharp"
);
@@clientName(
  DiskProperties.optimizedForFrequentAttach,
  "IsOptimizedForFrequentAttach",
  "csharp"
);
@@clientName(
  DiskUpdateProperties.optimizedForFrequentAttach,
  "IsOptimizedForFrequentAttach",
  "csharp"
);

// ── Qualified property name renames (C# backward compat) ──
@@clientName(Encryption.type, "EncryptionType", "csharp");

// ── Other property renames (C# backward compat) ──
@@clientName(
  DiskProperties.encryptionSettingsCollection,
  "EncryptionSettingsGroup",
  "csharp"
);
@@clientName(
  DiskUpdateProperties.encryptionSettingsCollection,
  "EncryptionSettingsGroup",
  "csharp"
);
@@clientName(
  SnapshotProperties.encryptionSettingsCollection,
  "EncryptionSettingsGroup",
  "csharp"
);
@@clientName(
  SnapshotUpdateProperties.encryptionSettingsCollection,
  "EncryptionSettingsGroup",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

// ── alternateType overrides: string → armResourceIdentifier (C# backward compat) ──

// Wrapper model id properties → ResourceIdentifier.
@@alternateType(SourceVault.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  ImageDiskReference.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Disk.
@@alternateType(Disk.managedBy, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  Disk.managedByExtended,
  Azure.Core.armResourceIdentifier[],
  "csharp"
);
@@alternateType(
  DiskProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// DiskUpdate.
@@alternateType(
  DiskUpdateProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// DiskRestorePoint.
// .NET back-compat: previously shipped DiskRestorePointData with a public ctor and
// settable properties. TypeSpec's default usage flags this as output-only, which
// removes both. Forcing Azure.ClientGenerator.Core.Usage.input restores the public ctor + property setters.
@@usage(DiskRestorePoint, Azure.ClientGenerator.Core.Usage.input, "csharp");
@@alternateType(
  DiskRestorePointProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DiskRestorePointProperties.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Snapshot.
@@alternateType(
  SnapshotProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// SnapshotUpdate.
@@alternateType(
  SnapshotUpdateProperties.diskAccessId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// CreationData.
@@alternateType(
  CreationData.sourceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  CreationData.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  CreationData.elasticSanResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Encryption.
@@alternateType(
  Encryption.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// DiskSecurityProfile.
@@alternateType(
  DiskSecurityProfile.secureVMDiskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// PrivateLinkResource.
@@alternateType(
  PrivateLinkResourceProperties.groupId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ── alternateType: Identity → ManagedServiceIdentity (C# backward compat) ──
@@alternateType(
  DiskEncryptionSet.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  DiskEncryptionSetUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);

// ── alternateType: string → Uri (C# backward compat) ──
@@alternateType(CreationData.sourceUri, url, "csharp");
@@alternateType(CreationData.securityDataUri, url, "csharp");
@@alternateType(KeyForDiskEncryptionSet.keyUrl, url, "csharp");
@@alternateType(KeyVaultAndKeyReference.keyUrl, url, "csharp");
@@alternateType(KeyVaultAndSecretReference.secretUrl, url, "csharp");
@@alternateType(ShareInfoElement.vmUri, url, "csharp");

// Mark non-pageable list operations as pageable for backward compatibility.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve C# pageable surface from the previous SDK."
@@Legacy.markAsPageable(DiskAccesses.getPrivateLinkResources, "csharp");

// .NET back-compat: restore previously shipped acronym/casing for extensible-enum members.
@@clientName(DiskStorageAccountTypes.Standard_LRS, "StandardLrs", "csharp");
@@clientName(DiskStorageAccountTypes.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(
  DiskStorageAccountTypes.StandardSSD_LRS,
  "StandardSsdLrs",
  "csharp"
);
@@clientName(DiskStorageAccountTypes.UltraSSD_LRS, "UltraSsdLrs", "csharp");
@@clientName(DiskStorageAccountTypes.Premium_ZRS, "PremiumZrs", "csharp");
@@clientName(
  DiskStorageAccountTypes.StandardSSD_ZRS,
  "StandardSsdZrs",
  "csharp"
);
@@clientName(DiskStorageAccountTypes.PremiumV2_LRS, "PremiumV2Lrs", "csharp");

@@clientName(SnapshotStorageAccountTypes.Standard_LRS, "StandardLrs", "csharp");
@@clientName(SnapshotStorageAccountTypes.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(SnapshotStorageAccountTypes.Standard_ZRS, "StandardZrs", "csharp");

@@clientName(
  DiskSecurityTypes.ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey,
  "ConfidentialVmGuestStateOnlyEncryptedWithPlatformKey",
  "csharp"
);
@@clientName(
  DiskSecurityTypes.ConfidentialVM_DiskEncryptedWithPlatformKey,
  "ConfidentialVmDiskEncryptedWithPlatformKey",
  "csharp"
);
@@clientName(
  DiskSecurityTypes.ConfidentialVM_DiskEncryptedWithCustomerKey,
  "ConfidentialVmDiskEncryptedWithCustomerKey",
  "csharp"
);
@@clientName(
  DiskSecurityTypes.ConfidentialVM_NonPersistedTPM,
  "ConfidentialVmNonPersistedTPM",
  "csharp"
);

@@clientName(DiskState.ActiveSAS, "ActiveSas", "csharp");
@@clientName(DiskState.ActiveSASFrozen, "ActiveSasFrozen", "csharp");

@@clientName(FileFormat.VHD, "Vhd", "csharp");
@@clientName(FileFormat.VHDX, "Vhdx", "csharp");

@@clientName(
  SupportedSecurityOption.TrustedLaunchAndConfidentialVMSupported,
  "TrustedLaunchAndConfidentialVmSupported",
  "csharp"
);

// ════════════════════════════════════════════════════════════════════════════
// region: ComputeGallery — type/property renames (csharp)
// Restore backward-compatible C# names for the Gallery RP during TypeSpec migration.
// ════════════════════════════════════════════════════════════════════════════

// ── Os→OS property casing renames (C# backward compat) ──
@@clientName(GalleryImageProperties.osType, "OSType", "csharp");
@@clientName(GalleryImageProperties.osState, "OSState", "csharp");
@@clientName(EncryptionImages.osDiskImage, "OSDiskImage", "csharp");
@@clientName(
  GalleryImageVersionStorageProfile.osDiskImage,
  "OSDiskImage",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileProperties.osType,
  "OSType",
  "csharp"
);
@@clientName(SharedGalleryImageProperties.osType, "OSType", "csharp");
@@clientName(SharedGalleryImageProperties.osState, "OSState", "csharp");
@@clientName(
  SharedGalleryImageVersionStorageProfile.osDiskImage,
  "OSDiskImage",
  "csharp"
);
@@clientName(CommunityGalleryImageProperties.osType, "OSType", "csharp");
@@clientName(CommunityGalleryImageProperties.osState, "OSState", "csharp");

@@clientName(
  GalleryTargetExtendedLocation.storageAccountType,
  "GalleryStorageAccountType",
  "csharp"
);

// Main's autorest.md re-typed `softDeletedTime` from string -> date-time:
//   GallerySoftDeletedResource.properties.softDeletedTime: -|date-time
// and the AutoRest naming convention then renamed `Time` -> `On`.
// Spec keeps it as `string`; mirror the legacy C# shape for back-compat.
@@alternateType(
  GallerySoftDeletedResourceProperties.softDeletedTime,
  utcDateTime,
  "csharp"
);
@@clientName(
  GallerySoftDeletedResourceProperties.softDeletedTime,
  "softDeletedOn",
  "csharp"
);

// C# enum singular←plural rename.
@@clientName(SharedToValues, "SharedToValue", "csharp");

// C# renames for backward compatibility (migration from AutoRest).
@@clientName(UserArtifactManage, "UserArtifactManagement", "csharp");
@@clientName(ValidationsProfile, "GalleryImageValidationsProfile", "csharp");
@@clientName(PolicyViolation, "GalleryImageVersionPolicyViolation", "csharp");
@@clientName(ReplicationMode, "GalleryReplicationMode", "csharp");
@@clientName(StorageAccountType, "ImageStorageAccountType", "csharp");
@@clientName(PlatformAttribute, "ComputeGalleryPlatformAttribute", "csharp");
@@clientName(ExecutedValidation, "GalleryImageExecutedValidation", "csharp");
@@clientName(ValidationStatus, "ComputeGalleryValidationStatus", "csharp");
@@clientName(
  GallerySharingPermissionTypes,
  "GallerySharingPermissionType",
  "csharp"
);

// Gallery update models previously shipped as ResourceData-derived patch models.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryImageUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryImageVersionUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryApplicationUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryApplicationVersionUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryScriptUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryScriptVersionUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryInVMAccessControlProfileUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Restore ResourceData base type for gallery patch models"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GalleryInVMAccessControlProfileVersionUpdate,
  Azure.ResourceManager.Foundations.Resource,
  "csharp"
);

// Accessibility overrides.
@@access(CommunityGalleryIdentifier, Access.public, "csharp");
@@access(CommunityGalleryImageIdentifier, Access.public, "csharp");
@@access(SharedGalleryIdentifier, Access.public, "csharp");

// Resource type InVM→InVm casing renames (backward compat with AutoRest output).
@@clientName(
  GalleryInVMAccessControlProfile,
  "GalleryInVmAccessControlProfile",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileVersion,
  "GalleryInVmAccessControlProfileVersion",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileProperties,
  "GalleryInVmAccessControlProfileProperties",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileUpdate,
  "GalleryInVmAccessControlProfilePatch",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileVersionProperties,
  "GalleryInVmAccessControlProfileVersionProperties",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileVersionUpdate,
  "GalleryInVmAccessControlProfileVersionPatch",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileList,
  "GalleryInVmAccessControlProfileList",
  "csharp"
);
@@clientName(
  GalleryInVMAccessControlProfileVersionList,
  "GalleryInVmAccessControlProfileVersionList",
  "csharp"
);

// AccessControlRules and EndpointAccess renames (backward compat with AutoRest RP-prefix).
@@clientName(AccessControlRules, "GalleryInVmAccessControlRules", "csharp");
@@clientName(
  AccessControlRulesMode,
  "GalleryInVmAccessControlRulesMode",
  "csharp"
);
@@clientName(
  AccessControlRulesPrivilege,
  "GalleryInVmAccessControlRulesPrivilege",
  "csharp"
);
@@clientName(
  AccessControlRulesRole,
  "GalleryInVmAccessControlRulesRole",
  "csharp"
);
@@clientName(
  AccessControlRulesIdentity,
  "GalleryInVmAccessControlRulesIdentity",
  "csharp"
);
@@clientName(
  AccessControlRulesRoleAssignment,
  "GalleryInVmAccessControlRulesRoleAssignment",
  "csharp"
);
@@clientName(EndpointAccess, "ComputeGalleryEndpointAccess", "csharp");

// Rename community gallery child identifier property to avoid CS0108 hiding conflict with base class Identifier.
@@clientName(
  CommunityGalleryImageProperties.identifier,
  "ImageIdentifier",
  "csharp"
);
@@clientName(SharedGalleryImageProperties.identifier, "Identifier", "csharp");

// Rename raw gallery operations to match old SDK method names.
@@clientName(SharedGalleries.get, "GetSharedGalleryData", "csharp");
@@clientName(SharedGalleries.list, "GetSharedGalleries", "csharp");
@@clientName(SharedGalleryImages.get, "GetSharedGalleryImage", "csharp");
@@clientName(SharedGalleryImages.list, "GetSharedGalleryImages", "csharp");
@@clientName(
  SharedGalleryImageVersions.get,
  "GetSharedGalleryImageVersion",
  "csharp"
);
@@clientName(
  SharedGalleryImageVersions.list,
  "GetSharedGalleryImageVersions",
  "csharp"
);
@@clientName(CommunityGalleries.get, "GetCommunityGalleryData", "csharp");
@@clientName(CommunityGalleryImages.get, "GetCommunityGalleryImage", "csharp");
@@clientName(
  CommunityGalleryImages.list,
  "GetCommunityGalleryImages",
  "csharp"
);
@@clientName(
  CommunityGalleryImageVersions.get,
  "GetCommunityGalleryImageVersion",
  "csharp"
);
@@clientName(
  CommunityGalleryImageVersions.list,
  "GetCommunityGalleryImageVersions",
  "csharp"
);

// Type renames for backward compatibility.
@@clientName(EndpointTypes, "ComputeGalleryEndpointType", "csharp");
@@clientName(EndpointTypes.IMDS, "Imds", "csharp");
@@clientName(
  GallerySoftDeletedResource,
  "GallerySoftDeletedResourceDetails",
  "csharp"
);
@@clientName(PirResource, "PirResourceData", "csharp");
@@clientName(
  PirSharedGalleryResource,
  "PirSharedGalleryResourceData",
  "csharp"
);
@@clientName(
  PirSharedGalleryResource.identifier,
  "galleryIdentifier",
  "csharp"
);
@@clientName(
  PirCommunityGalleryResource,
  "PirCommunityGalleryResourceData",
  "csharp"
);
@@clientName(
  PirCommunityGalleryResource.identifier,
  "galleryIdentifier",
  "csharp"
);

// Rename gallery models to *Data for backward compatibility (they were ARM resources before).
@@clientName(SharedGallery, "SharedGalleryData", "csharp");
@@clientName(SharedGalleryImage, "SharedGalleryImageData", "csharp");
@@clientName(
  SharedGalleryImageVersion,
  "SharedGalleryImageVersionData",
  "csharp"
);
@@clientName(CommunityGallery, "CommunityGalleryData", "csharp");
@@clientName(CommunityGalleryImage, "CommunityGalleryImageData", "csharp");
@@clientName(
  CommunityGalleryImageVersion,
  "CommunityGalleryImageVersionData",
  "csharp"
);

// ── Plural→singular enum renames (C# backward compat) ──
@@clientName(ReplicationStatusTypes, "ReplicationStatusType", "csharp");
@@clientName(SelectPermissions, "SelectPermission", "csharp");
@@clientName(SharingProfileGroupTypes, "SharingProfileGroupType", "csharp");
@@clientName(
  SharingUpdateOperationTypes,
  "SharingUpdateOperationType",
  "csharp"
);
@@clientName(
  SoftDeletedArtifactTypes,
  "GallerySoftDeletedArtifactType",
  "csharp"
);

// ── VM→Vm casing renames (C# backward compat) ──
@@clientName(
  ConfidentialVMEncryptionType,
  "ConfidentialVmEncryptionType",
  "csharp"
);

// ── Other renames (C# backward compat) ──
@@clientName(GalleryExpandParams, "GalleryExpand", "csharp");
@@clientName(
  PolicyViolationCategory,
  "GalleryImageVersionPolicyViolationCategory",
  "csharp"
);
@@clientName(ReplicationState, "RegionalReplicationState", "csharp");

// ── Property casing renames: acronym case normalization (C# backward compat) ──
@@clientName(
  OSDiskImageSecurityProfile.confidentialVMEncryptionType,
  "ConfidentialVmEncryptionType",
  "csharp"
);
@@clientName(
  OSDiskImageSecurityProfile.secureVMDiskEncryptionSetId,
  "SecureVmDiskEncryptionSetId",
  "csharp"
);
@@clientName(RecommendedMachineConfiguration.vCPUs, "VCpus", "csharp");

// ── Is* prefix property renames (C# backward compat) ──
@@clientName(
  GalleryApplicationCustomActionParameter.required,
  "IsRequired",
  "csharp"
);
@@clientName(
  GalleryImageVersionSafetyProfile.blockDeletionBeforeEndOfLife,
  "IsBlockedDeletionBeforeEndOfLife",
  "csharp"
);
@@clientName(
  GalleryImageVersionSafetyProfile.reportedForPolicyViolation,
  "IsReportedForPolicyViolation",
  "csharp"
);
@@clientName(TargetRegion.excludeFromLatest, "IsExcludedFromLatest", "csharp");
@@clientName(
  GalleryArtifactPublishingProfileBase.excludeFromLatest,
  "IsExcludedFromLatest",
  "csharp"
);
@@clientName(
  SharedGalleryImageVersionProperties.excludeFromLatest,
  "IsExcludedFromLatest",
  "csharp"
);
@@clientName(
  CommunityGalleryImageVersionProperties.excludeFromLatest,
  "IsExcludedFromLatest",
  "csharp"
);
// Match v1.14.0 baseline: property is `IsRestoreEnabled`.
@@clientName(
  GalleryImageVersionProperties.restore,
  "IsRestoreEnabled",
  "csharp"
);

// ── Qualified property name renames (C# backward compat) ──
@@clientName(
  GalleryApplicationCustomActionParameter.type,
  "ParameterType",
  "csharp"
);
@@clientName(GalleryExtendedLocation.type, "ExtendedLocationType", "csharp");
@@clientName(ExecutedValidation.type, "ExecutedValidationType", "csharp");
@@clientName(GalleryScriptParameter.type, "ParameterType", "csharp");
@@clientName(SharingProfileGroup.type, "GroupType", "csharp");
@@clientName(UefiKey.type, "KeyType", "csharp");

// ── Other property renames (C# backward compat) ──
@@clientName(ValidationsProfile.validationEtag, "ValidationETag", "csharp");
@@clientName(SharingProfile.permissions, "Permission", "csharp");

// ── alternateType: string → Uri (C# backward compat) ──
@@alternateType(GalleryImageProperties.privacyStatementUri, url, "csharp");
@@alternateType(GalleryImageProperties.releaseNoteUri, url, "csharp");
@@alternateType(
  GalleryApplicationProperties.privacyStatementUri,
  url,
  "csharp"
);
@@alternateType(GalleryApplicationProperties.releaseNoteUri, url, "csharp");
@@alternateType(GalleryScriptProperties.privacyStatementUri, url, "csharp");
@@alternateType(GalleryScriptProperties.releaseNoteUri, url, "csharp");
@@alternateType(
  SharedGalleryImageProperties.privacyStatementUri,
  url,
  "csharp"
);
@@clientName(CommunityGalleryInfo.publisherUri, "publisherUriString", "csharp");
@@alternateType(CommunityGalleryMetadata.privacyStatementUri, url, "csharp");
@@alternateType(
  CommunityGalleryImageProperties.privacyStatementUri,
  url,
  "csharp"
);

// ── alternateType: string → ResourceIdentifier (C# backward compat) ──

// Wrapper model id properties → ResourceIdentifier.
@@alternateType(
  GalleryArtifactVersionSource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Direct string properties → ResourceIdentifier.
@@alternateType(
  GalleryArtifactVersionFullSource.virtualMachineId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  GalleryDiskImageSource.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DiskImageEncryption.diskEncryptionSetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// ── PirCommunityGalleryResource.type: rename + retype for C# back-compat ──
// Spec emits `type?: string`. The previously shipped C# SDK exposed it as
// `ResourceType` of type `Azure.Core.ResourceType?`. Restore both.
@@clientName(PirCommunityGalleryResource.type, "ResourceType", "csharp");
@@alternateType(
  PirCommunityGalleryResource.type,
  Azure.Core.armResourceType,
  "csharp"
);

// ── alternateType: Identity → ManagedServiceIdentity (C# backward compat) ──
@@alternateType(
  Gallery.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  GalleryUpdate.identity,
  Azure.ResourceManager.Foundations.ManagedServiceIdentity,
  "csharp"
);

// .NET back-compat: restore previously shipped acronym/casing for extensible-enum members.
@@clientName(StorageAccountType.Standard_LRS, "StandardLrs", "csharp");
@@clientName(StorageAccountType.Standard_ZRS, "StandardZrs", "csharp");
@@clientName(StorageAccountType.Premium_LRS, "PremiumLrs", "csharp");
@@clientName(StorageAccountType.PremiumV2_LRS, "PremiumV2Lrs", "csharp");

@@clientName(EdgeZoneStorageAccountType.Standard_LRS, "StandardLrs", "csharp");
@@clientName(EdgeZoneStorageAccountType.Standard_ZRS, "StandardZrs", "csharp");
@@clientName(
  EdgeZoneStorageAccountType.StandardSSD_LRS,
  "StandardSsdLrs",
  "csharp"
);
@@clientName(EdgeZoneStorageAccountType.Premium_LRS, "PremiumLrs", "csharp");

@@clientName(
  ConfidentialVMEncryptionType.EncryptedVMGuestStateOnlyWithPmk,
  "EncryptedVmGuestStateOnlyWithPmk",
  "csharp"
);

@@clientName(PolicyViolationCategory.IpTheft, "IPTheft", "csharp");

@@clientName(
  StorageAccountStrategy.PreferStandard_ZRS,
  "PreferStandardZrs",
  "csharp"
);
@@clientName(
  StorageAccountStrategy.DefaultStandard_LRS,
  "DefaultStandardLrs",
  "csharp"
);

// ── Azure.ClientGenerator.Core.Usage.input forces public ctor + property setters on output-only models ──
// .NET back-compat: GallerySoftDeletedResource previously shipped with a public
// parameterless ctor and writable properties. Restore via Azure.ClientGenerator.Core.Usage.input for csharp.
@@usage(
  GallerySoftDeletedResource,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);
