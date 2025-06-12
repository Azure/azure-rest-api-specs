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
