import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HybridContainerService;

@@clientLocation(VirtualNetworks.retrieve, "virtualNetworks");
@@clientLocation(VirtualNetworks.createOrUpdate, "virtualNetworks");
@@clientName(VirtualNetworks.createOrUpdate::parameters.resource,
  "virtualNetworks"
);
@@clientLocation(VirtualNetworks.update, "virtualNetworks");
@@clientName(VirtualNetworks.update::parameters.properties, "virtualNetworks");
@@clientLocation(VirtualNetworks.delete, "virtualNetworks");
@@clientLocation(VirtualNetworks.listByResourceGroup, "virtualNetworks");
@@clientLocation(VirtualNetworks.listBySubscription, "virtualNetworks");
