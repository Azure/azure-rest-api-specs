import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.ManagedIdentity;

@@clientName(Microsoft.ManagedIdentity,
  "ManagedServiceIdentityClient",
  "javascript, java"
);

@@flattenProperty(Identity.properties, "java");
