import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

@@clientName(WebPubSubSharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@flattenProperty(PrivateLinkResource.properties);
