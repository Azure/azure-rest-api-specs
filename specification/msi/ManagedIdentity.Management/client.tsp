import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

@@clientName(Microsoft.ManagedIdentity,
  "ManagedServiceIdentityClient",
  "javascript, java"
);

#suppress "deprecated" "FIXME: added in TypeSpec migration, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Identity.properties, "java");
