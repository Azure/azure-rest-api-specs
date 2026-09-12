import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Compute;

// Service-level SDK names.
@@clientName(Microsoft.Compute, "RecommenderMgmtClient", "python");
@@clientName(
  Microsoft.Compute,
  "ComputeRecommenderManagementClient",
  "javascript"
);

// Shared placement score SDK types.
@@alternateType(PlacementScore.region, azureLocation, "csharp");
@@clientName(PlacementScore, "ComputeRecommenderPlacementScore", "csharp");
@@clientName(ResourceSize, "ComputeRecommenderResourceSize", "csharp");
@@clientName(
  PlacementScoresProperties,
  "ComputeRecommenderPlacementScoresProperties",
  "csharp"
);

// Spot placement score SDK names preserve the existing C# API surface.
@@alternateType(
  SpotPlacementScoresInput.desiredLocations,
  azureLocation[],
  "csharp"
);
@@clientName(
  SpotPlacementScoresInput,
  "ComputeRecommenderGenerateContent",
  "csharp"
);
@@alternateType(
  SpotPlacementScoresResponse.desiredLocations,
  azureLocation[],
  "csharp"
);
@@clientName(
  SpotPlacementScoresResponse,
  "ComputeRecommenderGenerateResult",
  "csharp"
);
@@clientName(SpotPlacementScoresBase, "ComputeRecommenderPlacementScores", "csharp");
@@clientName(SpotPlacementScores.post, "generate", "csharp");

// Regular compute placement score SDK names use the explicit operation group name.
@@clientName(
  ComputePlacementScoresInput,
  "ComputePlacementScoresGenerateContent",
  "csharp"
);
@@clientName(
  ComputePlacementScoresResponse,
  "ComputePlacementScoresGenerateResult",
  "csharp"
);
@@clientName(
  ComputePlacementScoresBase,
  "ComputePlacementScores",
  "csharp"
);
@@clientName(ComputePlacementScores.post, "generate", "csharp");

// SKU mix placement score SDK names.
@@clientName(
  SkuMixPlacementRequest,
  "ComputeSkuMixPlacementGenerateContent",
  "csharp"
);
@@clientName(
  SkuMixPlacementResponse,
  "ComputeSkuMixPlacementGenerateResult",
  "csharp"
);
@@clientName(
  SkuMixPlacementDeploymentChoice,
  "ComputeSkuMixPlacementDeploymentChoice",
  "csharp"
);
@@clientName(SkuMixPlacementItem, "ComputeSkuMixPlacementItem", "csharp");
@@clientName(
  SkuMixPlacementCapacityLimit,
  "ComputeSkuMixPlacementCapacityLimit",
  "csharp"
);
@@clientName(SkuMixPlacementBase, "ComputeSkuMixPlacement", "csharp");
@@clientName(SkuMixPlacementResponse.validUntil, "ValidUntilOn", "csharp");
@@clientName(SkuMixPlacementScores.post, "generate", "csharp");
