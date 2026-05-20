import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager.Foundations;
using Microsoft.PowerBIDedicated;

@@clientName(Capacities.getDetails, "get", "csharp");
@@clientName(CheckCapacityNameAvailabilityParameters,
  "CheckCapacityNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckCapacityNameAvailabilityParameters.type,
  "ResourceType",
  "csharp"
);
@@clientName(CapacitiesOperationGroup.checkNameAvailability,
  "checkNameAvailabilityCapacity",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(SkuDetailsForExistingResource, "SkuDetails", "csharp");
@@alternateType(DedicatedCapacityMutableProperties.tenantId, uuid, "csharp");
@@alternateType(CapacitiesOperationGroup.checkNameAvailability::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(CapacitiesOperationGroup.listSkus, "GetSkusCapacities", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "make it pageable for backwards compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Capacities.listSkusForCapacity,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "make it pageable for backwards compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(CapacitiesOperationGroup.listSkus,
  "csharp"
);

@@clientName(CapacitySkuTier.PBIE_Azure, "PbieAzure", "csharp");
