import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ServiceNetworking, "ServiceNetworkingMgmt", "python");
@@clientName(Microsoft.ServiceNetworking,
  "ServiceNetworkingManagementClient",
  "javascript"
);
@@clientName(Microsoft.ServiceNetworking,
  "TrafficControllerManagementClient",
  "java"
);
@@clientNamespace(Microsoft.ServiceNetworking,
  "com.azure.resourcemanager.servicenetworking",
  "java"
);
