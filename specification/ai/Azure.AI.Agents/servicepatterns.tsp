import "@azure-tools/typespec-azure-core";

@Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace ServicePatterns;

@doc("Error payload returned by the agents API.")
@error
model AgentV1Error {
  @doc("Represents the error.")
  error: {
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
    message?: string | null;
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
    type?: string | null;
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
    param?: string | null;
    #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
    code?: string | null;
  };
}

op AgentOperation<
  Params extends Reflection.Model,
  Response
> is Azure.Core.Foundations.Operation<
  Params,
  Response,
  ErrorResponse = AgentV1Error
>;
