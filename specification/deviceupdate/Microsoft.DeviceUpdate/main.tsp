import "@typespec/http";
import "@typespec/versioning";

import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

/**
 * Device Update for IoT Hub is an Azure service that enables customers to publish
 * updates for their IoT devices to the cloud, and then deploy that update to
 * their devices (approve updates to groups of devices managed and provisioned in
 * IoT Hub). It leverages the proven security and reliability of the Windows
 * Update platform, optimized for IoT devices. It works globally and knows when
 * and how to update devices, enabling customers to focus on their business goals
 * and let Device Update for IoT Hub handle the updates.
 */
@service({
  title: "DeviceUpdateClient",
})
@server(
  "https://{endpoint}",
  "Device Update for IoT Hub is an Azure service that enables customers to publish updates for their IoT devices to the cloud, and then deploy that update to their devices (approve updates to groups of devices managed and provisioned in IoT Hub). It leverages the proven security and reliability of the Windows Update platform, optimized for IoT devices. It works globally and knows when and how to update devices, enabling customers to focus on their business goals and let Device Update for IoT Hub handle the updates.",
  {
    endpoint: string,
  }
)
@versioned(Microsoft.DeviceUpdate.Versions)
namespace Microsoft.DeviceUpdate;

/** Device update service versions */
enum Versions {
  /** The 2023-10-01-preview version of the Microsoft.DeviceUpdate service. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2023-10-01-preview`,
}
