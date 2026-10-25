import "./inputs.tsp";

namespace Azure.AI.Projects;

/** Selected findings from one monitor in the job's Foundry project. */
model AgentOptimizationInsightsSource {
  /** Identifier of the monitor that owns every selected Insight. Up to 256 characters; surrounding whitespace and control characters are rejected. */
  @minLength(1)
  @maxLength(256)
  monitor_id: string;

  /** Between 1 and 20 distinct, non-empty Insight IDs belonging to the monitor and target agent. Each ID is at most 256 characters, with no surrounding whitespace or control characters. The service rejects duplicate IDs. */
  @minItems(1)
  @maxItems(20)
  insight_ids: AgentOptimizationInsightId[];
}

/** Non-empty Insight identifier, up to 256 characters. */
@minLength(1)
@maxLength(256)
scalar AgentOptimizationInsightId extends string;

/** Configuration for deriving evaluation inputs from Insights and optimizing the registered agent. The service resolves the baseline and optimization attributes; callers do not supply evaluation data, evaluators, baseline overrides, or optimization context. */
model InsightsOptimizationConfiguration
  extends AgentOptimizationConfigurationBase {
  /** Insights optimization discriminator. */
  type: AgentOptimizationConfigurationType.insights_optimization;

  /** Findings to address, selected from one monitor for the target agent. */
  insights_source: AgentOptimizationInsightsSource;

  /** Model used for scenario and evaluator preparation, conversation simulation, and judging. The job's optimization_model_configuration separately supplies candidate generation. Only text simulation is supported; voice_model is not accepted. */
  insights_preparation_model_configuration: EvaluationModelConfiguration;

  /** Optional search breadth. If omitted, the service defaults to one non-baseline candidate. */
  candidate_search_configuration?: AgentOptimizationCandidateSearchConfiguration;

  /** Complete server-generated, version-pinned datasets and evaluators. Included only on job detail GET after preparation is ready; omitted from LIST and before readiness. This is not accepted as create input, so the returned configuration must not be resubmitted unchanged. */
  @visibility(Lifecycle.Read)
  evaluation_configuration?: InsightsOptimizationPreparedEvaluationConfiguration;

  /** Attributes resolved by the backend for this job. Included in job reads when available, not required or accepted as SDK create input. */
  @visibility(Lifecycle.Read)
  agent_optimization_space?: AgentOptimizationSpace;
}

/** Frozen evaluation inputs returned after Insights preparation. These are service-owned outputs, not a reusable create request. */
model InsightsOptimizationPreparedEvaluationConfiguration {
  /** Version-pinned conversation-simulation training set prepared from the selected evidence. */
  training_set: AgentOptimizationUserConversationSimulationEvaluationSet;

  /** Version-pinned conversation-simulation validation set. It can reference the training dataset when shared replay is used; the validation metrics distinguish that evidence mode. */
  validation_set: AgentOptimizationUserConversationSimulationEvaluationSet;

  /** Exact evaluator versions used by the experiment. Between 2 and 21 references; older jobs can include one failure evaluator per selected Insight plus the quality rubric. */
  @minItems(2)
  @maxItems(21)
  evaluators: AgentOptimizationPreparedInsightEvaluator[];

  /** Model used by evaluators and text conversation simulation. */
  evaluation_model: EvaluationModelConfiguration;

  /** Conversation evaluation concurrency. If omitted, the service defaults to 1. The only supported value is 1. */
  @minValue(1)
  @maxValue(1)
  max_concurrent_agent_runs?: int32 = 1;
}

/** Pinned evaluator reference returned by Insights preparation, with an optional historical per-Insight binding. */
model AgentOptimizationPreparedInsightEvaluator {
  ...OmitProperties<AgentOptimizationEvaluator, "version">;

  /** Exact recorded evaluator version, not the latest alias. */
  @minLength(1)
  version: string;

  /** Insight judged by a prepared per-Insight failure evaluator. Omitted for the shared comparator, quality rubric, and other unbound evaluators. */
  insight_id?: AgentOptimizationInsightId;
}

/** Normalized evaluation score between 0 and 1. */
@minValue(0)
@maxValue(1)
scalar AgentOptimizationNormalizedScore extends float64;

