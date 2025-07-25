import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager.Foundations;

@@clientName(Microsoft.FileShares, "FileSharesManagementClient", "java");

@@clientName(CheckNameAvailabilityResponse,
  "CheckNameAvailabilityResult",
  "csharp"
);

@@clientName(FileShareLimitsResponse,
  "FileShareLimitsResult",
  "csharp"
);

@@clientName(FileShareProvisioningRecommendationResponse,
  "FileShareProvisioningRecommendationResult",
  "csharp"
);

@@clientName(FileShareUsageDataResponse,
  "FileShareUsageDataResult",
  "csharp"
);

@@clientName(Azure.ResourceManager.CommonTypes.Operation, "Info", "csharp");
