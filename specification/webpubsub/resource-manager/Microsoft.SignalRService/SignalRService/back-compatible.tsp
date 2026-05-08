import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientName(WebPubSubResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WebPubSubResources.update::parameters.properties, "parameters");
@@clientName(WebPubSubResources.regenerateKey::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WebPubSubResource.properties
);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WebPubSubSharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SharedPrivateLinkResource.properties
);

@@clientName(CustomCertificates.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CustomCertificate.properties
);

@@clientName(CustomDomains.createOrUpdate::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CustomDomain.properties);

@@clientName(WebPubSubHubs.createOrUpdate::parameters.resource, "parameters");

@@clientName(Replicas.createOrUpdate::parameters.resource, "parameters");
@@clientName(Replicas.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Replica.properties);
@@clientName(WebPubSubOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);

// @@clientLocation and @@clientName decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// WebPubSubResources interface operations with WebPubSub_ prefix
@@clientLocation(WebPubSubResources.get, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.get, "Get");
@@clientLocation(WebPubSubResources.createOrUpdate, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(WebPubSubResources.update, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.update, "Update");
@@clientLocation(WebPubSubResources.delete, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.delete, "Delete");
@@clientLocation(WebPubSubResources.listByResourceGroup,
  "WebPubSub",
  "!csharp"
);
@@clientName(WebPubSubResources.listByResourceGroup, "ListByResourceGroup");
@@clientLocation(WebPubSubResources.listBySubscription, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.listBySubscription, "ListBySubscription");
@@clientLocation(WebPubSubResources.listKeys, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.listKeys, "ListKeys");
@@clientLocation(WebPubSubResources.regenerateKey, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.regenerateKey, "RegenerateKey");
@@clientLocation(WebPubSubResources.restart, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.restart, "Restart");
@@clientLocation(WebPubSubResources.listSkus, "WebPubSub", "!csharp");
@@clientName(WebPubSubResources.listSkus, "ListSkus");
@@clientLocation(WebPubSubResources.list,
  "WebPubSubPrivateLinkResources",
  "!csharp"
);
@@clientName(WebPubSubResources.list, "List");

// Replicas interface operations with WebPubSubReplicas_ prefix
@@clientLocation(Replicas.get, "WebPubSubReplicas", "!csharp");
@@clientName(Replicas.get, "Get");
@@clientLocation(Replicas.createOrUpdate, "WebPubSubReplicas", "!csharp");
@@clientName(Replicas.createOrUpdate, "CreateOrUpdate");
@@clientLocation(Replicas.update, "WebPubSubReplicas", "!csharp");
@@clientName(Replicas.update, "Update");
@@clientLocation(Replicas.delete, "WebPubSubReplicas", "!csharp");
@@clientName(Replicas.delete, "Delete");
@@clientLocation(Replicas.list, "WebPubSubReplicas", "!csharp");
@@clientName(Replicas.list, "List");
@@clientLocation(Replicas.listReplicaSkus, "WebPubSub", "!csharp");
@@clientName(Replicas.listReplicaSkus, "ListReplicaSkus");
@@clientLocation(Replicas.restart, "WebPubSubReplicas", "!csharp");
@@clientName(Replicas.restart, "Restart");

// CustomCertificates interface operations with WebPubSubCustomCertificates_ prefix
@@clientLocation(CustomCertificates.get,
  "WebPubSubCustomCertificates",
  "!csharp"
);
@@clientName(CustomCertificates.get, "Get");
@@clientLocation(CustomCertificates.createOrUpdate,
  "WebPubSubCustomCertificates",
  "!csharp"
);
@@clientName(CustomCertificates.createOrUpdate, "CreateOrUpdate");
@@clientLocation(CustomCertificates.delete,
  "WebPubSubCustomCertificates",
  "!csharp"
);
@@clientName(CustomCertificates.delete, "Delete");
@@clientLocation(CustomCertificates.list,
  "WebPubSubCustomCertificates",
  "!csharp"
);
@@clientName(CustomCertificates.list, "List");

// CustomDomains interface operations with WebPubSubCustomDomains_ prefix
@@clientLocation(CustomDomains.get, "WebPubSubCustomDomains", "!csharp");
@@clientName(CustomDomains.get, "Get");
@@clientLocation(CustomDomains.createOrUpdate,
  "WebPubSubCustomDomains",
  "!csharp"
);
@@clientName(CustomDomains.createOrUpdate, "CreateOrUpdate");
@@clientLocation(CustomDomains.delete, "WebPubSubCustomDomains", "!csharp");
@@clientName(CustomDomains.delete, "Delete");
@@clientLocation(CustomDomains.list, "WebPubSubCustomDomains", "!csharp");
@@clientName(CustomDomains.list, "List");

// PrivateEndpointConnections interface operations with WebPubSubPrivateEndpointConnections_ prefix
@@clientLocation(PrivateEndpointConnections.get,
  "WebPubSubPrivateEndpointConnections",
  "!csharp"
);
@@clientName(PrivateEndpointConnections.get, "Get");
@@clientLocation(PrivateEndpointConnections.update,
  "WebPubSubPrivateEndpointConnections",
  "!csharp"
);
@@clientName(PrivateEndpointConnections.update, "Update");
@@clientLocation(PrivateEndpointConnections.delete,
  "WebPubSubPrivateEndpointConnections",
  "!csharp"
);
@@clientName(PrivateEndpointConnections.delete, "Delete");
@@clientLocation(PrivateEndpointConnections.list,
  "WebPubSubPrivateEndpointConnections",
  "!csharp"
);
@@clientName(PrivateEndpointConnections.list, "List");

// SharedPrivateLinkResources interface operations with WebPubSubReplicaSharedPrivateLinkResources_ prefix
@@clientLocation(SharedPrivateLinkResources.get,
  "WebPubSubReplicaSharedPrivateLinkResources",
  "!csharp"
);
@@clientName(SharedPrivateLinkResources.get, "Get");
@@clientLocation(SharedPrivateLinkResources.createOrUpdate,
  "WebPubSubReplicaSharedPrivateLinkResources",
  "!csharp"
);
@@clientName(SharedPrivateLinkResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(SharedPrivateLinkResources.list,
  "WebPubSubReplicaSharedPrivateLinkResources",
  "!csharp"
);
@@clientName(SharedPrivateLinkResources.list, "List");

// WebPubSubSharedPrivateLinkResources interface operations with WebPubSubSharedPrivateLinkResources_ prefix
@@clientName(WebPubSubSharedPrivateLinkResources.delete, "Delete");

// WebPubSubHubs interface operations with WebPubSubHubs_ prefix
@@clientName(WebPubSubHubs.delete, "Delete");

// WebPubSubOperationGroup interface operations with WebPubSub_ prefix
@@clientLocation(WebPubSubOperationGroup.checkNameAvailability,
  "WebPubSub",
  "!csharp"
);
@@clientName(WebPubSubOperationGroup.checkNameAvailability,
  "CheckNameAvailability"
);

// UsagesOperationGroup interface operations with Usages_ prefix
@@clientLocation(UsagesOperationGroup.list, "Usages", "!csharp");
@@clientName(UsagesOperationGroup.list, "List");
