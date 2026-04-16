import "@azure-tools/typespec-client-generator-core";
import "./Compute/client.tsp";
import "./ComputeDisk/client.tsp";
import "./ComputeGallery/client.tsp";
import "./ComputeSku/main.tsp";
import "./alternate-type-stubs.tsp";

using Azure.ClientGenerator.Core;
using Common;
using Compute;
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
  "!python"
)
@client(
  {
    name: "ComputeManagementClient",
    service: [Compute, ComputeDisk, ComputeGallery, ComputeSku],
    autoMergeService: true,
  },
  "python"
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
@@clientName(Common.SubResource, "ComputeSubResourceData", "csharp");
@@clientName(Common.SubResourceReadOnly, "ComputeWriteableSubResourceData", "csharp");

// ExtendedLocation → Azure.ResourceManager.Resources.Models.ExtendedLocation for C#
// TODO: ExtendedLocation alternateType needs a solution — can't define stub due to name collision with Common.ExtendedLocation

// ComputeSku namespace types
@@clientName(ComputeSku.ResourceSku, "ComputeResourceSku", "csharp");
@@clientName(ComputeSku.ResourceSkuCapabilities, "ComputeResourceSkuCapabilities", "csharp");
@@clientName(ComputeSku.ResourceSkuCapacity, "ComputeResourceSkuCapacity", "csharp");
@@clientName(ComputeSku.ResourceSkuCapacityScaleType, "ComputeResourceSkuCapacityScaleType", "csharp");
@@clientName(ComputeSku.ResourceSkuLocationInfo, "ComputeResourceSkuLocationInfo", "csharp");
@@clientName(ComputeSku.ResourceSkuRestrictionInfo, "ComputeResourceSkuRestrictionInfo", "csharp");
@@clientName(ComputeSku.ResourceSkuRestrictions, "ComputeResourceSkuRestrictions", "csharp");
@@clientName(ComputeSku.ResourceSkuRestrictionsReasonCode, "ComputeResourceSkuRestrictionsReasonCode", "csharp");
@@clientName(ComputeSku.ResourceSkuRestrictionsType, "ComputeResourceSkuRestrictionsType", "csharp");
@@clientName(ComputeSku.ResourceSkuZoneDetails, "ComputeResourceSkuZoneDetails", "csharp");

// ComputeSku property renames (C# backward compat)
@@clientName(ComputeSku.ResourceSkuCosts.meterID, "MeterId", "csharp");
@@clientName(ComputeSku.ResourceSkuRestrictions.type, "RestrictionsType", "csharp");
@@clientName(ComputeSku.ResourceSkuLocationInfo.type, "ExtendedLocationType", "csharp");

// ── alternateType: SubResource.id → ResourceIdentifier for C# (migration from AutoRest) ──
@@alternateType(Common.SubResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// NOTE: Common.Architecture → ArchitectureType is handled by auto-rename of Compute.ArchitectureTypes → ArchitectureType
