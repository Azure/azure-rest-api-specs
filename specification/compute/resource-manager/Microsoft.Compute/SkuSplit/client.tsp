import "./main.tsp";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.Compute;

@@clientName(Microsoft.Compute, "SkuSplitMgmtClient", "python");
@@clientName(Microsoft.Compute,
  "ComputeSkuSplitManagementClient",
  "javascript"
);
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
@@clientName(SkuMixPlacementBase, "ComputeSkuMixPlacementResource", "csharp");
@@clientName(SkuMixPlacementScores.post, "generate", "csharp");
