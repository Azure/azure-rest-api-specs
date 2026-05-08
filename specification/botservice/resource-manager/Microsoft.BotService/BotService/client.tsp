import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Microsoft.BotService;

namespace Microsoft.BotService;

@@scope(Operations.list, "!csharp");
@@clientName(AlexaChannelProperties.urlFragment, "UriFragment", "csharp");
@@alternateType(AlexaChannelProperties.serviceEndpointUri, url, "csharp");
@@alternateType(Bot.location, azureLocation, "csharp");
@@alternateType(Bot.etag, eTag, "csharp");
@@alternateType(BotChannel.location, azureLocation, "csharp");
@@alternateType(BotChannel.etag, eTag, "csharp");
@@alternateType(BotProperties.endpoint, url, "csharp");
@@alternateType(BotProperties.iconUrl, url, "csharp");
@@alternateType(BotProperties.manifestUrl, url, "csharp");
@@alternateType(BotProperties.cmekKeyVaultUrl, url, "csharp");
@@alternateType(BotProperties.tenantId, uuid, "csharp");
@@alternateType(ServiceProviderParameter.helpUrl, url, "csharp");
@@alternateType(BotProperties.msaAppMSIResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(BotProperties.disableLocalAuth, "IsLocalAuthDisabled", "csharp");
@@alternateType(BotProperties.storageResourceId,
  armResourceIdentifier,
  "csharp"
);

@@clientName(Channel, "BotChannelProperties", "csharp");
@@alternateType(Channel.etag, eTag, "csharp");
@@alternateType(Channel.location, azureLocation, "csharp");
@@clientName(ChannelSettings, "BotChannelSettings", "csharp");
@@alternateType(ChannelSettings.botIconUrl, url, "csharp");
@@alternateType(ConnectionSetting.location, azureLocation, "csharp");
@@alternateType(ConnectionSetting.etag, eTag, "csharp");
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
@@alternateType(CreateEmailSignInUrlResponse.location, azureLocation, "csharp");
@@alternateType(CreateEmailSignInUrlResponse.id,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(NetworkSecurityPerimeter.location, azureLocation, "csharp");
@@alternateType(Resource.location, azureLocation, "csharp");
@@alternateType(Resource.etag, eTag, "csharp");
@@clientName(Site, "BotChannelSite", "csharp");
@@alternateType(Site.tenantId, uuid, "csharp");
@@alternateType(Site.eTag, eTag, "csharp");
@@clientName(HostSettingsResponse, "BotServiceHostSettingsResult", "csharp");
@@clientName(Key, "BotServiceKey", "csharp");

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

// Java SDK back-compat: mitigate property rename breaks
@@clientName(TelephonyChannelProperties.premiumSKU, "premiumSku", "java");
@@clientName(SmsChannelProperties.accountSID, "accountSid", "java");
@@clientName(BotProperties.msaAppMSIResourceId, "msaAppMsiResourceId", "java");
@@clientName(Site.eTag, "etag", "java");
@@clientName(SkypeChannelProperties.callingWebHook, "callingWebhook", "java");
@@clientName(KikChannelProperties.userName, "username", "java");

// Java SDK back-compat: keep unknown as Object
@@alternateType(OperationEntity.properties, unknown, "java");

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@usage(ServiceProviderProperties, Usage.input | Usage.output, "csharp");

@@alternateType(SlackChannelProperties.landingPageUrl, url, "csharp");
@@alternateType(FacebookChannelProperties.callbackUrl, url, "csharp");
@@alternateType(LineChannelProperties.callbackUrl, url, "csharp");
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
@@alternateType(ServiceProviderProperties.devPortalUrl, url, "csharp");
@@alternateType(ServiceProviderProperties.iconUrl, url, "csharp");
@@alternateType(CreateEmailSignInUrlResponseProperties.url, url, "csharp");

@@alternateType(ChannelName, ChannelNameUnion, "csharp");
@@clientName(ChannelNameUnion, "BotChannelName", "csharp");

@@clientName(PrivateEndpointConnection,
  "BotServicePrivateEndpointConnection",
  "csharp"
);

@@clientName(ServiceProviderParameter.type,
  "ServiceProviderParameterType",
  "csharp"
);
@@clientName(TelephonyChannelProperties.premiumSKU, "PremiumSku", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");

@@clientName(BotChannels.listWithKeys, "GetChannelWithKeys", "csharp");
@@clientName(Bots.createSignInUrl, "createEmailSignInUri", "csharp");
@@clientName(Bots.listByBotResource,
  "GetPrivateLinkResourcesByBotResource",
  "csharp"
);
@@clientName(BotChannels.regenerateKeys,
  "GetBotChannelWithRegenerateKeys",
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Bots.listByBotResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the operation back to pageable for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(BotConnectionOperationGroup.listServiceProviders,
  "csharp"
);

// =============================================================================
// C# SDK backward-compatibility replacement models
//
// These models exist solely for C# client backward compatibility. They are used
// via @@alternateType to provide the correct base types and shapes that the
// previously published C# SDK exposed. They do not affect the service contract
// or swagger output.
// =============================================================================

/**
 * Bot resource definition
 */
model BotReplacement is Azure.ResourceManager.TrackedResource<BotProperties> {
  ...ResourceNameParameter<
    Resource = Bot,
    KeyName = "resourceName",
    SegmentName = "botServices",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
  ...OmitProperties<
    Bot,
    "location" | "tags" | "properties" | "id" | "name" | "type"
  >;
}

@@alternateType(Bot, BotReplacement, "csharp");
@@clientName(Bot, "BotTemp", "csharp");
@@clientName(BotReplacement, "Bot", "csharp");

/**
 * Bot channel resource definition
 */
model BotChannelReplacement is Azure.ResourceManager.TrackedResource<Channel> {
  ...ResourceNameParameter<
    Resource = BotChannel,
    KeyName = "channelName",
    SegmentName = "channels",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
  ...OmitProperties<
    BotChannel,
    "location" | "tags" | "properties" | "name" | "id" | "type"
  >;
}

@@alternateType(BotChannel, BotChannelReplacement, "csharp");
@@clientName(BotChannel, "BotChannelTemp", "csharp");
@@clientName(BotChannelReplacement, "BotChannel", "csharp");

/**
 * Connection setting resource definition
 */
model ConnectionSettingReplacement
  is Azure.ResourceManager.TrackedResource<ConnectionSettingProperties> {
  ...ResourceNameParameter<
    Resource = ConnectionSetting,
    KeyName = "connectionName",
    SegmentName = "connections",
    NamePattern = "^[a-zA-Z0-9][\\sa-zA-Z0-9_.-]*$"
  >;
  ...OmitProperties<
    ConnectionSetting,
    "location" | "tags " | "properties" | "id" | "name" | "type"
  >;
}

@@alternateType(ConnectionSetting, ConnectionSettingReplacement, "csharp");
@@clientName(ConnectionSetting, "ConnectionSettingTemp", "csharp");
@@clientName(ConnectionSettingReplacement, "BotConnectionSetting", "csharp");

/**
 * The ARM channel of list channel with keys operation response
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C# back-compat"
model ListChannelWithKeysResponseReplacement
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  ...OmitProperties<
    ListChannelWithKeysResponse,
    "location" | "tags" | "name" | "id" | "type"
  >;
}

@@alternateType(ListChannelWithKeysResponse,
  ListChannelWithKeysResponseReplacement,
  "csharp"
);
@@clientName(ListChannelWithKeysResponseReplacement,
  "BotChannelGetWithKeysResult",
  "csharp"
);
@@usage(ListChannelWithKeysResponseReplacement,
  Usage.input | Usage.output,
  "csharp"
);

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C# back-compat"
model PrivateLinkResourceReplacement
  extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

@@alternateType(PrivateLinkResource, PrivateLinkResourceReplacement, "csharp");
@@clientName(PrivateLinkResourceReplacement,
  "BotServicePrivateLinkResourceData",
  "csharp"
);
@@usage(PrivateLinkResourceReplacement, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResourceReplacement.properties
);

@@clientName(NetworkSecurityPerimeterConfiguration,
  "BotServiceNetworkSecurityPerimeterConfiguration",
  "csharp"
);

// Suppress OperationResults_Get LRO polling operation from C# SDK — it's an
// infrastructure operation, not user-facing.
@@scope(OperationResultsOperationGroup.get, "!csharp");

// Rename generic NSP model names with RP prefix to avoid cross-package collisions
@@clientName(Profile, "BotServiceNetworkSecurityPerimeterProfile", "csharp");
@@clientName(ResourceAssociation, "BotServiceResourceAssociation", "csharp");
@@clientName(AccessMode, "BotServiceAccessMode", "csharp");
@@clientName(Severity, "BotServiceSeverity", "csharp");
@@clientName(ProvisioningState, "BotServiceProvisioningState", "csharp");
@@clientName(OperationResultStatus,
  "BotServiceOperationResultStatus",
  "csharp"
);
@@clientName(NspAccessRulePropertiesSubscriptionsItem,
  "BotServiceNspAccessRuleSubscription",
  "csharp"
);
