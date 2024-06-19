import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

@doc("Extended location is an extension of Azure locations. They provide a way to use their Azure ARC enabled Kubernetes clusters as target locations for deploying Azure services instances.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name: string;

  @doc("Type of ExtendedLocation.")
  type: ExtendedLocationType;
}

@doc("The enum defining type of ExtendedLocation accepted.")
union ExtendedLocationType {
  string,

  @doc("CustomLocation type")
  "CustomLocation",
}

@doc("The enum defining status of resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is getting provisioned.")
  Provisioning: "Provisioning",

  @doc("Resource is Updating.")
  Updating: "Updating",

  @doc("Resource is Deleting.")
  Deleting: "Deleting",

  @doc("Resource has been Accepted.")
  Accepted: "Accepted",
}

@doc("Mode properties")
union Mode {
  string,

  @doc("Enabled is equivalent to True")
  Enabled: "Enabled",

  @doc("Disabled is equivalent to False.")
  Disabled: "Disabled",
}

@doc("X509 Certificate Authentication properties.")
model X509ManualCertificate {
  @doc("Kubernetes secret containing an X.509 client certificate. This is a reference to the secret through an identifying name, not the secret itself.")
  secretName: string;

  @doc("Certificate K8S namespace. Omit to use current namespace.")
  secretNamespace?: string;
}

@doc("Diagnostic Setting properties")
model Diagnostics {
  @doc("The log settings.")
  logs?: DiagnosticsLogs;

  @doc("The metrics properties.")
  metrics?: Metrics;

  @doc("The self check properties.")
  selfCheck?: SelfCheck;

  @doc("The trace properties.")
  traces?: Traces;
}

@doc("Diagnostic Log properties")
model DiagnosticsLogs {
  @doc("How often to export the logs to the open telemetry collector.")
  @minValue(1)
  @maxValue(300)
  exportIntervalSeconds?: int32 = 30;

  @doc("The level of logs to export.")
  exportLogLevel?: string = "error";

  @doc("The log level. Examples - 'debug', 'info', 'warn', 'error', 'trace'.")
  level?: string = "info";

  @doc("The open telemetry collector endpoint to export to.")
  openTelemetryCollectorAddress?: string;
}


@doc("Diagnostic Metrics properties")
model Metrics {
  @doc("The time used to determine if a metric is stale and drop from the metrics cache.")
  @minValue(60)
  @maxValue(600)
  stalenessTimeSeconds?: int32 = 600;

  @doc("The toggle to enable/disable metrics.")
  mode?: Mode = Mode.Enabled;

  @doc("How often to export the metrics to the open telemetry collector.")
  @minValue(1)
  @maxValue(300)
  exportIntervalSeconds?: int32 = 30;

  @doc("The open telemetry collector endpoint to export to.")
  openTelemetryCollectorAddress?: string;

  @doc("The prometheus port to expose the metrics.")
  @minValue(0)
  @maxValue(65535)
  prometheusPort?: int32 = 9600;

  @doc("How often to refresh the metrics.")
  @minValue(1)
  @maxValue(60)
  updateIntervalSeconds?: int32 = 30;
}
@doc("Diagnostic Self tracing properties")
model SelfTracing {
  @doc("The toggle to enable/disable self tracing.")
  mode?: Mode = Mode.Enabled;

  @doc("The self tracing interval.")
  @minValue(1)
  @maxValue(300)
  intervalSeconds?: int32 = 30;
}

@doc("Batching configuration")
model BatchingConfiguration {
  @doc("Batching latency in seconds.")
  @minValue(0)
  @maxValue(65535)
  latencySeconds?: int32 = 60;

  @doc("Maximum number of messages in a batch.")
  @minValue(0)
  @maxValue(4294967295)
  maxMessages?: int32 = 100000;
}