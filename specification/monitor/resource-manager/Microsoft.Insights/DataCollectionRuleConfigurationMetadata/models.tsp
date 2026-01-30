import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ResourceManager;

/** Request body for fetching configuration metadata. */
model DataCollectionRuleConfigurationMetadataRequest {
  /** DCR Kind for which metadata is being requested (e.g., PlatformTelemetry). */
  dcrKind?: string;

  /** Optional resource type filter (e.g., Microsoft.Compute/virtualMachines). If specified, returns configuration metadata for that resource type. */
  resourceType?: string;

  /** When true, returns detailed stream metadata in the response. Defaults to false. */
  withStreamMetadata?: boolean;
}

/** Response containing configuration metadata for data collection rules. */
model DataCollectionRuleConfigurationMetadataResponse {
  /** The configuration metadata for platform telemetry. */
  configurationMetadata?: ConfigurationMetadata;
}

/** Configuration metadata for data collection. */
model ConfigurationMetadata {
  /** Platform telemetry configuration metadata. */
  platformTelemetry?: PlatformTelemetryMetadata;
}

/** Metadata for platform telemetry (logs and metrics). */
model PlatformTelemetryMetadata {
  /** Configuration metadata for platform logs. */
  platformLogs?: TelemetryTypeMetadata;

  /** Configuration metadata for platform metrics. */
  platformMetrics?: TelemetryTypeMetadata;
}

/** Metadata for a specific telemetry type (logs or metrics). */
model TelemetryTypeMetadata {
  /** List of supported destination resource types. */
  supportedDestinations?: string[];

  /** List of supported source resource types. */
  supportedResourceTypes?: string[];

  /** Detailed stream information. Only returned when withStreamMetadata is true in the request. */
  @identifiers(#["streamId"])
  supportedStreams?: StreamMetadata[];
}

/** Metadata for a specific data stream. */
model StreamMetadata {
  /** The unique identifier for the stream. */
  streamId?: string;

  /** Additional metadata about the stream. */
  metadata?: StreamDetailMetadata;
}

/** Detailed metadata for a stream (logs or metrics specification). */
model StreamDetailMetadata {
  /** Specification for logs stream. */
  logsSpecification?: LogsSpecification;

  /** Specification for metrics stream. */
  metricsSpecification?: MetricsSpecification;
}

/** Specification for a logs stream. */
model LogsSpecification {
  /** The name of the logs stream. */
  name?: string;

  /** The display name of the logs stream. */
  displayName?: string;

  /** Categorization groups for the logs stream. */
  groups?: string[];
}

/** Specification for a metrics stream. Properties are driven by the service and are manifest driven. */
model MetricsSpecification {
  /** The name of the metric. */
  name?: string;

  /** The display name of the metric. */
  displayName?: string;

  /** Description of the metric. */
  description?: string;

  /**
   * The unit of measurement for the metric.
   * This value is provided by the service and is manifest-driven; the set of possible values may evolve over time.
   * Example: "Count".
   */
  unit?: string;

  /**
   * The aggregation type for the metric.
   * This value is provided by the service and is manifest-driven; the set of possible values may evolve over time.
   * Example: "Total".
   */
  aggregationType?: string;

  /** Categorization groups for the metric. */
  groups?: string[];
}
