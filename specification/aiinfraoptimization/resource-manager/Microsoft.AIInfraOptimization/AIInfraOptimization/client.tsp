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
@@clientName(
  RecommendVmSkuOption,
  "AIInfraOptimizationRecommendVmSkuOptionConfig",
  "csharp"
);
@@clientName(BenchmarkLevel, "RecommendVmSkuBenchmarkLevel", "csharp");
@@clientName(CostSource, "RecommendVmSkuCostSource", "csharp");
@@clientName(PlacementStatus, "RecommendVmSkuPlacementStatus", "csharp");
@@clientName(ProcurementOption, "RecommendVmSkuProcurementOption", "csharp");
@@clientName(QuotaStatus, "RecommendVmSkuQuotaStatus", "csharp");
@@clientName(RankingPreference, "RecommendVmSkuRankingPreference", "csharp");
@@clientName(ReadinessStatus, "RecommendVmSkuReadinessStatus", "csharp");
@@clientName(StageErrorCode, "RecommendVmSkuStageErrorCode", "csharp");
@@clientName(
  RecommendVmSkuOption.azureMlRecommended,
  "isAzureMlRecommended",
  "csharp"
);
@@clientName(RecommendVmSkuCost.priceAsOf, "priceObservedOn", "csharp");
@@clientName(
  RecommendVmSkuSubscriptionOptions.includeQuota,
  "shouldIncludeQuota",
  "csharp"
);
@@clientName(
  RecommendVmSkuSubscriptionOptions.includePlacement,
  "shouldIncludePlacement",
  "csharp"
);
@@clientName(
  RecommendVmSkuSubscriptionOptions.includePricing,
  "shouldIncludePricing",
  "csharp"
);
@@clientName(WeightPrecision.INT8, "Int8", "csharp");
@@clientName(WeightPrecision.INT4, "Int4", "csharp");

@@clientName(
  RecommendVmSkuOption.azureMlRecommended,
  "AzureMLRecommended",
  "go"
);
@@clientName(
  RecommendVmSkuMemory.kvCacheGiBPerRequest,
  "KVCacheGiBPerRequest",
  "go"
);
@@clientName(RecommendVmSkuMemory.kvCacheGiBTotal, "KVCacheGiBTotal", "go");
@@clientName(
  RecommendVmSkuMemory.modelAndKvCacheGiB,
  "ModelAndKVCacheGiB",
  "go"
);
@@clientName(RecommendVmSkuBenchmark.p99TpotMs, "P99TPOTMs", "go");
@@clientName(RecommendVmSkuBenchmark.p99TtftMs, "P99TTFTMs", "go");
@@clientName(RecommendVmSkuPerformanceEstimate.ttftMs, "TTFTMs", "go");
