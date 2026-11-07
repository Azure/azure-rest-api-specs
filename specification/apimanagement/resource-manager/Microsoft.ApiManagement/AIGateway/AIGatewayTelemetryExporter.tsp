import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ApiManagement;

/** Destination kind for gateway telemetry. */
@added(Versions.v2026_11_01)
union AiGatewayTelemetryExporterKind {
  string,

  /** Export to Application Insights. */
  ApplicationInsights: "ApplicationInsights",

  /** Export over OTLP HTTP/protobuf. */
  OpenTelemetry: "OpenTelemetry",
}

/** Managed identity used to authenticate telemetry export requests. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryManagedIdentity {
  /** Token audience requested for the managed identity. */
  resource?: string;

  /** User-assigned managed identity client ID; omit for the system-assigned identity. */
  clientId?: string;
}

/** Outbound authentication settings for an OpenTelemetry exporter. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryAuthentication {
  /** Managed identity authentication for export requests. */
  managedIdentity?: AiGatewayTelemetryManagedIdentity;

  /** Secret HTTP headers sent with export requests. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeader[];
}

/** Outbound authentication settings to update on an OpenTelemetry exporter. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryAuthenticationUpdate {
  /** Managed identity authentication for export requests. */
  managedIdentity?: AiGatewayTelemetryManagedIdentity;

  /** Secret HTTP headers sent with export requests. */
  @identifiers(#[])
  headers?: AiGatewaySecretHeaderUpdate[];
}

/** OpenTelemetry export signal destinations. */
@added(Versions.v2026_11_01)
model AiGatewayOpenTelemetryConfiguration {
  /** Full OTLP metrics endpoint URL, used without appending a signal path. */
  metricsEndpoint?: AiGatewayDestinationEndpoint;

  /** Full OTLP logs endpoint URL, used without appending a signal path. */
  logsEndpoint?: AiGatewayDestinationEndpoint;

  /** Full OTLP traces endpoint URL, used without appending a signal path. */
  tracesEndpoint?: AiGatewayDestinationEndpoint;
}

/** OpenTelemetry export signal destinations to update. */
@added(Versions.v2026_11_01)
model AiGatewayOpenTelemetryConfigurationUpdate {
  /** Full OTLP metrics endpoint URL, used without appending a signal path. */
  metricsEndpoint?: AiGatewayDestinationEndpointUpdate;

  /** Full OTLP logs endpoint URL, used without appending a signal path. */
  logsEndpoint?: AiGatewayDestinationEndpointUpdate;

  /** Full OTLP traces endpoint URL, used without appending a signal path. */
  tracesEndpoint?: AiGatewayDestinationEndpointUpdate;
}

/** Application Insights export destination. */
@added(Versions.v2026_11_01)
model AiGatewayApplicationInsightsConfiguration {
  /** Application Insights connection string. Required when creating this exporter kind. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  connectionString?: string;

  /** Azure resource identifier of the Application Insights component. */
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Insights/components";
    }
  ]>;
}

/** Telemetry signal receiving a claim attribute. */
@added(Versions.v2026_11_01)
union AiGatewayTelemetrySignal {
  string,

  /** Log records. */
  Logs: "logs",

  /** Trace spans. */
  Traces: "traces",

  /** Token-usage and token-cost metrics. */
  Metrics: "metrics",
}

/** A request JWT claim observed for telemetry only, not authentication or billing. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryAttributeSource {
  /** Source kind. Only claims is currently supported. */
  kind: "claims";

  /** Nonempty, case-sensitive claim name. */
  @minLength(1)
  value: string;
}

/** A claim mapping to azure.ai_gateway.identity.claims.{claim}. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryAttributeMapping {
  /** Claim source. Source claim names must be unique across mappings. */
  source: AiGatewayTelemetryAttributeSource;

  /** Distinct signals to enrich. Omit to select all configured signals. */
  @minItems(1)
  signals?: AiGatewayTelemetrySignal[];
}

/** A claim source to update. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryAttributeSourceUpdate
  is OptionalProperties<AiGatewayTelemetryAttributeSource>;

/** A claim mapping to update. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryAttributeMappingUpdate {
  /** Claim source. */
  source?: AiGatewayTelemetryAttributeSourceUpdate;

  /** Distinct signals to enrich. */
  @minItems(1)
  signals?: AiGatewayTelemetrySignal[];
}

/** Optional telemetry enrichment on a native AI Gateway OpenTelemetry exporter. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryConfiguration {
  /** Observed-claim mappings; an empty array removes existing mappings. */
  @identifiers(#["source/value"])
  attributes?: AiGatewayTelemetryAttributeMapping[];
}

/** Telemetry enrichment settings to update. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryConfigurationUpdate {
  /** Observed-claim mappings; an empty array removes existing mappings. */
  @identifiers(#[])
  attributes?: AiGatewayTelemetryAttributeMappingUpdate[];
}

/** Properties of an AI Gateway telemetry exporter. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryExporterProperties {
  /** Exporter type, which cannot change after creation. */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  telemetryExporterType: AiGatewayTelemetryExporterKind;

  /** Capture prompts, completions, and tool input/output; no built-in PII redaction is applied. */
  payloadCapture?: boolean = false;

  /** Configuration required for the ApplicationInsights exporter type. */
  applicationInsights?: AiGatewayApplicationInsightsConfiguration;

  /** Configuration required for the OpenTelemetry exporter type. At least one signal endpoint is required. */
  openTelemetry?: AiGatewayOpenTelemetryConfiguration;

  /** Outbound authentication for OpenTelemetry export requests. */
  authentication?: AiGatewayTelemetryAuthentication;

  /** Optional observed-claim mappings, supported on native AI Gateway OpenTelemetry exporters. */
  telemetry?: AiGatewayTelemetryConfiguration;

  /** Provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: AiGatewayProvisioningState;
}

/** Properties to update on an AI Gateway telemetry exporter. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryExporterUpdateProperties {
  /** Capture prompts, completions, and tool input/output. */
  payloadCapture?: boolean;

  /** Application Insights configuration. */
  applicationInsights?: AiGatewayApplicationInsightsConfiguration;

  /** OpenTelemetry configuration. */
  openTelemetry?: AiGatewayOpenTelemetryConfigurationUpdate;

  /** Outbound authentication for OpenTelemetry export requests. */
  authentication?: AiGatewayTelemetryAuthenticationUpdate;

  /** Observed-claim mappings to update. */
  telemetry?: AiGatewayTelemetryConfigurationUpdate;
}

/** Parameters for updating an AI Gateway telemetry exporter. */
@added(Versions.v2026_11_01)
model AiGatewayTelemetryExporterUpdateParameters {
  /** Exporter properties to update. */
  properties?: AiGatewayTelemetryExporterUpdateProperties;
}

/** A telemetry export destination in the default AI Gateway workspace. */
@added(Versions.v2026_11_01)
@parentResource(AiGatewayWorkspaceResource)
model AiGatewayTelemetryExporterResource
  is ProxyResource<AiGatewayTelemetryExporterProperties> {
  ...ResourceNameParameter<
    Resource = AiGatewayTelemetryExporterResource,
    KeyName = "telemetryExporterName",
    SegmentName = "telemetryExporters",
    NamePattern = "^[a-zA-Z0-9_-]+$"
  >;
  ...EntityTagProperty;
}
