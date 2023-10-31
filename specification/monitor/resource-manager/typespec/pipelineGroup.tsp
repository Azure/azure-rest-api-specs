import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./exporters/AzureMonitorWorkspaceLogs.tsp";
import "./exporters/TcpExporters.tsp";
import "./receivers/TcpReceivers.tsp";
import "./receivers/OtlpReceiver.tsp";

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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Extended location is not included in TrackedResource yet."
  @doc("The extended location for given pipeline group.")
  @visibility("read", "create")
  extendedLocation?: ExtendedLocation;
}

@doc("Properties that need to be specified to create a new pipeline group instance.")
model PipelineGroupProperties {
  @doc("Defines the amount of replicas of the pipeline group instance.")
  replicas?: int32 = 1;

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

  @doc("TCP service configurations. This field is mandatory for syslog type receivers.")
  tcpReceiver?: TcpReceiver;

  @doc("OTLP receiver configurations. This field is mandatory for OTLP and pipelineGroup receivers.")
  otlpReceiver?: OtlpReceiver;
}

@doc("The receiver type.")
enum ReceiverType {
  @doc("Linux syslog.")
  Syslog,

  @doc("Receives data from azure monitor agent receiver.")
  Ama,

  @doc("Receives data from another pipeline group.")
  PipelineGroup,

  @doc("Receives data from a OTLP collector.")
  OTLP,
}

@doc("Processor Info.")
model Processor {
  @doc("The type of processor.")
  type: ProcessorType;

  @doc("The name of processor.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;
}

@doc("The processor type.")
enum ProcessorType {
  @doc("filter")
  Filter,
}

@doc("Exporter Info.")
model Exporter {
  @doc("The type of exporter.")
  type: ExporterType;

  @doc("The name of exporter.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

  @doc("Azure Monitor Workspace Logs specific configurations.")
  azureMonitorWorkspaceLogsConfig?: AzureMonitorWorkspaceLogsConfig;

  @doc("TCP based exporter. Used for pipelineGroup exporter.")
  tcpExporter?: TcpExporter;
}

@doc("The exporter type.")
enum ExporterType {
  @doc("Export logs to Azure Monitor Workspace.")
  AzureMonitorWorkspaceLogs,

  @doc("Export data to another pipeline group instance.")
  PipelineGroup,
}

@doc("Service Info.")
model Service {
  @doc("Pipelines belonging to a given pipeline group.")
  @extension("x-ms-identifiers", [])
  pipelines: Pipeline[];
}

@doc("Pipeline Info.")
model Pipeline {
  @doc("Name of the pipeline.")
  @pattern("^(?!-)[a-zA-Z0-9-]{3,32}[^-]$")
  name: string;

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

@armResourceOperations
interface PipelineGroups {
  @doc("Returns the specific pipeline group instance.")
  get is ArmResourceRead<PipelineGroup>;

  @doc("Create or update a pipeline group instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PipelineGroup>;

  @doc("Delete a pipeline group instance.")
  delete is ArmResourceDeleteAsync<PipelineGroup>;

  @doc("Updates a pipeline group instance")
  update is ArmResourcePatchAsync<PipelineGroup, PipelineGroupProperties>;

  @doc("Lists all workspaces in the specified resource group")
  listByResourceGroup is ArmResourceListByParent<PipelineGroup>;

  @doc("Lists all workspaces in the specified subscription")
  listBySubscription is ArmListBySubscription<PipelineGroup>;
}
