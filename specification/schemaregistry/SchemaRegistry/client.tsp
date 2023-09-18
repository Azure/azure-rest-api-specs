import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, "private");
@@access(Azure.SchemaRegistry.SchemaGroup, "private");
