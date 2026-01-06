import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// go
@@clientLocation(Microsoft.BillingBenefits.BenefitOperationGroup.validate,
  "RP",
  "go"
);
@@clientName(Microsoft.BillingBenefits.ResourceSku, "SKU", "go");

// java
@@clientLocation(Microsoft.BillingBenefits.BenefitOperationGroup.validate,
  "ResourceProviders",
  "java"
);

// python
@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "ArmManagedServiceIdentity",
  "python"
);
@@clientName(Microsoft.BillingBenefits, "BillingBenefitsRP", "python");
@@clientName(Microsoft.BillingBenefits.Term.P1Y, "P1_Y", "python");
@@clientName(Microsoft.BillingBenefits.Term.P3Y, "P3_Y", "python");
@@clientName(Microsoft.BillingBenefits.Term.P5Y, "P5_Y", "python");
@@clientName(Microsoft.BillingBenefits.BillingPlan.P1M, "P1_M", "python");
