import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.SignalRService;

@@clientName(Microsoft.SignalRService,
  "WebPubSubManagementClient",
  "javascript,python"
);

@@clientDoc(Microsoft.SignalRService.EventHandler.urlTemplate,
  """
    Gets or sets the URL template for the event handler. The actual URL is calculated when the corresponding event is triggered. 
    The template supports predefined parameters syntax: `{event}`, `{hub}`, and KeyVault reference syntax `{&#64;Microsoft.KeyVault(SecretUri=_your_secret_identifier_)}` 
    For example, if the template is `http://example.com/api/{event}`, when `connect` event is triggered, a POST request will be sent to the URL `http://example.com/chat/api/connect`.
    Note: Parameters are not allowed in the hostname of the URL, and curly brackets `{}` are reserved for parameter syntax only. If your URL path contains literal curly brackets, please URL-encode them to ensure proper handling.
    """,
  DocumentationMode.replace,
  "java"
);

@@clientName(WebPubSubProperties.externalIP, "externalIp", "java");
@@clientName(WebPubSubProperties.hostName, "hostname", "java");
@@clientName(WebPubSubProperties.hostNamePrefix, "hostnamePrefix", "java");
@@clientName(ACLAction, "AclAction", "java");
@@clientName(NetworkACL, "NetworkAcl", "java");
@@clientName(IPRule, "IpRule", "java");
@@clientName(PrivateEndpointACL, "PrivateEndpointAcl", "java");
@@clientName(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go");
@@clientName(Microsoft.SignalRService.WebPubSubResourceList,
  "ResourceInfoList",
  "go"
);
@@clientName(EventHandler, "WebPubSubEventHandler", "csharp");
@@clientName(WebPubSubRequestType.RESTAPI, "RestApi", "csharp");
@@clientName(ProvisioningState, "WebPubSubProvisioningState", "csharp");
@@clientName(NameAvailabilityParameters,
  "WebPubSubNameAvailabilityContent",
  "csharp"
);
@@clientName(NameAvailabilityParameters.type, "ResourceType", "csharp");
@@clientName(RegenerateKeyParameters,
  "WebPubSubRegenerateKeyContent",
  "csharp"
);

@@scope(Operations.list, "!csharp");

@@clientName(ACLAction, "AclAction", "csharp");
@@clientName(PrivateEndpointACL, "PrivateEndpointAcl", "csharp");
@@clientName(NetworkACL, "PublicNetworkAcls", "csharp");
@@usage(ShareablePrivateLinkResourceProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@clientName(ShareablePrivateLinkResourceProperties,
  "ShareablePrivateLinkProperties",
  "csharp"
);
@@usage(ShareablePrivateLinkResourceType, Usage.input | Usage.output, "csharp");
@@clientName(ShareablePrivateLinkResourceType,
  "ShareablePrivateLinkType",
  "csharp"
);
@@clientName(KeyType, "WebPubSubKeyType", "csharp");
@@clientName(NameAvailability, "WebPubSubNameAvailability", "csharp");
@@clientName(WebPubSubNetworkACLs, "WebPubSubNetworkAcls", "csharp");
@@clientName(PrivateLinkResource, "WebPubSubPrivateLink", "csharp");
@@clientName(PrivateLinkResourceProperties.shareablePrivateLinkResourceTypes,
  "ShareablePrivateLinkTypes",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionStatus,
  "WebPubSubPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(SharedPrivateLinkResourceStatus,
  "WebPubSubSharedPrivateLinkStatus",
  "csharp"
);

@@clientName(WebPubSubResource, "WebPubSub", "csharp");
@@clientName(WebPubSubProperties.disableAadAuth, "IsAadAuthDisabled", "csharp");
@@clientName(WebPubSubTlsSettings.clientCertEnabled,
  "IsClientCertEnabled",
  "csharp"
);
@@clientName(WebPubSubProperties.disableLocalAuth,
  "IsLocalAuthDisabled",
  "csharp"
);
@@clientName(WebPubSubProperties.networkACLs, "NetworkAcls", "csharp");
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@clientName(CustomCertificate, "WebPubSubCustomCertificate", "csharp");
@@alternateType(CustomCertificateProperties.keyVaultBaseUri, url, "csharp");
@@clientName(CustomDomain, "WebPubSubCustomDomain", "csharp");
@@alternateType(ResourceReference.id, armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpoint.id, armResourceIdentifier, "csharp");
@@clientName(PrivateEndpointConnection,
  "WebPubSubPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionState,
  "WebPubSubPrivateLinkServiceConnectionState",
  "csharp"
);
@@clientName(PrivateLinkServiceConnectionStatus,
  "WebPubSubPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@alternateType(SharedPrivateLinkResourceProperties.privateLinkResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(Replica, "WebPubSubReplica", "csharp");
@@clientName(ReplicaProperties.regionEndpointEnabled,
  "IsRegionEndpointEnabled",
  "csharp"
);
@@clientName(WebPubSubProperties.regionEndpointEnabled,
  "IsRegionEndpointEnabled",
  "csharp"
);
@@alternateType(WebPubSubResource.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(Azure.ResourceManager.LocationParameter.location,
  azureLocation,
  "csharp"
);
@@clientName(WebPubSubOperationGroup.checkNameAvailability,
  "CheckWebPubSubNameAvailability",
  "csharp"
);
@@clientName(SharedPrivateLinkResource, "WebPubSubSharedPrivateLink", "csharp");
@@clientName(SharedPrivateLinkResourceStatus,
  "WebPubSubSharedPrivateLinkStatus",
  "csharp"
);
@@clientName(UsagesOperationGroup.list, "GetUsages", "csharp");
@@clientName(Sku, "WebPubSubSku", "csharp");
@@alternateType(Sku.resourceType, armResourceType, "csharp");
@@clientName(ResourceSku, "BillingInfoSku", "csharp");
@@clientName(SkuCapacity, "WebPubSubSkuCapacity", "csharp");
@@clientName(ScaleType, "WebPubSubScaleType", "csharp");
@@clientName(ApplicationFirewallSettings,
  "WebPubSubApplicationFirewallSettings",
  "csharp"
);
@@clientName(ClientConnectionCountRule,
  "WebPubSubClientConnectionCountRule",
  "csharp"
);
@@clientName(ClientTrafficControlRule,
  "WebPubSubClientTrafficControlRule",
  "csharp"
);
@@clientName(EventHubEndpoint, "WebPubSubEventHubEndpoint", "csharp");
@@clientName(EventListener, "WebPubSubEventListener", "csharp");
@@clientName(EventListenerEndpoint, "WebPubSubEventListenerEndpoint", "csharp");
@@clientName(EventListenerFilter, "WebPubSubEventListenerFilter", "csharp");
@@clientName(EventNameFilter, "WebPubSubEventNameFilter", "csharp");
@@clientName(GroupPresenceEventFilters,
  "WebPubSubGroupPresenceEventFilters",
  "csharp"
);
@@clientName(GroupPresenceEventName,
  "WebPubSubGroupPresenceEventName",
  "csharp"
);
@@clientName(IPRule, "WebPubSubIPRule", "csharp");
@@clientName(ServiceKind, "WebPubSubServiceKind", "csharp");
@@clientName(ThrottleByJwtCustomClaimRule,
  "WebPubSubThrottleByJwtCustomClaimRule",
  "csharp"
);
@@clientName(ThrottleByJwtSignatureRule,
  "WebPubSubThrottleByJwtSignatureRule",
  "csharp"
);
@@clientName(ThrottleByUserIdRule, "WebPubSubThrottleByUserIdRule", "csharp");
@@clientName(TrafficThrottleByJwtCustomClaimRule,
  "WebPubSubTrafficThrottleByJwtCustomClaimRule",
  "csharp"
);
@@clientName(TrafficThrottleByJwtSignatureRule,
  "WebPubSubTrafficThrottleByJwtSignatureRule",
  "csharp"
);
@@clientName(TrafficThrottleByUserIdRule,
  "WebPubSubTrafficThrottleByUserIdRule",
  "csharp"
);
@@clientName(UpstreamAuthSettings.type, "AuthType", "csharp");
@@alternateType(SignalRServiceUsage.id, armResourceIdentifier, "csharp");
@@clientName(LiveTraceCategory.enabled, "IsEnabled", "csharp");
@@alternateType(LiveTraceCategory.enabled, boolean, "csharp");
@@clientName(LiveTraceConfiguration.enabled, "IsEnabled", "csharp");
@@alternateType(LiveTraceConfiguration.enabled, boolean, "csharp");
@@clientName(WebPubSubResources.list,
  "GetWebPubSubPrivateLinkResources",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@markAsPageable(Replicas.listReplicaSkus, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Change the base type back to TrackedResource for backward compatibility"
@@markAsPageable(WebPubSubResources.listSkus, "csharp");
