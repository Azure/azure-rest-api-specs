import "@azure-tools/typespec-azure-core";

namespace Azure.AI.Agents;

@doc("Describes the error information returned by the agents API.")
model AgentErrorDetail {
  /** Human-readable description of the error. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  message?: string | null;

  /** Error type identifier (e.g. `invalid_request_error`). */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  type?: string | null;

  /** Name of the parameter that caused the error, if applicable. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  param?: string | null;

  /** Machine-readable error code. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  code?: string | null;
}

@doc("Error payload returned by the agents API.")
@error
model AgentV1Error {
  @doc("Represents the error.")
  error: AgentErrorDetail;
}

op AgentOperation<
  Params extends Reflection.Model,
  Response
> is Azure.Core.Foundations.Operation<
  Params,
  Response,
  ErrorResponse = AgentV1Error
>;
