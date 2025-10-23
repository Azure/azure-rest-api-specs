import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.PortalServices;

@@clientName(Microsoft.PortalServices,
  "PortalServicesCopilotMgmtClient",
  "python"
);

@@clientName(Microsoft.PortalServices,
  "PortalServicesCopilotMgmtClient",
  "java"
);

@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "PortalServicesResourceProvisioningState",
  "csharp"
);

@@clientName(CopilotSettingsResource, "PortalServicesCopilotSetting", "csharp");

@@clientName(CopilotSettingsProperties,
  "PortalServicesCopilotSettingsProperties",
  "csharp"
);
