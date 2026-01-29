import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

@@clientName(Microsoft.ManagedIdentity,
  "ManagedServiceIdentityClient",
  "javascript, java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Identity.properties,
  "java"
);
