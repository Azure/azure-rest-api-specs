import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KeyVault;
using Azure.Core;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnectionItem.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MhsmPrivateEndpointConnectionItem.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MhsmPrivateLinkResource.properties);
@@clientName(Attributes.nbf, "NotBefore");
@@clientName(Attributes.exp, "Expires");

@@clientName(Vaults.createOrUpdate::parameters.resource, "parameters");
@@clientName(Vaults.update::parameters.properties, "parameters");
@@clientName(Vaults.updateAccessPolicy::parameters.resource, "parameters");

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ManagedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedHsms.update::parameters.properties, "parameters");

@@clientName(MhsmPrivateEndpointConnections.put::parameters.resource,
  "properties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MhsmPrivateEndpointConnection.properties);

@@clientName(Secrets.createOrUpdate::parameters.resource, "parameters");
@@clientName(Secrets.update::parameters.properties, "parameters");
@@clientName(ManagedHsmsOperationGroup.checkMhsmNameAvailability::parameters.body,
  "mhsmName"
);
@@clientName(VaultsOperationGroup.checkNameAvailability::parameters.body,
  "vaultName"
);
@@visibility(DeletedVault.properties, Lifecycle.Read);
@@visibility(DeletedManagedHsm.properties, Lifecycle.Read);
@@clientName(MhsmPrivateEndpointConnection, "MHSMPrivateEndpointConnection");
@@clientName(MhsmPrivateLinkResource, "MHSMPrivateLinkResource");

@@clientName(MhsmPrivateLinkResourceListResult,
  "MHSMPrivateLinkResourceListResult"
);
@@clientName(MhsmRegionsListResult, "MHSMRegionsListResult");
@@clientName(MhsmPrivateEndpointConnectionProperties,
  "MHSMPrivateEndpointConnectionProperties"
);
@@clientName(MhsmPrivateEndpoint, "MHSMPrivateEndpoint");
@@clientName(MhsmPrivateLinkServiceConnectionState,
  "MHSMPrivateLinkServiceConnectionState"
);
@@clientName(MhsmPrivateEndpointConnectionItem,
  "MHSMPrivateEndpointConnectionItem"
);
@@clientName(MhsmNetworkRuleSet, "MHSMNetworkRuleSet");
@@clientName(MhsmGeoReplicatedRegion, "MHSMGeoReplicatedRegion");
@@clientName(MhsmVirtualNetworkRule, "MHSMVirtualNetworkRule");
@@clientName(MhsmipRule, "MHSMIPRule");
@@clientName(MhsmPrivateLinkResourceProperties,
  "MHSMPrivateLinkResourceProperties"
);
