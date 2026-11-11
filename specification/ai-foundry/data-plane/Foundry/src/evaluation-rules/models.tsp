import "../common/models.tsp";
import "../openai/evaluations/models.tsp";
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

  /** Evaluate agent traces on the rule's schedule. */
  traceEvaluation: "traceEvaluation",

  /** Evaluate dataset inputs on the rule's schedule. */
  datasetEvaluation: "datasetEvaluation",
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

/** Preview form of `azure_ai_traces`. Returned only for rules backed by existing preview schedules; rejected on create and update. */
@extension("x-ms-foundry-meta", AllConditionalEvaluationRuleActionPreviews)
model TracesPreviewEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_traces_preview`. */
  type: "azure_ai_traces_preview";

  ...OmitProperties<TracesEvalRunDataSource, "type">;
}

/** Preview form of `azure_ai_trace_data_source`. Returned only for rules backed by existing preview schedules; rejected on create and update. */
@extension("x-ms-foundry-meta", AllConditionalEvaluationRuleActionPreviews)
model TraceSourcePreviewEvalRunDataSource extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_trace_data_source_preview`. */
  type: "azure_ai_trace_data_source_preview";

  ...OmitProperties<TraceSourceEvalRunDataSource, "type">;
}

/** Preview form of `azure_ai_user_conversation_simulation`. Returned only for rules backed by existing preview schedules; rejected on create and update. */
@extension("x-ms-foundry-meta", AllConditionalEvaluationRuleActionPreviews)
model UserConversationSimulationPreviewEvalRunDataSource
  extends EvalRunDataSource {
  /** The type of data source, always `azure_ai_user_conversation_simulation_preview`. */
  type: "azure_ai_user_conversation_simulation_preview";

  ...OmitProperties<UserConversationSimulationEvalRunDataSource, "type">;
}

/** Existing trace-evaluation inputs supported by scheduled rules. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Subset of existing EvalRunDataSource variants accepted by scheduled rules; expressing it with union extends requires the experimental union-extends feature."
union TraceEvaluationSource {
  /** Trace-query inputs with lookback and ingestion-delay settings. */
  traces: TracesEvalRunDataSource,

  /** Trace inputs selected through an existing TraceSource variant. */
  traceDataSource: TraceSourceEvalRunDataSource,

  /** Response-only preview form of `traces`. */
  tracesPreview: TracesPreviewEvalRunDataSource,

  /** Response-only preview form of `traceDataSource`. */
  traceDataSourcePreview: TraceSourcePreviewEvalRunDataSource,
}

/** Configures a scheduled evaluation of observed agent traces. */
model TraceEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.traceEvaluation;

  /** Identifier of the evaluation used to score the selected traces. */
  evalId: string;

  /**
   * Trace inputs for each scheduled occurrence. The selected variant's query-window and sampling behavior is preserved.
   *
   * For `azure_ai_traces`, set exactly one of `agent_id` or `agent_name`; `trace_ids` is not supported.
   * For `azure_ai_trace_data_source`, set `trace_source`.
   * Preview source types may appear in responses for existing schedules but are rejected on create and update.
   */
  source: TraceEvaluationSource;

  /** Level at which each scheduled run evaluates. Required when the evaluation uses the messages item schema. */
  evaluation_level?: EvaluationLevel;
}

/** Dataset inputs supported by scheduled rules. Targets are configured within the selected source. */
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Subset of existing EvalRunDataSource variants accepted by scheduled rules; expressing it with union extends requires the experimental union-extends feature."
union DatasetEvaluationSource {
  /** JSONL inputs from file content or a file ID. */
  jsonl: OpenAI.CreateEvalJsonlRunDataSource,

  /** CSV inputs from a file ID. */
  csv: CsvEvalRunDataSource,

  /** Inputs that are sent to a model to generate completions before scoring. */
  completions: OpenAI.CreateEvalCompletionsRunDataSource,

  /** Inputs that are sent to an evaluation target to generate responses before scoring. */
  targetCompletions: TargetCompletionEvalRunDataSource,

  /** Simulated user conversations with an evaluation target. */
  userConversationSimulation: UserConversationSimulationEvalRunDataSource,

  /** Response-only preview form of `userConversationSimulation`. */
  userConversationSimulationPreview: UserConversationSimulationPreviewEvalRunDataSource,
}

/** Configures a scheduled evaluation of dataset inputs. */
model DatasetEvaluationRuleAction extends EvaluationRuleAction {
  type: EvaluationRuleActionType.datasetEvaluation;

  /** Identifier of the evaluation used to score the dataset. */
  evalId: string;

  /** Dataset inputs for each scheduled occurrence. Preview source types may appear in responses for existing schedules but are rejected on create and update. */
  source: DatasetEvaluationSource;

  /** Level at which each scheduled run evaluates. Required when the evaluation uses the messages item schema. */
  evaluation_level?: EvaluationLevel;
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

  /** Run the rule's action on its schedule. */
  timerTrigger: "timerTrigger",
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

  /** Timing for timerTrigger rules. Required for timerTrigger and not allowed for other event types. */
  schedule?: Trigger;

  /** Provisioning state of the rule's schedule. Returned for timerTrigger rules only. */
  @visibility(Lifecycle.Read)
  provisioningStatus?: ScheduleProvisioningStatus;

  /** Error that caused the rule to be disabled, if any. */
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;

  @doc("Indicates whether the evaluation rule is enabled. Default is true.")
  enabled: boolean;

  @visibility(Lifecycle.Read)
  @doc("System metadata for the evaluation rule.")
  systemData: Record<string>;
}
