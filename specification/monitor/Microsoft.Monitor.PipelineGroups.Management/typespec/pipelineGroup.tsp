import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./exporters/AzureMonitorWorkspaceLogs.tsp";
import "./exporters/TcpExporters.tsp";
import "./receivers/TcpReceivers.tsp";
import "./receivers/OtlpReceiver.tsp";
import "./receivers/SyslogReceiver.tsp";
import "./processors/BatchProcessor.tsp";
import "./processors/TransformLanguageProcessor.tsp";
import "./ExecutionPlacement.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;

namespace Microsoft.Monitor;

@doc("A pipeline group definition.")
model PipelineGroup is TrackedResource<PipelineGroupProperties> {
  @doc("The name of pipeline group. The name is case insensitive.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  @key("pipelineGroupName")
  @path
  @segment("pipelineGroups")
  name: string;

  ...ExtendedLocationProperty;
}

@doc("Properties that need to be specified to create a new pipeline group instance.")
model PipelineGroupProperties {
  @doc("Defines the amount of replicas of the pipeline group instance.")
  replicas?: int32;

  @doc("The receivers specified for a pipeline group instance.")
  @Azure.ResourceManager.identifiers(#[])
  receivers: Receiver[];

  @doc("The processors specified for a pipeline group instance.")
  @Azure.ResourceManager.identifiers(#[])
  processors: Processor[];

  @doc("The exporters specified for a pipeline group instance.")
  @Azure.ResourceManager.identifiers(#[])
  exporters: Exporter[];

  @doc("The service section for a given pipeline group instance.")
  service: Service;

  @doc("Networking configurations for the pipeline group instance.")
  @Azure.ResourceManager.identifiers(#[])
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  networkingConfigurations?: NetworkingConfiguration[];

  @doc("Constraints for guiding the execution environment of the pipeline group.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  executionPlacement?: ExecutionPlacement;

  @doc("TLS configurations for the pipeline group instance.")
  @Azure.ResourceManager.identifiers(#[])
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  tlsConfigurations?: TlsConfiguration[];

  @doc("The provisioning state of a pipeline group instance. Set to Succeeded if everything is healthy.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Receiver Info.")
model Receiver {
  @doc("The type of receiver.")
  type: ReceiverType;

  @doc("The name of receiver.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("Reference to a named TLS configuration. If not specified, default TLS configuration is used.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  tlsConfiguration?: string;

  @doc("Syslog configurations. This field is mandatory for syslog type receivers.")
  syslog?: SyslogReceiver;

  @doc("OTLP receiver configurations. This field is mandatory for OTLP and pipelineGroup receivers.")
  @renamedFrom(Microsoft.Monitor.Versions.v2025_03_01_preview, "otlp")
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  otlpv20241001preview?: OtlpReceiver;

  @doc("OTLP receiver configurations. This field is mandatory for OTLP receivers.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  otlp?: OtlpReceiver;

  @doc("UDP receiver configurations. This field is mandatory for UDP receivers.")
  udp?: UdpReceiver;
}

@doc("The receiver type.")
union ReceiverType {
  string,

  @doc("Linux syslog.")
  Syslog: "Syslog",

  @doc("Receives data from azure monitor agent receiver.")
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  Ama: "Ama",

  @doc("Receives data from another pipeline group.")
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  PipelineGroup: "PipelineGroup",

  @doc("Receives data from a OTLP collector.")
  OTLP: "OTLP",

  @doc("Receives data from an UDP collector.")
  UDP: "UDP",
}

@doc("Processor Info.")
model Processor {
  @doc("The type of processor.")
  type: ProcessorType;

  @doc("The name of processor.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("Batch processor configurations.")
  batch?: BatchProcessor;

  @doc("Transform language processor configurations.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  transformLanguage?: TransformLanguageProcessor;
}

@doc("The processor type.")
union ProcessorType {
  string,

  @doc("Batch processor.")
  Batch: "Batch",

  @doc("Transform language processor.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  TransformLanguage: "TransformLanguage",

  @doc("Microsoft Syslog processor.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  MicrosoftSyslog: "MicrosoftSyslog",

  @doc("Microsoft CEF/Common Security Log processor.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  MicrosoftCommonSecurityLog: "MicrosoftCommonSecurityLog",
}

@doc("Exporter Info.")
model Exporter {
  @doc("The type of exporter.")
  type: ExporterType;

  @doc("The name of exporter.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("Azure Monitor Workspace Logs specific configurations.")
  azureMonitorWorkspaceLogs?: AzureMonitorWorkspaceLogsExporter;

  @doc("TCP based exporter. Used for pipelineGroup exporter.")
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  tcp?: TcpExporter;
}

@doc("The exporter type.")
union ExporterType {
  string,

  @doc("Export logs to Azure Monitor Workspace.")
  AzureMonitorWorkspaceLogs: "AzureMonitorWorkspaceLogs",

  @doc("Export data to another pipeline group instance.")
  @removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
  PipelineGroup: "PipelineGroup",
}

@doc("Service Info.")
model Service {
  @doc("Pipelines belonging to a given pipeline group.")
  @Azure.ResourceManager.identifiers(#[])
  pipelines: Pipeline[];

  @doc("Persistence options to all pipelines in the instance.")
  persistence?: PersistenceConfigurations;
}

@doc("Pipeline Info.")
model Pipeline {
  @doc("Name of the pipeline.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("The type of pipeline")
  type: PipelineType;

  @doc("Reference to receivers configured for the pipeline.")
  receivers: string[];

  @doc("Reference to processors configured for the pipeline.")
  processors?: string[];

  @doc("Reference to exporters configured for the pipeline.")
  exporters: string[];
}

@doc("The pipeline type.")
union PipelineType {
  string,

  @doc("Pipeline for logs telemetry.")
  Logs: "Logs",
}

@doc("Networking configuration for the pipeline group instance.")
@removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
model NetworkingConfiguration {
  @doc("External networking mode.")
  externalNetworkingMode: ExternalNetworkingMode;

  @doc("The address exposed on the cluster. Example: azuremonitorpipeline.contoso.com.")
  @pattern("^[a-zA-Z0-9-\\.]+$")
  host?: string;

  @doc("Networking routes configuration.")
  @Azure.ResourceManager.identifiers(#[])
  routes: NetworkingRoute[];
}

@doc("The mode of the external networking.")
@removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
union ExternalNetworkingMode {
  string,

  @doc("Load balancer only.")
  LoadBalancerOnly: "LoadBalancerOnly",
}

@doc("Networking route configuration.")
@removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
model NetworkingRoute {
  @doc("The name of the previously defined receiver.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  receiver: string;

  @doc("The port that will be configured externally. If not specified, it will use the port from the receiver definition.")
  @minValue(1)
  @maxValue(65535)
  port?: int32;

  @doc("Route path.")
  @pattern("^[a-zA-Z0-9-/\\.]+$")
  path?: string;

  @doc("Route subdomain.")
  @pattern("^[a-zA-Z0-9-\\.]+$")
  subdomain?: string;
}

@doc("Persistence options to all pipelines in the instance.")
model PersistenceConfigurations {
  @doc("The name of the mounted persistent volume.")
  persistentVolumeName: string;
}

@doc("TLS security mode defining the level of transport security.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union TlsMode {
  string,

  @doc("No TLS encryption - plain text communication.")
  Disabled: "disabled",

  @doc("Server-side TLS only - encrypts communication but doesn't validate client certificates.")
  ServerOnly: "serverOnly",

  @doc("Mutual TLS - encrypts communication and validates both server and client certificates.")
  MutualTls: "mutualTls",
}

@doc("TLS configuration that can be referenced by receivers.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TlsConfiguration {
  @doc("The name of the TLS configuration.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("The TLS security mode for receivers using this configuration. Default is 'mutualTls'.")
  mode?: TlsMode = TlsMode.MutualTls;

  @doc("TLS certificate and its private key. If not specified, default TLS certificate is used.")
  tlsCertificate?: CertificateWithKey;

  @doc("Certificate source configuration for the client CA certificate for validating client certificates. If not specified, default CA certificates are used.")
  clientCa?: CertificateSource;
}

@doc("TLS certificate and private key pair.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model CertificateWithKey {
  @doc("Source configuration for the TLS certificate.")
  certificate: CertificateSource;

  @doc("Source configuration for the private key. Private keys must be stored in Kubernetes secrets for security reasons.")
  privateKey: PrivateKeySource;
}

@doc("Configuration for certificate source location.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model CertificateSource {
  @doc("The type of certificate source.")
  type: CertificateSourceType;

  @doc("Location of the certificate source.")
  location: string;

  @doc("Sub-location within the certificate source.")
  subLocation: string;
}

@doc("Configuration for private key source location.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model PrivateKeySource {
  @doc("The type of private key source. Only kubernetesSecret is supported for security reasons.")
  type: PrivateKeySourceType;

  @doc("Location of the private key source.")
  location: string;

  @doc("Sub-location within the private key source.")
  subLocation: string;
}

@doc("The type of certificate source.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union CertificateSourceType {
  string,

  @doc("Certificate stored in a Kubernetes secret.")
  KubernetesSecret: "kubernetesSecret",

  @doc("Certificate stored in a Kubernetes configmap.")
  KubernetesConfigMap: "kubernetesConfigMap",
}

@doc("The type of private key source.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union PrivateKeySourceType {
  string,

  @doc("Private key stored in a Kubernetes secret. This is the only supported type for security reasons.")
  KubernetesSecret: "kubernetesSecret",
}

@armResourceOperations
interface PipelineGroups {
  @doc("Returns the specific pipeline group instance.")
  get is ArmResourceRead<PipelineGroup>;

  @doc("Create or update a pipeline group instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PipelineGroup>;

  @doc("Delete a pipeline group instance.")
  delete is ArmResourceDeleteWithoutOkAsync<PipelineGroup>;

  @doc("Updates a pipeline group instance")
  update is ArmResourcePatchAsync<PipelineGroup, PipelineGroupProperties>;

  @doc("Lists all workspaces in the specified resource group")
  listByResourceGroup is ArmResourceListByParent<PipelineGroup>;

  @doc("Lists all workspaces in the specified subscription")
  listBySubscription is ArmListBySubscription<PipelineGroup>;
}
