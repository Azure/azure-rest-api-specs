import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BotService;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Bots.create::parameters.resource, "parameters");
@@clientName(Bots.update::parameters.properties, "parameters");

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(BotChannels.create::parameters.resource, "parameters");
@@clientName(BotChannels.update::parameters.properties, "parameters");
@@clientName(BotChannels.regenerateKeys::parameters.body, "parameters");

@@clientName(ConnectionSettings.create::parameters.resource, "parameters");
@@clientName(ConnectionSettings.update::parameters.properties, "parameters");

@@clientName(BotsOperationGroup.getCheckNameAvailability::parameters.body,
  "parameters"
);
@@clientName(QnAMakerEndpointKeysOperationGroup.get::parameters.body,
  "parameters"
);

// @@clientLocation decorators for @operationId operations
// Bots interface
@@clientLocation(Bots.createSignInUrl, "Email", "!csharp");
@@clientLocation(Bots.listByBotResource, "PrivateLinkResources", "!csharp");

// BotChannels interface
@@clientLocation(BotChannels.get, "Channels", "!csharp");
@@clientLocation(BotChannels.create, "Channels", "!csharp");
@@clientLocation(BotChannels.update, "Channels", "!csharp");
@@clientLocation(BotChannels.delete, "Channels", "!csharp");
@@clientLocation(BotChannels.listByResourceGroup, "Channels", "!csharp");
@@clientLocation(BotChannels.listWithKeys, "Channels", "!csharp");
@@clientLocation(BotChannels.regenerateKeys, "DirectLine", "!csharp");

// ConnectionSettings interface
@@clientLocation(ConnectionSettings.get, "BotConnection", "!csharp");
@@clientLocation(ConnectionSettings.create, "BotConnection", "!csharp");
@@clientLocation(ConnectionSettings.update, "BotConnection", "!csharp");
@@clientLocation(ConnectionSettings.delete, "BotConnection", "!csharp");
@@clientLocation(ConnectionSettings.listByBotService,
  "BotConnection",
  "!csharp"
);
@@clientLocation(ConnectionSettings.listWithSecrets,
  "BotConnection",
  "!csharp"
);

// OperationGroup interfaces from routes.tsp - use interface references to avoid conflicts
@@clientLocation(BotsOperationGroup.getCheckNameAvailability, Bots, "!csharp");
@@clientLocation(BotConnectionOperationGroup.listServiceProviders,
  "BotConnection",
  "!csharp"
);
@@clientLocation(QnAMakerEndpointKeysOperationGroup.get,
  "QnAMakerEndpointKeys",
  "!csharp"
);
@@clientLocation(HostSettingsOperationGroup.get, "HostSettings", "!csharp");
@@clientLocation(OperationResultsOperationGroup.get,
  "OperationResults",
  "!csharp"
);
