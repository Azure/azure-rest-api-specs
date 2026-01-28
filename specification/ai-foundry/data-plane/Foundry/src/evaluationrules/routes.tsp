import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias EvaluationRuleOperations = FoundryAzureOperations<WithRequiredFoundryPreviewHeader<FoundryPreviewOptInKeys.evaluations_v1>>;

@tag("EvaluationRules")
interface EvaluationRules {
  // GET /evaluationrules/{id}
  @doc("Get an evaluation rule.")
  get is EvaluationRuleOperations.ResourceRead<EvaluationRule>;

  // DELETE /evaluationrules/{id}
  @doc("Delete an evaluation rule.")
  delete is EvaluationRuleOperations.ResourceDelete<EvaluationRule>;

  // PUT /evaluationrules/{id}
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update an evaluation rule.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    EvaluationRule,
    {
      @doc("Evaluation rule resource")
      @Http.bodyRoot
      evaluationRule: EvaluationRule;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluationRule>
  >;

  // GET /evaluationrules
  @doc("List all evaluation rules.")
  list is EvaluationRuleOperations.ResourceList<
    EvaluationRule,
    ListQueryParametersTrait<{
      @query("actionType")
      @doc("Filter by the type of evaluation rule.")
      actionType?: EvaluationRuleActionType;

      @query("agentName")
      @doc("Filter by the agent name.")
      agentName?: string;

      @query("enabled")
      @doc("Filter by the enabled status.")
      enabled?: boolean;
    }>
  >;
}
