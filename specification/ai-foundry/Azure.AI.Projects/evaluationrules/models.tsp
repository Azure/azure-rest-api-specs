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
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union EvaluationRuleActionType {
  string,

  @doc("Continuous evaluation.")
  continuousEvaluation: "continuousEvaluation",

  @doc("Human evaluation.")
  humanEvaluation: "humanEvaluation",
}

@doc("Evaluation action model.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@discriminator("type")
model EvaluationRuleAction {
  @doc("Type of the evaluation action.")
  type: EvaluationRuleActionType;
}

@doc("Evaluation rule action for continuous evaluation.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model ContinuousEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.continuousEvaluation;

  @doc("Eval Id to add continuous evaluation runs to.")
  evalId: string;

  @doc("Maximum number of evaluation runs allowed per hour.")
  maxHourlyRuns?: int32;
}

@doc("Evaluation rule action for human evaluation.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model HumanEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.humanEvaluation;

  @doc("Human evaluation template Id.")
  templateId: AssetId;
}

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
@doc("Identifier of a saved asset.")
scalar AssetId extends string;

@doc("Evaluation filter model.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model EvaluationRuleFilter {
  @doc("Filter by agent name.")
  agentName: string;
}

@doc("Type of the evaluation rule event.")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
union EvaluationRuleEventType {
  string,

  @doc("Response completed.")
  responseCompleted: "response.completed",

  @doc("Manual trigger.")
  manual: "manual",
}

@doc("Evaluation rule model.")
@resource("evaluationrules")
@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
model EvaluationRule {
  @doc("Unique identifier for the evaluation rule.")
  @key
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Display Name for the evaluation rule.")
  displayName?: string;

  @doc("Description for the evaluation rule.")
  description?: string;

  @doc("Definition of the evaluation rule action.")
  action: EvaluationRuleAction;

  @doc("Filter condition of the evaluation rule.")
  filter?: EvaluationRuleFilter;

  @doc("Event type that the evaluation rule applies to.")
  eventType: EvaluationRuleEventType;

  @doc("Indicates whether the evaluation rule is enabled. Default is true.")
  enabled: boolean;

  @visibility(Lifecycle.Read)
  @doc("System metadata for the evaluation rule.")
  systemData: Record<string>;
}
