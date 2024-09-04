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

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using OpenAPI;

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
  @extension("x-ms-identifiers", [])
  receivers: Receiver[];

  @doc("The processors specified for a pipeline group instance.")
  @extension("x-ms-identifiers", [])
  processors: Processor[];

  @doc("The exporters specified for a pipeline group instance.")
  @extension("x-ms-identifiers", [])
  exporters: Exporter[];

  @doc("The service section for a given pipeline group instance.")
  service: Service;

  @doc("Networking configurations for the pipeline group instance.")
  @extension("x-ms-identifiers", [])
  networkingConfigurations?: NetworkingConfiguration[];

  @doc("The provisioning state of a pipeline group instance. Set to Succeeded if everything is healthy.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Receiver Info.")
model Receiver {
  @doc("The type of receiver.")
  type: ReceiverType;

  @doc("The name of receiver.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("Syslog configurations. This field is mandatory for syslog type receivers.")
  syslog?: SyslogReceiver;

  @doc("OTLP receiver configurations. This field is mandatory for OTLP and pipelineGroup receivers.")
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
  Ama: "Ama",

  @doc("Receives data from another pipeline group.")
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
}

@doc("The processor type.")
union ProcessorType {
  string,

  @doc("Batch processor.")
  Batch: "Batch",
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
  tcp?: TcpExporter;
}

@doc("The exporter type.")
union ExporterType {
  string,

  @doc("Export logs to Azure Monitor Workspace.")
  AzureMonitorWorkspaceLogs: "AzureMonitorWorkspaceLogs",

  @doc("Export data to another pipeline group instance.")
  PipelineGroup: "PipelineGroup",
}

@doc("Service Info.")
model Service {
  @doc("Pipelines belonging to a given pipeline group.")
  @extension("x-ms-identifiers", [])
  pipelines: Pipeline[];

  @doc("Persistence options to all pipelines in the instance.")
  @extension("x-ms-identifiers", [])
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
  @extension("x-ms-identifiers", [])
  receivers: string[];

  @doc("Reference to processors configured for the pipeline.")
  @extension("x-ms-identifiers", [])
  processors?: string[];

  @doc("Reference to exporters configured for the pipeline.")
  @extension("x-ms-identifiers", [])
  exporters: string[];
}

@doc("The pipeline type.")
union PipelineType {
  string,

  @doc("Pipeline for logs telemetry.")
  Logs: "Logs",
}

@doc("Networking configuration for the pipeline group instance.")
model NetworkingConfiguration {
  @doc("External networking mode.")
  externalNetworkingMode: ExternalNetworkingMode;

  @doc("The address exposed on the cluster. Example: azuremonitorpipeline.contoso.com.")
  @pattern("^[a-zA-Z0-9-\\.]+$")
  host?: string;

  @doc("Networking routes configuration.")
  @extension("x-ms-identifiers", [])
  routes: NetworkingRoute[];
}

@doc("The mode of the external networking.")
union ExternalNetworkingMode {
  string,

  @doc("Load balancer only.")
  LoadBalancerOnly: "LoadBalancerOnly",
}

@doc("Networking route configuration.")
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
