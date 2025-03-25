import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KeyVault;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnectionItem.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MhsmPrivateEndpointConnectionItem.properties);

@@clientName(Error.innererror, "innerError");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MhsmPrivateLinkResource.properties);

@@clientName(Attributes.nbf, "notBefore");
@@clientName(Attributes.exp, "expires");

@@clientName(KeyProperties.release_policy, "releasePolicy");

@@clientName(KeyAttributes.nbf, "notBefore");
@@clientName(KeyAttributes.exp, "expires");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Key.properties);

@@clientName(ManagedHsmKeyProperties.release_policy, "releasePolicy");

@@clientName(ManagedHsmKeyAttributes.nbf, "notBefore");
@@clientName(ManagedHsmKeyAttributes.exp, "expires");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedHsmKey.properties);

@@clientName(Vaults.createOrUpdate::parameters.resource, "parameters");
@@clientName(Vaults.update::parameters.properties, "parameters");
@@clientName(Vaults.updateAccessPolicy::parameters.body, "parameters");

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
