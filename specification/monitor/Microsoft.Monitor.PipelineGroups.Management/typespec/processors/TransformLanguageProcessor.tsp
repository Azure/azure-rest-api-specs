/*
  Definitions of elements defined for Transform language processor.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

@doc("Transform language processor.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransformLanguageProcessor {
  @doc("Query to execute on data passing through the processor.")
  @minLength(1)
  @maxLength(10000)
  query: string;
}

@doc("Request to validate a query expression.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ValidateTransformLanguageQueryRequest {
  @doc("Query to validate.")
  @minLength(1)
  @maxLength(10000)
  query: string;
}

@doc("Response for the query validation.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ValidateTransformLanguageQueryResponse {
  @doc("Result of the query validation.")
  status: string;

  @doc("Optional error details if the validation failed.")
  error?: ValidateTransformLanguageQueryResponseError;
}

@doc("Error details for query validation failures.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ValidateTransformLanguageQueryResponseError {
  @doc("Type of the error.")
  type: string;

  @doc("Error message providing details about the validation failure.")
  message: string;
}
