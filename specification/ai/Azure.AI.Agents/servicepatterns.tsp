import "@azure-tools/typespec-azure-core";

namespace Azure.AI.Agents;

@doc("Agent error detail.")
model AgentErrorDetail {
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  @doc("The error message.")
  message?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  @doc("The error type.")
  type?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  @doc("The error param.")
  param?: string | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
  @doc("The error code.")
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
