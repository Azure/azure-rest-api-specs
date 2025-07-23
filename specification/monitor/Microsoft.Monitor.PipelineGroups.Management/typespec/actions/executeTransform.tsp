/*
  Definitions of elements defined for the Transform action.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;
@doc("Request to execute a transform.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ExecuteTransformRequest {
  @doc("Transform statement to execute.")
  @minLength(1)
  @maxLength(10000)
  transformStatement: string;
}

@doc("Response for the execute transform request.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ExecuteTransformResponse {
  @doc("Validation information for the execute transform response.")
  validation: ExecuteTransformResponseValidation;
}

@doc("Validation information for the execute transform response.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model ExecuteTransformResponseValidation {
  @doc("Duration of validation portion of the transform execution in seconds.")
  duration: float32;
}
