import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PrivateLinksAPI;

@@clientLocation(PrivateLinkResources.get, "PrivateLinks");
@@clientLocation(PrivateLinkResources.head, "PrivateLinks");
@@clientLocation(PrivateLinkResources.create, "PrivateLinks");
@@clientName(PrivateLinkResources.create::parameters.resource, "privateLink");
@@clientLocation(PrivateLinkResources.update, "PrivateLinks");
@@clientName(PrivateLinkResources.update::parameters.properties, "privateLink");
@@clientLocation(PrivateLinkResources.delete, "PrivateLinks");
@@clientLocation(PrivateLinkResources.list, "PrivateLinks");
@@clientLocation(PrivateLinkResources.listBySubscription, "PrivateLinks");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnection"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientLocation(PrivateLinkGroupResources.get, PrivateLinkResources);
@@clientLocation(PrivateLinkGroupResources.list, PrivateLinkResources);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkGroupResource.properties);
