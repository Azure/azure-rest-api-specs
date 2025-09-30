import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Type of the evaluation action.")
@added(Versions.v2025_10_15_preview)
union EvaluationRuleActionType {
  string,

  @doc("Continuous evaluation.")
  continuous_evaluation: "continuous_evaluation",

  @doc("Human evaluation.")
  human_evaluation: "human_evaluation",
}

@doc("Evaluation action model.")
@added(Versions.v2025_10_15_preview)
@discriminator("type")
model EvaluationRuleAction {
  @doc("Type of the evaluation action.")
  type: EvaluationRuleActionType;
}

@doc("Evaluation rule action for continuous evaluation.")
@added(Versions.v2025_10_15_preview)
model ContinuousEvaluationRuleAction {
  @doc("Eval Id to add continuous evaluation runs to.")
  eval_id: string;

  @doc("Maximum number of evaluation runs allowed per hour.")
  max_hourly_runs?: int32;
}

@doc("Evaluation rule action for continuous evaluation.")
@added(Versions.v2025_10_15_preview)
model HumanEvaluationRuleAction {
  @doc("Human evaluation template Id.")
  template_id: AssetId;
}

@added(Versions.v2025_10_15_preview)
@doc("Identifier of a saved asset.")
scalar AssetId extends string;

@doc("Evaluation filter model.")
@added(Versions.v2025_10_15_preview)
model EvaluationRuleFilter {
  @doc("Filter by agent name.")
  agent_name: string;
}

@doc("Type of the evaluation rule event.")
@added(Versions.v2025_10_15_preview)
union EvaluationRuleEventType {
  string,

  @doc("Response completed.")
  response_completed: "response.completed",

  @doc("Manual trigger.")
  manual: "manual",
}

@doc("Evaluation rule model.")
@resource("evaluation_rules")
@added(Versions.v2025_10_15_preview)
model EvaluationRule {
  @doc("Unique identifier for the evaluation rule.")
  @key
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Description for the evaluation rule.")
  description?: string;

  @doc("Metadata about the evaluation rule.")
  metadata?: Record<string>;

  @doc("Definition of the evaluation rule action.")
  action: EvaluationRuleAction;

  @doc("Filter condition of the evaluation rule.")
  filter?: EvaluationRuleFilter;

  @doc("Event types that the evaluation rule applies to.")
  event_types: EvaluationRuleEventType[];

  @doc("Indicates whether the evaluation rule is disabled. Default is false.")
  disabled: boolean = false;

  @visibility(Lifecycle.Read)
  @doc("Creation date/time of the evaluation rule.")
  created_at: string;
}
