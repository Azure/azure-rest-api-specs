import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ClientGenerator.Core;
using Microsoft.KeyVault;
using Azure.Core;

@@clientName(KeyAttributes.nbf, "NotBefore");
@@clientName(KeyAttributes.exp, "Expires");

@@clientName(ManagedHsmKeyAttributes.nbf, "NotBefore");
@@clientName(ManagedHsmKeyAttributes.exp, "Expires");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnectionItem.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MhsmPrivateEndpointConnectionItem.properties
);

@@clientName(Error.innererror, "innerError");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MhsmPrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);
@@clientName(Operation.properties, "operationProperties");

@@clientName(Attributes.nbf, "NotBefore");
@@clientName(Attributes.exp, "Expires");

@@clientName(Keys.createIfNotExist::parameters.resource, "parameters");
@@clientLocation(KeyOperationGroup.getVersion, Keys);
@@clientLocation(KeyOperationGroup.listVersions, Keys);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Key.properties);

@@clientName(ManagedHsmKeys.createIfNotExist::parameters.resource,
  "parameters"
);
@@clientLocation(ManagedHsmKeyOperationGroup.getVersion, ManagedHsmKeys);
@@clientLocation(ManagedHsmKeyOperationGroup.listVersions, ManagedHsmKeys);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ManagedHsmKey.properties);

@@clientName(Vaults.createOrUpdate::parameters.resource, "parameters");
@@clientName(Vaults.update::parameters.properties, "parameters");
@@clientName(Vaults.updateAccessPolicy::parameters.resource, "parameters");
@@clientLocation(Vaults.listByVault, "PrivateLinkResources");

@@clientLocation(DeletedVaults.getDeleted, Vaults);
@@clientLocation(DeletedVaults.purgeDeleted, Vaults);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

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
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MhsmPrivateEndpointConnection.properties
);

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
@@clientName(MhsmPrivateEndpointConnection,
  "MHSMPrivateEndpointConnection",
  "!java"
);
@@clientName(MhsmPrivateLinkResource, "MHSMPrivateLinkResource", "!java");
@@clientName(MhsmPrivateLinkResourceListResult,
  "MHSMPrivateLinkResourceListResult",
  "!java"
);
@@clientName(MhsmRegionsListResult, "MHSMRegionsListResult", "!java");
@@clientName(MhsmPrivateEndpointConnectionProperties,
  "MHSMPrivateEndpointConnectionProperties",
  "!java"
);
@@clientName(MhsmPrivateEndpoint, "MHSMPrivateEndpoint", "!java");
@@clientName(MhsmPrivateLinkServiceConnectionState,
  "MHSMPrivateLinkServiceConnectionState",
  "!java"
);
@@clientName(MhsmPrivateEndpointConnectionItem,
  "MHSMPrivateEndpointConnectionItem",
  "!java"
);
@@clientName(MhsmNetworkRuleSet, "MHSMNetworkRuleSet", "!java");
@@clientName(MhsmGeoReplicatedRegion, "MHSMGeoReplicatedRegion", "!java");
@@clientName(MhsmVirtualNetworkRule, "MHSMVirtualNetworkRule", "!java");
@@clientName(MhsmipRule, "MHSMIPRule", "!java");
@@clientName(MhsmPrivateLinkResourceProperties,
  "MHSMPrivateLinkResourceProperties",
  "!java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);
@@clientName(Operation.properties, "OperationProperties");

@@OpenAPI.extension(MhsmRegionsListResult.value, "x-ms-identifiers", #["name"]);

@@clientName(Azure.ResourceManager.CommonTypes.Resource,
  "ArmResource",
  "python"
);
@@clientName(VaultListResult, "ResourceListResult");
@@clientName(MhsmServiceTagRule, "MHSMServiceTagRule");
