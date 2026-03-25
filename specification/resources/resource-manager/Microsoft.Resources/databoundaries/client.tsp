import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Resources, "DataBoundaryMgmtClient", "python");
@@clientName(Microsoft.Resources,
  "DataboundariesManegementClient",
  "javascript"
);
