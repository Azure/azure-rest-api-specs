import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@client(Azure.IoT.DeviceUpdate.DeviceUpdateOperations, {
  name: "DeviceUpdateClient",
});

@@client(Azure.IoT.DeviceUpdate.DeviceManagementOperations, {
  name: "DeviceManagementClient",
});