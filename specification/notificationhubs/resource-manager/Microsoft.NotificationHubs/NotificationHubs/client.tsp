import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.NotificationHubs;

@@clientName(Microsoft.NotificationHubs,
  "NotificationHubsManagementClient",
  "javascript"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(NamespaceResourceListParameters.$top,
  100,
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(NamespaceResourceListAllParameters.$top,
  100,
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(NotificationHubResourcesListParameters.$top,
  100,
  "javascript"
);
@@clientName(NamespaceResources.listAll, "GetNotificationHubNamespaces", "csharp");
@@clientName(NamespaceResource, "NotificationHubNamespace", "csharp");
@@clientName(ApnsCredential, "NotificationHubApnsCredential", "csharp");
@@alternateType(ApnsCredentialProperties.endpoint, url, "csharp");
@@clientName(ApnsCredentialProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(BaiduCredential, "NotificationHubBaiduCredential", "csharp");
@@clientName(BaiduCredentialProperties.baiduEndPoint, "BaiduEndpoint", "csharp");
@@alternateType(BaiduCredentialProperties.baiduEndPoint, url, "csharp");
@@clientName(GcmCredential, "NotificationHubGcmCredential", "csharp");
@@alternateType(GcmCredentialProperties.gcmEndpoint, url, "csharp");
@@clientName(GcmCredentialProperties.googleApiKey, "gcmApiKey", "csharp");
@@clientName(WnsCredential, "NotificationHubWnsCredential", "csharp");
@@alternateType(WnsCredentialProperties.windowsLiveEndpoint, url, "csharp");
@@clientName(NotificationHubResource, "NotificationHub", "csharp");
@@clientName(SharedAccessAuthorizationRuleResource, "NotificationHubAuthorizationRule", "csharp");
@@clientName(SharedAccessAuthorizationRuleProperties.createdTime, "CreatedOn", "csharp");
@@alternateType(SharedAccessAuthorizationRuleProperties.createdTime, utcDateTime, "csharp");
@@clientName(SharedAccessAuthorizationRuleProperties.modifiedTime, "ModifiedOn", "csharp");
@@alternateType(SharedAccessAuthorizationRuleProperties.modifiedTime, utcDateTime, "csharp");
@@clientName(MpnsCredential, "NotificationHubMpnsCredential", "csharp");
@@clientName(MpnsCredentialProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(AdmCredential, "NotificationHubAdmCredential", "csharp");
@@alternateType(AdmCredentialProperties.authTokenUrl, url, "csharp");
@@clientName(AccessRights, "AuthorizationRuleAccessRightExt", "csharp");
@@clientName(CheckAvailabilityResult, "NotificationHubAvailabilityResultTemp", "csharp");
@@alternateType(CheckAvailabilityResult, CheckAvailabilityResultReplacement, "csharp");
@@clientName(CheckAvailabilityResultReplacement, "NotificationHubAvailabilityResult", "csharp");
@@usage(CheckAvailabilityResultReplacement, Usage.input | Usage.output, "csharp");
@@clientName(NamespaceListResult, "NotificationHubNamespaceListResult", "csharp");
@@clientName(NamespaceType, "NotificationHubNamespaceTypeExt", "csharp");
@@clientName(PnsCredentialsResource, "NotificationHubPnsCredentialsTemp", "csharp");
@@alternateType(PnsCredentialsResource, PnsCredentialsResourceReplacement, "csharp");
@@clientName(PnsCredentialsResourceReplacement, "NotificationHubPnsCredentials", "csharp");
@@usage(PnsCredentialsResourceReplacement, Usage.input | Usage.output, "csharp");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PnsCredentialsResourceReplacement.properties);
@@clientName(PolicyKeyResource, "NotificationHubPolicyKey", "csharp");
@@clientName(ResourceListKeys, "NotificationHubResourceKeys", "csharp");
@@clientName(Sku, "NotificationHubSku", "csharp");
@@clientName(SkuName, "NotificationHubSkuName", "csharp");
@@clientName(IpRule, "NotificationHubIPRule", "csharp");
@@clientName(IpRule.rights, "AccessRights", "csharp");
@@clientName(NetworkAcls, "NotificationHubNetworkAcls", "csharp");
@@clientName(PublicInternetAuthorizationRule.rights, "AccessRights", "csharp");
@@clientName(SharedAccessAuthorizationRuleProperties.rights, "AccessRights", "csharp");
@@clientName(PrivateLinkResource, "NotificationHubsPrivateLinkResource", "csharp");
@@usage(PrivateLinkResource, Usage.input | Usage.output, "csharp");
@@clientName(PrivateEndpointConnectionResource, "NotificationHubPrivateEndpointConnection", "csharp");
@@clientName(PrivateEndpointConnectionProperties, "NotificationHubPrivateEndpointConnectionProperties", "csharp");
@@clientName(NamespaceProperties, "NotificationHubNamespaceProperties", "csharp");
@@clientName(NamespaceProperties.enabled, "IsEnabled", "csharp");
@@clientName(NamespaceProperties.critical, "IsCritical", "csharp");
@@clientName(NamespaceStatus, "NotificationHubNamespaceStatus", "csharp");
@@clientName(PrivateLinkConnectionStatus, "NotificationHubPrivateLinkConnectionStatus", "csharp");
@@clientName(PublicNetworkAccess, "NotificationHubPublicNetworkAccess", "csharp");
@@clientName(RegistrationResult, "NotificationHubPubRegistrationResult", "csharp");
@@clientName(ReplicationRegion, "AllowedReplicationRegion", "csharp");
@@clientName(ReplicationRegion.WestUs2, "WestUS2", "csharp");
@@alternateType(NamespaceProperties.serviceBusEndpoint, url, "csharp");
@@clientName(NamespaceProperties.provisioningState, "OperationProvisioningState", "csharp");
@@clientName(NamespaceProperties.status, "NamespaceStatus", "csharp");
@@clientName(NamespaceProperties.namespaceType, "HubNamespaceType", "csharp");
@@clientName(CheckAvailabilityParameters, "NotificationHubAvailabilityContentTemp", "csharp");
@@alternateType(CheckAvailabilityParameters, CheckAvailabilityParametersReplacement, "csharp");
@@clientName(CheckAvailabilityParametersReplacement, "NotificationHubAvailabilityContent", "csharp");
@@clientName(DebugSendResponse, "NotificationHubTestSendResultTemp", "csharp");
@@alternateType(DebugSendResponse, DebugSendResponseReplacement, "csharp");
@@clientName(DebugSendResponseReplacement, "NotificationHubTestSendResult", "csharp");
@@usage(DebugSendResponseReplacement, Usage.input | Usage.output, "csharp");
@@clientName(NotificationHubProperties.name, "NotificationHubName", "csharp");
@@alternateType(NotificationHubProperties.registrationTtl, duration, "csharp");
@@clientName(NamespaceProperties.name, "NamespaceName", "csharp");
@@clientName(DebugSendResult.results, "FailureDescription", "csharp");
@@clientName(NamespacesOperationGroup.checkAvailability, "CheckNotificationHubNamespaceAvailability", "csharp");
@@clientName(IpRule.ipMask, "IPMask", "csharp");
@@clientName(NetworkAcls.ipRules, "IPRules", "csharp");
@@alternateType(RemotePrivateEndpointConnection.id, Azure.Core.armResourceIdentifier, "csharp");

// Replacement model swaps: ProxyResource → TrackedResource for C# backward compat (TrackedResourceData base class)
@@alternateType(NotificationHubPatchParameters, NotificationHubPatchParametersReplacement, "csharp");
@@clientName(NotificationHubPatchParametersReplacement, "NotificationHubPatch", "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NotificationHubPatchParametersReplacement.properties);

// Change SharedAccessAuthorizationRuleResource base type from ProxyResource (ResourceData)
// to TrackedResource (TrackedResourceData) for C# backward compatibility.
// The pre-migration SDK had TrackedResourceData as the base with location/tags.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(SharedAccessAuthorizationRuleResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// C#-only replacement models — swap ProxyResource → TrackedResource to preserve TrackedResourceData base class.

/**
 * Properties for CheckAvailabilityResult replacement model.
 */
model CheckAvailabilityResultProperties {
  /**
   * Gets or sets true if the name is available and can be used to
   * create new Namespace/NotificationHub. Otherwise false.
   */
  isAvailiable?: boolean;
}

/**
 * Replacement for CheckAvailabilityResult — uses TrackedResource base for C# backward compat.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model"
model CheckAvailabilityResultReplacement
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Gets or sets true if the name is available and can be used to
   * create new Namespace/NotificationHub. Otherwise false.
   */
  isAvailiable?: boolean;

  /**
   * The Sku description for a namespace
   */
  sku?: Sku;
}

/**
 * Replacement for PnsCredentialsResource — uses TrackedResource base for C# backward compat.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model"
model PnsCredentialsResourceReplacement
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Collection of Notification Hub or Notification Hub Namespace PNS credentials.
   */
  properties?: PnsCredentials;
}

/**
 * Replacement for SharedAccessAuthorizationRuleResource — uses TrackedResource base for C# backward compat.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model"
model SharedAccessAuthorizationRuleResourceReplacement
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * SharedAccessAuthorizationRule properties.
   */
  properties?: SharedAccessAuthorizationRuleProperties;
}

/**
 * Replacement for DebugSendResponse — uses TrackedResource base for C# backward compat.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model"
model DebugSendResponseReplacement
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Result of DebugSend operations.
   */
  properties?: DebugSendResult;
}

/**
 * Replacement for NotificationHubPatchParameters — uses TrackedResource base for C# backward compat.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model"
model NotificationHubPatchParametersReplacement
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * NotificationHub properties.
   */
  properties?: NotificationHubProperties;

  /**
   * The Sku description for a namespace
   */
  sku?: Sku;
}

/**
 * Replacement for CheckAvailabilityParameters — uses TrackedResource base for C# backward compat.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "C#-only replacement model"
model CheckAvailabilityParametersReplacement
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Not used and deprecated since API version 2023-01-01-preview
   */
  isAvailiable?: boolean;

  /**
   * The Sku description for a namespace
   */
  sku?: Sku;
}
