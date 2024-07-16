import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DevOpsInfrastructure;

@@clientName(Microsoft.DevOpsInfrastructure,
  "DevOpsInfrastructureMgmt",
  "python"
);
@@access(Operations.list, Access.internal, "csharp");
