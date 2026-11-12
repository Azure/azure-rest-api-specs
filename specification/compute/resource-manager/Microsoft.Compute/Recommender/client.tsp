import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Compute;

// Service-level SDK names.
@@clientName(Microsoft.Compute, "RecommenderMgmtClient", "python");
@@clientName(Microsoft.Compute,
  "ComputeRecommenderManagementClient",
  "javascript"
);

// Shared placement score SDK types.
@@doc(PlacementScore,
  "The placement score for a virtual machine SKU, region, and availability zone combination."
);
@@doc(PlacementScore.score,
  "A placement score indicating the likelihood of successfully allocating the specified virtual machines."
);
@@alternateType(PlacementScore.region, azureLocation, "csharp");
@@clientName(PlacementScore, "ComputeRecommenderPlacementScore", "csharp");
@@clientName(ResourceSize, "ComputeRecommenderResourceSize", "csharp");
@@clientName(PlacementScoresProperties,
  "ComputeRecommenderPlacementScoresProperties",
  "csharp"
);

// Spot placement score SDK names preserve the existing C# API surface.
@@alternateType(SpotPlacementScoresInput.desiredLocations,
  azureLocation[],
  "csharp"
);
@@clientName(SpotPlacementScoresInput,
  "ComputeRecommenderGenerateContent",
  "csharp"
);
@@alternateType(SpotPlacementScoresResponse.desiredLocations,
  azureLocation[],
  "csharp"
);
@@clientName(SpotPlacementScoresResponse,
  "ComputeRecommenderGenerateResult",
  "csharp"
);
@@clientName(SpotPlacementScoresBase, "ComputeRecommenderDiagnostic", "csharp");
@@clientName(PlacementScoresProperties.supportedResourceTypes,
  "ComputeRecommenderDiagnosticSupportedResourceTypes",
  "csharp"
);
@@clientName(SpotPlacementScores.post, "generate", "csharp");

// Regular compute placement score SDK names use the explicit operation group name.
@@doc(ComputePlacementScoresResponse,
  "The results of scoring placement for regular virtual machines."
);
@@doc(ComputePlacementScoresResponse.placementScores,
  "Placement scores indicating the likelihood of successfully allocating the specified regular virtual machines."
);
@@clientName(ComputePlacementScoresInput,
  "ComputePlacementScoresGenerateContent",
  "csharp"
);
@@clientName(ComputePlacementScoresInput.availabilityZones,
  "IsZonal",
  "csharp"
);
@@clientName(ComputePlacementScoresResponse,
  "ComputePlacementScoresGenerateResult",
  "csharp"
);
@@clientName(ComputePlacementScoresResponse.availabilityZones,
  "IsZonal",
  "csharp"
);
@@clientName(ComputePlacementScoresBase, "ComputePlacementScores", "csharp");
@@clientName(ComputePlacementScores.post, "generate", "csharp");

// SKU mix placement score SDK names.
@@clientName(SkuMixPlacementVMSize, "SkuMixPlacementVmSize", "csharp");
@@clientName(SkuMixPlacementRequest,
  "ComputeSkuMixPlacementGenerateContent",
  "csharp"
);
@@clientName(SkuMixPlacementResponse,
  "ComputeSkuMixPlacementGenerateResult",
  "csharp"
);
@@clientName(SkuMixPlacementDeploymentChoice,
  "ComputeSkuMixPlacementDeploymentChoice",
  "csharp"
);
@@clientName(SkuMixPlacementItem, "ComputeSkuMixPlacementItem", "csharp");
@@clientName(SkuMixPlacementCapacityLimit,
  "ComputeSkuMixPlacementCapacityLimit",
  "csharp"
);
@@clientName(SkuMixPlacementBase, "ComputeSkuMixPlacement", "csharp");
@@clientName(SkuMixPlacementResponse.validUntil, "ValidUntilOn", "csharp");
@@clientName(SkuMixPlacementScores.post, "generate", "csharp");
