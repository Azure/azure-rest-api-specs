import "@azure-tools/typespec-client-generator-core";
import "./Compute/client.tsp";
import "./ComputeDisk/client.tsp";
import "./ComputeGallery/client.tsp";
import "./ComputeSku/main.tsp";
import "./alternate-type-stubs.tsp";

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
@@usage(VirtualMachineInstanceView,
  Azure.ClientGenerator.Core.Usage.input,
  "java"
);

// AvailabilitySetSkuTypes needs public access and input+output usage for premium layer
@@access(AvailabilitySetSkuTypes, Access.public, "java");
@@usage(AvailabilitySetSkuTypes,
  Azure.ClientGenerator.Core.Usage.input | Azure.ClientGenerator.Core.Usage.output,
  "java"
);

// TODO: maximumDuration type changed from String to Duration, revert to String to avoid breaking change
@@alternateType(VirtualMachineInstallPatchesParameters.maximumDuration,
  string,
  "java"
);

// PurchasePlan needs input usage for premium layer constructor and setters
@@usage(PurchasePlan, Azure.ClientGenerator.Core.Usage.input, "java");

// Property name changes: retain old Java names for ComputeGallery and ComputeSku models
@@clientName(AccessControlRulesIdentity.userName, "username", "java");
@@clientName(ResourceSkuCosts.meterID, "meterId", "java");

// Rename model to match old Swagger-generated name
@@clientName(UserAssignedIdentitiesValue,
  "VirtualMachineIdentityUserAssignedIdentities",
  "java"
);

// ── C# type renames for backward compatibility (migration from AutoRest) ──

// Common namespace types
// Common.SubResource has a writable id → maps to ComputeWriteableSubResourceData (matches old AutoRest).
// Common.SubResourceReadOnly has a read-only id → maps to ComputeSubResourceData (matches old AutoRest).
@@clientName(Common.SubResource, "ComputeWriteableSubResourceData", "csharp");
@@clientName(Common.SubResourceReadOnly, "ComputeSubResourceData", "csharp");

// Replace Compute's local ExtendedLocation / ExtendedLocationType with ARM common types
@@alternateType(Common.ExtendedLocation,
  Azure.ResourceManager.CommonTypes.ExtendedLocation,
  "csharp"
);
@@alternateType(ComputeSku.ResourceSkuLocationInfo.type,
  Azure.ResourceManager.CommonTypes.ExtendedLocationType,
  "csharp"
);

// ComputeSku namespace types
@@clientName(ComputeSku.ResourceSku, "ComputeResourceSku", "csharp");
@@clientName(ComputeSku.ResourceSkuCapabilities,
  "ComputeResourceSkuCapabilities",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuCapacity,
  "ComputeResourceSkuCapacity",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuCapacityScaleType,
  "ComputeResourceSkuCapacityScaleType",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuLocationInfo,
  "ComputeResourceSkuLocationInfo",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuRestrictionInfo,
  "ComputeResourceSkuRestrictionInfo",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuRestrictions,
  "ComputeResourceSkuRestrictions",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuRestrictionsReasonCode,
  "ComputeResourceSkuRestrictionsReasonCode",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuRestrictionsType,
  "ComputeResourceSkuRestrictionsType",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuZoneDetails,
  "ComputeResourceSkuZoneDetails",
  "csharp"
);

// ComputeSku property renames (C# backward compat)
@@clientName(ComputeSku.ResourceSkuCosts.meterID, "MeterId", "csharp");
@@clientName(ComputeSku.ResourceSkuRestrictions.type,
  "RestrictionsType",
  "csharp"
);
@@clientName(ComputeSku.ExtendedLocationType,
  "ComputeExtendedLocationType",
  "csharp"
);
@@clientName(ComputeSku.ResourceSkuLocationInfo.type,
  "ExtendedLocationType",
  "csharp"
);

