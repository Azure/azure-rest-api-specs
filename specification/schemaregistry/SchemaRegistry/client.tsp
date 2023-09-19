import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
 
using Azure.ClientGenerator.Core;

@@access(Azure.SchemaRegistry.Version, Access.internal);
@@access(Azure.SchemaRegistry.SchemaGroup, Access.internal);
