import "../common/models.tsp";
import "../openai/evaluations/common.tsp";
import "../schedules/models.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const AllConditionalEvaluationRuleActionPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

@doc("Type of the evaluation action.")
union EvaluationRuleActionType {
  string,

  @doc("Continuous evaluation.")
  continuousEvaluation: "continuousEvaluation",

  @doc("Human evaluation.")
  @removed(Versions.v1)
  humanEvaluation: "humanEvaluation",

  @doc("Human evaluation preview.")
  humanEvaluationPreview: "humanEvaluationPreview",

  /** Evaluate agent traces using a configured schedule. */
  traceEvaluation: "trace_evaluation",

  /** Evaluate dataset inputs using a configured schedule. */
  datasetEvaluation: "dataset_evaluation",
}

/** Selects action types for List without changing the existing unfiltered results. */
union EvaluationRuleActionTypeFilter {
  /** Return rules matching the specified action type. */
  actionType: EvaluationRuleActionType,

  /** Return existing event rules and supported scheduled evaluations. This selector is not a rule action. */
  all: "all",
}

@doc("Evaluation action model.")
@discriminator("type")
model EvaluationRuleAction {
  @doc("Type of the evaluation action.")
  type: EvaluationRuleActionType;
}

@doc("Evaluation rule action for continuous evaluation.")
model ContinuousEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.continuousEvaluation;

  @doc("Eval Id to add continuous evaluation runs to.")
  evalId: string;

  @doc("Maximum number of evaluation runs allowed per hour.")
  maxHourlyRuns?: int32;

  @doc("Percentage (0-100] chance that a matching event triggers an evaluation. When omitted, the service-default is to evaluate every event, which is equivalent to setting a sampling rate of 100.")
  @minValueExclusive(0)
  @maxValue(100)
  samplingRate?: float64 = 100;
}

/** Configures a scheduled evaluation of observed agent traces. */
model TraceEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.traceEvaluation;

  /** Identifier of the evaluation used to score the selected traces. */
  @encodedName("application/json", "eval_id")
  evalId: string;

  /** Agent selection and query settings for each scheduled occurrence. */
  source: AgentTraceSource;
}

/** Configures a scheduled evaluation of dataset inputs. */
model DatasetEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.datasetEvaluation;

  /** Identifier of the evaluation used to score the dataset. */
  @encodedName("application/json", "eval_id")
  evalId: string;

  /** Dataset inputs selected for each scheduled occurrence. */
  source: DatasetSource;

  /** Optional existing evaluation target used to generate responses before scoring. */
  target?: FoundryEvaluationTarget;
}

/** Selects an agent's traces using the existing scheduled trace-query behavior. */
model AgentTraceSource {
  /** Identifies the agent-trace input configuration. */
  type: "agent_traces";

  /** Name of the agent whose traces are selected. */
  @encodedName("application/json", "agent_name")
  @minLength(1)
  agentName: string;

  /** Optional exact agent version used to filter traces. */
  @encodedName("application/json", "agent_version")
  agentVersion?: string;

  /** Trace-query lookback in hours. When omitted, use the scheduler's existing behavior. */
  @encodedName("application/json", "lookback_hours")
  @minValue(1)
  lookbackHours?: int32;

  /** Maximum number of traces sampled for an evaluation run. */
  @encodedName("application/json", "max_traces")
  @minValue(1)
  maxTraces?: int32;
}

/** References an exact version of a dataset for scheduled evaluation. */
model DatasetSource {
  /** Identifies a versioned dataset input. */
  type: "dataset";

  /** Name of the dataset containing evaluation inputs. */
  @encodedName("application/json", "dataset_name")
  @minLength(1)
  datasetName: string;

  /** Exact immutable dataset version; mutable aliases such as latest are not supported. */
  @encodedName("application/json", "dataset_version")
  @minLength(1)
  datasetVersion: string;
}

@doc("Evaluation rule action for human evaluation.")
@removed(Versions.v1)
model HumanEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.humanEvaluation;

  @doc("Human evaluation template Id.")
  templateId: AssetId;
}

@doc("Evaluation rule action for human evaluation.")
@extension("x-ms-foundry-meta", AllConditionalEvaluationRuleActionPreviews)
model HumanEvaluationPreviewRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.humanEvaluationPreview;

  @doc("Human evaluation template Id.")
  templateId: AssetId;
}

@doc("Identifier of a saved asset.")
scalar AssetId extends string;

@doc("Evaluation filter model.")
model EvaluationRuleFilter {
  @doc("Filter by agent name.")
  agentName: string;
}

@doc("Type of the evaluation rule event.")
union EvaluationRuleEventType {
  string,

  @doc("Response completed.")
  responseCompleted: "responseCompleted",

  @doc("Manual trigger.")
  manual: "manual",

  /** Execute the evaluation using the rule's configured schedule. */
  timeTrigger: "time_trigger",
}

@doc("Evaluation rule model.")
@resource("evaluationrules")
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
  @extension("x-ms-foundry-meta", AllConditionalEvaluationRuleActionPreviews)
  action: EvaluationRuleAction;

  @doc("Filter condition of the evaluation rule.")
  filter?: EvaluationRuleFilter;

  @doc("Event type that the evaluation rule applies to.")
  eventType: EvaluationRuleEventType;

  /** Timing for time_trigger rules. Required for time_trigger and forbidden for other events. Reuses existing Cron, Recurrence, and OneTime triggers. */
  schedule?: Trigger;

  @doc("Indicates whether the evaluation rule is enabled. Default is true.")
  enabled: boolean;

  @visibility(Lifecycle.Read)
  @doc("System metadata for the evaluation rule.")
  systemData: Record<string>;
}
