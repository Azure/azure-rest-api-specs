import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.CostManagement,
  "CostManagementPriceEstimationMgmtClient",
  "python"
);

@@scope(
  Microsoft.CostManagement.PriceEstimation.getEstimatePricesOperationResult,
  "!java"
);
