import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Playwright.Management;

@@clientName(Playwright.Management, "PlaywrightMgmtClient", "python");
@@clientName(Playwright.Management, "PlaywrightManagementClient", "javascript");

@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "PlaywrightNameAvailabilityResult",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "PlaywrightNameAvailabilityContent",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "PlaywrightNameUnavailableReason",
  "csharp"
);
@@clientName(PlaywrightWorkspaces.checkNameAvailability,
  "CheckPlaywrightNameAvailability",
  "csharp"
);

@@clientName(QuotaName, "PlaywrightQuotaName", "csharp");
@@clientName(ProvisioningState, "PlaywrightProvisioningState", "csharp");
@@clientName(EnablementStatus, "PlaywrightEnablementStatus", "csharp");
@@clientName(FreeTrialProperties, "PlaywrightFreeTrialProperties", "csharp");
@@clientName(FreeTrialState, "PlaywrightFreeTrialState", "csharp");
