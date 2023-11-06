import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@client(Microsoft.DeviceUpdate.DeviceUpdateOperations, {
  name: "DeviceUpdateClient",
});

@@client(Microsoft.DeviceUpdate.DeviceManagementOperations, {
  name: "DeviceManagementClient",
});