import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@client(Azure.IoT.DeviceUpdate.DeviceUpdate,
  {
    name: "DeviceUpdateClient",
  }
);

@@client(Azure.IoT.DeviceUpdate.DeviceManagement,
  {
    name: "DeviceManagementClient",
  }
);

@@client(Azure.IoT.DeviceUpdate.InstanceManagement,
  {
    name: "InstanceManagementClient",
  }
);
