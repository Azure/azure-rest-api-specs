// Cleaned TypeSpec file aligned with Python model definitions
// Removed models not defined or needed based on your Python code baseline
import "@typespec/http";
import "@typespec/openapi";
using TypeSpec.OpenAPI;

namespace VoiceLive;

@doc("Error object returned in case of API failure.")
model ErrorDetails {
  @doc("Error code, or null if unspecified.")
  code?: string;

  @doc("Human-readable error message.")
  message: string;

  @doc("Parameter name related to the error, if applicable.")
  param?: string;

  @doc("Type or category of the error.")
  type?: string;

  @doc("Event id of the error.")
  event_id?: string;
}

@error
@doc("Standard error response envelope.")
model ErrorResponse {
  @doc("Error object returned in case of API failure.")
  error: ErrorDetails;
}

@doc("A single log probability entry for a token.")
model LogProbProperties {
  @doc("The token that was used to generate the log probability.")
  token: string;

  @doc("The log probability of the token.")
  logprob: float32;

  @doc("The bytes that were used to generate the log probability.")
  bytes: int32[];
}