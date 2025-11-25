import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;

namespace Microsoft.Compute;

@@clientName(ResourceSku, "ComputeResourceSku", "csharp");
@@alternateType(ResourceSku.locations, azureLocation[], "csharp");
@@clientName(ResourceSkuCapacity, "ComputeResourceSkuCapacity", "csharp");
@@clientName(ResourceSkuCapabilities,
  "ComputeResourceSkuCapabilities",
  "csharp"
);
@@clientName(ResourceSkuLocationInfo,
  "ComputeResourceSkuLocationInfo",
  "csharp"
);
@@alternateType(ResourceSkuLocationInfo.location, azureLocation, "csharp");
@@clientName(ResourceSkuLocationInfo.type, "ExtendedLocationType", "csharp");
@@clientName(ResourceSkuRestrictions,
  "ComputeResourceSkuRestrictions",
  "csharp"
);
@@clientName(ResourceSkuRestrictions.type, "RestrictionsType", "csharp");
@@clientName(ResourceSkuCapacityScaleType,
  "ComputeResourceSkuCapacityScaleType",
  "csharp"
);
@@clientName(ResourceSkuRestrictionInfo,
  "ComputeResourceSkuRestrictionInfo",
  "csharp"
);
@@alternateType(ResourceSkuRestrictionInfo.locations,
  azureLocation[],
  "csharp"
);
@@clientName(ResourceSkuRestrictionsReasonCode,
  "ComputeResourceSkuRestrictionsReasonCode",
  "csharp"
);
@@clientName(ResourceSkuRestrictionsType,
  "ComputeResourceSkuRestrictionsType",
  "csharp"
);
@@clientName(ResourceSkuZoneDetails, "ComputeResourceSkuZoneDetails", "csharp");
@@clientName(ResourceSkuCosts.meterID, "MeterId", "csharp");
@@clientName(ResourceSkus.list, "GetComputeResourceSkus", "csharp");
