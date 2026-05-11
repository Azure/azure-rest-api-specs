import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Databricks;

@@clientName(Encryption.keyversion, "KeyVersion");
@@clientName(Encryption.keyvaulturi, "KeyVaultUri");

@@clientName(Workspaces.createOrUpdate::parameters.resource, "parameters");
@@clientName(Workspaces.update::parameters.properties, "parameters");
@@clientLocation(Workspaces.list, "OutboundNetworkDependenciesEndpoints");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Workspace.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "privateEndpointConnection"
);

@@clientLocation(GroupIdInformations.get, "PrivateLinkResources");
@@clientLocation(GroupIdInformations.list, "PrivateLinkResources");

@@clientLocation(VirtualNetworkPeerings.get, "vNetPeering");
@@clientLocation(VirtualNetworkPeerings.createOrUpdate, "vNetPeering");
@@clientName(VirtualNetworkPeerings.createOrUpdate::parameters.resource,
  "VirtualNetworkPeeringParameters"
);
@@clientLocation(VirtualNetworkPeerings.delete, "vNetPeering");
@@clientLocation(VirtualNetworkPeerings.listByWorkspace, "vNetPeering");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VirtualNetworkPeering.properties);

@@clientName(AccessConnectors.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(AccessConnectors.update::parameters.properties, "parameters");
