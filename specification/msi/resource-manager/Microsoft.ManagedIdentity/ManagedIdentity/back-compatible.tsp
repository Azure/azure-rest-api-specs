import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

// Flatten properties for backward compatibility
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SystemAssignedIdentity.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Identity.properties,
  "autorest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IdentityUpdate.properties);

@@clientName(Identities.update,
  "Identities.update::parameters.properties",
  "parameters"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FederatedIdentityCredential.properties
);

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FederatedIdentityCredential.properties
);
