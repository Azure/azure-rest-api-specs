import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientLocation(Microsoft.BillingBenefits.validatePurchase, "RP");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");
