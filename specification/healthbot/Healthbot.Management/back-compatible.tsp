import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthBot;

@@clientName(HealthBots.create::parameters.resource, "parameters");
@@clientName(HealthBots.update::parameters.properties, "parameters");
@@visibility(BotResponseList.value, Lifecycle.Read);
@@clientName(KeyVaultProperties.keyName, "KeyName");
@@clientName(KeyVaultProperties.keyVersion, "KeyVersion");
@@clientName(KeyVaultProperties.keyVaultUri, "KeyVaultUri");
@@clientName(KeyVaultProperties.userIdentity, "UserIdentity");
