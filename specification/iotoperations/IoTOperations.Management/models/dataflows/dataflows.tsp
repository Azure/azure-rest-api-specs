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
model DataFlowResource is TrackedResource<DataFlowProperties> {
  @doc("Name of Instance dataflowProfile dataflow resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("dataflowName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("dataflows")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("DataFlow Resource properties")
model DataFlowProperties {
  @doc("Mode for DataFlow. Optional; defaults to Enabled.")
  mode?: Mode = Mode.Enabled;

  @doc("List of operations including source and destination references as well as transformation.")
  @OpenAPI.extension("x-ms-identifiers", [])
  operations: DataFlowOperation[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("DataFlow Operation properties. NOTE - One only method is allowed to be used for one entry.")
model DataFlowOperation {
  @doc("Transformation configuration.")
  builtInTransformation?: DataFlowBuiltInTransformation;

  @doc("Destination configuration.")
  destination: DataFlowDestinationOperation;

  @doc("Source configuration.")
  source: DataFlowSourceOperation;
}

@doc("DataFlow BuiltIn Transformation properties")
model DataFlowBuiltInTransformation {
  @doc("Enrich data from MQ State Store. Dataset references a key in MQ State Store.")
  @OpenAPI.extension("x-ms-identifiers", [])
  enrich?: DataFlowBuiltInTransformationEnrich[] = #[];

  @doc("Filters input record or datapoints based on condition.")
  @OpenAPI.extension("x-ms-identifiers", [])
  filter?: DataFlowBuiltInTransformationFilter[] = #[];

  @doc("Name of the transformation.")
  name: string;

  @doc("Maps input to output message.")
  @OpenAPI.extension("x-ms-identifiers", [])
  map?: DataFlowBuiltInTransformationMap[] = #[];

  @doc("Serialization format. Optional; defaults to JSON.")
  serializationFormat?: TransformationSerializationFormat = TransformationSerializationFormat.Json;

  @doc("Schema CR reference.")
  schemaRef?: string;
}

@doc("DataFlow BuiltIn Transformation enrich properties")
model DataFlowBuiltInTransformationEnrich {
  @doc("Condition to enrich data from MQ State Store.")
  condition: string;

  @doc("Dataset reference key in MQ State Store.")
  dataset: string;
}

@doc("DataFlow BuiltIn Transformation filter properties")
model DataFlowBuiltInTransformationFilter {
  @doc("Condition to filter data. Can reference input fields with {n} where n is the index of the input field starting from 1.")
  condition: string;

  @doc("List of fields for filtering in JSON path expression.")
  inputs: string[];
}

@doc("DataFlow BuiltIn Transformation map properties")
model DataFlowBuiltInTransformationMap {
  @doc("Modify the inputs field(s) to the final output field.")
  conversion?: string;

  @doc("List of fields for mapping in JSON path expression.")
  inputs: string[];

  @doc("Where and how the input fields to be organized in the output record.")
  output: string;
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
}

@doc("DataFlow Destination Operation properties")
model DataFlowDestinationOperation {
  @doc("Reference to the Endpoint CR. Can be of MQTT, Kafka, Fabric, ADLS, ADX type.")
  endpointRef: string;

  @doc("Name of the destination.")
  name: string;

  @doc("Destination path, can be a topic or table name. Supports dynamic values with $topic, $systemProperties, $userProperties, $payload, $context, and $subscription.")
  path: string;
}

@doc("DataFlow Source Operation properties")
model DataFlowSourceOperation {
  @doc("Reference to the Endpoint CR. Can only be of MQTT and Kafka type.")
  endpointRef: string;

  @doc("Name of the source.")
  name: string;

  @doc("List of source paths. Can be MQTT or Kafka topics. Supports wildcards # and +.")
  paths: string[];

  @doc("Serialization format. Optional; defaults to JSON.")
  serializationFormat?: SourceSerializationFormat = SourceSerializationFormat.Json;

  @doc("Schema CR reference. Data will be deserialized according to the schema, and dropped if it doesn't match.")
  schemaRef?: string;
}
