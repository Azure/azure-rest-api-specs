import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.flattenProperty(IdentityUpdate.properties);

// @@flattenProperty(SystemAssignedIdentity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.clientName(Identities.update,
  "Identities.update::parameters.properties",
  "parameters"
);
// @@flattenProperty(Identity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@Azure.ClientGenerator.Core.flattenProperty(FederatedIdentityCredential.properties
);
