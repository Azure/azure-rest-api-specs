import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "./devices.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

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

  /** Reported by a customer. */
  User: "User",
}

/**
 * A device attribute resource stores cloud-side metadata for a device, such as software versions reported
 * by Azure Device Update or user-defined device attribution used to select the devices during management
 * workflows. It is separate from live device telemetry.
 */
@resource("attributes")
@parentResource(Device)
@discriminator("reportedBy")
model DeviceAttribute {
  ...OmitProperties<DataPlaneResourceBase, "name">;

  /** The name of the device attribute. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: DeviceAttributeName;

  /**
   * The UUID of the device that this attribute belongs to. Used to verify that the device attribute
   * matches the reverse lookup document and is not for an older device that was deleted and
   * re-created with the same `deviceName`.
   */
  @visibility(Lifecycle.Read)
  deviceUuid?: string;

  /** The cloud service that reports this device attribute. */
  reportedBy: DeviceAttributeReportedBy;
}

@@key(DeviceAttribute.name, "attributeName");

/** A device attribute reported by Azure Device Update. */
model UpdateDeviceAttribute extends DeviceAttribute {
  /** Discriminator value for an Azure Device Update reported attribute. */
  reportedBy: DeviceAttributeReportedBy.ADU;

  /** Properties reported by Azure Device Update. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "`UpdateDeviceAttributeProperties` is an open model (spreads `Record<unknown>`) so it can tolerate future ADU-added fields; `Record<string>` would be semantically wrong because the bag contains nested objects, ints, and arrays."
  properties?: UpdateDeviceAttributeProperties;
}

/**
 * A device attribute reported by a customer or other non-Microsoft caller. The `properties` bag
 * is opaque — the service stores customer-defined fields verbatim and returns them on read.
 * The service does not interpret, validate, or constrain the bag's contents.
 */
model UserDeviceAttribute extends DeviceAttribute {
  /** Discriminator value for a customer-reported attribute. */
  reportedBy: DeviceAttributeReportedBy.User;

  /** Customer-defined opaque property bag. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "`UserDeviceAttributeProperties` is `Record<unknown>` so customers can supply arbitrary fields including nested objects, ints, and arrays; `Record<string>` would be semantically wrong."
  properties?: UserDeviceAttributeProperties;
}

/**
 * Customer-defined opaque property bag for a `User`-reported device attribute. Any field shape
 * is accepted; the service stores and returns the bag verbatim without inspection. Customers
 * who want to advertise a schema for their bag may include their own field (e.g. `$schema`).
 */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Customer-defined opaque bag; arbitrary value types must be accepted."
model UserDeviceAttributeProperties is Record<unknown>;

/** Properties of the update device attribute, reported by the Azure Device Update agent. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "Open model: spreads `Record<unknown>` so future ADU-added fields are tolerated without an SDK rebuild."
model UpdateDeviceAttributeProperties {
  // Spread Record<unknown> so future ADU-added fields are tolerated without an SDK rebuild.
  ...Record<unknown>;

  /**
   * URL of the JSON Schema document describing the concrete shape of this property bag. Optional
   * advertisement so clients can validate the bag without out-of-band documentation. The service
   * does not validate or dereference this field — any string is accepted. Suggested value:
   * `https://raw.githubusercontent.com/Azure/azure-rest-api-specs/<commit-sha>/specification/deviceregistry/schemas/UpdateDeviceAttributeProperties.json`
   */
  schema?: url;

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

/**
 * The terminal result of an update attempt as reported by the device update agent.
 */
model InstallResult {
  /** Authoritative terminal outcome of the update attempt. */
  outcome: InstallResultOutcome;

  /** Best-effort hint identifying which subsystem produced the failure. Value is `NOT_APPLICABLE` for successful install. */
  failureOrigin: InstallResultFailureOrigin;

  /** Result code representing an install result. 0 or negative failures designate failures, positive values indicate success. */
  resultCode: int64;

  /** Comma-separated list of agent ExtendedResultCode (ERC) values for diagnostic correlation. Each value is the unsigned hexadecimal representation of an `int32`. */
  @maxLength(1024)
  extendedResultCodes: string;

  /** Human-readable result details. */
  @maxLength(1024)
  resultDetails?: string;

  /** Per-step results of the steps defined by the manifest's `instructions.steps`. */
  @maxItems(10)
  stepResults?: UpdateStepResult[];
}

/** The terminal result of an individual installation step. */
model UpdateStepResult {
  /** The identifier of the leaf update worked on by this step. ADU resolves this from the manifest's `instructions.steps` (inline step → parent updateId; reference step → child updateId). */
  updateId: DeviceUpdateId;

  /** Authoritative terminal outcome of this step. */
  outcome: InstallResultOutcome;

  /** Best-effort hint identifying which subsystem produced the failure for this step. Value is `NOT_APPLICABLE` for successful install. */
  failureOrigin: InstallResultFailureOrigin;

  /** Step-level install result code. Same semantics as `InstallResult.resultCode`. */
  resultCode: int64;

  /** Step-level extended result codes. Same format as `InstallResult.extendedResultCodes`. */
  @maxLength(1024)
  extendedResultCodes: string;

  /** Human-readable result details for this step. */
  @maxLength(1024)
  resultDetails?: string;
}

/** Authoritative terminal outcome of an update attempt or step, as reported by the device update agent. */
union InstallResultOutcome {
  string,

  /** The step or workflow completed successfully. */
  Succeeded: "SUCCEEDED",

  /** The step or workflow failed. */
  Failed: "FAILED",

  /** The step or workflow was canceled before reaching a terminal state. */
  Canceled: "CANCELED",

  /** The step was skipped because it was not required. */
  Skipped: "SKIPPED",
}

/** Best-effort hint identifying which subsystem produced an install failure. */
union InstallResultFailureOrigin {
  string,

  /** Failure communicating with the ADU cloud service. */
  AduCloudService: "ADU_CLOUD_SERVICE",

  /** Failure related to ADU managed resources. (e.g. CDN download failure) */
  AduManagedResource: "ADU_MANAGED_RESOURCE",

  /** Failure in the ADU agent core components (workflow, state machine, manifest parsing, common utilities). */
  AgentCore: "AGENT_CORE",

  /** Failure in a customer-supplied content handler or extension code (content handler, communication provider, log provider, component enumerator). The ADU agent core functioned correctly. */
  AgentExtension: "AGENT_EXTENSION",

  /** Failure in an agent dependency (e.g. local identity service). */
  AgentDependency: "AGENT_DEPENDENCY",

  /** Device-side problem — storage, battery, hardware fault, transient device condition (busy, maintenance mode), permissions. */
  Device: "DEVICE",

  /** Failure origin does not fit into any of the predefined categories. This is also used as the default failure origin. */
  Other: "OTHER",

  /** This failure origin must be used for non-failed result outcomes. */
  NotApplicable: "NOT_APPLICABLE",
}

// ──────────────────────────────────────────────
// Device attributes interface
// ──────────────────────────────────────────────

/** Operations on device attributes. */
@tag("Device Attributes")
interface DeviceAttributes {
  /** Create or replace a device attribute. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  createOrReplace is ResourceOperations.ResourceCreateOrReplace<DeviceAttribute>;

  /** Get a device attribute. */
  get is ResourceOperations.ResourceRead<DeviceAttribute>;

  /** Update a device attribute. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  update is ResourceOperations.ResourceCreateOrUpdate<DeviceAttribute>;

  /** Delete a device attribute. */
  @added(Versions.v2026_11_02_preview) // Private Preview (Internal) at Ignite
  delete is ResourceOperations.ResourceDelete<DeviceAttribute>;

  /** List device attributes for a device. */
  list is ResourceOperations.ResourceList<DeviceAttribute>;
}
