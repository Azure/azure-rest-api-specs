import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias EvaluationRulesPreviewHeader = WithConditionalFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

alias EvaluationRulesFilterQueryParams = {
  /** The action type query parameter. */
  @query("actionType")
  @doc("Select an action type, or all to include existing event rules and supported schedules. When omitted, return only existing event-rule types. trace_evaluation and dataset_evaluation select their scheduled evaluations explicitly; existing action filters retain their behavior.")
  actionType?: EvaluationRuleActionTypeFilter;

  /** The agent name query parameter. */
  @query("agentName")
  @doc("Filter by the agent name.")
  agentName?: string;

  /** The enabled query parameter. */
  @query("enabled")
  @doc("Filter by the enabled status.")
  enabled?: boolean;
};

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We are using service specific operation templates"
@tag("Evaluation Rules")
interface EvaluationRules {
  // GET /evaluationrules/{id}
  /** Retrieves the specified evaluation rule and its configuration. */
  @summary("Get an evaluation rule")
  get is FoundryResourceOperation<
    EvaluationRule,
    {},
    Azure.Core.Foundations.ResourceOkResponse<EvaluationRule>
  >;

  // DELETE /evaluationrules/{id}
  /** Removes the specified evaluation rule from the project. */
  @summary("Delete an evaluation rule")
  @Http.delete
  delete is FoundryResourceOperation<
    EvaluationRule,
    {},
    Http.NoContentResponse
  >;

  // PUT /evaluationrules/{id}
  /** Creates a new evaluation rule, or replaces the existing rule when the identifier matches. */
  @summary("Create or update an evaluation rule")
  @Http.put
  createOrUpdate is FoundryResourceOperation<
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
  /** Returns existing event rules by default. Use actionType=all for the combined collection, or trace_evaluation or dataset_evaluation for scheduled evaluations of that type. Agent and enabled filters still apply, and results remain paginated. */
  @summary("List evaluation rules")
  @Rest.listsResource(EvaluationRule)
  list is FoundryResourceList<
    EvaluationRule,
    EvaluationRulesFilterQueryParams,
    Azure.Core.Page<EvaluationRule>
  >;
}
