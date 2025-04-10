import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.BotService;

@@clientName(HostSettingsResponse.OAuthUrl, "oAuthUrl");
@@clientName(HostSettingsResponse.ToBotFromChannelOpenIdMetadataUrl,
  "toBotFromChannelOpenIdMetadataUrl"
);
@@clientName(HostSettingsResponse.ToBotFromChannelTokenIssuer,
  "toBotFromChannelTokenIssuer"
);
@@clientName(HostSettingsResponse.ToBotFromEmulatorOpenIdMetadataUrl,
  "toBotFromEmulatorOpenIdMetadataUrl"
);
@@clientName(HostSettingsResponse.ToChannelFromBotLoginUrl,
  "toChannelFromBotLoginUrl"
);
@@clientName(HostSettingsResponse.ToChannelFromBotOAuthScope,
  "toChannelFromBotOAuthScope"
);
@@clientName(HostSettingsResponse.ValidateAuthority, "validateAuthority");
@@clientName(HostSettingsResponse.BotOpenIdMetadata, "botOpenIdMetadata");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(DirectLineChannelProperties.DirectLineEmbedCode,
  "directLineEmbedCode"
);

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
