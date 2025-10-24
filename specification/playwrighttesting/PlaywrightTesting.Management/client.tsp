import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Microsoft.AzurePlaywrightService;

@@clientNamespace(Microsoft.AzurePlaywrightService,
  "com.azure.resourcemanager.playwrighttesting",
  "java"
);

@@clientName(Microsoft.AzurePlaywrightService,
  "PlaywrightTestingMgmt",
  "python"
);
@@clientName(Microsoft.AzurePlaywrightService,
  "PlaywrightTestingMgmtClient",
  "java"
);

@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "PlaywrightTestingNameAvailabilityResult",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "PlaywrightTestingNameAvailabilityRequest",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "PlaywrightTestingNameUnavailableReason",
  "csharp"
);
@@clientName(Accounts.checkNameAvailability,
  "CheckPlaywrightTestingNameAvailability",
  "csharp"
);

@@clientName(Quota, "PlaywrightTestingQuotas", "csharp");
@@clientName(QuotaProperties, "PlaywrightTestingQuotaProperties", "csharp");
@@clientName(QuotaNames, "PlaywrightTestingQuotaNames", "csharp");
@@clientName(Account, "PlaywrightTestingAccount", "csharp");
@@clientName(AccountProperties, "PlaywrightTestingAccountProperties", "csharp");
@@clientName(AccountFreeTrialProperties,
  "PlaywrightTestingAccountFreeTrialProperties",
  "csharp"
);
@@clientName(AccountQuota, "PlaywrightTestingAccountQuotas", "csharp");
@@clientName(AccountQuotaProperties,
  "PlaywrightTestingAccountQuotaProperties",
  "csharp"
);
@@clientName(ProvisioningState, "PlaywrightTestingProvisioningState", "csharp");
@@clientName(EnablementStatus, "PlaywrightTestingEnablementStatus", "csharp");
@@clientName(FreeTrialProperties,
  "PlaywrightTestingFreeTrialProperties",
  "csharp"
);
@@clientName(FreeTrialState, "PlaywrightTestingFreeTrialState", "csharp");
@@clientName(OfferingType, "PlaywrightTestingOfferingType", "csharp");
@@clientName(Versions.`2024-12-01`,
  "$DO_NOT_NORMALIZE$V2024-12-01",
  "javascript"
);
