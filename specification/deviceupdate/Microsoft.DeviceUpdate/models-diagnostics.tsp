import "./models-shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.DeviceUpdate;

/** Diagnostics request body */
@resource("management/deviceDiagnostics/logCollections")
model LogCollection {
  /** The log collection id. */
  @key
  @path
  @visibility("read")
  operationId: string;

  /** Array of Device Update agent ids */
  deviceList: DeviceUpdateAgentId[];

  /** Description of the diagnostics operation. */
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

/** The list of log collections with detailed status, with server paging support. */
model LogCollectionDetailedStatusList {
  /** The collection of pageable items. */
  value: LogCollectionOperationDetailedStatus[];

  /** The link to the next page of items. */
  nextLink?: string;
}

/** Device diagnostics operation detailed status */
model LogCollectionOperationDetailedStatus {
  /** The device diagnostics operation id. */
  @projectedName("json", "operationId")
  logCollectionId?: string;

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
