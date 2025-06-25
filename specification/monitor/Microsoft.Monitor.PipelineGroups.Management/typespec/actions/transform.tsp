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
  @doc("Validation information for the transform request.")
  validation: TransfromResponseValidation;
}

@doc("Validation information for the transform request.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TransfromResponseValidation {
  @doc("Whether the transform statement is syntactically valid or not.")
  syntaxValid: boolean;
}
