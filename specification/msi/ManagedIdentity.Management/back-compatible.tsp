import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(IdentityUpdate.properties);

@@clientName(Identities.update,
  "Identities.update::parameters.properties",
  "parameters"
);

#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FederatedIdentityCredential.properties);

@@clientLocation(Identities.get, "UserAssignedIdentities");
@@clientLocation(Identities.createOrUpdate, "UserAssignedIdentities");
@@clientName(Identities.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Identities.update, "UserAssignedIdentities");
@@clientName(Identities.update::parameters.properties, "parameters");
@@clientLocation(Identities.delete, "UserAssignedIdentities");
@@clientLocation(Identities.listByResourceGroup, "UserAssignedIdentities");
@@clientLocation(Identities.listBySubscription, "UserAssignedIdentities");
@@clientName(FederatedIdentityCredentials.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FederatedIdentityCredential.properties);