/** Failure-training metrics from an existing parent/candidate screening sample. */
model AgentOptimizationSampledTrainingEvaluation {
  /** Average score for each evaluator in this sample. */
  evaluator_scores: Record<float64>;

  /** Number of sampled training results, at least 0. */
  @minValue(0)
  sample_size: int32;

  /** Sampled rows with a reproduced failure, at least 0. */
  @minValue(0)
  reproduced_failure_rows: int32;

  /** Sampled rows excluded from the failure screen, at least 0. */
  @minValue(0)
  excluded_rows: int32;
}

/** Failure-remediation validation and quality guards for an Insights candidate. Missing scores are omitted rather than synthesized as zero. */
model AgentOptimizationCandidateValidationEvaluation {
  /** Remediation score between 0 and 1 on baseline-qualified held-out failures. Omitted when no held-out score is available. */
  failure_holdout_score?: AgentOptimizationNormalizedScore;

  /** Failure-boundary score between 0 and 1 for jobs that performed this historical assessment. Omitted otherwise. */
  failure_boundary_score?: AgentOptimizationNormalizedScore;

  /** General-quality score between 0 and 1 on broad validation scenarios. Omitted when broad-quality evidence is unavailable. */
  broad_quality_score?: AgentOptimizationNormalizedScore;

  /** Remediation score between 0 and 1 on reused training scenarios, not an independent holdout. Omitted unless shared replay was used. */
  failure_replay_score?: AgentOptimizationNormalizedScore;

  /** General-quality score between 0 and 1 on shared replay scenarios. Omitted unless shared replay was used. */
  replay_quality_score?: AgentOptimizationNormalizedScore;

  /** Number of shared replay scenarios, at least 1. Omitted for independent validation. */
  @minValue(1)
  failure_replay_rows?: int32;

  /** Number of held-out failure rows, at least 0. */
  @minValue(0)
  failure_holdout_rows: int32;

  /** Failure rows where the baseline reproduced a selected failure, at least 0. */
  @minValue(0)
  qualified_failure_rows: int32;

  /** Failure rows excluded from qualification, at least 0. */
  @minValue(0)
  excluded_failure_rows: int32;

  /** Number of failure-boundary rows, at least 0. */
  @minValue(0)
  failure_boundary_rows: int32;

  /** Number of broad-quality rows, at least 0. */
  @minValue(0)
  broad_quality_rows: int32;

  /** Whether this candidate passed the applicable validation guards and is eligible for selection. Eligibility alone does not mean the candidate improved on the baseline. */
  eligible: boolean;

  /** Number of definite paired-quality comparisons, at least 0. Omitted when this assessment did not run. */
  @minValue(0)
  paired_quality_rows?: int32;

  /** Paired rows preferring the candidate, at least 0. Omitted when this assessment did not run. */
  @minValue(0)
  paired_quality_wins?: int32;

  /** Paired rows preferring the baseline, at least 0. Omitted when this assessment did not run. */
  @minValue(0)
  paired_quality_losses?: int32;

  /** Paired rows without a preference, at least 0. Omitted when this assessment did not run. */
  @minValue(0)
  paired_quality_ties?: int32;

  /** Paired rows without a usable verdict, at least 0. Omitted when this assessment did not run. */
  @minValue(0)
  paired_quality_undefined_rows?: int32;

  /** Paired net preference, (wins - losses) / definite rows, between -1 and 1. Omitted when no paired assessment is available. */
  @minValue(-1)
  @maxValue(1)
  paired_net_preference?: float64;

  /** Candidate minus baseline goal-achievement rate, between -1 and 1. Omitted when no paired assessment is available. */
  @minValue(-1)
  @maxValue(1)
  goal_achievement_delta?: float64;

  /** Paired-quality counts keyed by validation cohort. Omitted when this historical assessment did not run. */
  paired_quality_by_cohort?: Record<AgentOptimizationPairedQualityCohort>;

  /** Safe explanations of an ineligible result. Omitted when no reasons were recorded. */
  eligibility_reasons?: string[];

  /** Scenario-matched native rubric comparisons, keyed by validation cohort. These are score differences, not side-by-side model preferences. Omitted when no native comparison was recorded. */
  rubric_comparisons?: Record<AgentOptimizationRubricComparison>;
}

