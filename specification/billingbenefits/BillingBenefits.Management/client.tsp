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

// python
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentity,
  "ServiceManagedIdentity",
  "python"
);
@@clientName(Microsoft.BillingBenefits.ManagedServiceIdentityType,
  "ServiceManagedIdentityType",
  "python"
);

// python: client name mitigation
@@clientName(Microsoft.BillingBenefits, "BillingBenefitsMgmtClient", "python");

// python: enum value naming mitigations
@@clientName(BillingPlan.P1M, "P1_M", "python");
@@clientName(Term.P1Y, "P1_Y", "python");
@@clientName(Term.P3Y, "P3_Y", "python");
@@clientName(Term.P5Y, "P5_Y", "python");
