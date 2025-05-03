import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * Instance dataflowEndpoint resource
 */
@added(Versions.`2025-07-01-preview`)
@parentResource(DataflowProfileResource)
model DataflowGraphResource is ProxyResource<DataflowGraphProperties> {
  /**
   * Name of Instance dataflowEndpoint resource
   */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowGraphName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflowGraphs")
  name: string;

  /**
   * Edge location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

/**
 * DataflowGraph properties
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphProperties {
  /**
   * The mode of the dataflow graph.
   */
  mode?: OperationalMode; // Should this be optional?

  /**
   * Disk persistence mode.
   */
  requestDiskPersistence?: OperationalMode;

  /**
   * List of nodes in the dataflow graph.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  nodes: DataflowGraphNode[];

  /**
   * List of connections between nodes in the dataflow graph.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  nodeConnections: DataflowGraphNodeConnection[];

  /**
   * The provisioning state of the dataflow graph.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * DataflowGraph node properties.
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("type")
model DataflowGraphNode {
  /**
   * Name of the node.
   */
  name: string;

  /**
   * Type of the node.
   */
  type: DataflowGraphNodeType;
}

/**
 * DataflowGraph node types.
 */
@added(Versions.`2025-07-01-preview`)
union DataflowGraphNodeType {
  string,

  /**
   * Dataflow source node.
   */
  Source,

  /**
   * Dataflow graph node.
   */
  Graph,

  /**
   * Dataflow destination node.
   */
  Destination,
}

/**
 * DataflowGraph source node properties.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSourceNode extends DataflowGraphNode {
  /**
   * Type of the source node.
   */
  type: Source;

  /**
   * Source configuration.
   */
  sourceSettings: DataflowGraphSourceSettings;
}

/**
 * DataflowGraph source node settings.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSourceSettings {
  /**
   * The endpoint reference for the source.
   */
  endpointRef: string; // should we leverage k8s-bridge translation here? https://armwiki.azurewebsites.net/rpaas/arc-rp/conversion/SchemaTranslation.html#kubernetes-bridge-custom-filters

  /**
   * List of data sources.
   */
  dataSources: string[];
}

/**
 * DataflowGraph graph node properties.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphGraphNode extends DataflowGraphNode {
  /**
   * Type of the graph node.
   */
  type: Graph;

  /**
   * Graph configuration.
   */
  graphSettings: DataflowGraphNodeGraphSettings;
}

/**
 * DataflowGraph graph node settings.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphNodeGraphSettings {
  /**
   * Reference to the registry endpoint for pulling the artifact.
   */
  registryEndpointRef: string;

  /**
   * The artifact name and version to pull.
   */
  artifact: string;

  /**
   * Configuration key-value pairs.
   */
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  configuration?: DataflowGraphGraphNodeConfiguration[];
}

/**
 * DataflowGraph graph node configuration.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphGraphNodeConfiguration {
  /**
   * Key of the configuration.
   */
  key: string;

  /**
   * Value of the configuration.
   */
  value: string;
}

/**
 * DataflowGraph destination node properties.
 */
@added(Versions.`2025-07-01-preview`)
model DatafloGraphDestinationNode extends DataflowGraphNode {
  /**
   * Type of the destination node.
   */
  type: Destination;

  /**
   * Destination configuration.
   */
  destinationSettings: DataflowGraphDestinationNodeSettings;
}

/**
 * DataflowGraph destination node settings.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphDestinationNodeSettings {
  /**
   * The endpoint reference for the destination.
   */
  endpointRef: string;

  /**
   * Data destination at the endpoint.
   */
  dataDestination: string;

  /**
   * Output schema settings.
   */
  outputSchemaSettings?: DataflowGraphSchemaSettings;
}

/**
 * DataflowGraph output schema settings.
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphSchemaSettings {
  /**
   * Output serialization format.
   */
  serializationFormat: DataflowGraphSerializationFormat;

  /**
   * Reference to the schema that describes the output of the transformation.
   */
  schemaRef?: string;
}

/**
 * Serialization format for dataflow graph.
 */
@added(Versions.`2025-07-01-preview`)
union DataflowGraphSerializationFormat { // Is this net new or should we just update TransformationSerializationFormat with Avro?
  TransformationSerializationFormat,

  /**
   * Avro serialization format.
   */
  Avro,
}

/**
 * DataflowGraph DataflowGraphNode Connection
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphNodeConnection {
  /**
   * Information about the source node.
   */
  from: DataflowGraphConnectionInput;

  /**
   * Information about the destination node.
   */
  to: DataflowGraphConnectionOutput;
}

/**
 * DataflowGraph DataflowGraphNode Connection Input
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionInput {
  /**
   * Name of the source node.
   */
  name: string;

  /**
   * Schema settings for the source node.
   */
  schema: DataflowGraphSchemaSettings;
}

/**
 * DataflowGraph DataflowGraphNode Connection Output
 */
@added(Versions.`2025-07-01-preview`)
model DataflowGraphConnectionOutput {
  /**
   * Name of the destination node.
   */
  name: string;
}
