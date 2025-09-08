import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Compute, "RecommenderMgmt", "python");
@@clientName(Microsoft.Compute,
  "ComputeRecommenderManagementClient",
  "javascript"
);
@@alternateType(
  Microsoft.Compute.SpotPlacementScoresInput.desiredLocations,
  Azure.Core.AzureLocation,
  "csharp"
);
@@alternateType(
  Microsoft.Compute.SpotPlacementScoresResponse.desiredLocations,
  Azure.Core.AzureLocation,
  "csharp"
);
