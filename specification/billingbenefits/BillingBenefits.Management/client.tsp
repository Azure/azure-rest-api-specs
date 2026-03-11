import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// go
@@clientLocation(Microsoft.BillingBenefits.validatePurchase, "RP", "go");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");

// java
@@clientLocation(Microsoft.BillingBenefits.validatePurchase,
  "ResourceProviders",
  "java"
);
