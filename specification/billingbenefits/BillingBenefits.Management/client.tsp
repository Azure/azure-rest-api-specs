import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

// go
@@clientLocation(BenefitOperationGroup.validate, "RP", "go");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");

// java
@@clientLocation(BenefitOperationGroup.validate, "ResourceProviders", "java");