// ── alternateType: SubResource.id → ResourceIdentifier for C# (migration from AutoRest) ──
@@alternateType(Common.SubResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// NOTE: Common.Architecture → ArchitectureType is handled by auto-rename of Compute.ArchitectureTypes → ArchitectureType

// ── Consolidate duplicate enums into the C# baseline names (G1) ──
// Baseline shipped a single ArchitectureType / HyperVGeneration / IPVersion;
// the spec splits them into multiple unions. Retype the minority-enum properties
// to the canonical union so the C# SDK exposes a single type per concept.
@@alternateType(ComputeDisk.SupportedCapabilities.architecture, Compute.ArchitectureTypes, "csharp");
@@alternateType(ComputeGallery.GalleryImageProperties.architecture, Compute.ArchitectureTypes, "csharp");
@@alternateType(ComputeGallery.SharedGalleryImageProperties.architecture, Compute.ArchitectureTypes, "csharp");
@@alternateType(ComputeGallery.CommunityGalleryImageProperties.architecture, Compute.ArchitectureTypes, "csharp");

@@alternateType(Compute.VirtualMachineImageProperties.hyperVGeneration, Common.HyperVGeneration, "csharp");
@@alternateType(Compute.ImageProperties.hyperVGeneration, Common.HyperVGeneration, "csharp");
@@alternateType(Compute.RestorePointSourceMetadata.hyperVGeneration, Common.HyperVGeneration, "csharp");
@@alternateType(Compute.VirtualMachineInstanceView.hyperVGeneration, Common.HyperVGeneration, "csharp");

@@alternateType(Compute.VirtualMachineNetworkInterfaceIPConfigurationProperties.privateIPAddressVersion, Compute.IPVersion, "csharp");
@@alternateType(Compute.VirtualMachinePublicIPAddressConfigurationProperties.publicIPAddressVersion, Compute.IPVersion, "csharp");

// ── G2: location / resourceType narrowed to string in spec; restore Azure.Core.azureLocation/armResourceType ──
@@alternateType(ComputeSku.ResourceSku.locations, Azure.Core.azureLocation[], "csharp");
@@alternateType(ComputeSku.ResourceSkuRestrictionInfo.locations, Azure.Core.azureLocation[], "csharp");
@@alternateType(ComputeSku.ResourceSkuLocationInfo.location, Azure.Core.azureLocation, "csharp");
@@alternateType(ComputeDisk.DiskRestorePointProperties.sourceResourceLocation, Azure.Core.azureLocation, "csharp");
@@alternateType(ComputeGallery.PirResource.location, Azure.Core.azureLocation, "csharp");
@@alternateType(ComputeGallery.PirCommunityGalleryResource.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Compute.RestorePointCollectionSourceProperties.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Compute.RestorePointSourceMetadata.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Compute.UpgradeOperationHistoricalStatusInfo.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Compute.VirtualMachineScaleSetVMExtension.location, Azure.Core.azureLocation, "csharp");
@@alternateType(Compute.VirtualMachineScaleSetSku.resourceType, Azure.Core.armResourceType, "csharp");

// ── G5: rename `protectedSettingsFromKeyVault` → `keyVaultProtectedSettings` (csharp only) so the generated
//        property matches the previously-shipped name `KeyVaultProtectedSettings` of type KeyVaultSecretReference.
//        A separate partial-class shim restores the deprecated BinaryData `ProtectedSettingsFromKeyVault` member.
@@clientName(Compute.VirtualMachineExtensionProperties.protectedSettingsFromKeyVault, "keyVaultProtectedSettings", "csharp");
@@clientName(Compute.VirtualMachineExtensionUpdateProperties.protectedSettingsFromKeyVault, "keyVaultProtectedSettings", "csharp");
@@clientName(Compute.VirtualMachineScaleSetExtensionProperties.protectedSettingsFromKeyVault, "keyVaultProtectedSettings", "csharp");

// ── C# operation renames for backward compatibility (migration from AutoRest) ──
// These mirror the override-operation-name entries from the deleted autorest.md.
@@clientName(Compute.VirtualMachines.start, "PowerOn", "csharp");
@@clientName(Compute.VirtualMachines.migrateToVMScaleSet,
  "MigrateToVirtualMachineScaleSet",
  "csharp"
);
@@clientName(Compute.VirtualMachineScaleSets.start, "PowerOn", "csharp");
@@clientName(Compute.VirtualMachineScaleSets.cancel,
  "CancelVirtualMachineScaleSetRollingUpgrade",
  "csharp"
);
@@clientName(Compute.VirtualMachineScaleSets.startExtensionUpgrade,
  "StartExtensionUpgradeVirtualMachineScaleSetRollingUpgrade",
  "csharp"
);
@@clientName(Compute.VirtualMachineScaleSetVMS.start, "PowerOn", "csharp");
@@clientName(ComputeGallery.Galleries.gallerySharingProfileUpdate,
  "UpdateSharingProfile",
  "csharp"
);
@@clientName(ComputeGallery.Galleries.listByArtifactName,
  "GetSoftDeletedResourcesByArtifactName",
  "csharp"
);

// ── C# operation rename: ResourceSkus.list emits `GetAll`; restore baseline name. ──
@@clientName(ComputeSku.ResourceSkus.list, "GetComputeResourceSkus", "csharp");
