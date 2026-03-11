import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

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

// Resolve breaking changes for Go SDK compatibility
@@clientName(Microsoft.SignalRService.WebPubSubResource, "ResourceInfo", "go");
@@clientName(Microsoft.SignalRService.WebPubSubResourceList,
  "ResourceInfoList",
  "go"
);

// C# mgmt SDK: Override @@clientLocation entries from back-compatible.tsp
// to avoid namespace conflict. The client named "WebPubSub" conflicts with
// the namespace segment "WebPubSub" in Azure.ResourceManager.WebPubSub,
// causing the generator to produce _WebPubSub as a prefix.
// Renaming the client to "WebPubSubService" for csharp avoids this.
@@clientLocation(WebPubSubResources.get, "WebPubSubService", "csharp");
@@clientLocation(WebPubSubResources.createOrUpdate,
  "WebPubSubService",
  "csharp"
);
@@clientLocation(WebPubSubResources.update, "WebPubSubService", "csharp");
@@clientLocation(WebPubSubResources.delete, "WebPubSubService", "csharp");
@@clientLocation(WebPubSubResources.listByResourceGroup,
  "WebPubSubService",
  "csharp"
);
@@clientLocation(WebPubSubResources.listBySubscription,
  "WebPubSubService",
  "csharp"
);
@@clientLocation(WebPubSubResources.listKeys, "WebPubSubService", "csharp");
@@clientLocation(WebPubSubResources.regenerateKey,
  "WebPubSubService",
  "csharp"
);
@@clientLocation(WebPubSubResources.restart, "WebPubSubService", "csharp");
@@clientLocation(WebPubSubResources.listSkus, "WebPubSubService", "csharp");
@@clientLocation(Replicas.listReplicaSkus, "WebPubSubService", "csharp");
@@clientLocation(WebPubSubOperationGroup.checkNameAvailability,
  "WebPubSubService",
  "csharp"
);

// C# SDK: Rename EventHandler to avoid conflict with System.EventHandler
@@clientName(EventHandler, "WebPubSubEventHandler", "csharp");

// C# SDK: Rename RESTAPI to RestApi for consistent casing
@@clientName(WebPubSubRequestType.RESTAPI, "RestApi", "csharp");

// C# SDK: Rename ProvisioningState to include service prefix
@@clientName(ProvisioningState, "WebPubSubProvisioningState", "csharp");

// C# SDK: Rename Parameters models to Content (matches old API surface)
@@clientName(NameAvailabilityParameters,
  "WebPubSubNameAvailabilityContent",
  "csharp"
);
@@clientName(RegenerateKeyParameters,
  "WebPubSubRegenerateKeyContent",
  "csharp"
);

// C# SDK: Rename Operation to avoid AZC0033 forbidden suffix
@@clientName(Operation, "WebPubSubOperationDetail", "csharp");

// C# SDK: Model renames for backward compatibility with old API surface
@@clientName(ACLAction, "AclAction", "csharp");
@@clientName(ResourceSku, "BillingInfoSku", "csharp");
@@clientName(PrivateEndpointACL, "PrivateEndpointAcl", "csharp");
@@clientName(NetworkACL, "PublicNetworkAcls", "csharp");
@@clientName(ShareablePrivateLinkResourceProperties,
  "ShareablePrivateLinkProperties",
  "csharp"
);
@@clientName(ShareablePrivateLinkResourceType,
  "ShareablePrivateLinkType",
  "csharp"
);
@@clientName(KeyType, "WebPubSubKeyType", "csharp");
@@clientName(NameAvailability, "WebPubSubNameAvailability", "csharp");
@@clientName(WebPubSubNetworkACLs, "WebPubSubNetworkAcls", "csharp");
@@clientName(PrivateLinkResource, "WebPubSubPrivateLink", "csharp");
@@clientName(PrivateLinkServiceConnectionStatus,
  "WebPubSubPrivateLinkServiceConnectionStatus",
  "csharp"
);
@@clientName(ScaleType, "WebPubSubScaleType", "csharp");
@@clientName(SharedPrivateLinkResourceStatus,
  "WebPubSubSharedPrivateLinkStatus",
  "csharp"
);
@@clientName(SkuCapacity, "WebPubSubSkuCapacity", "csharp");

// C# SDK: Resource model renames for backward compatibility
@@clientName(WebPubSubResource, "WebPubSub", "csharp");
@@clientName(SharedPrivateLinkResource, "WebPubSubSharedPrivateLink", "csharp");

// C# SDK: Property renames for backward compatibility
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
