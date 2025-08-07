import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

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
@@clientLocation(Vaults.listByVault, "PrivateLinkResources");

@@clientLocation(DeletedVaults.getDeleted, Vaults);
@@clientLocation(DeletedVaults.purgeDeleted, Vaults);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ManagedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedHsms.update::parameters.properties, "parameters");
@@clientLocation(ManagedHsms.listByMHSMResource, "MHSMPrivateLinkResources");
@@clientLocation(ManagedHsms.listByResource, "MHSMRegions");

@@clientLocation(MhsmPrivateEndpointConnections.get,
  "MHSMPrivateEndpointConnections"
);
@@clientLocation(MhsmPrivateEndpointConnections.put,
  "MHSMPrivateEndpointConnections"
);
@@clientName(MhsmPrivateEndpointConnections.put::parameters.resource,
  "properties"
);
@@clientLocation(MhsmPrivateEndpointConnections.delete,
  "MHSMPrivateEndpointConnections"
);
@@clientLocation(MhsmPrivateEndpointConnections.listByResource,
  "MHSMPrivateEndpointConnections"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MhsmPrivateEndpointConnection.properties);

@@clientLocation(DeletedManagedHsms.getDeleted, ManagedHsms);
@@clientLocation(DeletedManagedHsms.purgeDeleted, ManagedHsms);

@@clientName(Secrets.createOrUpdate::parameters.resource, "parameters");
@@clientName(Secrets.update::parameters.properties, "parameters");

@@clientLocation(VaultsOperationGroup.listDeleted, Vaults);
@@clientLocation(VaultsOperationGroup.list, Vaults);
@@clientLocation(VaultsOperationGroup.checkNameAvailability, Vaults);

@@clientLocation(ManagedHsmsOperationGroup.listDeleted, ManagedHsms);
@@clientLocation(ManagedHsmsOperationGroup.checkMhsmNameAvailability,
  ManagedHsms
);
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);
@@clientName(Operation.properties, "OperationProperties");

@@OpenAPI.extension(MhsmRegionsListResult.value, "x-ms-identifiers", #["name"]);

@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python"
);
