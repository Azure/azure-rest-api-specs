import "./models-shared.tsp";

namespace Azure.IoT.DeviceUpdate;

/** Update compliance information. */
model UpdateCompliance {
  /** Total number of devices. */
  totalDeviceCount: int32;

  /** Number of devices on the latest update. */
  onLatestUpdateDeviceCount: int32;

  /** Number of devices with a newer update available. */
  newUpdatesAvailableDeviceCount: int32;

  /** Number of devices with update in-progress. */
  updatesInProgressDeviceCount: int32;
}
