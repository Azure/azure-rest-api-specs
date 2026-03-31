import "@azure-tools/typespec-client-generator-core";
import "./Compute/client.tsp";
import "./ComputeDisk/client.tsp";
import "./ComputeGallery/main.tsp";
import "./ComputeSku/main.tsp";

using Azure.ClientGenerator.Core;
using Common;
using Compute;
using ComputeGallery;
using ComputeSku;

/**
 * Compute Client
 */
@client({
  name: "ComputeClient",
  service: [Compute, ComputeDisk, ComputeGallery, ComputeSku],
  autoMergeService: true,
})
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
