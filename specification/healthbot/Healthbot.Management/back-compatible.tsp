import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthBot;

@@clientName(HealthBots.create::parameters.resource, "parameters");
@@clientName(HealthBots.update::parameters.properties, "parameters");
@@alternateType(HealthBotProperties.botManagementPortalLink, url);
@@clientName(KeyVaultProperties, "HealthBotKeyVaultProperties");
#suppress "@azure-tools/typespec-azure-core/no-openapi" ""
@@OpenAPI.extension(HealthBot.properties, "x-ms-client-flatten", false);
