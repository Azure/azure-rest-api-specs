import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations.DataflowGraphs;

@doc("Instance dataflowEndpoint resource")
@added(Versions.`2025-07-01-preview`)
@parentResource(DataflowProfileResource)
model DataflowGraphResource is ProxyResource<Properties> {
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
model Properties {
  @doc("The mode of the dataflow graph.")
  mode?: OperationalMode; // Should this be optional?

  @doc("Disk persistence mode.")
  requestDiskPersistence?: OperationalMode;

  @doc("Reference to the dataflow profile")
  profileRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("List of nodes in the dataflow graph.")
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  nodes: Node[];

  @doc("The provisioning state of the dataflow graph.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("DataflowGraph node properties.")
@added(Versions.`2025-07-01-preview`)
@discriminator("type")
model Node {
  @doc("Name of the node.")
  @maxLength(64)
  name: string;

  @doc("Type of the node.")
  type: NodeType;
}

@doc("DataflowGraph node types.")
@added(Versions.`2025-07-01-preview`)
union NodeType {
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
model SourceNode extends Node {
  @doc("Type of the source node.")
  type: NodeType.Source;

  @doc("Source configuration.")
  sourceSettings: SourceSettings;
}

@doc("DataflowGraph source node settings.")
@added(Versions.`2025-07-01-preview`)
model SourceSettings {
  @doc("The endpoint reference for the source.")
  endpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("List of data sources.")
  dataSources: string[];
}

@doc("DataflowGraph graph node properties.")
@added(Versions.`2025-07-01-preview`)
model GraphNode extends Node {
  @doc("Type of the graph node.")
  type: NodeType.Graph;

  @doc("Graph configuration.")
  graphSettings: GraphSettings;
}

@doc("DataflowGraph graph node settings.")
@added(Versions.`2025-07-01-preview`)
model GraphSettings { // Maybe this resource isn't needed?
  @doc("Reference to the registry endpoint for pulling the artifact.")
  registryEndpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("The artifact name and version to pull.")
  artifact: string;

  @doc("Configuration key-value pairs.")
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  configuration?: GraphNodeConfiguration[];
}

@doc("DataflowGraph graph node configuration.")
@added(Versions.`2025-07-01-preview`)
model GraphNodeConfiguration {
  @doc("Key of the configuration.")
  @maxLength(64)
  key: string;

  @doc("Value of the configuration.")
  value: string;
}

@doc("DataflowGraph destination node properties.")
@added(Versions.`2025-07-01-preview`)
model DestinationNode extends Node {
  @doc("Type of the destination node.")
  type: NodeType.Destination;

  @doc("Destination configuration.")
  destinationSettings: DestinationSettings;
}

@doc("DataflowGraph destination node settings.")
@added(Versions.`2025-07-01-preview`)
model DestinationSettings {
  @doc("The endpoint reference for the destination.")
  endpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  @doc("Data destination at the endpoint.")
  dataDestination: string;

  @doc("Output schema settings.")
  outputSchemaSettings?: SchemaSettings;
}

@doc("DataflowGraph output schema settings.")
@added(Versions.`2025-07-01-preview`)
model SchemaSettings {
  @doc("Output serialization format.")
  serializationFormat: SerializationFormat;

  @doc("Reference to the schema that describes the output of the transformation.")
  schemaRef?: string;
}

@doc("Serialization format for dataflow graph.")
@added(Versions.`2025-07-01-preview`)
union SerializationFormat { // Is this net new or should we just update TransformationSerializationFormat with Avro?
  TransformationSerializationFormat,

  @doc("Avro serialization format.")
  Avro: "Avro",
}

@doc("DataflowGraph Node Connection")
@added(Versions.`2025-07-01-preview`)
model NodeConnection {
  @doc("Information about the source node.")
  from: ConnectionInput;

  @doc("Information about the destination node.")
  to: ConnectionOutput;
}

@doc("DataflowGraph Node Connection Input")
@added(Versions.`2025-07-01-preview`)
model ConnectionInput {
  @doc("Name of the source node.")
  @maxLength(64)
  name: string;

  @doc("Schema settings for the source node.")
  schema: SchemaSettings;
}

@doc("DataflowGraph Node Connection Output")
@added(Versions.`2025-07-01-preview`)
model ConnectionOutput {
  @doc("Name of the destination node.")
  @maxLength(64)
  name: string;
}
