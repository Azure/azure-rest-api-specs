import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Microsoft.DeviceRegistry,
  "com.azure.resourcemanager.deviceregistry",
  "java"
);
@@clientName(Microsoft.DeviceRegistry, "DeviceRegistryMgmt", "python");
@@clientName(Microsoft.DeviceRegistry,
  "DeviceRegistryManagementClient",
  "java"
);
