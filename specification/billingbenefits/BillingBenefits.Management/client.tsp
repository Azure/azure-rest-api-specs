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

// csharp
@@clientName(DiscountsOperationGroup.scopeList,
  "GetApplicableDiscounts",
  "csharp"
);
@@clientName(ConditionalCreditsOperationGroup.scopeList,
  "GetApplicableConditionalCredits",
  "csharp"
);

// csharp: Rename Request/Response models to comply with AZC0030 naming rules
@@clientName(BenefitValidateRequest,
  "BillingBenefitsBenefitValidateContent",
  "csharp"
);
@@clientName(BenefitValidateResponse,
  "BillingBenefitsBenefitValidateResult",
  "csharp"
);
@@clientName(ChargeShortfallRequest,
  "BillingBenefitsChargeShortfallContent",
  "csharp"
);
@@clientName(PurchaseRequest,
  "BillingBenefitsPurchaseContent",
  "csharp"
);
@@clientName(ReservationOrderAliasRequest,
  "BillingBenefitsReservationOrderAliasContent",
  "csharp"
);
@@clientName(SavingsPlanUpdateValidateRequest,
  "BillingBenefitsSavingsPlanUpdateValidateContent",
  "csharp"
);
@@clientName(SavingsPlanValidateResponse,
  "BillingBenefitsSavingsPlanValidateResult",
  "csharp"
);
@@clientName(SellerResourceListRequest,
  "BillingBenefitsSellerResourceListContent",
  "csharp"
);
