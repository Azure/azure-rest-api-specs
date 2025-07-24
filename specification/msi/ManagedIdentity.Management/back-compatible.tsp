import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IdentityUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SystemAssignedIdentity.properties);

@@clientLocation(Identities.get, "UserAssignedIdentities");
@@clientLocation(Identities.createOrUpdate, "UserAssignedIdentities");
@@clientName(Identities.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Identities.update, "UserAssignedIdentities");
@@clientName(Identities.update::parameters.properties, "parameters");
@@clientLocation(Identities.delete, "UserAssignedIdentities");
@@clientLocation(Identities.listByResourceGroup, "UserAssignedIdentities");
@@clientLocation(Identities.listBySubscription, "UserAssignedIdentities");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Identity.properties);

@@clientName(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FederatedIdentityCredential.properties);
