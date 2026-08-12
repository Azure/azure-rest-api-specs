import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Resources, "DataBoundaryMgmtClient", "python");
@@clientName(
  Microsoft.Resources,
  "DataboundariesManegementClient",
  "javascript"
);

@@clientName(Microsoft.Resources, "DataBoundariesManagementClient", "java");
@@scope(Microsoft.Resources.Operations.list, "!java");
