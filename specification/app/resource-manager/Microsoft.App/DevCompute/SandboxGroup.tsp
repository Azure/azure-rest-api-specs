import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;

/** A SandboxGroup resource, representing a group of sandboxes that share configuration defaults and quotas. */
model SandboxGroup is TrackedResource<SandboxGroupProperties> {
  ...ResourceNameParameter<
    Resource = SandboxGroup,
    KeyName = "sandboxGroupName",
    SegmentName = "sandboxGroups",
    NamePattern = "^(?![.-])[A-Za-z0-9-]{1,32}$"
  >;
}

/** SandboxGroup resource specific properties. */
model SandboxGroupProperties {
  /** The resource ID of the Azure Container Apps environment to link to the sandbox group. A sandbox group can be linked after creation, but the link cannot then be changed or removed. For subsequent create-or-update (PUT) requests, specify the same environment ID; omitting or changing it returns 409 Conflict. Omitting it from an update (PATCH) request leaves the existing link unchanged. */
  environmentId?: armResourceIdentifier<[
    {
      type: "Microsoft.App/managedEnvironments";
    }
  ]>;

  /** The default domain of the linked Azure Container Apps environment. Sandbox endpoints use subdomains of this domain. This read-only property is populated by the service and is omitted when no environment is linked. */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /** The telemetry configuration for sandboxes in the sandbox group. When omitted, telemetry is not forwarded to any endpoint. */
  telemetryConfig?: TelemetryConfig;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Description is on the referenced type to avoid emitting a sibling of $ref."
  @visibility(Lifecycle.Read)
  provisioningState?: SandboxGroupProvisioningState;
}

/** Provisioning state of the SandboxGroup. */
@lroStatus
union SandboxGroupProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  InProgress: "InProgress",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

@armResourceOperations
interface SandboxGroups {
  /** Get the properties of a SandboxGroup. */
  get is ArmResourceRead<SandboxGroup>;

  /** Create or update a SandboxGroup. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SandboxGroup>;

  /** Patches a SandboxGroup. */
  update is ArmCustomPatchAsync<
    SandboxGroup,
    SandboxGroupPatch,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /** Delete a SandboxGroup. */
  delete is ArmResourceDeleteWithoutOkAsync<
    SandboxGroup,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /** Get all SandboxGroups in a resource group. */
  listByResourceGroup is ArmResourceListByParent<SandboxGroup>;

  /** Get all SandboxGroups for a subscription. */
  listBySubscription is ArmListBySubscription<SandboxGroup>;
}

/** A SandboxGroup resource for use in patch requests. */
model SandboxGroupPatch {
  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Resource tags are defined as an open key/value map per ARM contract."
  tags?: Record<string>;

  /** SandboxGroup properties that can be updated. */
  properties?: SandboxGroupPatchProperties;
}

/** SandboxGroup resource specific properties for patch requests. */
model SandboxGroupPatchProperties {
  ...PickProperties<
    SandboxGroupProperties,
    "environmentId" | "telemetryConfig"
  >;
}

