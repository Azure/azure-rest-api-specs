import "@typespec/http";

using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

@doc("OpenTelemetry endpoint properties")
@added(Versions.`2025-07-01-preview`)
model DataflowEndpointOpenTelemetry {
  @doc("The number of seconds to wait before sending metrics to the Open telemetry collector.")
  metricIntervalSec?: int32;

  @doc("Host of the OpenTelemetry in the form of <host>:<port>.")
  host: string;

  @doc("Batching configuration.")
  batching?: BatchingConfiguration;

  @doc("TLS configuration.")
  tls?: TlsProperties;
}