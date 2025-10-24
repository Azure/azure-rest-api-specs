import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthBot;

@@clientLocation(HealthBots.get, "Bots");
@@clientLocation(HealthBots.create, "Bots");
@@clientLocation(HealthBots.update, "Bots");
@@clientLocation(HealthBots.delete, "Bots");
@@clientLocation(HealthBots.listByResourceGroup, "Bots");
@@clientLocation(HealthBots.list, "Bots");
@@clientLocation(HealthBots.listSecrets, "Bots");
@@clientLocation(HealthBots.regenerateApiJwtSecret, "Bots");

@@clientName(HealthBots.create::parameters.resource, "parameters");
@@clientName(HealthBots.update::parameters.properties, "parameters");
@@visibility(BotResponseList.value, Lifecycle.Read);
@@clientName(KeyVaultProperties.keyName, "KeyName");
@@clientName(KeyVaultProperties.keyVersion, "KeyVersion");
@@clientName(KeyVaultProperties.keyVaultUri, "KeyVaultUri");
@@clientName(KeyVaultProperties.userIdentity, "UserIdentity");
@@clientName(HealthBotKeysResponse, "HealthBotKeysResult", "csharp");
@@clientName(ErrorDetail, "ErrorError");
