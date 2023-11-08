import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

@@client(Azure.IoT.DeviceUpdate.DeviceUpdateOperations,
  {
    name: "DeviceUpdateClient",
  }
);

@@client(Azure.IoT.DeviceUpdate.DeviceManagementOperations,
  {
    name: "DeviceManagementClient",
  }
);

@@client(Azure.IoT.DeviceUpdate.InstanceManagementOperations,
  {
    name: "InstanceManagementClient",
  }
);

@@projectedName(Azure.IoT.DeviceUpdate.DeviceManagementOperations.cancel,
  "client",
  "StopDeployment"
);

@@projectedName(Azure.IoT.DeviceUpdate.DeviceManagementOperations.retry,
  "client",
  "RetryDeployment"
);
