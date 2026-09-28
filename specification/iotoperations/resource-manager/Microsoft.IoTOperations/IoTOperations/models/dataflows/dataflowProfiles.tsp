import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** ******************* */
/**
 * dataflowProfile resource type model details.
 */
@doc("Instance dataflowProfile resource")
@parentResource(InstanceResource)
model DataflowProfileResource is ProxyResource<DataflowProfileProperties> {
  @doc("Name of Instance dataflowProfile resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowProfileName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowProfiles")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @madeOptional(Versions.`2025-07-01-preview`)
  extendedLocation?: ExtendedLocation;
}

@doc("DataflowProfile Resource properties")
model DataflowProfileProperties {
  @doc("Spec defines the desired identities of NBC diagnostics settings.")
  diagnostics?: ProfileDiagnostics;

  @doc("To manually scale the dataflow profile, specify the maximum number of instances you want to run.")
  @minValue(1)
  @maxValue(20)
  instanceCount?: int32 = 1;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The status for the dataflow profile.")
  @added(Versions.`2026-03-01`)
  @typeChangedFrom(Versions.`2026-11-01-preview`, DataflowProfileStatusV1)
  status?: DataflowProfileStatus;

  #suppress "deprecated" "ResourceHealth is deprecated, use 'status.healthState' instead."
  ...ResourceHealth;
}

@doc("DataflowProfile Diagnostics properties")
model ProfileDiagnostics {
  ...MetricProperties;

  /**
   * Profile-wide debugging configuration shared by all dataflow graphs under this profile.
   * Defines where diagnostic events are published and how often they are sampled.
   * When omitted, no diagnostic infrastructure is created and any graph-level debugging opt-in is ignored.
   * Updates to this block take effect on running pods without triggering a restart.
   */
  @added(Versions.`2026-11-01-preview`)
  debuggingSettings?: ProfileDebuggingSettings;
}

/**
 * Profile-wide settings controlling how diagnostic events are emitted from dataflow graphs.
 * Individual graphs opt in to debugging; this block defines the shared destination and sampling policy they use.
 */
@added(Versions.`2026-11-01-preview`)
model ProfileDebuggingSettings {
  /** Destination where diagnostic events for opted-in graphs are published. Required when debugging is configured. */
  destinationSettings: ProfileDebuggingDestinationSettings;

  /**
   * Sampling policy that determines which messages produce diagnostic events as they traverse the pipeline.
   * When absent, no sampling-based diagnostics are emitted.
   */
  samplingPolicy?: ProfileDebuggingSamplingPolicy;
}

/** Destination configuration for diagnostic events emitted by debugging-enabled dataflow graphs. */
@added(Versions.`2026-11-01-preview`)
model ProfileDebuggingDestinationSettings {
  /**
   * Name of a DataflowEndpoint resource that diagnostic events are published to.
   * Only MQTT endpoints are supported in the initial release; the reference is rejected with an InvalidDataflow error otherwise.
   * Each event is published to the topic `diagnostics/{pipeline-name}` derived at publish time.
   */
  endpointRef: string;
}

/**
 * Sampling policy that selects which messages flowing through a dataflow graph are tagged for diagnostics.
 * Tagged messages carry a correlation ID that links every diagnostic event emitted during their traversal.
 * NOTE - only the settings property matching `method` is allowed per entry.
 */
@added(Versions.`2026-11-01-preview`)
model ProfileDebuggingSamplingPolicy {
  /** The sampling method. */
  method: ProfileDebuggingSamplingMethod;

  /** Settings controlling the count-based sampling cadence. */
  countSettings?: ProfileDebuggingCountSettings;
}

/** Supported sampling strategies for selecting messages to diagnose. */
@added(Versions.`2026-11-01-preview`)
union ProfileDebuggingSamplingMethod {
  string,

  /** Tag every Nth message flowing through the graph for diagnostics. */
  Count: "Count",
}

/** Settings controlling the cadence of count-based diagnostic sampling. */
@added(Versions.`2026-11-01-preview`)
model ProfileDebuggingCountSettings {
  /**
   * Emit diagnostic events for every Nth message processed by the graph (e.g. 100 emits diagnostics for one out of every 100 messages).
   */
  @minValue(1)
  nth: int64;
}

/** DataflowProfile status. */
@added(Versions.`2026-03-01`)
@removed(Versions.`2026-11-01-preview`)
@renamedFrom(Versions.`2026-11-01-preview`, "DataflowProfileStatus")
model DataflowProfileStatusV1 {
  /** The health state of the DataflowProfile. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}

/** Read-only runtime status reported by the service for a DataflowProfile. */
@added(Versions.`2026-11-01-preview`)
model DataflowProfileStatus {
  /** Aggregated health state of the DataflowProfile and the resources it manages. */
  @visibility(Lifecycle.Read)
  healthState?: ResourceHealthStatus;
}
