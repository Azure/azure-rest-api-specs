import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using Azure.Core;

/** Request body for fetching configuration metadata. */
model DataCollectionRuleConfigurationMetadataRequest {
  /** DCR Kind for which metadata is being requested (e.g., PlatformTelemetry). */
  dcrKind?: string;

  /** Optional resource type filter (e.g., Microsoft.Compute/virtualMachines). If specified, returns detailed configuration metadata for that resource type. */
  resourceType?: string;
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

  /** Detailed stream information per resource type (only in fetchDetails response). */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Using Record to represent dynamic resource type keys in the response"
  supportedStreams?: Record<StreamMetadata[]>;
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

/** Specification for a metrics stream. */
model MetricsSpecification {
  /** The name of the metric. */
  name?: string;

  /** The display name of the metric. */
  displayName?: string;

  /** Description of the metric. */
  description?: string;

  /** The unit of measurement for the metric. */
  unit?: string;

  /** The aggregation type for the metric. */
  aggregationType?: string;

  /** Categorization groups for the metric. */
  groups?: string[];
}
