import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Rest;
using OpenAPI;

namespace Azure.AI.Projects;

const EvaluatorDiagnosticJobsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

@doc("The requested evaluator diagnostic job type.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union EvaluatorDiagnosticJobType {
  @doc("Measure human-evaluator agreement between one evaluator version and registered human annotations.")
  human_evaluator_agreement: "human_evaluator_agreement",

  @doc("Compare two evaluator versions on the same registered evidence.")
  rubric_comparison: "rubric_comparison",
}

@doc("The interpretation status for one bounded evaluator diagnostic metric.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union EvaluatorDiagnosticMetricStatus {
  string,

  @doc("The metric was computed and can be interpreted for the registered evidence.")
  assessed: "assessed",

  @doc("The required representation was not registered.")
  not_assessed: "not_assessed",

  @doc("The statistic is mathematically undefined for the observed values.")
  non_estimable: "non_estimable",

  @doc("Only one categorical class was observed.")
  single_class: "single_class",

  @doc("Comparable support or variation was insufficient.")
  insufficient_support: "insufficient_support",

  @doc("The human and judge values use incompatible semantics.")
  incompatible_semantics: "incompatible_semantics",
}

@doc("One bounded evaluator diagnostic metric.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticMetric {
  @doc("Whether and how the metric can be interpreted.")
  status: EvaluatorDiagnosticMetricStatus;

  @doc("The point estimate when the metric is estimable. Its valid range is defined by the owning statistic and documented on that property.")
  value?: float64;

  @doc("The non-negative number of comparable evidence units.")
  @minValue(0)
  sample_count: int32;

  @doc("The lower bound from the registered uncertainty procedure, in the same documented range as the point estimate.")
  lower_bound?: float64;

  @doc("The upper bound from the registered uncertainty procedure, in the same documented range as the point estimate.")
  upper_bound?: float64;
}

@doc("The exact evaluator version snapshot used by a completed diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticVersionSnapshot {
  @doc("The exact numbered evaluator version.")
  version: string;

  @doc("The verified lowercase 64-character SHA-256 functional content hash.")
  content_hash: Sha256Hash;

  @doc("Whether the exact numbered version was a draft when the diagnostic was computed.")
  draft: boolean;
}

@doc("An immutable registered dataset used by an evaluator diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model ImmutableDatasetReference {
  @doc("The registered dataset name.")
  name: string;

  @doc("The exact immutable dataset version. Aliases and `latest` are not accepted.")
  version: string;
}

@doc("The supported human annotation sources for human-evaluator agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union HumanEvaluatorAgreementAnnotationSourceType {
  @doc("An immutable registered dataset containing structured human annotations.")
  dataset: "dataset",

  @doc("Human annotations associated with traces in the current project's configured Application Insights resource.")
  annotated_traces: "annotated_traces",
}

@doc("A human annotation source for a human-evaluator agreement job.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementAnnotationSource {
  @doc("The annotation source type.")
  type: HumanEvaluatorAgreementAnnotationSourceType;
}

