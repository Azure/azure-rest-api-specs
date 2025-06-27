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
@@clientLocation(Bots.createSignInUrl, "Email");
@@clientLocation(Bots.listByBotResource, "PrivateLinkResources");

// BotChannels interface
@@clientLocation(BotChannels.get, "Channels");
@@clientLocation(BotChannels.create, "Channels");
@@clientLocation(BotChannels.update, "Channels");
@@clientLocation(BotChannels.delete, "Channels");
@@clientLocation(BotChannels.listByResourceGroup, "Channels");
@@clientLocation(BotChannels.listWithKeys, "Channels");
@@clientLocation(BotChannels.regenerateKeys, "DirectLine");

// ConnectionSettings interface
@@clientLocation(ConnectionSettings.get, "BotConnection");
@@clientLocation(ConnectionSettings.create, "BotConnection");
@@clientLocation(ConnectionSettings.update, "BotConnection");
@@clientLocation(ConnectionSettings.delete, "BotConnection");
@@clientLocation(ConnectionSettings.listByBotService, "BotConnection");
@@clientLocation(ConnectionSettings.listWithSecrets, "BotConnection");

// OperationGroup interfaces from routes.tsp - use interface references to avoid conflicts
@@clientLocation(BotsOperationGroup.getCheckNameAvailability, Bots);
@@clientLocation(BotConnectionOperationGroup.listServiceProviders,
  "BotConnection"
);
@@clientLocation(QnAMakerEndpointKeysOperationGroup.get,
  "QnAMakerEndpointKeys"
);
@@clientLocation(HostSettingsOperationGroup.get, "HostSettings");
@@clientLocation(OperationResultsOperationGroup.get, "OperationResults");
