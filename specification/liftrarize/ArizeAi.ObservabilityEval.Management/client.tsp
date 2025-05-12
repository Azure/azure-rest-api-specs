import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ArizeAi.ObservabilityEval;

@@clientName(ArizeAi.ObservabilityEval,
  "ArizeAIObservabilityEvalMgmt",
  "python"
);

@@clientName(ArizeAi.ObservabilityEval,
  "ArizeAIObservabilityEvalMgmtClient",
  "java"
);

@@clientName(OrganizationResource,
  "ArizeAIObservabilityEvalOrganization",
  "csharp"
);
@@clientName(OrganizationProperties,
  "ArizeAIObservabilityEvalOrganizationProperties",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceDetails,
  "ArizeAIObservabilityEvalMarketplaceDetails",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceSubscriptionStatus,
  "ArizeAIObservabilityEvalMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(LiftrBase.OfferDetails,
  "ArizeAIObservabilityEvalOfferDetails",
  "csharp"
);
@@clientName(PartnerProperties,
  "ArizeAIObservabilityEvalOfferPartnerProperties",
  "csharp"
);
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "ArizeAIObservabilityEvalOfferProvisioningState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnPropertiesV2,
  "ArizeAIObservabilityEvalSingleSignOnPropertiesV2",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnStates,
  "ArizeAIObservabilityEvalSingleSignOnState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnType,
  "ArizeAIObservabilityEvalSingleSignOnType",
  "csharp"
);
@@clientName(LiftrBase.UserDetails,
  "ArizeAIObservabilityEvalUserDetails",
  "csharp"
);
