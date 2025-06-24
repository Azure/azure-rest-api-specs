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

@doc("Request to validate a TransformLanguageProcessor definition.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ValidateTransformLanguageProcessorRequest {
  @doc("Query to validate.")
  @minLength(1)
  @maxLength(10000)
  query: string;
}

@doc("Response for the TransformLanguageProcessor validation.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ValidateTransformLanguageProcessorResponse {
  @doc("Result of the query validation.")
  status: string;

  @doc("Optional error details if the validation failed.")
  error?: ValidateTransformLanguageProcessorResponseError;
}

@doc("Error details for TransformLanguageProcessor validation failures.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ValidateTransformLanguageProcessorResponseError {
  @doc("Type of the error.")
  type: string;

  @doc("Error message providing details about the validation failure.")
  message: string;
}
