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
@@clientLocation(WebPubSubResources.get, "WebPubSub");
@@clientName(WebPubSubResources.get, "Get");
@@clientLocation(WebPubSubResources.createOrUpdate, "WebPubSub");
@@clientName(WebPubSubResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(WebPubSubResources.update, "WebPubSub");
@@clientName(WebPubSubResources.update, "Update");
@@clientLocation(WebPubSubResources.delete, "WebPubSub");
@@clientName(WebPubSubResources.delete, "Delete");
@@clientLocation(WebPubSubResources.listByResourceGroup, "WebPubSub");
@@clientName(WebPubSubResources.listByResourceGroup, "ListByResourceGroup");
@@clientLocation(WebPubSubResources.listBySubscription, "WebPubSub");
@@clientName(WebPubSubResources.listBySubscription, "ListBySubscription");
@@clientLocation(WebPubSubResources.listKeys, "WebPubSub");
@@clientName(WebPubSubResources.listKeys, "ListKeys");
@@clientLocation(WebPubSubResources.regenerateKey, "WebPubSub");
@@clientName(WebPubSubResources.regenerateKey, "RegenerateKey");
@@clientLocation(WebPubSubResources.restart, "WebPubSub");
@@clientName(WebPubSubResources.restart, "Restart");
@@clientLocation(WebPubSubResources.listSkus, "WebPubSub");
@@clientName(WebPubSubResources.listSkus, "ListSkus");
@@clientLocation(WebPubSubResources.list, "WebPubSubPrivateLinkResources");
@@clientName(WebPubSubResources.list, "List");

// Replicas interface operations with WebPubSubReplicas_ prefix
@@clientLocation(Replicas.get, "WebPubSubReplicas");
@@clientName(Replicas.get, "Get");
@@clientLocation(Replicas.createOrUpdate, "WebPubSubReplicas");
@@clientName(Replicas.createOrUpdate, "CreateOrUpdate");
@@clientLocation(Replicas.update, "WebPubSubReplicas");
@@clientName(Replicas.update, "Update");
@@clientLocation(Replicas.delete, "WebPubSubReplicas");
@@clientName(Replicas.delete, "Delete");
@@clientLocation(Replicas.list, "WebPubSubReplicas");
@@clientName(Replicas.list, "List");
@@clientLocation(Replicas.listReplicaSkus, "WebPubSub");
@@clientName(Replicas.listReplicaSkus, "ListReplicaSkus");
@@clientLocation(Replicas.restart, "WebPubSubReplicas");
@@clientName(Replicas.restart, "Restart");

// CustomCertificates interface operations with WebPubSubCustomCertificates_ prefix
@@clientLocation(CustomCertificates.get, "WebPubSubCustomCertificates");
@@clientName(CustomCertificates.get, "Get");
@@clientLocation(CustomCertificates.createOrUpdate,
  "WebPubSubCustomCertificates"
);
@@clientName(CustomCertificates.createOrUpdate, "CreateOrUpdate");
@@clientLocation(CustomCertificates.delete, "WebPubSubCustomCertificates");
@@clientName(CustomCertificates.delete, "Delete");
@@clientLocation(CustomCertificates.list, "WebPubSubCustomCertificates");
@@clientName(CustomCertificates.list, "List");

// CustomDomains interface operations with WebPubSubCustomDomains_ prefix
@@clientLocation(CustomDomains.get, "WebPubSubCustomDomains");
@@clientName(CustomDomains.get, "Get");
@@clientLocation(CustomDomains.createOrUpdate, "WebPubSubCustomDomains");
@@clientName(CustomDomains.createOrUpdate, "CreateOrUpdate");
@@clientLocation(CustomDomains.delete, "WebPubSubCustomDomains");
@@clientName(CustomDomains.delete, "Delete");
@@clientLocation(CustomDomains.list, "WebPubSubCustomDomains");
@@clientName(CustomDomains.list, "List");

// PrivateEndpointConnections interface operations with WebPubSubPrivateEndpointConnections_ prefix
@@clientLocation(PrivateEndpointConnections.get,
  "WebPubSubPrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnections.get, "Get");
@@clientLocation(PrivateEndpointConnections.update,
  "WebPubSubPrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnections.update, "Update");
@@clientLocation(PrivateEndpointConnections.delete,
  "WebPubSubPrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnections.delete, "Delete");
@@clientLocation(PrivateEndpointConnections.list,
  "WebPubSubPrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnections.list, "List");

// SharedPrivateLinkResources interface operations with WebPubSubReplicaSharedPrivateLinkResources_ prefix
@@clientLocation(SharedPrivateLinkResources.get,
  "WebPubSubReplicaSharedPrivateLinkResources"
);
@@clientName(SharedPrivateLinkResources.get, "Get");
@@clientLocation(SharedPrivateLinkResources.createOrUpdate,
  "WebPubSubReplicaSharedPrivateLinkResources"
);
@@clientName(SharedPrivateLinkResources.createOrUpdate, "CreateOrUpdate");
@@clientLocation(SharedPrivateLinkResources.list,
  "WebPubSubReplicaSharedPrivateLinkResources"
);
@@clientName(SharedPrivateLinkResources.list, "List");

// WebPubSubSharedPrivateLinkResources interface operations with WebPubSubSharedPrivateLinkResources_ prefix
@@clientName(WebPubSubSharedPrivateLinkResources.delete, "Delete");

// WebPubSubHubs interface operations with WebPubSubHubs_ prefix
@@clientName(WebPubSubHubs.delete, "Delete");

// WebPubSubOperationGroup interface operations with WebPubSub_ prefix
@@clientLocation(WebPubSubOperationGroup.checkNameAvailability, "WebPubSub");
@@clientName(WebPubSubOperationGroup.checkNameAvailability,
  "CheckNameAvailability"
);

// UsagesOperationGroup interface operations with Usages_ prefix
@@clientLocation(UsagesOperationGroup.list, "Usages");
@@clientName(UsagesOperationGroup.list, "List");

@@clientName(PersistentStorages.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PersistentStorage.properties
);

// PersistentStorages interface operations with WebPubSubPersistentStorages_ prefix
@@clientLocation(PersistentStorages.get, "WebPubSubPersistentStorages");
@@clientName(PersistentStorages.get, "Get");
@@clientLocation(PersistentStorages.createOrUpdate,
  "WebPubSubPersistentStorages"
);
@@clientName(PersistentStorages.createOrUpdate, "CreateOrUpdate");
@@clientLocation(PersistentStorages.delete, "WebPubSubPersistentStorages");
@@clientName(PersistentStorages.delete, "Delete");
@@clientLocation(PersistentStorages.list, "WebPubSubPersistentStorages");
@@clientName(PersistentStorages.list, "List");
