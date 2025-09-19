import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@route("agents/{agentId}/humanEvaluations")
@added(Versions.v2025_10_15_preview)
@doc("Manage human evaluations for a specific agent.")
interface HumanEvaluations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get all evaluation template used with this agent.")
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the agent.")
      @path
      agentId: string;

      @doc("Whether to return only active templates. If omitted, all templates will be returned.")
      @query
      active?: boolean;
    },
    OkResponse<AgentHumanEvaluations>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update a reference to an evaluation template for this agent.")
  put is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the agent.")
      @path
      agentId: string;

      @doc("Request body to update an existing human evaluation template reference.")
      @body
      body: HumanEvaluationTemplateReference;
    },
    OkResponse<HumanEvaluationTemplateReference>
  >;
}
