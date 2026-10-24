import "../../ApiVersions.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Describes an error reported while processing a resource.")
@added(ApiVersions.v2026_09_01_preview)
model OperationError {
  @doc("The error identifier.")
  id: int32;

  @doc("The error code.")
  code: string;

  @doc("The error severity.")
  severity: string;

  @doc("The error summary.")
  summaryMessage?: string;

  @doc("The detailed error message.")
  message: string;

  @doc("The error category.")
  category?: string;

  @doc("The UTC timestamp when the error occurred.")
  timestamp: utcDateTime;

  @doc("The possible causes of the error.")
  possibleCauses?: string;

  @doc("The recommended actions for the error.")
  recommendedActions?: string;
}
