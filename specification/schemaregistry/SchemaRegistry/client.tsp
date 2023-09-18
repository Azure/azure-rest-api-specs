import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@exclude(Azure.SchemaRegistry.Version);
@@exclude(Azure.SchemaRegistry.SchemaGroup);
