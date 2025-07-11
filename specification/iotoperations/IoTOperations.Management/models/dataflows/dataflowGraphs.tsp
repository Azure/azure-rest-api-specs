import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** Instance dataflowEndpoint resource. */
@added(Versions.`2025-07-01-preview`)
@parentResource(DataflowProfileResource)
model DataflowGraphResource is ProxyResource<DataflowGraphProperties> {
  /** Name of Instance dataflowEndpoint resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowGraphName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowGraphs")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** DataflowGraph properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphProperties {
  /** The mode of the dataflow graph. */
  mode?: OperationalMode = Enabled;

  /** Disk persistence mode. */
  requestDiskPersistence?: OperationalMode;

  /** List of nodes in the dataflow graph. */
  @identifiers(#["name"])
  nodes: DataflowGraphNode[];

  /** List of connections between nodes in the dataflow graph. */
  @identifiers(#[])
  nodeConnections: DataflowGraphNodeConnection[];

  /** The provisioning state of the dataflow graph. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** DataflowGraph node properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("nodeType")
model DataflowGraphNode {
  /** Name of the node. */
  name: string;

  /** Type of the node. */
  nodeType: DataflowGraphNodeType;
}

/** DataflowGraph node types. */
@added(Versions.`2025-07-01-preview`)
union DataflowGraphNodeType {
  string,

  /** Dataflow source node. */
  Source,

  /** Dataflow graph node. */
  Graph,

  /** Dataflow destination node. */
  Destination,
}

/** DataflowGraph source node properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSourceNode extends DataflowGraphNode {
  /** Type of the source node. */
  nodeType: Source;

  /** Source configuration. */
  sourceSettings: DataflowGraphSourceSettings;
}

/** DataflowGraph source node settings. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSourceSettings {
  /** The endpoint reference for the source. */
  endpointRef: string;

  /** List of data sources. */
  dataSources: string[];

  /** Reference to the resource in Azure Device Registry where the data in the endpoint originates from. */
  assetRef?: string;
}

/** DataflowGraph graph node properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphGraphNode extends DataflowGraphNode {
  /** Type of the graph node. */
  nodeType: Graph;

  /** Graph configuration. */
  graphSettings: DataflowGraphNodeGraphSettings;
}

/** DataflowGraph graph node settings. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphNodeGraphSettings {
  /** Reference to the registry endpoint for pulling the artifact. */
  registryEndpointRef: string;

  /** The artifact name and version to pull. This should be in the format `<artifact-name>:<version>`. */
  artifact: string;

  /** Configuration key-value pairs. */
  @identifiers(#["key"])
  configuration?: DataflowGraphGraphNodeConfiguration[];
}

/** DataflowGraph graph node configuration. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphGraphNodeConfiguration {
  /** Key of the configuration. */
  key: string;

  /** Value of the configuration. */
  value: string;
}

/** DataflowGraph destination node properties. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphDestinationNode extends DataflowGraphNode {
  /** Type of the destination node. */
  nodeType: Destination;

  /** Destination configuration. */
  destinationSettings: DataflowGraphDestinationNodeSettings;
}

/** DataflowGraph destination node settings. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphDestinationNodeSettings {
  /** The name of the DataflowEndpoint resource . */
  endpointRef: string;

  /** Data destination at the endpoint. */
  dataDestination: string;

  /** Output schema settings. */
  outputSchemaSettings?: DataflowGraphDestinationSchemaSettings;
}

/** DataflowGraph destination node output schema settings. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphDestinationSchemaSettings {
  /** The format of the output data. */
  serializationFormat: DataflowGraphDestinationSchemaSerializationFormat;

  /** Reference to the schema that describes the output of the transformation. */
  schemaRef?: string;
}

/** Serialization format for dataflow graph. */
@added(Versions.`2025-07-01-preview`)
union DataflowGraphDestinationSchemaSerializationFormat {
  string,

  /** Parquet serialization format. */
  Parquet,

  /** Delta serialization format. */
  Delta,
}

/** DataflowGraph DataflowGraphNode Connection. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphNodeConnection {
  /** Information about the source node. */
  from: DataflowGraphConnectionInput;

  /** Information about the destination node. */
  to: DataflowGraphConnectionOutput;
}

/** DataflowGraph DataflowGraphNode Connection Input. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionInput {
  /** Name of the input node. */
  name: string;

  /** Schema settings for the input node. */
  schema?: DataflowGraphConnectionSchemaSettings;
}

/** DataflowGraph connection node output schema settings. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionSchemaSettings {
  /** Output serialization format. */
  serializationFormat?: DataflowGraphConnectionSchemaSerializationFormat;

  /** Reference to the schema that describes the output of the transformation. */
  schemaRef?: string;
}

/** Serialization format for dataflow graph connection. */
@added(Versions.`2025-07-01-preview`)
union DataflowGraphConnectionSchemaSerializationFormat {
  TransformationSerializationFormat,

  /** Avro serialization format. */
  Avro,
}

/** DataflowGraph DataflowGraphNode Connection Output. */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionOutput {
  /** Name of the destination node. */
  name: string;
}
