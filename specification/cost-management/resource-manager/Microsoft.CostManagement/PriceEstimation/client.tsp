import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.CostManagement,
  "CostManagementPriceEstimationMgmtClient",
  "python"
);

@@clientName(
  Microsoft.CostManagement,
  "CostManagementPriceEstimationManagementClient",
  "javascript"
);

// estimatePrices polls this GET through its Location header; Java must not expose it as an LRO initiator.
@@scope(
  Microsoft.CostManagement.PriceEstimation.getEstimatePricesOperationResult,
  "!java"
);