/** Historical paired-quality counts for one validation cohort. */
model AgentOptimizationPairedQualityCohort {
  /** Number of definite comparison rows, at least 0. */
  @minValue(0)
  rows: int32;

  /** Rows preferring the candidate, at least 0. */
  @minValue(0)
  wins: int32;

  /** Rows preferring the baseline, at least 0. */
  @minValue(0)
  losses: int32;

  /** Rows with no preference, at least 0. */
  @minValue(0)
  ties: int32;

  /** Rows without a usable verdict, at least 0. */
  @minValue(0)
  undefined_rows: int32;

  /** Rows where only the candidate achieved the user goal, at least 0. */
  @minValue(0)
  goal_wins: int32;

  /** Unjustified losses of a goal achieved by the baseline, at least 0. */
  @minValue(0)
  unjustified_goal_losses: int32;
}

/** Scenario-matched rubric scores for one validation cohort. */
model AgentOptimizationRubricComparison {
  /** Number of definite comparison rows, at least 0. */
  @minValue(0)
  rows: int32;

  /** Rows with a higher candidate rubric score, at least 0. */
  @minValue(0)
  improved_rows: int32;

  /** Rows with a lower candidate rubric score, at least 0. */
  @minValue(0)
  regressed_rows: int32;

  /** Rows with equal rubric scores, at least 0. */
  @minValue(0)
  tied_rows: int32;

  /** Rows without a usable paired score, at least 0. */
  @minValue(0)
  undefined_rows: int32;

  /** Mean baseline rubric score between 0 and 1, or null when unavailable. */
  baseline_score: AgentOptimizationNormalizedScore | null;

  /** Mean candidate rubric score between 0 and 1, or null when unavailable. */
  candidate_score: AgentOptimizationNormalizedScore | null;

  /** Candidate minus baseline rubric score, or null when unavailable. */
  delta: float64 | null;
}

/** Availability and completeness of an all-failure Insights report, independent of candidate or job status. */
union AgentOptimizationInsightsSummaryStatus {
  string,

  /** The report has no incomplete repetitions; individual cases can still lack a definite verdict. */
  complete: "complete",

  /** Some failure cases have incomplete repetitions; final rates and the improved Insight count are omitted. */
  incomplete: "incomplete",

  /** Report generation failed; final rates and the improved Insight count are omitted. */
  failed: "failed",
}

/** Report-only remediation over all prepared failure cases, including training cases and the baseline candidate. This report does not change candidate ranking or eligibility. */
model AgentOptimizationInsightsSummary {
  /** Report outcome, not the parent candidate's lifecycle status. */
  status: AgentOptimizationInsightsSummaryStatus;

  /** Number of Insights with at least one fully remediated case, at least 0. This is not improvement versus the baseline or proof that every case for an Insight is fixed. Omitted for incomplete or failed reports. */
  @minValue(0)
  improved_insight_count?: int32;

  /** Coverage of unique source-conversation/Insight pairs, not collected trace counts. */
  coverage: AgentOptimizationInsightsSummaryCoverage;

  /** Results grouped by Insight identity; repetitions are aggregated within each unique case. */
  per_insight: AgentOptimizationInsightSummary[];
}

/** Case counts for an all-failure Insights report. A conversation linked to two Insights contributes one case to each. */
model AgentOptimizationInsightsSummaryCoverage {
  /** Total unique source-conversation/Insight cases, at least 0. */
  @minValue(0)
  failure_pairs: int32;

  /** Cases with a definite score, at least 0. */
  @minValue(0)
  definite_pairs: int32;

  /** Cases missing configured repetitions, at least 0. */
  @minValue(0)
  partial_pairs: int32;
}

/** Report-only remediation of one Insight's unique failure cases. */
model AgentOptimizationInsightSummary {
  /** Insight associated with the failure cases. */
  insight_id: AgentOptimizationInsightId;

  /** Mean definite-case score between 0 and 1; repetitions can produce fractional case scores. Omitted when no complete, scorable result is available. */
  failure_evaluation_score?: AgentOptimizationNormalizedScore;

  /** Unique cases classified as fully remediated, at least 0. */
  @minValue(0)
  remediated_pairs: int32;

  /** Unique cases with a definite score, at least 0. */
  @minValue(0)
  definite_pairs: int32;

  /** Fully remediated cases divided by definite cases, between 0 and 1. This can differ from the mean case score. Omitted without complete, scorable evidence. */
  rows_improved_rate?: AgentOptimizationNormalizedScore;
}
