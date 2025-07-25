import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.ManagedIdentity;

#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.flattenProperty(IdentityUpdate.properties);

#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.clientName(Identities.update,
  "Identities.update::parameters.properties",
  "parameters"
);

#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.flattenProperty(FederatedIdentityCredential.properties
);
