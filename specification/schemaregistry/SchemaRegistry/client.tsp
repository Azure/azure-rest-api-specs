import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, "internal");
@@access(Azure.SchemaRegistry.SchemaGroup, "internal");
