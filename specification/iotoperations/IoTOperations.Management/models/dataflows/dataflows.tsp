import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/** ******************* */
/**
 * dataflow resource type model details.
 */
@doc("Instance dataflowProfile dataflow resource")
@parentResource(DataFlowProfileResource)
model DataFlowResource is ProxyResource<DataFlowProperties> {
  @doc("Name of Instance dataflowProfile dataflow resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflows")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("DataFlow Resource properties")
model DataFlowProperties {
  @doc("Reference to the DataflowProfile CR.")
  profileRef: string;

  @doc("Mode for DataFlow. Optional; defaults to Enabled.")
  mode?: OperationalMode = OperationalMode.Enabled;

  @doc("List of operations including source and destination references as well as transformation.")
  @OpenAPI.extension("x-ms-identifiers", [])
  operations: DataFlowOperation[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataFlow Operation properties. NOTE - One only method is allowed to be used for one entry.")
model DataFlowOperation {
  @doc("Type of operation.")
  operationType: OperationType;

  @doc("Optional user provided name of the transformation.")
  @maxLength(64)
  name?: string;

  @doc("Transformation configuration.")
  builtInTransformationSettings?: DataFlowBuiltInTransformation;

  @doc("Destination configuration.")
  destinationSettings: DataFlowDestinationOperation;

  @doc("Source configuration.")
  sourceSettings: DataFlowSourceOperation;
}

@doc("DataFlow Operation Type properties")
union OperationType {
  string,

  @doc("DataFlow Source Operation")
  Source: "Source",

  @doc("DataFlow Destination Operation")
  Destination: "Destination",

  @doc("DataFlow BuiltIn Transformation Operation")
  BuiltInTransformation: "BuiltInTransformation",
}

@doc("DataFlow BuiltIn Transformation properties")
model DataFlowBuiltInTransformation {
  @doc("Serialization format. Optional; defaults to JSON. Allowed value JSON Schema/draft-7, Parquet. Default: Json")
  serializationFormat?: TransformationSerializationFormat = TransformationSerializationFormat.Json;

  @doc("Reference to the schema that describes the output of the transformation.")
  schemaRef?: string;

  @doc("Enrich data from Broker State Store. Dataset references a key in Broker State Store.")
  @maxItems(1)
  @OpenAPI.extension("x-ms-identifiers", [])
  datasets?: DataFlowBuiltInTransformationDataset[] = #[];

  @doc("Filters input record or datapoints based on condition.")
  @OpenAPI.extension("x-ms-identifiers", [])
  filter?: DataFlowBuiltInTransformationFilter[] = #[];

  @doc("Maps input to output message.")
  @OpenAPI.extension("x-ms-identifiers", [])
  map?: DataFlowBuiltInTransformationMap[] = #[];
}

@doc("DataFlow BuiltIn Transformation dataset properties")
model DataFlowBuiltInTransformationDataset {
  @doc("The key of the dataset.")
  @maxLength(64)
  key: string;

  @doc("A user provided optional description of the dataset.")
  @maxLength(256)
  description?: string;

  @doc("The reference to the schema that describes the dataset. Allowed: JSON Schema/draft-7.")
  schemaRef?: string;

  @doc("List of fields for enriching from the Broker State Store.")
  inputs: string[];

  @doc("Condition to enrich data from Broker State Store. Example: $1 < 0 || $1 > $2 (Assuming inputs section $1 and $2 are provided)")
  expression?: string;
}

@doc("DataFlow BuiltIn Transformation filter properties")
model DataFlowBuiltInTransformationFilter {
  @doc("The type of dataflow operation.")
  type?: FilterType = FilterType.Filter;

  @doc("A user provided optional description of the filter.")
  @maxLength(256)
  description?: string;

  @doc("List of fields for filtering in JSON path expression.")
  inputs: string[];

  @doc("Condition to filter data. Can reference input fields with {n} where n is the index of the input field starting from 1. Example: $1 < 0 || $1 > $2 (Assuming inputs section $1 and $2 are provided)")
  expression: string;
}

@doc("Filter Type properties")
union FilterType {
  string,

  @doc("Filter type")
  Filter: "Filter",
}

@doc("DataFlow BuiltIn Transformation map properties")
model DataFlowBuiltInTransformationMap {
  @doc("Type of transformation.")
  type?: DataFlowMappingType;

  @doc("A user provided optional description of the mapping function.")
  @maxLength(256)
  description?: string;

  @doc("List of fields for mapping in JSON path expression.")
  inputs: string[];

  @doc("Modify the inputs field(s) to the final output field. Example: $1 * 2.2 (Assuming inputs section $1 is provided)")
  expression?: string;

  @doc("Where and how the input fields to be organized in the output record.")
  output: string;
}

@doc("DataFlow type mapping properties")
union DataFlowMappingType {
  string,

  @doc("New Properties type")
  NewProperties: "NewProperties",

  @doc("Rename type")
  Rename: "Rename",

  @doc("Compute type")
  Compute: "Compute",

  @doc("Pass-through type")
  PassThrough: "PassThrough",

  @doc("Built in function type")
  BuiltInFunction: "BuiltInFunction",
}

@doc("Serialization Format properties")
union SourceSerializationFormat {
  string,

  @doc("JSON Format")
  Json: "Json",
}

@doc("Transformation Format properties")
union TransformationSerializationFormat {
  string,

  @doc("Delta Format")
  Delta: "Delta",

  @doc("JSON Format")
  Json: "Json",

  @doc("Parquet Format")
  Parquet: "Parquet",
}

@doc("DataFlow Destination Operation properties")
model DataFlowDestinationOperation {
  @doc("Reference to the Endpoint CR. Can be of Broker, Kafka, Fabric, ADLS, ADX type.")
  endpointRef: string;

  @doc("Destination location, can be a topic or table name. Supports dynamic values with $topic, $systemProperties, $userProperties, $payload, $context, and $subscription.")
  dataDestination: string;
}

@doc("DataFlow Source Operation properties")
model DataFlowSourceOperation {
  @doc("Reference to the Dataflow Endpoint resource. Can only be of Broker and Kafka type.")
  endpointRef: string;

  @doc("Reference to the resource in Azure Device Registry where the data in the endpoint originates from.")
  assetRef?: string;

  @doc("Content is a JSON Schema. Allowed: JSON Schema/draft-7.")
  serializationFormat?: SourceSerializationFormat = SourceSerializationFormat.Json;

  @doc("Schema CR reference. Data will be deserialized according to the schema, and dropped if it doesn't match.")
  schemaRef?: string;

  @doc("List of source locations. Can be Broker or Kafka topics. Supports wildcards # and +.")
  dataSources: string[];
}
