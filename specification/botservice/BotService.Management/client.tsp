import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.BotService;

@@scope(Operations.list, "!csharp");
@@clientName(ConnectionSetting, "BotConnectionSetting", "csharp");
@@clientName(AlexaChannelProperties.urlFragment, "UriFragment", "csharp");
@@clientName(BotProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@clientName(PrivateLinkResource,
  "BotServicePrivateLinkResourceData",
  "csharp"
);
@@clientName(Channel, "BotChannelProperties", "csharp");
@@clientName(ChannelName, "BotChannelName", "csharp");
@@clientName(ChannelSettings, "BotChannelSettings", "csharp");
@@clientName(CheckNameAvailabilityRequestBody,
  "BotServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequestBody.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityResponseBody,
  "BotServiceNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResponseBody.valid, "IsValid", "csharp");
@@clientName(ConnectionSettingParameter,
  "BotConnectionSettingParameter",
  "csharp"
);
@@clientName(ConnectionSettingProperties,
  "BotConnectionSettingProperties",
  "csharp"
);
@@clientName(CreateEmailSignInUrlResponse,
  "BotCreateEmailSignInUriResult",
  "csharp"
);
@@clientName(Site, "BotChannelSite", "csharp");
@@clientName(HostSettingsResponse, "BotServiceHostSettingsResult", "csharp");
@@clientName(Key, "BotServiceKey", "csharp");
@@clientName(ListChannelWithKeysResponse,
  "BotChannelGetWithKeysResult",
  "csharp"
);
@@clientName(MsaAppType, "BotMsaAppType", "csharp");
@@clientName(MsTeamsChannelProperties.enableCalling,
  "IsCallingEnabled",
  "csharp"
);
@@clientName(PublicNetworkAccess, "BotServicePublicNetworkAccess", "csharp");
@@clientName(QnAMakerEndpointKeysRequestBody,
  "GetBotServiceQnAMakerEndpointKeyContent",
  "csharp"
);
@@clientName(QnAMakerEndpointKeysResponse,
  "GetBotServiceQnAMakerEndpointKeyResult",
  "csharp"
);
@@clientName(RegenerateKeysChannelName,
  "RegenerateKeysBotChannelName",
  "csharp"
);
@@clientName(ServiceProvider, "BotServiceProvider", "csharp");
@@clientName(ServiceProviderParameter, "BotServiceProviderParameter", "csharp");
@@clientName(ServiceProviderProperties,
  "BotServiceProviderProperties",
  "csharp"
);
@@clientName(SiteInfo, "BotChannelRegenerateKeysContent", "csharp");
@@clientName(SkypeChannelProperties.enableMessaging,
  "IsMessagingEnabled",
  "csharp"
);
@@clientName(SkypeChannelProperties.enableMediaCards,
  "IsMediaCardsEnabled",
  "csharp"
);
@@clientName(SkypeChannelProperties.enableVideo, "IsVideoEnabled", "csharp");
@@clientName(SkypeChannelProperties.enableCalling,
  "IsCallingEnabled",
  "csharp"
);
@@clientName(SkypeChannelProperties.enableScreenSharing,
  "IsScreenSharingEnabled",
  "csharp"
);
@@clientName(SkypeChannelProperties.enableGroups, "IsGroupsEnabled", "csharp");
@@clientName(ServiceProviderParameterMetadataConstraints.required,
  "IsRequired",
  "csharp"
);
@@clientName(BotChannels.listWithKeys, "GetChannelWithKeys", "csharp");
@@clientName(Bots.createSignInUrl, "CreateEmailSignInUri", "csharp");
@@clientName(BotChannels.regenerateKeys,
  "GetBotChannelWithRegenerateKeys",
  "csharp"
);
@@clientName(Bots.listByBotResource,
  "GetPrivateLinkResourcesByBotResource",
  "csharp"
);
@@clientName(BotsOperationGroup.getCheckNameAvailability,
  "CheckBotServiceNameAvailability",
  "csharp"
);
@@clientName(BotConnectionOperationGroup.listServiceProviders,
  "GetBotConnectionServiceProviders",
  "csharp"
);
@@clientName(HostSettingsOperationGroup.get,
  "GetBotServiceHostSettings",
  "csharp"
);
@@clientName(QnAMakerEndpointKeysOperationGroup.get,
  "GetBotServiceQnAMakerEndpointKey",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(TelephonyChannelProperties.premiumSKU, "PremiumSku", "csharp");
@@clientName(ServiceProviderParameter.type,
  "ServiceProviderParameterType",
  "csharp"
);

@@usage(PrivateLinkResource, Usage.input, "csharp");
@@usage(ListChannelWithKeysResponse, Usage.input, "csharp");

@@scope(OperationResultsOperationGroup.get, "!csharp"); 

@@alternateType(DirectLineSpeechChannelProperties.cognitiveServiceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(TelephonyChannelResourceApiConfiguration.cognitiveServiceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(TelephonyPhoneNumbers.acsResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(TelephonyPhoneNumbers.cognitiveServiceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BotProperties.endpoint, url, "csharp");
@@alternateType(BotProperties.msaAppMSIResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BotProperties.storageResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CheckNameAvailabilityRequestBody.type,
  armResourceType,
  "csharp"
);
@@alternateType(CreateEmailSignInUrlResponse.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(BotChannel.name, ChannelName, "csharp");
@@alternateType(BotProperties.iconUrl, url, "csharp");
@@alternateType(BotProperties.manifestUrl, url, "csharp");
@@alternateType(BotProperties.cmekKeyVaultUrl, url, "csharp");
@@alternateType(BotProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(BotChannel.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ConnectionSetting.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Bot.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(AlexaChannelProperties.serviceEndpointUri, url, "csharp");
@@alternateType(Channel.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Channel.location, Azure.Core.azureLocation, "csharp");
@@alternateType(ChannelSettings.botIconUrl, url, "csharp");
@@alternateType(Site.eTag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Site.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(SlackChannelProperties.landingPageUrl, url, "csharp");
@@alternateType(CreateEmailSignInUrlResponseProperties.url, url, "csharp");
@@alternateType(CreateEmailSignInUrlResponse.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(HostSettingsResponse.OAuthUrl, url, "csharp");
@@alternateType(HostSettingsResponse.ToBotFromChannelOpenIdMetadataUrl,
  url,
  "csharp"
);
@@alternateType(HostSettingsResponse.ToBotFromEmulatorOpenIdMetadataUrl,
  url,
  "csharp"
);
@@alternateType(HostSettingsResponse.ToChannelFromBotLoginUrl, url, "csharp");
@@alternateType(ServiceProviderParameter.helpUrl, url, "csharp");
@@alternateType(ServiceProviderProperties.devPortalUrl, url, "csharp");
@@alternateType(ServiceProviderProperties.iconUrl, url, "csharp");
@@alternateType(FacebookChannelProperties.callbackUrl, url, "csharp");
@@alternateType(LineChannelProperties.callbackUrl, url, "csharp");
