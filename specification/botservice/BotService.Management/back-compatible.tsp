import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BotService;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(Bots.create::parameters.resource, "parameters");
@@clientName(Bots.update::parameters.properties, "parameters");

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
