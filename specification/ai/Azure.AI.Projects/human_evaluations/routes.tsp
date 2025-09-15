import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@route("agents/{agentId}/humanEvaluations")
@added(Versions.v2025_05_15_preview)
@doc("Manage human evaluations for a specific agent.")
interface HumanEvaluations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get all evaluation template associated with this agent.")
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the agent.")
      @path
      agentId: string;

      @doc("Whether to return only active associations. If omitted, all associations are returned.")
      @query
      active?: boolean;
    },
    OkResponse<HumanEvaluation>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update an association between an evaluation template and this agent.")
  put is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the agent.")
      @path
      agentId: string;

      @doc("Request body to update an existing human evaluation template association.")
      @body
      body: HumanEvaluationAssociation;
    },
    OkResponse<HumanEvaluationAssociation>
  >;
}
