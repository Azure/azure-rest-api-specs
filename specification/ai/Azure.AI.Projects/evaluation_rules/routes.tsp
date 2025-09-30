import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "./models.tsp";
import "../servicepatterns.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Projects;

alias EvaluationRuleTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias EvaluationRuleOperations = Azure.Core.ResourceOperations<EvaluationRuleTraits>;

@added(Versions.v2025_10_15_preview)
interface EvaluationRules {
  // GET /evaluation_rules/{name}
  @doc("Get an evaluation rule.")
  getEvaluationRule is EvaluationRuleOperations.ResourceRead<EvaluationRule>;

  // DELETE /evaluation_rules/{name}
  @doc("Delete an evaluation rule.")
  delete is EvaluationRuleOperations.ResourceDelete<EvaluationRule>;

  // POST /evaluation_rules/{name}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update an evaluation rule.")
  @Http.post
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    EvaluationRule,
    {
      @doc("Evaluation rule resource")
      @Http.bodyRoot
      evaluationRule: EvaluationRule;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluationRule>
  >;

  // GET /evaluation_rules
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @get
  @doc("List all evaluation rules.")
  @route("/evaluation_rules")
  listEvaluationRules(
    @doc("List evaluation rules of this action type.")
    @query("action_type")
    actionType?: EvaluationRuleActionType,

    @doc("List evaluation rules with filter for this agent name.")
    @query("agent_name")
    agentName?: string,

    ...ApiVersionParameter,
  ): OpenAIPageableListOf<EvaluationRule>;
}
