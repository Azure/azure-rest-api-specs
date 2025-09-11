import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.Monitor;

@doc("Duration in HH:MM:SS format (e.g. 00:01:00) to match service response.")
@pattern("^[0-9]{2}:[0-9]{2}:[0-9]{2}$")
scalar HmsDuration extends string;

@doc("Represents the result of a KQL-M query.")
model KqlmQueryResult {
  @doc("The request ID.")
  requestId?: string;

  @doc("The query state.")
  state: QueryState;

  @doc("The list of time series sets, where each set represents results for a query statement.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  timeSeriesSets: TimeSeriesSet[];

  @doc("The list of KQL-M query execution messages.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  executionMessages: ExecutionMessage[];
}

@doc("Represents the state of a KQL-M query.")
union QueryState {
  @doc("Query succeeded.")
  Success: "Success",

  @doc("Query failed.")
  Failed: "Failed",

  string,
}

@doc("Represents a set of time series results for a query statement.")
model TimeSeriesSet {
  @doc("The KQL-M query result metadata.")
  resultsMetadata: ResultsMetadata;

  @doc("The list of time series data.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  timeSeriesData: TimeSeriesData[];
}

@doc("Represents metadata for a KQL-M query result.")
model ResultsMetadata {
  @doc("The start time for the KQL-M query result.")
  startTimeUtc: utcDateTime;

  @doc("The end time for the KQL-M query result.")
  endTimeUtc: utcDateTime;

  @doc("The data resolution of the KQL-M query result in HH:MM:SS format.")
  dataResolution: HmsDuration;

  @doc("The list of output dimensions of the KQL-M query result.")
  resultantDimensions: string[];

  @doc("The list of output sampling types of the KQL-M query result.")
  resultantSamplingTypes: string[];

  @doc("The number of datapoints in the KQL-M query result.")
  datapointsCount: int64;
}

@doc("Dictionary of dimension names to dimension values.")
model DimensionValuesDictionary {
  ...Record<string>;
}

@doc("Dictionary of sampling types to metric values.")
model SamplingTypesDataDictionary {
  ...Record<float64[]>;
}

@doc("Represents a time series data entry.")
model TimeSeriesData {
  @doc("The dictionary of dimension names to dimension values.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  dimensionValues: DimensionValuesDictionary;

  @doc("The dictionary of sampling types to metric values (as list of doubles).")
  @OpenAPI.extension("x-ms-identifiers", #[])
  samplingTypesData: SamplingTypesDataDictionary;
}

@doc("Represents a KQL-M query execution message.")
model ExecutionMessage {
  @doc("The message severity.")
  severity: MessageSeverity;

  @doc("The message text.")
  text: string;

  @doc("The message documentation link.")
  documentationLink: string;

  @doc("The message statement context.")
  statementContext: StatementContextInformation;
}

@doc("Represents the severity of a message.")
union MessageSeverity {
  @doc("Error message.")
  Error: "Error",

  @doc("Warning message.")
  Warning: "Warning",

  @doc("Informational message.")
  Info: "Info",

  string,
}

@doc("Represents statement context information for a message.")
model StatementContextInformation {
  @doc("The line number in the input where the error occurred.")
  lineNumber: int32;

  @doc("The character position within that line where the error occurred.")
  charPositionInLine: int32;

  @doc("The character position within the entire statement text where the error occurred.")
  charPositionAbsolute: int32;

  @doc("Length of text section which caused an error.")
  errorSectionLength: int32;
}
