import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Consumption;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Consumption,
  "ConsumptionManagementClient",
  "python,javascript"
);

// Fix property name changes from lowercase to uppercase (etag -> eTag)
@@clientName(BudgetProperties.eTag, "etag", "java");
@@clientName(TagProperties.eTag, "etag", "java");
@@clientName(EventProperties.eTag, "etag", "java");
@@clientName(LotProperties.eTag, "etag", "java");
@@clientName(CreditSummaryProperties.eTag, "etag", "java");

// Fix USD property name changes (costInUSD -> costInUsd, paygCostInUSD -> paygCostInUsd)
@@clientName(ModernUsageDetailProperties.costInUSD, "costInUsd", "java");
@@clientName(ModernUsageDetailProperties.paygCostInUSD,
  "paygCostInUsd",
  "java"
);

@@clientName(LegacyChargeSummaryProperties.azureMarketplaceCharges,
  "marketplaceCharges",
  "go"
);
