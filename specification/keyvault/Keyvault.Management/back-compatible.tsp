import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KeyVault;
using Azure.Core;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnectionItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MhsmPrivateEndpointConnectionItem.properties);
/*
@@clientName(Error.innererror, "innerError");
*/
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MhsmPrivateLinkResource.properties);
@@clientName(Attributes.nbf, "NotBefore");
@@clientName(Attributes.exp, "Expires");

@@clientName(Vaults.createOrUpdate::parameters.resource, "parameters");
@@clientName(Vaults.update::parameters.properties, "parameters");
@@clientName(Vaults.updateAccessPolicy::parameters.resource, "parameters");

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ManagedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(ManagedHsms.update::parameters.properties, "parameters");

@@clientName(MhsmPrivateEndpointConnections.put::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
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
@@clientName(KeyAttributes.nbf, "NotBefore");
@@clientName(KeyAttributes.exp, "Expires");
@@clientName(MhsmPrivateLinkResourceListResult,
  "MHSMPrivateLinkResourceListResult"
);
@@clientName(MhsmRegionsListResult, "MHSMRegionsListResult");
