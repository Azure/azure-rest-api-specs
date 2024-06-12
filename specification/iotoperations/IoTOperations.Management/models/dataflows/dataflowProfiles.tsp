import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;


/** ******************* */
/**
 * dataflowProfile resource type model details.
 */
@doc("Instance dataflowProfile resource")
@parentResource(InstanceResource)
model DataFlowProfileResource is TrackedResource<DataFlowProfileProperties> {
  @doc("Name of Instance dataflowProfile resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowProfileName")
  @path
  @segment("dataflowProfiles")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("DataFlowProfile Resource properties")
model DataFlowProfileProperties {
  @doc("Spec defines the desired identities of NBC diagnostics settings.")
  diagnostics?: DataFlowProfileDiagnostics;

  @doc("To manually scale the dataflow profile, specifcy the maximum number of instances you want to run.")
  @minValue(1)
  @maxValue(10)
  maxInstances?: int32;

  @doc("Node tolerations. Optional; see https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/.")
  tolerations?: NodeTolerations;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataFlowProfile Diagnostics properties")
model DataFlowProfileDiagnostics {
  @doc("The format for the logs generated.")
  logFormat?: string = "text";

  @doc("The level for the logs generated.")
  logLevel?: string = "info";

  @doc("The metrics settings for the dataflow.")
  metrics?: DataFlowProfileDiagnosticsMetrics;

  @doc("The traces settings for the dataflow.")
  traces?: DataFlowProfileDiagnosticsTraces;
}

@doc("Mode properties")
union Mode {
  string,

  @doc("Mode is equivalent to True")
  Enabled: "Enabled",

  @doc("Mode is equivalent to False.")
  Disabled: "Disabled",
}

@doc("DataFlowProfile Diagnostics Metrics properties")
model DataFlowProfileDiagnosticsMetrics {
  @doc("The time used to determine if a metric is stale and drop from the metrics cache.")
  @minValue(60)
  @maxValue(600)
  cacheTimeoutSeconds?: int32 = 600;

  @doc("The mode for metrics.")
  mode?: Mode = Mode.Enabled;

  @doc("How often to export the metrics to the open telemetry collector.")
  @minValue(1)
  @maxValue(300)
  exportIntervalSeconds?: int32 = 30;

  @doc("The open telemetry collector endpoint to export to.")
  openTelemetryCollectorAddress?: string;

  @doc("The prometheus port for the metrics.")
  @minValue(0)
  @maxValue(65535)
  prometheusPort?: int32 = 9600;

  @doc("How often to refresh the metrics.")
  @minValue(1)
  @maxValue(60)
  updateIntervalSeconds?: int32 = 30;
}

@doc("DataFlowProfile Diagnostics Traces properties")
model DataFlowProfileDiagnosticsTraces {
  @doc("The cache size in megabytes.")
  @minValue(1)
  @maxValue(128)
  cacheSizeMegabytes?: int32 = 16;

  @doc("The mode for traces.")
  mode?: Mode = Mode.Enabled;

  @doc("How often to export the metrics to the open telemetry collector.")
  @minValue(1)
  @maxValue(300)
  exportIntervalSeconds?: int32 = 30;

  @doc("The openTelemetryCollectorAddress for the traces.")
  openTelemetryCollectorAddress?: string;

  @doc("The selfTracing settings for the traces.")
  selfTracing?: DataFlowProfileDiagnosticsTracesSelfTracing;

  @doc("The span channel capacity.")
  @minValue(1000)
  @maxValue(100000)
  spanChannelCapacity?: int32 = 1000;
}

@doc("DataFlowProfile Diagnostics Traces SelfTracing properties")
model DataFlowProfileDiagnosticsTracesSelfTracing {
  @doc("The mode for selfTracing.")
  mode?: Mode = Mode.Enabled;

  @doc("The self tracing interval.")
  @minValue(1)
  @maxValue(300)
  intervalSeconds?: int32 = 30;
}