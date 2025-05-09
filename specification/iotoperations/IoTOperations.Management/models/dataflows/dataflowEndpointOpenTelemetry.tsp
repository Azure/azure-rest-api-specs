import "@typespec/http";

using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

/** OpenTelemetry endpoint properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowEndpointOpenTelemetry {
  /** The number of seconds to wait before sending metrics to the Open telemetry collector. */
  metricIntervalSec?: int32;

  /** Host of the OpenTelemetry in the form of <host>:<port>. */
  host: string;

  /** Batching configuration. */
  batching?: BatchingConfiguration;

  /** TLS configuration. */
  tls?: TlsProperties;
}