@doc("An immutable registered dataset containing human annotations.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementDatasetSource
  extends HumanEvaluatorAgreementAnnotationSource {
  type: HumanEvaluatorAgreementAnnotationSourceType.dataset;

  @doc("The immutable registered annotation dataset.")
  dataset: ImmutableDatasetReference;
}

@doc("Human annotations associated with traces in the current project's configured Application Insights resource. Annotation time, not trace creation time, controls inclusion.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementAnnotatedTracesSource
  extends HumanEvaluatorAgreementAnnotationSource {
  type: HumanEvaluatorAgreementAnnotationSourceType.annotated_traces;

  @doc("The unique agent ID used to filter annotated traces. Provide `agent_id` or `agent_name`; at least one is required. If both are supplied, they must identify the same agent.")
  agent_id?: string;

  @doc("The agent name used to filter annotated traces. Provide `agent_id` or `agent_name`; at least one is required. If both are supplied, they must identify the same agent.")
  agent_name?: string;

  @doc("The exact agent version used to filter annotated traces. When omitted, annotations for all agent versions in the annotation-time window are eligible.")
  agent_version?: string;

  @doc("The inclusive annotation-time lower bound, represented in Unix time. Trace creation time does not control inclusion.")
  annotation_start_time: FoundryTimestamp;

  @doc("The exclusive annotation-time upper bound, represented in Unix time. When omitted, the service freezes job acceptance time as the upper bound.")
  annotation_end_time?: FoundryTimestamp;
}

@doc("The registered dataset snapshot used by a completed evaluator diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticDatasetSnapshot {
  @doc("The registered dataset name.")
  name: string;

  @doc("The exact immutable dataset version.")
  version: string;

  @doc("The lowercase 64-character SHA-256 dataset content hash.")
  content_hash: Sha256Hash;

  @doc("The registered dataset or annotation schema version.")
  schema_version: string;

  @doc("The lowercase 64-character SHA-256 hash of the stable item/data mapping.")
  mapping_hash: Sha256Hash;

  @doc("The lowercase 64-character SHA-256 annotation-guidance content hash, when the dataset contains agreement labels.")
  guidance_content_hash?: Sha256Hash;
}

@doc("The frozen human annotation source used by a completed human-evaluator agreement diagnostic.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementAnnotationSourceSnapshot {
  @doc("The annotation source type.")
  type: HumanEvaluatorAgreementAnnotationSourceType;
}

@doc("The frozen registered-dataset source used for human-evaluator agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementDatasetSourceSnapshot
  extends HumanEvaluatorAgreementAnnotationSourceSnapshot {
  type: HumanEvaluatorAgreementAnnotationSourceType.dataset;

  @doc("The frozen registered dataset identity.")
  dataset: EvaluatorDiagnosticDatasetSnapshot;
}

@doc("The frozen annotated-traces source used for human-evaluator agreement. It contains no trace, conversation, annotation, comment, or evidence identifiers or content.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementAnnotatedTracesSourceSnapshot
  extends HumanEvaluatorAgreementAnnotationSourceSnapshot {
  type: HumanEvaluatorAgreementAnnotationSourceType.annotated_traces;

  @doc("The resolved agent ID filter, when supplied.")
  agent_id?: string;

  @doc("The resolved agent name filter, when supplied.")
  agent_name?: string;

  @doc("The resolved agent version filter, when supplied.")
  agent_version?: string;

  @doc("The inclusive annotation-time lower bound represented in Unix time.")
  annotation_start_time: FoundryTimestamp;

  @doc("The exclusive annotation-time upper bound frozen at job acceptance, represented in Unix time.")
  annotation_end_time: FoundryTimestamp;

  @doc("The lowercase 64-character SHA-256 hash of the frozen effective annotation and trace evidence projection.")
  content_hash: Sha256Hash;

  @doc("The canonical annotation schema version.")
  schema_version: string;

  @doc("The lowercase 64-character SHA-256 hash of the canonical annotation/trace mapping.")
  mapping_hash: Sha256Hash;

  @doc("The lowercase 64-character SHA-256 annotation-guidance content hash.")
  guidance_content_hash: Sha256Hash;
}

@doc("An immutable evaluator or annotation scoring contract.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticScoringContractReference {
  @doc("The scoring contract identifier.")
  id: string;

  @doc("The immutable scoring contract version.")
  version: string;

  @doc("The lowercase 64-character SHA-256 contract content hash.")
  content_hash: Sha256Hash;
}

@doc("A bounded reference to an evaluation run used by an evaluator diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticEvaluationRunReference {
  @doc("The evaluation identifier or group containing the run.")
  eval_id: string;

  @doc("The evaluation run identifier.")
  run_id: string;

  @doc("The exact evaluator version executed by the run.")
  evaluator_version: string;

  @doc("The lowercase 64-character SHA-256 evaluator content hash executed by the run.")
  evaluator_content_hash: Sha256Hash;
}

@doc("The evidence sufficiency and compatibility outcome of a human-evaluator agreement diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union HumanEvaluatorAgreementEvidenceStatus {
  string,

  @doc("The registered evidence supports the bounded human-evaluator agreement result.")
  sufficient: "sufficient",

  @doc("Comparable evidence was insufficient.")
  insufficient_evidence: "insufficient_evidence",

  @doc("Human and evaluator scoring semantics were incompatible.")
  incompatible_scoring_semantics: "incompatible_scoring_semantics",

  @doc("The registered annotation evidence was invalid.")
  invalid_registered_evidence: "invalid_registered_evidence",
}

@doc("The semantic compatibility of evaluator and human annotation contracts.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union HumanEvaluatorAgreementSemanticStatus {
  string,

  @doc("Evaluator and annotation semantics are compatible.")
  compatible: "compatible",

  @doc("Evaluator and annotation semantics are incompatible.")
  incompatible: "incompatible",

  @doc("Semantic compatibility was not assessed.")
  not_assessed: "not_assessed",
}

@doc("The evaluator and annotation semantics used by human-evaluator agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementSemanticCompatibility {
  @doc("The compatibility assessment.")
  status: HumanEvaluatorAgreementSemanticStatus;

  @doc("The evaluator scoring contract.")
  evaluator_scoring_contract: EvaluatorDiagnosticScoringContractReference;

  @doc("The human annotation scoring contract.")
  annotation_scoring_contract: EvaluatorDiagnosticScoringContractReference;

  @doc("Whether applicability, weighting, normalization, and threshold semantics match.")
  aggregation_policy_match: boolean;

  @doc("Stable bounded mismatch codes.")
  mismatch_codes: string[];
}

@doc("Bounded evidence counts for a human-evaluator agreement diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementSupportSummary {
  @doc("Number of items in the registered source.")
  source_item_count: int32;

  @doc("Number of items with comparable human and judge representations.")
  comparable_item_count: int32;

  @doc("Number of source items excluded from the comparison.")
  excluded_item_count: int32;
}

@doc("Applicability-label support for human-evaluator agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorApplicabilitySupport {
  @doc("Items where both marked the dimension applicable.")
  both_applicable: int32;

  @doc("Items where both marked the dimension not applicable.")
  both_not_applicable: int32;

  @doc("Items marked applicable only by the human.")
  human_only: int32;

  @doc("Items marked applicable only by the judge.")
  judge_only: int32;
}

@doc("Applicability agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorApplicabilityAgreementSummary {
  @doc("Applicability-label support.")
  support: EvaluatorApplicabilitySupport;

  @doc("Observed applicability agreement. The value must be between 0 and 1, inclusive.")
  observed_agreement: EvaluatorDiagnosticMetric;
}

@doc("Ordinal-score counts represented as a JSON object. Each key is the canonical decimal-string representation of a score allowed by the registered scoring contract, and each value is a non-negative item count.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorOrdinalScoreDistribution is Record<int32>;

@doc("Per-dimension ordinal-score agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorDimensionAgreementSummary {
  @doc("The stable rubric dimension identifier.")
  dimension_id: string;

  @doc("Number of comparable common-applicable items.")
  comparable_item_count: int32;

  @doc("Number of missing or abstained representations.")
  missing_or_abstained_count: int32;

  @doc("Exact ordinal-score match rate. The value must be between 0 and 1, inclusive.")
  exact_match: EvaluatorDiagnosticMetric;

  @doc("Mean absolute ordinal-score error. The value must be between 0 and the registered ordinal-score span, inclusive.")
  mean_absolute_error: EvaluatorDiagnosticMetric;

  @doc("Mean signed judge-minus-human score bias. The value must be between the negative and positive registered ordinal-score span, inclusive.")
  signed_bias: EvaluatorDiagnosticMetric;

  @doc("Kendall tau-b rank agreement. The value must be between -1 and 1, inclusive.")
  kendall_tau_b: EvaluatorDiagnosticMetric;

  @doc("Spearman rank agreement. The value must be between -1 and 1, inclusive.")
  spearman_rho: EvaluatorDiagnosticMetric;

  @doc("Human annotation counts keyed by ordinal score.")
  human_score_distribution: EvaluatorOrdinalScoreDistribution;

  @doc("Evaluator counts keyed by ordinal score.")
  judge_score_distribution: EvaluatorOrdinalScoreDistribution;
}

@doc("Centered rubric-profile agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorProfileAgreementSummary {
  @doc("Number of common-applicable dimensions represented.")
  common_applicable_dimension_count: int32;

  @doc("Centered weighted profile distance. The value must be non-negative; its upper bound is derived from the registered scoring contract and dimension weights.")
  centered_weighted_profile_distance: EvaluatorDiagnosticMetric;

  @doc("Judge-minus-human aggregate score difference. The valid signed range is derived from the registered aggregate-score span.")
  aggregate_score_difference: EvaluatorDiagnosticMetric;

  @doc("Number of aggregate-score collisions hiding profile divergence.")
  aggregate_collision_count: int32;

  @doc("Aggregate-score collision rate. The value must be between 0 and 1, inclusive.")
  aggregate_collision_rate: EvaluatorDiagnosticMetric;
}

@doc("Structured decision-driver agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorDecisionDriverAgreementSummary {
  @doc("Whether structured decision-driver agreement was assessed.")
  status: EvaluatorDiagnosticMetricStatus;

  @doc("Why decision-driver agreement was not assessed.")
  reason?: string;

  @doc("Exact primary-driver match rate. The value must be between 0 and 1, inclusive.")
  primary_driver_exact_match?: EvaluatorDiagnosticMetric;

  @doc("Registered top-k driver overlap. The value must be between 0 and 1, inclusive.")
  top_k_overlap?: EvaluatorDiagnosticMetric;
}

@doc("Final-verdict confusion counts.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorVerdictConfusion {
  @doc("Items both passed.")
  both_pass: int32;

  @doc("Items both failed.")
  both_fail: int32;

  @doc("Items the human passed and judge failed.")
  human_pass_judge_fail: int32;

  @doc("Items the human failed and judge passed.")
  human_fail_judge_pass: int32;
}

@doc("Final-verdict agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorVerdictAgreementSummary {
  @doc("Pass/fail confusion counts.")
  confusion: EvaluatorVerdictConfusion;

  @doc("Observed pass/fail agreement. The value must be between 0 and 1, inclusive.")
  observed_agreement: EvaluatorDiagnosticMetric;

  @doc("Gwet AC1 when both classes have estimable support. The value must be between -1 and 1, inclusive.")
  gwet_ac1: EvaluatorDiagnosticMetric;

  @doc("Judge-pass rate on human-fail cases. The value must be between 0 and 1, inclusive.")
  false_pass_rate: EvaluatorDiagnosticMetric;

  @doc("Judge-fail rate on human-pass cases. The value must be between 0 and 1, inclusive.")
  false_fail_rate: EvaluatorDiagnosticMetric;
}

@doc("Same-configuration repeatability available from service-registered runs.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementRepeatabilitySummary {
  @doc("The compatible registered repeat run.")
  run: EvaluatorDiagnosticEvaluationRunReference;

  @doc("Whether the repeat used the exact registered configuration.")
  configuration_match: boolean;

  @doc("Final-verdict agreement between the primary and repeat. The value must be between 0 and 1, inclusive.")
  final_verdict_agreement: EvaluatorDiagnosticMetric;

  @doc("Bounded limitations.")
  limitations: string[];
}

@doc("The four-way verdict movement between baseline and target evaluator versions.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonVerdictConfusion {
  @doc("Items passed by both versions.")
  pass_to_pass: int32;

  @doc("Items failed by both versions.")
  fail_to_fail: int32;

  @doc("Items that moved from pass to fail.")
  pass_to_fail: int32;

  @doc("Items that moved from fail to pass.")
  fail_to_pass: int32;
}

@doc("Per-dimension comparison between two evaluator versions.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricDimensionComparison {
  @doc("The stable rubric dimension identifier.")
  dimension_id: string;

  @doc("Number of comparable evaluation units.")
  sample_count: int32;

  @doc("Baseline mean score.")
  baseline_mean_score?: float64;

  @doc("Target mean score.")
  compared_mean_score?: float64;

  @doc("Target-minus-baseline mean score.")
  mean_score_delta?: float64;

  @doc("Baseline applicability rate. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  baseline_applicability_rate?: float64;

  @doc("Target applicability rate. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  compared_applicability_rate?: float64;

  @doc("Applicability disagreement rate. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  applicability_disagreement_rate?: float64;
}

@doc("A rubric dimension weight change.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricWeightChange {
  @doc("The stable rubric dimension identifier.")
  dimension_id: string;

  @doc("Baseline weight.")
  baseline_weight: int32;

  @doc("Target weight.")
  compared_weight: int32;
}

@doc("Bounded behavioral and structural comparison between two evaluator versions.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricVersionComparisonSummary {
  @doc("The shared evaluation granularity.")
  evaluation_level: EvaluationLevel;

  @doc("Number of comparable evaluation units.")
  sample_count: int32;

  @doc("Baseline aggregate score.")
  baseline_aggregate_score?: float64;

  @doc("Target aggregate score.")
  compared_aggregate_score?: float64;

  @doc("Target-minus-baseline aggregate score.")
  aggregate_score_delta?: float64;

  @doc("Baseline pass rate. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  baseline_pass_rate?: float64;

  @doc("Target pass rate. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  compared_pass_rate?: float64;

  @doc("Target-minus-baseline pass-rate change.")
  pass_rate_delta?: float64;

  @doc("Number of verdict flips.")
  verdict_flip_count?: int32;

  @doc("Verdict flip rate. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  verdict_flip_rate?: float64;

  @doc("Pass/fail movement counts.")
  verdict_confusion?: RubricComparisonVerdictConfusion;

  @doc("Shared-dimension comparisons.")
  shared_dimensions: RubricDimensionComparison[];

  @doc("Dimension identifiers present only in the target.")
  added_dimension_ids: string[];

  @doc("Dimension identifiers present only in the baseline.")
  removed_dimension_ids: string[];

  @doc("Shared dimension identifiers whose definitions changed.")
  changed_dimension_ids?: string[];

  @doc("Shared-dimension weight changes.")
  weight_changes: RubricWeightChange[];

  @doc("Baseline pass threshold. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold_before?: float64;

  @doc("Target pass threshold. The value must be between 0 and 1, inclusive.")
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold_after?: float64;
}

@doc("One shared evaluation/group and its baseline and target runs.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonRunReferences {
  @doc("The baseline evaluator run.")
  baseline: EvaluatorDiagnosticEvaluationRunReference;

  @doc("The target evaluator run.")
  target: EvaluatorDiagnosticEvaluationRunReference;
}

@doc("The registered relationship of comparison evidence to evaluator fitting and validation.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union EvaluatorDiagnosticEvidenceScope {
  string,

  @doc("Evidence contains one supported evaluation unit.")
  single_item: "single_item",

  @doc("Evidence was available during evaluator fitting.")
  fit: "fit",

  @doc("Evidence is a locked holdout.")
  locked_holdout: "locked_holdout",

  @doc("Evidence is fresh relative to evaluator fitting.")
  fresh: "fresh",

  @doc("Evidence comes from a protected online audit.")
  protected_online: "protected_online",

  @doc("Evidence comes from a registered random audit.")
  random_audit: "random_audit",
}

@doc("A completed human-evaluator agreement diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementDiagnostic extends EvaluatorDiagnostic {
  type: EvaluatorDiagnosticType.human_evaluator_agreement;

  @doc("The exact evaluator version analyzed.")
  target: EvaluatorDiagnosticVersionSnapshot;

  @doc("The frozen human annotation source.")
  source: HumanEvaluatorAgreementAnnotationSourceSnapshot;

  @doc("The resolved evaluation granularity.")
  evaluation_level: EvaluationLevel;

  @doc("The evaluator run compared with human labels.")
  evaluation_run: EvaluatorDiagnosticEvaluationRunReference;

  @doc("The evidence sufficiency and compatibility outcome.")
  evidence_status: HumanEvaluatorAgreementEvidenceStatus;

  @doc("Evaluator and annotation semantic compatibility.")
  semantic_compatibility: HumanEvaluatorAgreementSemanticCompatibility;

  @doc("Bounded evidence counts.")
  support: HumanEvaluatorAgreementSupportSummary;

  @doc("Applicability agreement.")
  applicability: HumanEvaluatorApplicabilityAgreementSummary;

  @doc("Per-dimension ordinal-score agreement.")
  dimension_scores: HumanEvaluatorDimensionAgreementSummary[];

  @doc("Centered rubric-profile agreement.")
  profile: HumanEvaluatorProfileAgreementSummary;

  @doc("Structured decision-driver agreement.")
  decision_drivers: HumanEvaluatorDecisionDriverAgreementSummary;

  @doc("Final-verdict agreement.")
  final_verdict: HumanEvaluatorVerdictAgreementSummary;

  @doc("Compatible service-registered repeats, when available.")
  repeatability?: HumanEvaluatorAgreementRepeatabilitySummary[];

  @doc("Bounded interpretation limitations.")
  limitations: string[];
}

@doc("A completed comparison between two evaluator versions.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonEvaluatorDiagnostic extends EvaluatorDiagnostic {
  type: EvaluatorDiagnosticType.rubric_comparison;

  @doc("The exact baseline evaluator version.")
  baseline: EvaluatorDiagnosticVersionSnapshot;

  @doc("The exact target evaluator version.")
  target: EvaluatorDiagnosticVersionSnapshot;

  @doc("The shared immutable registered dataset.")
  dataset: EvaluatorDiagnosticDatasetSnapshot;

  @doc("The shared evaluation/group and paired runs.")
  evaluation_runs: RubricComparisonRunReferences;

  @doc("The registered evidence relationship resolved from dataset metadata.")
  evidence_scope: EvaluatorDiagnosticEvidenceScope;

  @doc("Bounded behavioral and structural comparison.")
  summary: RubricVersionComparisonSummary;

  @doc("Bounded interpretation limitations.")
  limitations: string[];
}

@doc("A flat page of completed evaluator diagnostics.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model CompletedEvaluatorDiagnosticsPage {
  @doc("The completed evaluator diagnostics.")
  @pageItems
  data: EvaluatorDiagnostic[];

  @doc("The first diagnostic identifier represented in this page.")
  first_id?: string | null;

  @doc("The last diagnostic identifier represented in this page.")
  @continuationToken
  last_id?: string | null;

  @doc("Whether more completed diagnostics are available.")
  has_more: boolean;
}

@doc("The request for an evaluator diagnostic job.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticJobRequest {
  @doc("The requested diagnostic calculation.")
  type: EvaluatorDiagnosticJobType;
}

@doc("The request for a human-evaluator agreement diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model HumanEvaluatorAgreementDiagnosticJobRequest
  extends EvaluatorDiagnosticJobRequest {
  type: EvaluatorDiagnosticJobType.human_evaluator_agreement;

  @doc("The exact immutable evaluator version to compare with human annotations.")
  evaluator_version: string;

  @doc("The human annotation source.")
  source: HumanEvaluatorAgreementAnnotationSource;

  @doc("The evaluation granularity. Required only when evaluator and dataset metadata do not resolve one unique shared level.")
  evaluation_level?: EvaluationLevel;
}

@doc("The request for a rubric-comparison diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonDiagnosticJobRequest
  extends EvaluatorDiagnosticJobRequest {
  type: EvaluatorDiagnosticJobType.rubric_comparison;

  @doc("The exact immutable baseline evaluator version.")
  baseline_version: string;

  @doc("The exact immutable target evaluator version.")
  target_version: string;

  @doc("The immutable registered dataset used for both evaluator versions.")
  dataset: ImmutableDatasetReference;

  @doc("The evaluation granularity. Required only when evaluator and dataset metadata do not resolve one unique shared level.")
  evaluation_level?: EvaluationLevel;
}

@doc("The completed diagnostic published by a successful evaluator diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticJobResult {
  @doc("The stable identifier of the completed diagnostic.")
  diagnostic_id: string;
}

@doc("A long-running evaluator diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticJob {
  ...OmitProperties<JobLike<EvaluatorDiagnosticJobResult>, "inputs">;
}
