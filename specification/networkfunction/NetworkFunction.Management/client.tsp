import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.NetworkFunction,
  "AzureTrafficCollectorClient",
  "javascript"
);

@@clientName(Microsoft.NetworkFunction, "TrafficCollectorMgmtClient", "python");
