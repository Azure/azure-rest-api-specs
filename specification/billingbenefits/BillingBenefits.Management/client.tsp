import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

// go
@@clientLocation(BenefitOperationGroup.validate, "RP", "go");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "BillingBenefitsManagedServiceIdentity",
  "go"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "BillingBenefitsManagedServiceIdentityType",
  "go"
);

// java
@@clientLocation(BenefitOperationGroup.validate, "ResourceProviders", "java");
