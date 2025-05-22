import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Fabric {
  @@access(Operations.list, Access.internal, "csharp");

  // @@clientName(FabricCapacities.checkNameAvailability, "CheckFabricCapacityNameAvailability", "csharp"); // this current does not work on C# generator, temporarily remove this customization and will restore this back once the generator solves the issue
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
    "FabricNameAvailabilityContent",
    "csharp"
  );
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
    "ResourceType",
    "csharp"
  );
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
    "FabricNameAvailabilityResult",
    "csharp"
  );
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
    "IsNameAvailable",
    "csharp"
  );
  @@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
    "FabricNameUnavailableReason",
    "csharp"
  );
  @@clientName(ProvisioningState, "FabricProvisioningState", "csharp");
  @@clientName(ResourceState, "FabricResourceState", "csharp");
  @@clientName(RpSkuDetailsForNewResource,
    "FabricSkuDetailsForNewCapacity",
    "csharp"
  );
  @@clientName(RpSkuDetailsForExistingResource,
    "FabricSkuDetailsForExistingCapacity",
    "csharp"
  );
  @@clientName(RpSku, "FabricSku", "csharp");
  @@clientName(RpSkuTier, "FabricSkuTier", "csharp");
  @@clientName(CapacityAdministration,
    "FabricCapacityAdministration",
    "csharp"
  );
}
