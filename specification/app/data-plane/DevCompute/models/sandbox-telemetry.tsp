using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

namespace Azure.DevCompute;

/** Kubernetes-style CPU resource quantity string (e.g. "500m", "2", "0.5"). */
scalar CpuQuantity;

/** CPU usage counters and load averages. */
model CpuStatsView {
  user?: UInt64OrString;
  nice?: UInt64OrString;
  system?: UInt64OrString;
  idle?: UInt64OrString;
  iowait?: UInt64OrString;
  irq?: UInt64OrString;
  softirq?: UInt64OrString;
  steal?: UInt64OrString;
  loadAvg1?: Float64OrString;
  loadAvg5?: Float64OrString;
  loadAvg15?: Float64OrString;
}

/** Debug information that can be included in API responses. */
model DebugInfo {
  /** The OTEL trace ID for correlating logs and requests across services. */
  traceId?: null | string;

  /**
   * Performance spans for waterfall visualization.
   * Flat list with parent-child relationships via ParentId.
   */
  traces?: null | PerfTrace[];
}

/** Filesystem usage for a single mount point. */
model DiskStatsEntryView {
  /** Mount path (e.g., "/containers/container-0/bundle/rootfs"). Deprecated: use Label instead. */
  mountPoint?: null | string;

  filesystem?: string;
  totalBytes?: UInt64OrString;
  usedBytes?: UInt64OrString;
  availableBytes?: UInt64OrString;

  /** Human-friendly display label (e.g., "container-0"). If set, UI should prefer this over MountPoint. */
  label?: null | string;
}

/** Kubernetes-style memory resource quantity string (e.g. "256Mi", "1Gi", "2048"). */
scalar MemoryQuantity;

/** Memory statistics in bytes. */
model MemoryStatsView {
  totalBytes?: UInt64OrString;
  availableBytes?: UInt64OrString;
  usedBytes?: UInt64OrString;
}

/** Network I/O counters. */
model NetworkStatsView {
  rxBytes?: UInt64OrString;
  txBytes?: UInt64OrString;
  rxPackets?: UInt64OrString;
  txPackets?: UInt64OrString;
}

model SandboxStatsResponseView {
  @oneOf tokenUsage?: null | TokenUsageStatsView;
  @oneOf cpu?: null | CpuStatsView;
  @oneOf memory?: null | MemoryStatsView;
  @oneOf network?: null | NetworkStatsView;
  disk?: null | DiskStatsEntryView[];
  uptimeSecs?: Float64OrString;
}

/**
 * Authentication for an ApplicationInsights telemetry endpoint via secret reference.
 * The connection string is resolved at runtime from the referenced user-managed secret.
 */
model TelemetryApplicationInsightsAuth {
  /** Reference to a user-managed secret containing key-value pairs. */
  secretId: SecretId;

  /** The key within the secret whose value is the Application Insights connection string. */
  secretKey: string;
}

/**
 * Base type for telemetry authentication that uses a `kind` discriminator.
 * Supports user-assigned and system-assigned managed identity; designed for future auth kinds
 * (e.g., workload identity).
 */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetryAuth {
  ManagedIdentity: TelemetryAuthTelemetryManagedIdentityAuth,
  SystemAssignedManagedIdentity: TelemetryAuthTelemetrySystemAssignedManagedIdentityAuth,
}

/**
 * User-assigned managed identity authentication for a Log Analytics telemetry endpoint.
 * The egress proxy acquires a bearer token via Identity Proxy using the specified user-assigned MI.
 */
model TelemetryAuthTelemetryManagedIdentityAuth {
  kind?: "ManagedIdentity";

  /**
   * Full ARM resource ID of a user-assigned managed identity
   *             (e.g., /subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{name}).
   */
  identity: string;
}

/**
 * System-assigned managed identity authentication for a Log Analytics telemetry endpoint.
 * The egress proxy acquires a bearer token via Identity Proxy using the sandbox group's system-assigned MI.
 * No explicit identity resource ID is needed — the Identity Proxy defaults to the system-assigned identity.
 */
model TelemetryAuthTelemetrySystemAssignedManagedIdentityAuth {
  kind?: "SystemAssignedManagedIdentity";
}

