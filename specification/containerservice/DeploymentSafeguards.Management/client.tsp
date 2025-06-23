import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ContainerService,
  "ContainerServiceSafeguardsMgmtClient",
  "python"
);
