import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Fabric {
  @@access(Operations.list, Access.internal, "csharp");

  @@clientName(FabricCapacities.checkNameAvailability,
    "CheckFabricCapacityNameAvailability",
    "csharp"
  );
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
  @@clientName(Quota, "FabricQuota", "csharp");
}

@@clientName(Microsoft.Fabric, "FabricMgmtClient", "python");
@@clientName(Microsoft.Fabric, "FabricManagementClient", "java");