/** The telemetry configuration for sandboxes in a sandbox group. */
model TelemetryConfig {
  /** The endpoints that sandbox telemetry is sent to. At least one endpoint must be specified. */
  @identifiers(#[])
  @minItems(1)
  endpoints?: TelemetryEndpoint[];

  /** The interval, in seconds, at which sandbox metrics are collected. Defaults to 15 seconds when not specified. */
  @minValue(2)
  metricsIntervalSeconds?: int32;
}

/** The kind of a telemetry endpoint. */
union TelemetryEndpointKind {
  string,

  /** An endpoint that accepts the OpenTelemetry Protocol (OTLP). */
  OTLP: "OTLP",

  /** An Application Insights resource. */
  ApplicationInsights: "ApplicationInsights",

  /** An Azure Monitor Log Analytics workspace, written through the Logs Ingestion API. */
  LogAnalytics: "LogAnalytics",
}

/** A destination that sandbox telemetry is sent to. */
@discriminator("kind")
model TelemetryEndpoint {
  /** The kind of the telemetry endpoint. */
  kind: TelemetryEndpointKind;

  /** The categories of telemetry sent to this endpoint. At least one category must be specified. */
  @minItems(1)
  data: TelemetryData[];

  /** A custom output schema for log records. Applies to `ContainerStdoutStderr` telemetry, and additionally to `Metrics` telemetry on an OpenTelemetry Protocol endpoint. When omitted, records are written in their default shape. */
  @identifiers(#["name"])
  columns?: LogColumn[];

  /** Whether to parse JSON log lines and merge their top-level keys into the output record. Reserved keys, and keys already produced by an entry in `columns`, are not overwritten. Requires `ContainerStdoutStderr` in `data`. Defaults to `Disabled` when not specified. */
  dynamicJsonColumns?: DynamicJsonColumnsMode;
}

/** Whether JSON log lines are parsed into additional output columns. */
union DynamicJsonColumnsMode {
  string,

  /** Top-level keys of JSON log lines are merged into the output record. */
  Enabled: "Enabled",

  /** Log lines are written to the output record without JSON parsing. */
  Disabled: "Disabled",
}

/** A telemetry endpoint that accepts the OpenTelemetry Protocol (OTLP). */
model OtlpTelemetryEndpoint extends TelemetryEndpoint {
  /** The kind of the telemetry endpoint. */
  kind: "OTLP";

  /** The URL of the OpenTelemetry Protocol endpoint. */
  endpoint: url;

  /** The protocol used to send telemetry to the endpoint. */
  protocol: TelemetryProtocol;

  /** The authentication used when sending telemetry to the endpoint. When omitted, requests are sent without an authentication header. */
  authentication?: TelemetryHeaderAuth;
}

/** A telemetry endpoint that sends telemetry to an Application Insights resource. */
model ApplicationInsightsTelemetryEndpoint extends TelemetryEndpoint {
  /** The kind of the telemetry endpoint. */
  kind: "ApplicationInsights";

  /** The authentication used when sending telemetry to the endpoint. */
  authentication: TelemetryApplicationInsightsAuth;
}

/** A telemetry endpoint that sends telemetry to an Azure Monitor Log Analytics workspace through the Logs Ingestion API. */
model LogAnalyticsTelemetryEndpoint extends TelemetryEndpoint {
  /** The kind of the telemetry endpoint. */
  kind: "LogAnalytics";

  /** The URL of the data collection endpoint that receives the telemetry. */
  dataCollectionEndpoint: url;

  /** The immutable ID of the data collection rule that processes the telemetry. */
  dataCollectionRuleImmutableId: string;

  /** The name of the target stream in the data collection rule. */
  tableName: string;

  /** The managed identity used to authenticate to the data collection endpoint. */
  authentication: TelemetryAuth;
}

/** A category of telemetry that can be sent to a telemetry endpoint. */
union TelemetryData {
  string,

  /** Standard output and standard error written by containers in the sandbox. */
  ContainerStdoutStderr: "ContainerStdoutStderr",

  /** OpenTelemetry data emitted by containers in the sandbox. */
  ContainerOtel: "ContainerOtel",

  /** Resource usage metrics for the sandbox. */
  Metrics: "Metrics",

  /** A record of each decision made by the network egress policy of the sandbox. */
  NetworkEgressDecisions: "NetworkEgressDecisions",
}

/** The protocol used to send telemetry to an OpenTelemetry Protocol endpoint. */
union TelemetryProtocol {
  string,

  /** Telemetry is sent over gRPC. */
  Grpc: "Grpc",

  /** Telemetry is sent over HTTP with a protobuf payload. */
  Http: "Http",
}

/** Authentication for an OpenTelemetry Protocol telemetry endpoint. The referenced secret value is sent as an HTTP request header. */
model TelemetryHeaderAuth {
  /** The name of the HTTP request header to send, for example `Authorization`. */
  headerName: string;

  /** The name of the sandbox group secret that holds the header value. */
  secretId: string;

  /** The key within the sandbox group secret whose value is sent as the header value. */
  secretKeyName: string;
}

/** Authentication for an Application Insights telemetry endpoint. */
model TelemetryApplicationInsightsAuth {
  /** The name of the sandbox group secret that holds the Application Insights connection string. */
  secretId: string;

  /** The key within the sandbox group secret whose value is the Application Insights connection string. */
  secretKeyName: string;
}

/** The type of managed identity used to authenticate to a telemetry endpoint. */
union TelemetryAuthType {
  string,

  /** A user-assigned managed identity. */
  UserAssigned: "UserAssigned",

  /** The system-assigned managed identity of the sandbox group. */
  SystemAssigned: "SystemAssigned",
}

/** The managed identity used to authenticate to a telemetry endpoint. */
@discriminator("type")
model TelemetryAuth {
  /** The type of managed identity used to authenticate to the telemetry endpoint. */
  type: TelemetryAuthType;
}

/** Authentication that uses a user-assigned managed identity. */
model TelemetryUserAssignedIdentityAuth extends TelemetryAuth {
  /** The type of managed identity used to authenticate to the telemetry endpoint. */
  type: "UserAssigned";

  /** The resource ID of the user-assigned managed identity. The identity must be assigned to the sandbox group. */
  identityResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/** Authentication that uses the system-assigned managed identity of the sandbox group. */
model TelemetrySystemAssignedIdentityAuth extends TelemetryAuth {
  /** The type of managed identity used to authenticate to the telemetry endpoint. */
  type: "SystemAssigned";
}

/** The kind of a custom log output column. */
union LogColumnKind {
  string,

  /** A column whose value is a literal string. */
  Value: "Value",

  /** A column whose value is resolved from a sandbox attribute. */
  Ref: "Ref",
}

/** A single column in a custom log output schema. */
@discriminator("kind")
model LogColumn {
  /** The name of the output column to produce. */
  name: string;

  /** The kind of the custom log output column. */
  kind: LogColumnKind;
}

/** A custom log output column whose value is a literal string. */
model ValueLogColumn extends LogColumn {
  /** The kind of the custom log output column. */
  kind: "Value";

  /** The literal value written to every log record. */
  value: string;
}

/** A custom log output column whose value is resolved from a sandbox attribute. */
model RefLogColumn extends LogColumn {
  /** The kind of the custom log output column. */
  kind: "Ref";

  /** The sandbox attribute to resolve. */
  refName: LogColumnRef;
}

/** A sandbox attribute that a custom log output column can reference. */
union LogColumnRef {
  string,

  /** The contents of the container log line. */
  LogContent: "LogContent",

  /** The container output stream the log line was written to, either `stdout` or `stderr`. */
  LogStream: "LogStream",

  /** The ID of the sandbox that produced the record. */
  SandboxId: "SandboxId",

  /** The Azure region the sandbox is running in. */
  Region: "Region",

  /** The name of the container that produced the record. */
  ContainerName: "ContainerName",
}
