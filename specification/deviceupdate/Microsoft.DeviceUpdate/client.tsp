import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Azure.IoT.DeviceUpdate;

@@client(DeviceUpdate,
  {
    name: "DeviceUpdateClient",
  }
);

@@client(DeviceManagement,
  {
    name: "DeviceManagementClient",
  }
);

@@client(InstanceManagement,
  {
    name: "InstanceManagementClient",
  }
);

@@projectedName(DeviceUpdate.importUpdate, "csharp", "StartImportUpdate");