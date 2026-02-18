import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias EvaluationRulesPreviewHeader = WithConditionalFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

alias EvaluationRulesFilterQueryParams = {
  @query("actionType")
  @doc("Filter by the type of evaluation rule.")
  actionType?: EvaluationRuleActionType;

  @query("agentName")
  @doc("Filter by the agent name.")
  agentName?: string;

  @query("enabled")
  @doc("Filter by the enabled status.")
  enabled?: boolean;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Evaluation Rules")
interface EvaluationRules {
  // GET /evaluationrules/{id}
  @doc("Get an evaluation rule.")
  get is Azure.Core.Foundations.ResourceOperation<
    EvaluationRule,
    {},
    Azure.Core.Foundations.ResourceOkResponse<EvaluationRule>
  >;

  // DELETE /evaluationrules/{id}
  @doc("Delete an evaluation rule.")
  @Http.delete
  delete is Azure.Core.Foundations.ResourceOperation<
    EvaluationRule,
    {},
    Http.NoContentResponse
  >;

  // PUT /evaluationrules/{id}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update an evaluation rule.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    EvaluationRule,
    {
      ...EvaluationRulesPreviewHeader;

      @doc("Evaluation rule resource")
      @Http.bodyRoot
      evaluationRule: EvaluationRule;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluationRule>
  >;

  // GET /evaluationrules
  @doc("List all evaluation rules.")
  @Rest.listsResource(EvaluationRule)
  list is Azure.Core.Foundations.ResourceList<
    EvaluationRule,
    EvaluationRulesFilterQueryParams,
    Azure.Core.Page<EvaluationRule>
  >;
}
