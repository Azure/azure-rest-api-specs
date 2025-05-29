import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(WebPubSubResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WebPubSubResources.update::parameters.properties, "parameters");
@@clientName(WebPubSubResources.regenerateKey::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WebPubSubResource.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(WebPubSubSharedPrivateLinkResources.createOrUpdate::parameters.resource,
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

@@clientName(WebPubSubHubs.createOrUpdate::parameters.resource, "parameters");

@@clientName(Replicas.createOrUpdate::parameters.resource, "parameters");
@@clientName(Replicas.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Replica.properties);
