import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

@doc("Instance dataflowEndpoint resource")
@added(Versions.`2025-07-01-preview`)
@parentResource(DataflowProfileResource)
model DataflowGraphResource is ProxyResource<DataflowGraphProperties> {
  @doc("Name of Instance dataflowEndpoint resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowGraphName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowGraphs")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@doc("DataflowGraph properties")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphProperties {
  @doc("The mode of the dataflow graph.")
  mode?: OperationalMode; // Should this be optional?

  @doc("Disk persistence mode.")
  requestDiskPersistence?: OperationalMode;

  @doc("Reference to the dataflow profile")
  profileRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("List of nodes in the dataflow graph.")
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  nodes: DataflowGraphNode[];

  @doc("List of connections between nodes in the dataflow graph.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  nodeConnections: DataflowGraphNodeConnection[];

  @doc("The provisioning state of the dataflow graph.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("DataflowGraph node properties.")
@added(Versions.`2025-07-01-preview`)
@discriminator("type")
model DataflowGraphNode {
  @doc("Name of the node.")
  @maxLength(64)
  name: string;

  @doc("Type of the node.")
  type: DataflowGraphNodeType;
}

@doc("DataflowGraph node types.")
@added(Versions.`2025-07-01-preview`)
union DataflowGraphNodeType {
  string,

  @doc("Dataflow source node.")
  Source: "Source",

  @doc("Dataflow graph node.")
  Graph: "Graph",

  @doc("Dataflow destination node.")
  Destination: "Destination",
}

@doc("DataflowGraph source node properties.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSourceNode extends DataflowGraphNode {
  @doc("Type of the source node.")
  type: DataflowGraphNodeType.Source;

  @doc("Source configuration.")
  sourceSettings: DataflowGraphSourceSettings;
}

@doc("DataflowGraph source node settings.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSourceSettings {
  @doc("The endpoint reference for the source.")
  endpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("List of data sources.")
  dataSources: string[];
}

@doc("DataflowGraph graph node properties.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphGraphNode extends DataflowGraphNode {
  @doc("Type of the graph node.")
  type: DataflowGraphNodeType.Graph;

  @doc("Graph configuration.")
  graphSettings: DataflowGraphNodeGraphSettings;
}

@doc("DataflowGraph graph node settings.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphNodeGraphSettings { // Maybe this resource isn't needed?
  @doc("Reference to the registry endpoint for pulling the artifact.")
  registryEndpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("The artifact name and version to pull.")
  artifact: string;

  @doc("Configuration key-value pairs.")
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  configuration?: DataflowGraphGraphNodeConfiguration[];
}

@doc("DataflowGraph graph node configuration.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphGraphNodeConfiguration {
  @doc("Key of the configuration.")
  @maxLength(64)
  key: string;

  @doc("Value of the configuration.")
  value: string;
}

@doc("DataflowGraph destination node properties.")
@added(Versions.`2025-07-01-preview`)
model DatafloGraphDestinationNode extends DataflowGraphNode {
  @doc("Type of the destination node.")
  type: DataflowGraphNodeType.Destination;

  @doc("Destination configuration.")
  destinationSettings: DataflowGraphDestinationNodeSettings;
}

@doc("DataflowGraph destination node settings.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphDestinationNodeSettings {
  @doc("The endpoint reference for the destination.")
  endpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("Data destination at the endpoint.")
  dataDestination: string;

  @doc("Output schema settings.")
  outputSchemaSettings?: DataflowGraphSchemaSettings;
}

@doc("DataflowGraph output schema settings.")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSchemaSettings {
  @doc("Output serialization format.")
  serializationFormat: DataflowGraphSerializationFormat;

  @doc("Reference to the schema that describes the output of the transformation.")
  schemaRef?: string;
}

@doc("Serialization format for dataflow graph.")
@added(Versions.`2025-07-01-preview`)
union DataflowGraphSerializationFormat { // Is this net new or should we just update TransformationSerializationFormat with Avro?
  TransformationSerializationFormat,

  @doc("Avro serialization format.")
  Avro: "Avro",
}

@doc("DataflowGraph DataflowGraphNode Connection")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphNodeConnection {
  @doc("Information about the source node.")
  from: DataflowGraphConnectionInput;

  @doc("Information about the destination node.")
  to: DataflowGraphConnectionOutput;
}

@doc("DataflowGraph DataflowGraphNode Connection Input")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionInput {
  @doc("Name of the source node.")
  @maxLength(64)
  name: string;

  @doc("Schema settings for the source node.")
  schema: DataflowGraphSchemaSettings;
}

@doc("DataflowGraph DataflowGraphNode Connection Output")
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionOutput {
  @doc("Name of the destination node.")
  @maxLength(64)
  name: string;
}
