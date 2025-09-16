import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using LambdaTest.HyperExecute;

@@clientName(LambdaTest.HyperExecute,
  "LambdaTestHyperExecuteMgmtClient",
  "java"
);
@@clientName(LambdaTest.HyperExecute,
  "LambdaTestHyperExecuteMgmtClient",
  "python"
);

// csharp
@@clientName(OrganizationResource,
  "LambdaTestHyperExecuteOrganization",
  "csharp"
);
@@clientName(OrganizationProperties,
  "LambdaTestHyperExecuteOrganizationProperties",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceDetails,
  "LambdaTestHyperExecuteMarketplaceDetails",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceSubscriptionStatus,
  "LambdaTestHyperExecuteMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(LiftrBase.OfferDetails,
  "LambdaTestHyperExecuteOfferDetails",
  "csharp"
);
@@clientName(PartnerProperties,
  "LambdaTestHyperExecuteOfferPartnerProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "LambdaTestHyperExecuteOfferProvisioningState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnPropertiesV2,
  "LambdaTestHyperExecuteSingleSignOnPropertiesV2",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnStates,
  "LambdaTestHyperExecuteSingleSignOnState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnType,
  "LambdaTestHyperExecuteSingleSignOnType",
  "csharp"
);
@@clientName(LiftrBase.UserDetails,
  "LambdaTestHyperExecuteUserDetails",
  "csharp"
);
