import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(Microsoft.Compute, "RecommenderMgmtClient", "python");
@@clientName(Microsoft.Compute,
  "ComputeRecommenderManagementClient",
  "javascript"
);
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
@@alternateType(PlacementScore.region, azureLocation, "csharp");
@@clientName(PlacementScore, "ComputeRecommenderPlacementScore", "csharp");
@@clientName(ResourceSize, "ComputeRecommenderResourceSize", "csharp");
@@clientName(ComputeDiagnosticBase, "ComputeRecommenderDiagnostic", "csharp");
@@clientName(DiagnosticProperties,
  "ComputeRecommenderDiagnosticProperties",
  "csharp"
);
@@clientName(ComputeDiagnosticBases.post, "generate", "csharp");
