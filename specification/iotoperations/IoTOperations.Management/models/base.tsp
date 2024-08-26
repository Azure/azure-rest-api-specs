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
union OperationalMode {
  string,

  @doc("Enabled is equivalent to True")
  Enabled: "Enabled",

  @doc("Disabled is equivalent to False.")
  Disabled: "Disabled",
}

@doc("Diagnostic Log properties")
model DiagnosticsLogs {
  @doc("The open telemetry export configuration.")
  opentelemetryExportConfig?: OpenTelemetryLogExportConfig;

  @doc("The log level. Examples - 'debug', 'info', 'warn', 'error', 'trace'.")
  level?: string = "info";
}

@doc("OpenTelemetry Log Export Configuration properties")
model OpenTelemetryLogExportConfig {
  ...OpenTelemetryExportConfig;

  @doc("The log level. Examples - 'debug', 'info', 'warn', 'error', 'trace'.")
  level?: string = "error";
}

@doc("OpenTelemetry Export Configuration properties")
model OpenTelemetryExportConfig {
  @doc("The open telemetry collector endpoint to export to.")
  otlpGrpcEndpoint: string;

  @doc("How often to export the metrics to the open telemetry collector.")
  @minValue(1)
  @maxValue(300)
  intervalSeconds?: int32 = 30;
}

@doc("Diagnostic Metrics properties")
model Metrics {
  @doc("The open telemetry export configuration.")
  opentelemetryExportConfig?: OpenTelemetryExportConfig;

  @doc("The prometheus port to expose the metrics.")
  @minValue(0)
  @maxValue(65535)
  prometheusPort?: int32 = 9600;
}

@doc("Metric properties")
model MetricProperties {
  @doc("Diagnostic log settings for the resource.")
  logs?: DiagnosticsLogs;

  @doc("The metrics settings for the resource.")
  metrics?: Metrics;
}

@doc("Diagnostic Self tracing properties")
model SelfTracing {
  @doc("The toggle to enable/disable self tracing.")
  mode?: OperationalMode = OperationalMode.Enabled;

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

@doc("Tls properties")
model TlsProperties {
  @doc("Mode for TLS.")
  mode?: OperationalMode = OperationalMode.Enabled;

  @doc("Trusted CA certificate config map.")
  trustedCaCertificateConfigMapRef?: string;
}

@doc("Broker Protocol types")
union BrokerProtocolType {
  string,

  @doc("protocol broker")
  Mqtt: "Mqtt",

  @doc("protocol websocket")
  WebSockets: "WebSockets",
}

@doc("Kubernetes reference")
model KubernetesReference {
  ...LocalKubernetesReference;

  @doc("Namespace is the namespace of the resource being referenced. This field is required when the resource has a namespace.")
  `namespace`?: string;
}

@doc("Kubernetes reference")
model LocalKubernetesReference {
  @doc("APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.")
  apiGroup?: string;

  @doc("Kind is the type of resource being referenced")
  kind: string;

  @doc("Name is the name of resource being referenced")
  name: string;
}

@doc("Cert-Manager issuerRef properties")
model CertManagerIssuerRef {
  @doc("group of issuer.")
  group: string = "cert-manager.io";

  @doc("kind of issuer (Issuer or ClusterIssuer).")
  kind: CertManagerIssuerKind;

  @doc("name of issuer.")
  name: string;
}

@doc("CertManagerIssuerKind properties")
union CertManagerIssuerKind {
  string,

  @doc("Issuer kind.")
  Issuer: "Issuer",

  @doc("ClusterIssuer kind.")
  ClusterIssuer: "ClusterIssuer",
}

alias SystemAssignedManagedIdentity = "SystemAssignedManagedIdentity";
alias UserAssignedManagedIdentity = "UserAssignedManagedIdentity";
alias AccessToken = "AccessToken";
alias Sasl = "Sasl";
alias X509Certificate = "X509Certificate";
alias Anonymous = "Anonymous";
alias ServiceAccountToken = "ServiceAccountToken";

@doc("Managed Identity Method")
union ManagedIdentityMethod {
  string,

  @doc("SystemAssignedManagedIdentity type")
  SystemAssignedManagedIdentity: SystemAssignedManagedIdentity,

  @doc("UserAssignedManagedIdentity type")
  UserAssignedManagedIdentity: UserAssignedManagedIdentity,
}

@doc("Access Token Method")
union AccessTokenMethod {
  string,

  @doc("AccessToken Option")
  AccessToken: AccessToken,
}

@doc("Sasl Method")
union SaslMethod {
  string,

  @doc("Sasl Option")
  Sasl: Sasl,
}

@doc("x509 Certificate Method")
union x509CertificateMethod {
  string,

  @doc("x509Certificate Option")
  X509Certificate: X509Certificate,
}

@doc("x509 Certificate Method")
union AnonymousMethod {
  string,

  @doc("Anonymous Option")
  Anonymous: Anonymous,
}

@doc("Service Account Token Method")
union ServiceAccountTokenMethod {
  string,

  @doc("ServiceAccountToken Option")
  ServiceAccountToken: ServiceAccountToken,
}
