import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.NotificationHubs;

@@clientName(Microsoft.NotificationHubs,
  "NotificationHubsManagementClient",
  "javascript"
);

@@clientName(CheckAvailabilityParameters, "CheckAvailabilityContent", "csharp");
@@clientName(DebugSendResponse, "DebugSendResponseResult", "csharp");
@@clientName(Operation, "Info", "csharp");

@@clientName(NamespaceResource, "NotificationHubNamespace", "csharp");
@@alternateType(NamespaceProperties.serviceBusEndpoint, url, "csharp");
@@clientName(NamespaceProperties.enabled, "IsEnabled", "csharp");
@@clientName(NamespaceProperties.critical, "IsCritical", "csharp");
@@clientName(NamespaceProperties.provisioningState, "OperationProvisioningState", "csharp");
@@clientName(NamespaceProperties.status, "NamespaceStatus", "csharp");
@@clientName(NamespaceProperties.namespaceType, "HubNamespaceType", "csharp");
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
//  NotificationHubResourceProperties.registrationTtl: -|duration-constant
@@clientName(SharedAccessAuthorizationRuleResource, "NotificationHubAuthorizationRule", "csharp");
  // SharedAccessAuthorizationRuleResourceProperties.createdTime: CreatedOn|date-time
  // SharedAccessAuthorizationRuleResourceProperties.modifiedTime: ModifiedOn|date-time
@@clientName(SharedAccessAuthorizationRuleProperties.rights, "AccessRights", "csharp");
  // SharedAccessAuthorizationRuleProperties.createdTime: CreatedOn|date-time
  // SharedAccessAuthorizationRuleProperties.modifiedTime: ModifiedOn|date-time
@@clientName(MpnsCredential, "NotificationHubMpnsCredential", "csharp");
@@clientName(MpnsCredentialProperties.thumbprint, "ThumbprintString", "csharp");
@@clientName(AdmCredential, "NotificationHubAdmCredential", "csharp");
@@clientName(AccessRights, "AuthorizationRuleAccessRightExt", "csharp");
@@clientName(CheckAvailabilityParameters, "NotificationHubAvailabilityContent", "csharp");
@@clientName(CheckAvailabilityResult, "NotificationHubAvailabilityResult", "csharp");
@@clientName(DebugSendResponse, "NotificationHubTestSendResult", "csharp");
@@clientName(DebugSendResult.results, "FailureDescription", "csharp");
@@clientName(NamespaceListResult, "NotificationHubNamespaceListResult", "csharp");
@@clientName(NamespaceType, "NotificationHubNamespaceTypeExt", "csharp");
@@clientName(PnsCredentialsResource, "NotificationHubPnsCredentials", "csharp");
@@clientName(PolicyKeyResource, "NotificationHubPolicyKey", "csharp");
@@clientName(ResourceListKeys, "NotificationHubResourceKeys", "csharp");
@@clientName(Sku, "NotificationHubSku", "csharp");
@@clientName(SkuName, "NotificationHubSkuName", "csharp");
@@clientName(IpRule, "NotificationHubIPRule", "csharp");
@@clientName(IpRule.rights, "AccessRights", "csharp");
@@clientName(NetworkAcls, "NotificationHubNetworkAcls", "csharp");
@@clientName(PublicInternetAuthorizationRule.rights, "AccessRights", "csharp");
@@clientName(SharedAccessAuthorizationRuleProperties.rights, "AccessRights", "csharp");
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