import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./devices.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

// ──────────────────────────────────────────────
// Device state resource
// ──────────────────────────────────────────────

/** Well-known device state names. */
union DeviceStateName {
  string,

  /** The default state of a device. */
  default: "default",

  /** The update state of a device. */
  update: "update",
}

/** A device state resource. */
@resource("states")
@parentResource(Device)
model DeviceState {
  ...OmitProperties<DataPlaneResourceBase, "name">;

  /** The name of the device state. */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: DeviceStateName;

  /** The owner that is permitted to write this device state (e.g. "Microsoft.DeviceUpdate"). */
  owner?: string;

  /** The resource-specific properties for this state. */
  properties?: DeviceStateProperties;
}

@@key(DeviceState.name, "stateName");

/** Base properties of a device state resource. The concrete shape is determined by `kind`. */
@discriminator("kind")
model DeviceStateProperties {
  /** The kind of device state, matching the resource `name`. */
  kind: DeviceStateName;
}

/** Properties of the default device state. */
model DefaultDeviceStateProperties extends DeviceStateProperties {
  /** Discriminator value for the default state. */
  kind: DeviceStateName.default;

  /** The desired state values. */
  desired?: Record<string>;

  /** The reported state values. */
  reported?: Record<string>;
}

/** Properties of the update device state, reported by the Azure Device Update agent. */
model UpdateDeviceStateProperties extends DeviceStateProperties {
  /** Discriminator value for the update state. */
  kind: DeviceStateName.update;

  /** The unique identifier of the device. */
  deviceUuid: uuid;

  /** The external identifier of the device. */
  externalDeviceId: string;

  /** The device class identifier, calculated by ADU from `agentInfo.compatibilityProperties` and `agentInfo.agentProfile`. */
  deviceClassId?: string;

  /** The identifier of the update currently installed on the device. */
  installedUpdateId?: DeviceUpdateId;

  /** The entity tag for the reported `agentInfo`. */
  agentInfoEtag?: string;

  /** Information reported by the device update agent. */
  agentInfo?: AgentInfo;

  /** Information about the most recent update job targeting this device. */
  latestUpdateJobInfo?: UpdateJobInfo;
}

// ──────────────────────────────────────────────
// Device update supporting models
// ──────────────────────────────────────────────

/** A unique identifier for an update referenced by the device update agent. */
model DeviceUpdateId {
  /** The provider of the update. */
  provider: string;

  /** The name of the update. */
  name: string;

  /** The version of the update. */
  version: string;
}

/** Information reported by the device update agent. */
model AgentInfo {
  /** Properties used to determine compatibility with available updates. */
  compatibilityProperties?: Record<string>;

  /** The agent profile identifier. */
  agentProfile?: int32;

  /** The version of the agent SDK in use on the device. */
  agentSdkVersion?: string;
}

/** Information about an update job targeting a device. */
model UpdateJobInfo {
  /** The identifier of the update job workflow. */
  workflowId: string;

  /** The current state of the update job. */
  state: UpdateJobState;

  /** The identifier of the update being applied by the job. */
  updateId: DeviceUpdateId;

  /** The result of installing the update on the device, if available. */
  installResult?: InstallResult;
}

/** The state of an update job on a device. */
union UpdateJobState {
  string,

  /** The update job completed successfully. */
  Succeeded: "Succeeded",

  /** The update job failed. */
  Failed: "Failed",

  /** The update job is in progress. */
  InProgress: "InProgress",

  /** The update job was canceled. */
  Canceled: "Canceled",
}

/** The result of installing an update on a device. */
model InstallResult {
  /** Whether the overall installation succeeded. */
  succeeded?: boolean;

  /** Error details for the overall installation, if it did not succeed. */
  errorDetails?: ErrorDetails;

  /** Per-step results for the installation. */
  stepResults?: StepResult[];
}

/** The result of an individual installation step. */
model StepResult {
  /** The identifier of the update applied in this step. */
  updateId: DeviceUpdateId;

  /** Whether this step succeeded. */
  succeeded?: boolean;

  /** Error details for this step, if it did not succeed. */
  errorDetails?: ErrorDetails;
}

/** Details about an error that occurred during update installation. */
model ErrorDetails {
  /** The category of the error, used to determine accountability and remediation. */
  errorCategory?: ErrorCategory;

  /** A numeric code identifying the specific error. */
  errorCode?: int32;

  /** A human-readable message describing the error. */
  errorMessage?: string;
}

/** The category of an update installation error. */
union ErrorCategory {
  string,

  /** Transient networking or service-side condition; the agent may retry the operation. */
  RETRYABLE: "RETRYABLE",

  /** The update metadata is invalid or incompatible; the service must fix the update. */
  SERVICE: "SERVICE",

  /** Device-local state prevents the update; may self-resolve or require operator action. */
  DEVICE_CONDITION: "DEVICE_CONDITION",

  /** Device resource or hardware problem requiring operator intervention. */
  DEVICE_FAULT: "DEVICE_FAULT",

  /** Agent implementation error; should not occur in production. */
  AGENT_FAULT: "AGENT_FAULT",

  /** Cryptographic or integrity validation failure requiring investigation. */
  SECURITY: "SECURITY",
}

// ──────────────────────────────────────────────
// Device states interface
// ──────────────────────────────────────────────

/** CRUD operations on device states. */
@tag("Device States")
interface DeviceStates {
  /** Create or replace a device state. */
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceState>;

  /** Get a device state. */
  get is ResourceOperations.ResourceRead<DeviceState>;

  /** Update a device state. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceState>;

  /** List device states for a device. */
  list is ResourceOperations.ResourceList<DeviceState>;
}
