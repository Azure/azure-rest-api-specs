import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BillingBenefits;

// go
@@clientLocation(BenefitOperationGroup.validate, "RP", "go");
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "ServiceManagedIdentity",
  "go"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "ServiceManagedIdentityType",
  "go"
);

// java
@@clientLocation(BenefitOperationGroup.validate, "ResourceProviders", "java");
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "ServiceManagedIdentity",
  "java"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "ServiceManagedIdentityType",
  "java"
);
