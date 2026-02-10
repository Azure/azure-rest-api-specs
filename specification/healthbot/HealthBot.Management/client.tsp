import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HealthBot;

@@clientName(Microsoft.HealthBot, "HealthbotClient", "javascript");
@@clientName(Microsoft.HealthBot, "HealthBotMgmtClient", "python");

@@clientName(KeyVaultProperties, "HealthBotKeyVaultProperties", "csharp");
@@clientName(HealthBots.update::parameters.properties, "patch", "csharp");
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(HealthBotProperties.botManagementPortalLink, url, "csharp");
@@alternateType(KeyVaultProperties.keyVaultUri, url, "csharp");
@@alternateType(HealthBot.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(HealthBotUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(HealthBotUpdateParameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
