import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Compute, "RecommenderMgmt", "python");
@@clientName(Microsoft.Compute,
  "ComputeRecommenderManagementClient",
  "javascript"
);
@@alternateType(
  SpotPlacementScoresInput::properties.desiredLocations,
  Azure.Core.AzureLocation,
  "csharp"
);
@@alternateType(
  SpotPlacementScoresResponse::properties.desiredLocations,
  Azure.Core.AzureLocation,
  "csharp"
);
