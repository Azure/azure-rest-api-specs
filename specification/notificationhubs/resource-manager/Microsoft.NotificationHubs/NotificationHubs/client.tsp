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
@@clientName(NamespaceResources.listAll,
  "GetNotificationHubNamespaces",
  "csharp"
);
@@clientName(NamespaceResource, "NotificationHubNamespace", "csharp");
@@clientName(ApnsCredential, "NotificationHubApnsCredential", "csharp");
@@alternateType(ApnsCredentialProperties.endpoint, url, "csharp");
@@clientName(ApnsCredentialProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(BaiduCredential, "NotificationHubBaiduCredential", "csharp");
@@clientName(BaiduCredentialProperties.baiduEndPoint,
  "BaiduEndpoint",
  "csharp"
);
@@alternateType(BaiduCredentialProperties.baiduEndPoint, url, "csharp");
@@clientName(GcmCredential, "NotificationHubGcmCredential", "csharp");
@@alternateType(GcmCredentialProperties.gcmEndpoint, url, "csharp");
@@clientName(GcmCredentialProperties.googleApiKey, "gcmApiKey", "csharp");
@@clientName(WnsCredential, "NotificationHubWnsCredential", "csharp");
@@alternateType(WnsCredentialProperties.windowsLiveEndpoint, url, "csharp");
@@clientName(NotificationHubResource, "NotificationHub", "csharp");
@@clientName(SharedAccessAuthorizationRuleResource,
  "NotificationHubAuthorizationRule",
  "csharp"
);
@@clientName(SharedAccessAuthorizationRuleProperties.createdTime,
  "CreatedOn",
  "csharp"
);
@@alternateType(SharedAccessAuthorizationRuleProperties.createdTime,
  utcDateTime,
  "csharp"
);
@@clientName(SharedAccessAuthorizationRuleProperties.modifiedTime,
  "ModifiedOn",
  "csharp"
);
@@alternateType(SharedAccessAuthorizationRuleProperties.modifiedTime,
  utcDateTime,
  "csharp"
);
@@clientName(MpnsCredential, "NotificationHubMpnsCredential", "csharp");
@@clientName(MpnsCredentialProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(AdmCredential, "NotificationHubAdmCredential", "csharp");
@@alternateType(AdmCredentialProperties.authTokenUrl, url, "csharp");
@@clientName(AccessRights, "AuthorizationRuleAccessRightExt", "csharp");
@@clientName(CheckAvailabilityResult,
  "NotificationHubAvailabilityResult",
  "csharp"
);
@@usage(CheckAvailabilityResult, Usage.input | Usage.output, "csharp");
@@clientName(NamespaceListResult,
  "NotificationHubNamespaceListResult",
  "csharp"
);
@@clientName(NamespaceType, "NotificationHubNamespaceTypeExt", "csharp");
@@clientName(PnsCredentialsResource, "NotificationHubPnsCredentials", "csharp");
@@usage(PnsCredentialsResource, Usage.input | Usage.output, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PnsCredentialsResource.properties,
  "csharp"
);
@@clientName(PolicyKeyResource, "NotificationHubPolicyKey", "csharp");
@@clientName(ResourceListKeys, "NotificationHubResourceKeys", "csharp");
@@clientName(Sku, "NotificationHubSku", "csharp");
@@clientName(SkuName, "NotificationHubSkuName", "csharp");
@@clientName(IpRule, "NotificationHubIPRule", "csharp");
@@clientName(IpRule.rights, "AccessRights", "csharp");
@@clientName(NetworkAcls, "NotificationHubNetworkAcls", "csharp");
@@clientName(PublicInternetAuthorizationRule.rights, "AccessRights", "csharp");
@@clientName(SharedAccessAuthorizationRuleProperties.rights,
  "AccessRights",
  "csharp"
);
@@clientName(PrivateLinkResource,
  "NotificationHubsPrivateLinkResource",
  "csharp"
);
@@usage(PrivateLinkResource, Usage.input | Usage.output, "csharp");
@@clientName(PrivateEndpointConnectionResource,
  "NotificationHubPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateEndpointConnectionProperties,
  "NotificationHubPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(NamespaceProperties,
  "NotificationHubNamespaceProperties",
  "csharp"
);
@@clientName(NamespaceProperties.enabled, "IsEnabled", "csharp");
@@clientName(NamespaceProperties.critical, "IsCritical", "csharp");
@@clientName(NamespaceStatus, "NotificationHubNamespaceStatus", "csharp");
@@clientName(PrivateLinkConnectionStatus,
  "NotificationHubPrivateLinkConnectionStatus",
  "csharp"
);
@@clientName(PublicNetworkAccess,
  "NotificationHubPublicNetworkAccess",
  "csharp"
);
@@clientName(RegistrationResult,
  "NotificationHubPubRegistrationResult",
  "csharp"
);
@@clientName(ReplicationRegion, "AllowedReplicationRegion", "csharp");
@@clientName(ReplicationRegion.WestUs2, "WestUS2", "csharp");
@@alternateType(NamespaceProperties.serviceBusEndpoint, url, "csharp");
@@clientName(NamespaceProperties.provisioningState,
  "OperationProvisioningState",
  "csharp"
);
@@clientName(NamespaceProperties.status, "NamespaceStatus", "csharp");
@@clientName(NamespaceProperties.namespaceType, "HubNamespaceType", "csharp");
@@clientName(NotificationHubProperties.name, "NotificationHubName", "csharp");
@@alternateType(NotificationHubProperties.registrationTtl, duration, "csharp");
@@clientName(NamespaceProperties.name, "NamespaceName", "csharp");
@@clientName(DebugSendResult.results, "FailureDescription", "csharp");
@@clientName(NamespacesOperationGroup.checkAvailability,
  "CheckNotificationHubNamespaceAvailability",
  "csharp"
);
@@clientName(IpRule.ipMask, "IPMask", "csharp");
@@clientName(NetworkAcls.ipRules, "IPRules", "csharp");
@@alternateType(RemotePrivateEndpointConnection.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Change base type from ProxyResource (ResourceData) to TrackedResource (TrackedResourceData)
// for C# backward compatibility. The pre-migration SDK had TrackedResourceData as the base with location/tags.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(CheckAvailabilityResult,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(PnsCredentialsResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(SharedAccessAuthorizationRuleResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(DebugSendResponse,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);
@@clientName(DebugSendResponse, "NotificationHubTestSendResult", "csharp");
@@usage(DebugSendResponse, Usage.input | Usage.output, "csharp");

// Cannot use @@hierarchyBuilding because NotificationHubPatchParameters' properties are not a strict superset
// of TrackedResource (missing id, name, type, systemData, location).
/**
 * Patch parameter for NamespaceResource.
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

@@alternateType(NotificationHubPatchParameters,
  NotificationHubPatchParametersReplacement,
  "csharp"
);
@@clientName(NotificationHubPatchParametersReplacement,
  "NotificationHubPatch",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NotificationHubPatchParametersReplacement.properties,
  "csharp"
);

// Cannot use @@hierarchyBuilding because CheckAvailabilityParameters' properties are not a strict superset
// of TrackedResource (e.g. location is string vs azureLocation, id is string vs armResourceIdentifier).
/**
 * Parameters supplied to the Check Name Availability for Namespace and
 * NotificationHubs.
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

@@clientName(CheckAvailabilityParameters,
  "NotificationHubAvailabilityContentTemp",
  "csharp"
);
@@alternateType(CheckAvailabilityParameters,
  CheckAvailabilityParametersReplacement,
  "csharp"
);
@@clientName(CheckAvailabilityParametersReplacement,
  "NotificationHubAvailabilityContent",
  "csharp"
);
