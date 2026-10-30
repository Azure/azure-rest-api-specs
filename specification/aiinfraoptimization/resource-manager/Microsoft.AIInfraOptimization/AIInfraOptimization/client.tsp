import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AIInfraOptimization;

@@clientName(
  Microsoft.AIInfraOptimization,
  "AIInfraOptimizationMgmtClient",
  "python"
);

@@clientName(RecommendVmSkuRequest, "RecommendVmSkuContent", "csharp");
@@clientName(RecommendVmSkuResponse, "RecommendVmSkuResult", "csharp");
@@clientName(
  RecommendVmSkuSubscriptionOptions,
  "RecommendVmSkuSubscriptionConfig",
  "csharp"
);
@@clientName(
  RecommendVmSkuOption.documentationUrl,
  "documentationUri",
  "csharp"
);
@@clientName(RecommendVmSkuQuotaIncrease.portalUrl, "portalUri", "csharp");
