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
@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
      scopes: ["https://api.adu.microsoft.com/.default"],
    }
  ]>
)
@service({
  title: "DeviceUpdateClient",
})
@server(
  "https://{endpoint}/deviceUpdate/{instanceId}",
  "Device Update for IoT Hub is an Azure service that enables customers to publish updates for their IoT devices to the cloud, and then deploy that update to their devices (approve updates to groups of devices managed and provisioned in IoT Hub). It leverages the proven security and reliability of the Windows Update platform, optimized for IoT devices. It works globally and knows when and how to update devices, enabling customers to focus on their business goals and let Device Update for IoT Hub handle the updates.",
  {
    /** The Device Update for IoT Hub account endpoint (hostname only, no protocol). */
    endpoint: string,

    /** The Device Update for IoT Hub account instance identifier. */
    instanceId: string,
  }
)
@versioned(Azure.IoT.DeviceUpdate.Versions)
namespace Azure.IoT.DeviceUpdate;

/** Device Update service versions */
enum Versions {
  /** The 2023-10-01-preview version of the Azure.IoT.DeviceUpdate service. */
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2023-10-01-preview`,
}
