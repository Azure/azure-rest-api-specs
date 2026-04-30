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
// Device attribute resource
// ──────────────────────────────────────────────

/** Well-known device attribute names. */
union DeviceAttributeName {
  string,

  /** The update attribute of a device. */
  update: "update",
}

/** The cloud service that reports a device attribute. */
union DeviceAttributeReportedBy {
  string,

  /** Reported by Azure Device Update. */
  ADU: "Microsoft.DeviceUpdate",
}

/** A device attribute resource that holds properties managed by cloud services and not sent to the device. */
@resource("attributes")
@parentResource(Device)
@discriminator("reportedBy")
model DeviceAttribute {
  ...OmitProperties<DataPlaneResourceBase, "name">;

  /** The name of the device attribute. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: DeviceAttributeName;

  /** The cloud service that reports this device attribute. */
  reportedBy: DeviceAttributeReportedBy;
}

@@key(DeviceAttribute.name, "attributeName");

/** A device attribute reported by Azure Device Update. */
model UpdateDeviceAttribute extends DeviceAttribute {
  /** Discriminator value for an Azure Device Update reported attribute. */
  reportedBy: DeviceAttributeReportedBy.ADU;

  /** Properties reported by Azure Device Update. */
  properties: UpdateDeviceAttributeProperties;
}

/** Properties of the update device attribute, reported by the Azure Device Update agent. */
model UpdateDeviceAttributeProperties {
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
  errorDetails?: DeviceUpdateError;

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
  errorDetails?: DeviceUpdateError;
}

/**
 * Details about an error that occurred during update installation.
 *
 * Follows the standard Azure / OData error shape (`Azure.Core.Foundations.Error`):
 * - `code` carries the error category (constrained to a known set, but extensible).
 * - `message` is the human-readable description of the failure.
 * - `innererror.code` carries the agent-reported numeric error code as a string.
 */
model DeviceUpdateError {
  ...OmitProperties<Azure.Core.Foundations.Error, "code">;

  /** The category of the error, used to determine accountability and remediation. */
  code: ErrorCategory;
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
// Device attributes interface
// ──────────────────────────────────────────────

/** CRUD operations on device attributes. */
@tag("Device Attributes")
interface DeviceAttributes {
  /** Create or replace a device attribute. */
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceAttribute>;

  /** Get a device attribute. */
  get is ResourceOperations.ResourceRead<DeviceAttribute>;

  /** Update a device attribute. */
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceAttribute>;

  /** List device attributes for a device. */
  list is ResourceOperations.ResourceList<DeviceAttribute>;
}
