import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";
import "./instance.tsp";
import "./pipeline.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.IoTOperationsDataProcessor;

@doc("The request properties to execute a test run.")
@added(Versions.Preview20240201)
model TestRunRequest {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("Configure where test run messages are sourced from.")
  dataSource: DataSourceBase;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("Map of stage IDs to stage configurations for all pipeline processing and output stages.")
  stages?: Record<PipelineStage>;
}

@doc("The response properties from a test run.")
@added(Versions.Preview20240201)
model TestRunResponse {
  @doc("Unordered list of every message state seen at a stages input and output.")
  @extension("x-ms-identifiers", [])
  messages?: Message[];

  @doc("Unordered list of the results from an individual stage processing a message.")
  @extension("x-ms-identifiers", ["stage"])
  executions?: ExecutionResult[];
}

@doc("The properties for a Message.")
@added(Versions.Preview20240201)
model Message {
  @doc("The partition key of the message.")
  partitionKey: string;

  @doc("ISO 8601 timestamp indicating when the message was ingested.")
  timestamp: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("The entire message object.")
  data: Record<unknown>;
}

@doc("The properties for a ExecutionResult.")
@added(Versions.Preview20240201)
model ExecutionResult {
  @doc("The stage id.")
  stage: string;

  @doc("Data field index of the input message.")
  input?: int64;

  @doc("Data field index of the output message.")
  output?: int64;

  @doc("Pipeline stage level error.")
  error?: string;

  @doc("Total execution time for the stage to complete.")
  @pattern("[-+]?([0-9]*(\\.[0-9]*)?(h|m|s|ms|us|ns))+")
  duration?: string;
}

#suppress "@azure-tools/typespec-azure-core/bad-record-type"
@doc("The data source properties.")
@added(Versions.Preview20240201)
@discriminator("type")
model DataSourceBase {}

@added(Versions.Preview20240201)
@doc("Data source input sampling is used to retrieve messages from the specified input stage.")
model DataSourceInputSampling extends DataSourceBase {
  @doc("InputSampling type.")
  type: DataSourceType.inputSampling;

  @doc("Sampling duration specifies the duration to wait before timing out he test run.")
  @pattern("[-+]?([0-9]*(\\.[0-9]*)?(h|m|s|ms|us|ns))+")
  samplingDuration: string;

  @doc("Sampling count specifies the number of messages to acquire for sampling.")
  @minValue(1)
  @maxValue(10)
  samplingCount: int64;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type"
  @doc("The input stage specifying where to retrieve messages from.")
  input: PipelineInput;
}

@added(Versions.Preview20240201)
@doc("Data source messages will be used directly to execute the test run.")
model DataSourceMessages extends DataSourceBase {
  @doc("Messages sampling type.")
  type: DataSourceType.messages;

  @doc("Messages retrieved from a previous test run.")
  @extension("x-ms-identifiers", [])
  messages: Message[];
}

@doc("The data source type that should be used to execute a test run.")
@added(Versions.Preview20240201)
enum DataSourceType {
  @doc("The input sampling data source type performs sampling from the provided input stage.")
  inputSampling,

  @doc("The messages data source type uses the provided messages directly.")
  messages,
}
