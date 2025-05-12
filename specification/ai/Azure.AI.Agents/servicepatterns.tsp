import "@azure-tools/typespec-azure-core";

@Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace ServicePatterns;

@doc("Agent error response.")
@error
model AgentV1Error {
    @doc("Represents the error.")
    error: {
        #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
        code?: string | null;
        #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI compatible/openai uses optional nullable"
        message?: string | null;
    }
}

op AgentOperation<Params extends Reflection.Model, Response> is Azure.Core.Foundations.Operation<Params, Response, ErrorResponse = AgentV1Error>;