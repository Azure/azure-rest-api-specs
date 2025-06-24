import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.WeightsAndBiases;

@@clientName(Microsoft.WeightsAndBiases, "WeightsAndBiasesMgmt", "python");
@@clientName(Microsoft.WeightsAndBiases,
  "WeightsAndBiasesManagementClient",
  "java"
);

// csharp
@@clientName(InstanceResource, "WeightsAndBiasesInstance", "csharp");
@@clientName(InstanceProperties,
  "WeightsAndBiasesInstanceProperties",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceDetails,
  "WeightsAndBiasesMarketplaceDetails",
  "csharp"
);
@@clientName(LiftrBase.MarketplaceSubscriptionStatus,
  "WeightsAndBiasesMarketplaceSubscriptionStatus",
  "csharp"
);
@@clientName(LiftrBase.OfferDetails, "WeightsAndBiasesOfferDetails", "csharp");
@@clientName(PartnerProperties, "WeightsAndBiasesPartnerProperties", "csharp");
@@clientName(Region, "WeightsAndBiasesRegion", "csharp");
@@clientName(Region.eastus, "EastUS", "csharp");
@@clientName(Region.centralus, "CentralUS", "csharp");
@@clientName(Region.westus, "WestUS", "csharp");
@@clientName(Region.westeurope, "WestEurope", "csharp");
@@clientName(Region.japaneast, "JapanEast", "csharp");
@@clientName(Region.koreacentral, "KoreaCentral", "csharp");
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "WeightsAndBiasesProvisioningState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnPropertiesV2,
  "WeightsAndBiasesSingleSignOnPropertiesV2",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnStates,
  "WeightsAndBiasesSingleSignOnState",
  "csharp"
);
@@clientName(LiftrBase.SingleSignOnType,
  "WeightsAndBiasesSingleSignOnType",
  "csharp"
);
@@clientName(LiftrBase.UserDetails, "WeightsAndBiasesUserDetails", "csharp");
