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

  ...ResourceHealth;
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

  /** Headers for the output data. */
  @identifiers(#["actionType"])
  @added(Versions.`2025-10-01`)
  headers?: DataflowGraphDestinationHeaderAction[];

  /** Output schema settings. */
  @removed(Versions.`2025-10-01`)
  outputSchemaSettings?: DataflowGraphDestinationSchemaSettings;
}

/** DataflowGraph destination node output schema settings. */
@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2025-10-01`)
model DataflowGraphDestinationSchemaSettings {
  /** The format of the output data. */
  serializationFormat: DataflowGraphDestinationSchemaSerializationFormat;

  /** Reference to the schema that describes the output of the transformation. */
  schemaRef?: string;
}

/** Serialization format for dataflow graph. */
@added(Versions.`2025-07-01-preview`)
@removed(Versions.`2025-10-01`)
union DataflowGraphDestinationSchemaSerializationFormat {
  string,

  /** Parquet serialization format. */
  Parquet,

  /** Delta serialization format. */
  Delta,
}

/** DataflowGraph Destination Header Action. */
@added(Versions.`2025-10-01`)
@discriminator("actionType")
model DataflowGraphDestinationHeaderAction {
  /** The type of header operation to perform. */
  actionType: DataflowGraphDestinationHeaderActionType;
}

/** DataflowGraph Destination Header Action Types. */
@added(Versions.`2025-10-01`)
union DataflowGraphDestinationHeaderActionType {
  string,

  /** Add if not present type. */
  AddIfNotPresent,

  /** Remove type. */
  Remove,

  /** Add or Replace type. */
  AddOrReplace,
}

/** DataflowGraph Destination Add if not present HeaderAction properties. */
@added(Versions.`2025-10-01`)
model DataflowGraphDestinationAddIfNotPresentHeaderAction
  extends DataflowGraphDestinationHeaderAction {
  actionType: AddIfNotPresent;

  /** The name of the header to add. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  key: string;

  /** The value of the header to add. */
  value: string;
}

/** DataflowGraph Destination Remove HeaderAction properties. */
@added(Versions.`2025-10-01`)
model DataflowGraphDestinationRemoveHeaderAction
  extends DataflowGraphDestinationHeaderAction {
  actionType: Remove;

  /** The name of the header to remove. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  key: string;
}

/** DataflowGraph Destination Add or Replace HeaderAction properties. */
@added(Versions.`2025-10-01`)
model DataflowGraphDestinationAddOrReplaceHeaderAction
  extends DataflowGraphDestinationHeaderAction {
  actionType: AddOrReplace;

  /** The name of the header to add or replace. */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  key: string;

  /** The value of the header to add or replace. */
  value: string;
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
