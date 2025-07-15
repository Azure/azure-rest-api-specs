import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(SignalRResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SignalRResources.update::parameters.properties, "parameters");
@@clientName(SignalRResources.regenerateKey::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SignalRResource.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SignalRSharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SharedPrivateLinkResource.properties);

@@clientName(CustomCertificates.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomCertificate.properties);

@@clientName(CustomDomains.createOrUpdate::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomDomain.properties);

@@clientName(Replicas.createOrUpdate::parameters.resource, "parameters");
@@clientName(Replicas.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Replica.properties);

@@clientName(SignalROperationGroup.checkNameAvailability::parameters.body, "parameters");

@@clientLocation(CustomCertificates.get, "SignalRCustomCertificates");
@@clientLocation(CustomCertificates.createOrUpdate,
  "SignalRCustomCertificates"
);
@@clientLocation(CustomCertificates.delete, "SignalRCustomCertificates");
@@clientLocation(CustomCertificates.list, "SignalRCustomCertificates");
@@clientLocation(CustomDomains.get, "SignalRCustomDomains");
@@clientLocation(CustomDomains.createOrUpdate, "SignalRCustomDomains");
@@clientLocation(CustomDomains.delete, "SignalRCustomDomains");
@@clientLocation(CustomDomains.list, "SignalRCustomDomains");
@@clientLocation(PrivateEndpointConnections.get,
  "SignalRPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.update,
  "SignalRPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "SignalRPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.list,
  "SignalRPrivateEndpointConnections"
);
@@clientLocation(Replicas.get, "SignalRReplicas");
@@clientLocation(Replicas.createOrUpdate, "SignalRReplicas");
@@clientLocation(Replicas.update, "SignalRReplicas");
@@clientLocation(Replicas.delete, "SignalRReplicas");
@@clientLocation(Replicas.list, "SignalRReplicas");
@@clientLocation(Replicas.restart, "SignalRReplicas");
@@clientLocation(Replicas.listReplicaSkus, "SignalR");
@@clientLocation(SharedPrivateLinkResources.get,
  "SignalRReplicaSharedPrivateLinkResources"
);
@@clientLocation(SharedPrivateLinkResources.createOrUpdate,
  "SignalRReplicaSharedPrivateLinkResources"
);
@@clientLocation(SharedPrivateLinkResources.list,
  "SignalRReplicaSharedPrivateLinkResources"
);
@@clientLocation(SignalRResources.get, "SignalR");
@@clientLocation(SignalRResources.createOrUpdate, "SignalR");
@@clientLocation(SignalRResources.update, "SignalR");
@@clientLocation(SignalRResources.delete, "SignalR");
@@clientLocation(SignalRResources.listByResourceGroup, "SignalR");
@@clientLocation(SignalRResources.listBySubscription, "SignalR");
@@clientLocation(SignalRResources.listKeys, "SignalR");
@@clientLocation(SignalRResources.regenerateKey, "SignalR");
@@clientLocation(SignalRResources.restart, "SignalR");
@@clientLocation(SignalRResources.listSkus, "SignalR");
@@clientLocation(SignalRResources.list, "SignalRPrivateLinkResources");
@@clientLocation(UsagesOperationGroup.list, "Usage");
