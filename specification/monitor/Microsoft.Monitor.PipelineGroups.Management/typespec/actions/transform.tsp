/*
  Definitions of elements defined for the Transform action.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;
@doc("Request to execute a transform.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransformRequest {
  @doc("Transform statement to execute.")
  @minLength(1)
  @maxLength(10000)
  transformStatement: string;
}

@doc("Response for the transform request.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransformResponse {
  @doc("Result of the transform.")
  status: string;

  @doc("Optional error details if the transform failed.")
  error?: TransformResponseError;
}

@doc("Error details for transform failures.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransformResponseError {
  @doc("Type of the error.")
  type: string;

  @doc("Error message providing details about the failure.")
  message: string;
}