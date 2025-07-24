import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(IdentityUpdate.properties);

// @@flattenProperty(SystemAssignedIdentity.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@clientName(Identities.update,
  "Identities.update::parameters.properties",
  "parameters"
);
// @@flattenProperty(Identity.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FederatedIdentityCredential.properties);