/** Configures telemetry collection for a sandbox. Passed in sandbox creation requests. */
model TelemetryConfig {
  /** One or more telemetry endpoints to route data to. */
  endpoints: TelemetryEndpoint[];

  /** Optional metrics collection interval in seconds. Must be &gt;= 2. Defaults to 15 if not specified. */
  metricsIntervalSeconds?: NullableInt32OrString;
}

/** Specifies which category of telemetry data to route to an endpoint. */
union TelemetryData {
  "ContainerStdoutStderr",
  "ContainerOtel",
  "Metrics",
  "NetworkEgressDecisions",
}

/** Base type for telemetry endpoint configuration. Polymorphic on `kind` discriminator. */
@discriminated(#{ envelope: "none", discriminatorPropertyName: "kind" })
union TelemetryEndpoint {
  OTLP: TelemetryEndpointOtlpTelemetryEndpoint,
  ApplicationInsights: TelemetryEndpointApplicationInsightsTelemetryEndpoint,
  LogAnalytics: TelemetryEndpointLogAnalyticsTelemetryEndpoint,
  LogAnalyticsLegacy: TelemetryEndpointLogAnalyticsLegacyTelemetryEndpoint,
}

/**
 * Application Insights telemetry endpoint configuration.
 * Uses the connection string to derive the ingestion and live-metrics endpoints.
 */
model TelemetryEndpointApplicationInsightsTelemetryEndpoint {
  kind?: "ApplicationInsights";
  auth: TelemetryApplicationInsightsAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /**
   * Optional custom column schema. When set, log records are projected
   *             through this schema before being forwarded. Supported on all endpoint kinds for
   *             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record
   *             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an
   *             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant
   *             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes
   *             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR
   *             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record
   *             fields.
   */
  columns?: null | Record<LogColumnDef>;

  /**
   * When true, JSON log lines are parsed and their top-level
   *             keys are merged into the output record. Reserved keys (`message`, `time`,
   *             `TimeGenerated`, anything starting with `adc.`) and any key already produced by
   *             an explicit LogColumnDef are preserved (the parsed JSON does not override
   *             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data.
   */
  dynamicJsonColumns?: boolean;
}

/** Log Analytics Legacy (Data Collector API) telemetry endpoint configuration. */
model TelemetryEndpointLogAnalyticsLegacyTelemetryEndpoint {
  kind?: "LogAnalyticsLegacy";

  /** The Log Analytics workspace ID. */
  workspaceId: string;

  /** The custom log table name (e.g., "ContainerAppConsoleLogs"). */
  tableName: string;

  /**
   * Polymorphic secret reference for the shared key. Resolved at runtime
   *             from Key Vault. May be a TelemetrySecretRef (sandboxGroup-scoped legacy
   *             secret) or a TelemetryAppSecretRef (artifactApp-local inline secret).
   */
  auth: TelemetrySecretReference;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /**
   * Optional custom column schema. When set, log records are projected
   *             through this schema before being forwarded. Supported on all endpoint kinds for
   *             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record
   *             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an
   *             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant
   *             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes
   *             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR
   *             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record
   *             fields.
   */
  columns?: null | Record<LogColumnDef>;

  /**
   * When true, JSON log lines are parsed and their top-level
   *             keys are merged into the output record. Reserved keys (`message`, `time`,
   *             `TimeGenerated`, anything starting with `adc.`) and any key already produced by
   *             an explicit LogColumnDef are preserved (the parsed JSON does not override
   *             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data.
   */
  dynamicJsonColumns?: boolean;
}

/**
 * Azure Monitor Log Analytics telemetry endpoint configuration.
 * Uses the Logs Ingestion API via Data Collection Endpoint (DCE) and Data Collection Rule (DCR).
 * Authentication is handled by the customer's managed identity (user-assigned or system-assigned) via Identity Proxy.
 */
model TelemetryEndpointLogAnalyticsTelemetryEndpoint {
  kind?: "LogAnalytics";

  /** Data Collection Endpoint URL. */
  dceEndpoint: url;

  /** Data Collection Rule immutable ID. */
  dcrImmutableId: string;

  /** Target stream name in the DCR. */
  tableName: string;

  /** Required managed identity authentication. The identity must be assigned to the sandbox group. */
  auth: TelemetryAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /**
   * Optional custom column schema. When set, log records are projected
   *             through this schema before being forwarded. Supported on all endpoint kinds for
   *             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record
   *             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an
   *             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant
   *             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes
   *             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR
   *             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record
   *             fields.
   */
  columns?: null | Record<LogColumnDef>;

  /**
   * When true, JSON log lines are parsed and their top-level
   *             keys are merged into the output record. Reserved keys (`message`, `time`,
   *             `TimeGenerated`, anything starting with `adc.`) and any key already produced by
   *             an explicit LogColumnDef are preserved (the parsed JSON does not override
   *             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data.
   */
  dynamicJsonColumns?: boolean;
}

/** OTLP telemetry endpoint configuration. */
model TelemetryEndpointOtlpTelemetryEndpoint {
  kind?: "OTLP";

  /** OTLP endpoint URL (e.g., "https://customer.monitor.azure.com/otlp"). */
  endpoint: url;

  /** `Grpc` or `Http`. */
  protocol: TelemetryProtocol;

  @oneOf auth?: null | TelemetryHeaderAuth;

  /** Which telemetry data to route: `sandbox`, `system`. If empty, all data is routed. */
  data: TelemetryData[];

  /**
   * Optional custom column schema. When set, log records are projected
   *             through this schema before being forwarded. Supported on all endpoint kinds for
   *             `ContainerStdoutStderr` data. Per-kind semantics: OTLP — columns become log record
   *             attributes (the `LogContent` ref also remains the OTLP body), and additionally, for an
   *             OTLP endpoint routing `Metrics`, the `Value` columns and the resource-constant
   *             `Ref` columns (`SandboxId`, `Region`) become OTLP metrics resource attributes
   *             (`ResourceMetrics.Resource.Attributes`); LogAnalytics modern — columns become the DCR
   *             stream record fields; LogAnalyticsLegacy — columns become the HTTP Data Collector API record
   *             fields.
   */
  columns?: null | Record<LogColumnDef>;

  /**
   * When true, JSON log lines are parsed and their top-level
   *             keys are merged into the output record. Reserved keys (`message`, `time`,
   *             `TimeGenerated`, anything starting with `adc.`) and any key already produced by
   *             an explicit LogColumnDef are preserved (the parsed JSON does not override
   *             them). Requires `ContainerStdoutStderr` in IReadOnlyList&lt;TelemetryData&gt; TelemetryEndpoint.Data.
   */
  dynamicJsonColumns?: boolean;
}

/**
 * Authentication configuration for an OTLP telemetry endpoint.
 * The egress proxy injects the resolved secret value as an HTTP header.
 */
model TelemetryHeaderAuth {
  /** HTTP header to inject (e.g., "x-api-key", "Authorization"). */
  headerName: string;

  /** Reference to a user-managed secret containing key-value pairs. */
  secretId: SecretId;

  /** The key within the secret whose value should be used as the header value. */
  secretKey: string;
}

/** Specifies the protocol used to send telemetry data to an OTLP endpoint. */
union TelemetryProtocol {
  "Grpc",
  "Http",
}

/**
 *             Base type for telemetry endpoint secret references. Polymorphic on a `kind`
 *             discriminator that selects between two resolution paths:
 *             * TelemetrySecretRef (kind GlobalSecret) —
 *             references a sandboxGroup-scoped GlobalSecret by id. Used by direct /apps
 *             callers and by legacy payloads that pre-date the artifactApp inline-secrets work.
 * * TelemetryAppSecretRef (kind AppSecret) —
 *             references a secret by its local name within the app's own
 *             Secrets[] array. Used by Microsoft.App/artifactApps callers
 *             that declare inline secrets on the app resource itself.
 */
scalar TelemetrySecretReference;

/** Token usage statistics for a sandbox. */
model TokenUsageStatsView {
  totalInputTokens?: Int64OrString;
  totalOutputTokens?: Int64OrString;
  requestCount?: Int32OrString;
}
