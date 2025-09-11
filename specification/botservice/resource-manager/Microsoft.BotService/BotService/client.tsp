import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.BotService;

@@scope(Operations.list, "!csharp");
@@clientName(ConnectionSetting, "BotConnectionSetting", "csharp");
@@clientName(AlexaChannelProperties.urlFragment, "UriFragment", "csharp");
@@alternateType(BotProperties.endpoint, url, "csharp");
@@alternateType(BotProperties.msaAppMSIResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BotProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@alternateType(BotProperties.storageResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(PrivateLinkResource,
  "BotServicePrivateLinkResourceData",
  "csharp"
);
@@clientName(Channel, "BotChannelProperties", "csharp");
@@alternateType(Channel.etag, eTag, "csharp");
@@alternateType(Channel.location, azureLocation, "csharp");
@@clientName(ChannelName, "BotChannelName", "csharp");
@@clientName(ChannelSettings, "BotChannelSettings", "csharp");
@@alternateType(ChannelSettings.botIconUrl, url, "csharp");
@@usage(ChannelSettings, Usage.input | Usage.output, "csharp");
@@clientName(CheckNameAvailabilityRequestBody,
  "BotServiceNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequestBody.type, "ResourceType", "csharp");
@@alternateType(CheckNameAvailabilityRequestBody.type,
  armResourceType,
  "csharp"
);
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
@@alternateType(CreateEmailSignInUrlResponse.id,
  armResourceIdentifier,
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
