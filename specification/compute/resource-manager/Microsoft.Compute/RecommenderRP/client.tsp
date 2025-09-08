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
  Microsoft.Compute.SpotPlacementScoresInput::properties.desiredLocations,
  Azure.Core.AzureLocation,
  "csharp"
);
@@alternateType(
  Microsoft.Compute.SpotPlacementScoresResponse::properties.desiredLocations,
  Azure.Core.AzureLocation,
  "csharp"
);
