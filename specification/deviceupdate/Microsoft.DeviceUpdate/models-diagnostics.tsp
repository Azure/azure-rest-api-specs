import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.IoT.DeviceUpdate;

/** Diagnostics request body */
@resource("management/deviceDiagnostics/logCollections")
model LogCollection {
  /** The log collection id. */
  @key
  @visibility("read", "create")
  operationId: string;

  /** Array of Device Update agent ids */
  @visibility("read", "create")
  deviceList: DeviceUpdateAgentId[];

  /** Description of the diagnostics operation. */
  @visibility("read", "create")
  description?: string;

  /** The timestamp when the operation was created. */
  @visibility("read")
  createdDateTime?: string;

  /** A timestamp for when the current state was entered. */
  @visibility("read")
  lastActionDateTime?: string;

  /** Operation status. */
  @visibility("read")
  status?: OperationStatus;
}

/** Device Update agent id */
model DeviceUpdateAgentId {
  /** Device Id */
  deviceId: string;

  /** Module Id */
  moduleId?: string;
}

/** Device diagnostics operation detailed status */
model LogCollectionOperationDetailedStatus {
  /** The device diagnostics operation id. */
  operationId?: string;

  /** The timestamp when the operation was created. */
  createdDateTime?: string;

  /** A timestamp for when the current state was entered. */
  lastActionDateTime?: string;

  /** Operation status. */
  status?: OperationStatus;

  /** Status of the devices in the operation */
  deviceStatus?: LogCollectionOperationDeviceStatus[];

  /** Device diagnostics operation description. */
  description?: string;
}

/** Diagnostics operation device status */
model LogCollectionOperationDeviceStatus {
  /** Device id */
  deviceId: string;

  /** Module id. */
  moduleId?: string;

  /** Log upload status */
  status: OperationStatus;

  /** Log upload result code */
  resultCode?: string;

  /** Log upload extended result code */
  extendedResultCode?: string;

  /** Log upload location */
  logLocation?: string;
}
