import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

/** Device metadata. */
@resource("management/devices")
model Device {
  /** Device identity. */
  @key
  @path
  @visibility("read")
  deviceId: string;

  /** Device module identity. */
  moduleId?: string;

  /** Device class identity. */
  deviceClassId: string;

  /** Device group identity. */
  groupId?: string;

  /** The update that device last attempted to install. */
  lastAttemptedUpdate?: UpdateInfo;

  /** State of the device in its last deployment. */
  deploymentStatus?: DeviceDeploymentState;

  /** Currently installed update on device. */
  installedUpdate?: UpdateInfo;

  /**
   * Boolean flag indicating whether the latest update (the best compatible update
   * for the device's device class and group) is installed on the device
   */
  onLatestUpdate: boolean;

  /** The deployment identifier for the last deployment to the device */
  lastDeploymentId?: string;

  /** Last install result. */
  lastInstallResult?: InstallResult;
}

/** The install result of an update and any step results under it. */
model InstallResult {
  /** Install result code. */
  resultCode: int32;

  /** Install extended result code */
  extendedResultCode: int32;

  /** A string containing further details about the install result */
  resultDetails?: string;

  /** Array of step results */
  stepResults?: StepResult[];
}

/** The step result under an update. */
model StepResult {
  /** The update that this step installs if it is of reference type. */
  update?: UpdateInfo;

  /** Step description. */
  description?: string;

  /** Install result code. */
  resultCode: int32;

  /** Install extended result code */
  extendedResultCode: int32;

  /** A string containing further details about the install result */
  resultDetails?: string;
}

/** Device Health */
@resource("management/deviceDiagnostics/deviceHealth")
model DeviceHealth {
  /** Device id */
  @key
  @path
  @visibility("read")
  deviceId: string;

  /** Module id */
  moduleId?: string;

  /** Aggregate device health state */
  state: DeviceHealthState;

  /** Digital twin model Id */
  digitalTwinModelId?: string;

  /** Array of health checks and their results */
  healthChecks: HealthCheck[];
}

/** Device health state */
enum DeviceHealthState {
  /** Agent is healthy */
  healthy,

  /** Agent is in an unhealthy state */
  unhealthy,
}

/** Health check */
model HealthCheck {
  /** Health check name */
  name?: string;

  /** Health check result */
  result?: HealthCheckResult;
}

/** Health check result */
enum HealthCheckResult {
  /** Health check succeeded */
  success,

  /** Health check failed due to user error */
  userError,
}

/** Device filter. */
model DeviceFilter {
  /** Device group identity. */
  groupId?: string;

  /** Device class identity. */
  deviceClassId?: string;

  /** State of the device in its last deployment. */
  deploymentStatus?: DeviceDeploymentState;
}

/** Device health filter. */
model DeviceHealthFilter {
  /** Device health state */
  state?: DeviceHealthState;

  /** Device Id */
  deviceId?: string;

  /** Module Id */
  moduleId?: string;
}

/** Operation metadata. */
@resource("management/operations")
model DeviceOperation {
  /** Operation Id. */
  @key
  @path
  @visibility("read")
  operationId: string;

  /** Operation status. */
  status: OperationStatus;

  /** Operation error encountered, if any. */
  error?: Azure.Core.Foundations.Error;

  /** Operation correlation identity that can used by Microsoft Support for troubleshooting. */
  traceId?: string;

  /** Date and time in UTC when the operation status was last updated. */
  lastActionDateTime: utcDateTime;

  /** Date and time in UTC when the operation was created. */
  createdDateTime: utcDateTime;

  /** Operation ETag. */
  etag?: string;
}

/** Import type */
enum ImportType {
  /** Import only devices but not modules. */
  Devices,

  /** Import only modules but not devices. */
  Modules,

  /** Import both devices and modules. */
  All,
}
