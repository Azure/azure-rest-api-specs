import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Microsoft.HybridConnectivity,
  "com.azure.resourcemanager.hybridconnectivity",
  "java"
);

@@clientName(Microsoft.HybridConnectivity, "HybridConnectivityMgmt", "python");

@@clientName(Microsoft.HybridConnectivity, "HybridConnectivityMgmtClient", "java");
