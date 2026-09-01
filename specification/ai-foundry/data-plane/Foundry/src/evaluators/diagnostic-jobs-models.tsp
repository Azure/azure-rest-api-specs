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
  @doc("Measure agreement between one evaluator version and registered human annotations.")
  agreement: "agreement",

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

  @doc("The point estimate when the metric is estimable.")
  value?: float64;

  @doc("The number of comparable evidence units.")
  sample_count: int32;

  @doc("Bounded class or value support when needed to interpret the metric.")
  support?: Record<int32>;

  @doc("The lower bound from the registered uncertainty procedure.")
  lower_bound?: float64;

  @doc("The upper bound from the registered uncertainty procedure.")
  upper_bound?: float64;
}

@doc("An exact evaluator version and functional-content precondition.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticVersionReference {
  @doc("The exact numbered evaluator version.")
  version: string;

  @doc("The expected lowercase 64-character SHA-256 functional content hash. Job creation fails when the current value differs.")
  @pattern("^[0-9a-f]{64}$")
  expected_content_hash: string;
}

@doc("The exact evaluator version snapshot used by a completed diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticVersionSnapshot {
  @doc("The exact numbered evaluator version.")
  version: string;

  @doc("The verified lowercase 64-character SHA-256 functional content hash.")
  @pattern("^[0-9a-f]{64}$")
  content_hash: string;

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

@doc("The registered dataset snapshot used by a completed evaluator diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticDatasetSnapshot {
  @doc("The registered dataset name.")
  name: string;

  @doc("The exact immutable dataset version.")
  version: string;

  @doc("The lowercase 64-character SHA-256 dataset content hash.")
  @pattern("^[0-9a-f]{64}$")
  content_hash: string;

  @doc("The registered dataset or annotation schema version.")
  schema_version: string;

  @doc("The lowercase 64-character SHA-256 hash of the stable item/data mapping.")
  @pattern("^[0-9a-f]{64}$")
  mapping_hash: string;

  @doc("The registered human-annotation scoring contract, when the dataset contains agreement labels.")
  scoring_contract?: EvaluatorDiagnosticScoringContractReference;

  @doc("The lowercase 64-character SHA-256 annotation-guidance content hash, when the dataset contains agreement labels.")
  @pattern("^[0-9a-f]{64}$")
  guidance_content_hash?: string;
}

@doc("An immutable evaluator or annotation scoring contract.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticScoringContractReference {
  @doc("The scoring contract identifier.")
  id: string;

  @doc("The immutable scoring contract version.")
  version: string;

  @doc("The lowercase 64-character SHA-256 contract content hash.")
  @pattern("^[0-9a-f]{64}$")
  content_hash: string;
}

@doc("A bounded reference to an evaluation run used by an evaluator diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticEvaluationRunReference {
  @doc("The evaluation identifier or group containing the run, when not supplied by a containing shared evaluation reference.")
  eval_id?: string;

  @doc("The evaluation run identifier.")
  run_id: string;

  @doc("The exact evaluator version executed by the run.")
  evaluator_version: string;

  @doc("The lowercase 64-character SHA-256 evaluator content hash executed by the run.")
  @pattern("^[0-9a-f]{64}$")
  evaluator_content_hash: string;
}

@doc("The evidence sufficiency and compatibility outcome of an agreement diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union EvaluatorAgreementEvidenceStatus {
  string,

  @doc("The registered evidence supports the bounded agreement result.")
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
union EvaluatorAgreementSemanticStatus {
  string,

  @doc("Evaluator and annotation semantics are compatible.")
  compatible: "compatible",

  @doc("Evaluator and annotation semantics are incompatible.")
  incompatible: "incompatible",

  @doc("Semantic compatibility was not assessed.")
  not_assessed: "not_assessed",
}

@doc("The evaluator and annotation semantics used by agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorAgreementSemanticCompatibility {
  @doc("The compatibility assessment.")
  status: EvaluatorAgreementSemanticStatus;

  @doc("The evaluator scoring contract.")
  evaluator_scoring_contract: EvaluatorDiagnosticScoringContractReference;

  @doc("The human annotation scoring contract.")
  annotation_scoring_contract: EvaluatorDiagnosticScoringContractReference;

  @doc("Whether applicability, weighting, normalization, and threshold semantics match.")
  aggregation_policy_match: boolean;

  @doc("Stable bounded mismatch codes.")
  mismatch_codes: string[];
}

@doc("Bounded evidence counts for an agreement diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorAgreementSupportSummary {
  @doc("Number of items in the registered source.")
  source_item_count: int32;

  @doc("Number of items satisfying registered evidence requirements.")
  qualified_item_count: int32;

  @doc("Number of items selected by the service policy.")
  selected_item_count: int32;

  @doc("Number of items with comparable human and judge representations.")
  comparable_item_count: int32;

  @doc("Number of source items excluded from the comparison.")
  excluded_item_count: int32;
}

@doc("Applicability-label support for agreement.")
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
model EvaluatorApplicabilityAgreementSummary {
  @doc("Applicability-label support.")
  support: EvaluatorApplicabilitySupport;

  @doc("Observed applicability agreement.")
  observed_agreement: EvaluatorDiagnosticMetric;

  @doc("Observed applicability disagreement rate.")
  disagreement_rate: EvaluatorDiagnosticMetric;
}

@doc("Per-dimension ordinal-score agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDimensionAgreementSummary {
  @doc("The stable rubric dimension identifier.")
  dimension_id: string;

  @doc("Number of comparable common-applicable items.")
  comparable_item_count: int32;

  @doc("Number of missing or abstained representations.")
  missing_or_abstained_count: int32;

  @doc("Exact ordinal-score match rate.")
  exact_match: EvaluatorDiagnosticMetric;

  @doc("Mean absolute ordinal-score error.")
  mean_absolute_error: EvaluatorDiagnosticMetric;

  @doc("Mean signed judge-minus-human score bias.")
  signed_bias: EvaluatorDiagnosticMetric;

  @doc("Kendall tau-b rank agreement.")
  kendall_tau_b: EvaluatorDiagnosticMetric;

  @doc("Spearman rank agreement.")
  spearman_rho: EvaluatorDiagnosticMetric;

  @doc("Bounded human score counts keyed by score.")
  human_score_distribution: Record<int32>;

  @doc("Bounded judge score counts keyed by score.")
  judge_score_distribution: Record<int32>;
}

@doc("Centered rubric-profile agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorProfileAgreementSummary {
  @doc("Number of common-applicable dimensions represented.")
  common_applicable_dimension_count: int32;

  @doc("Centered weighted profile distance.")
  centered_weighted_profile_distance: EvaluatorDiagnosticMetric;

  @doc("Judge-minus-human aggregate score difference.")
  aggregate_score_difference: EvaluatorDiagnosticMetric;

  @doc("Number of aggregate-score collisions hiding profile divergence.")
  aggregate_collision_count: int32;

  @doc("Aggregate-score collision rate.")
  aggregate_collision_rate: EvaluatorDiagnosticMetric;
}

@doc("Structured decision-driver agreement.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDecisionDriverAgreementSummary {
  @doc("Whether structured decision-driver agreement was assessed.")
  status: EvaluatorDiagnosticMetricStatus;

  @doc("Why decision-driver agreement was not assessed.")
  reason?: string;

  @doc("Exact primary-driver match rate.")
  primary_driver_exact_match?: EvaluatorDiagnosticMetric;

  @doc("Registered top-k driver overlap.")
  top_k_overlap?: EvaluatorDiagnosticMetric;
}

@doc("Final-verdict class support.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorVerdictSupport {
  @doc("Human pass count.")
  human_pass: int32;

  @doc("Human fail count.")
  human_fail: int32;

  @doc("Judge pass count.")
  judge_pass: int32;

  @doc("Judge fail count.")
  judge_fail: int32;
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
model EvaluatorVerdictAgreementSummary {
  @doc("Human and judge class support.")
  support: EvaluatorVerdictSupport;

  @doc("Pass/fail confusion counts.")
  confusion: EvaluatorVerdictConfusion;

  @doc("Observed pass/fail agreement.")
  observed_agreement: EvaluatorDiagnosticMetric;

  @doc("Gwet AC1 when both classes have estimable support.")
  gwet_ac1: EvaluatorDiagnosticMetric;

  @doc("Judge-pass rate on human-fail cases.")
  false_pass_rate: EvaluatorDiagnosticMetric;

  @doc("Judge-fail rate on human-pass cases.")
  false_fail_rate: EvaluatorDiagnosticMetric;
}

@doc("Same-configuration repeatability available from service-registered runs.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorAgreementRepeatabilitySummary {
  @doc("The compatible registered repeat run.")
  run: EvaluatorDiagnosticEvaluationRunReference;

  @doc("Whether the repeat used the exact registered configuration.")
  configuration_match: boolean;

  @doc("Final-verdict agreement between the primary and repeat.")
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

  @doc("Bounded target-minus-baseline distribution deltas keyed by score.")
  score_distribution_delta?: Record<float64>;

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

  @doc("Number of unchanged shared dimensions.")
  unchanged_dimension_count?: int32;

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

  @doc("Stable bounded warnings.")
  warnings?: string[];
}

@doc("One shared evaluation/group and its baseline and target runs.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonRunReferences {
  @doc("The shared evaluation identifier or group.")
  eval_id: string;

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

@doc("A completed agreement diagnostic.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model AgreementEvaluatorDiagnostic extends EvaluatorDiagnosticChangeBase {
  type: EvaluatorDiagnosticType.agreement;

  @doc("The exact evaluator version analyzed.")
  target: EvaluatorDiagnosticVersionSnapshot;

  @doc("The immutable registered annotation dataset.")
  dataset: EvaluatorDiagnosticDatasetSnapshot;

  @doc("The resolved evaluation granularity.")
  evaluation_level: EvaluationLevel;

  @doc("The evaluator run compared with human labels.")
  evaluation_run: EvaluatorDiagnosticEvaluationRunReference;

  @doc("The evidence sufficiency and compatibility outcome.")
  evidence_status: EvaluatorAgreementEvidenceStatus;

  @doc("Evaluator and annotation semantic compatibility.")
  semantic_compatibility: EvaluatorAgreementSemanticCompatibility;

  @doc("Bounded evidence counts.")
  support: EvaluatorAgreementSupportSummary;

  @doc("Applicability agreement.")
  applicability: EvaluatorApplicabilityAgreementSummary;

  @doc("Per-dimension ordinal-score agreement.")
  dimension_scores: EvaluatorDimensionAgreementSummary[];

  @doc("Centered rubric-profile agreement.")
  profile: EvaluatorProfileAgreementSummary;

  @doc("Structured decision-driver agreement.")
  decision_drivers: EvaluatorDecisionDriverAgreementSummary;

  @doc("Final-verdict agreement.")
  final_verdict: EvaluatorVerdictAgreementSummary;

  @doc("Compatible service-registered repeats, when available.")
  repeatability?: EvaluatorAgreementRepeatabilitySummary[];

  @doc("Bounded interpretation limitations.")
  limitations: string[];
}

@doc("A completed comparison between two evaluator versions.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonEvaluatorDiagnostic
  extends EvaluatorDiagnosticChangeBase {
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

@doc("A completed evaluator diagnostic.")
@oneOf
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union EvaluatorDiagnostic {
  version_created: VersionCreatedDiagnosticChange,
  dimension_added: DimensionAddedDiagnosticChange,
  dimension_updated: DimensionUpdatedDiagnosticChange,
  dimension_removed: DimensionRemovedDiagnosticChange,
  definition_updated: DefinitionUpdatedDiagnosticChange,
  health_computed: HealthComputedDiagnosticChange,
  health_invalidated: HealthInvalidatedDiagnosticChange,
  agreement: AgreementEvaluatorDiagnostic,
  rubric_comparison: RubricComparisonEvaluatorDiagnostic,
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

@doc("Caller-supplied inputs for an evaluator diagnostic job.")
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model EvaluatorDiagnosticJobInputBase {
  @doc("The requested diagnostic calculation.")
  type: EvaluatorDiagnosticJobType;

  @doc("The evaluator name that owns the completed diagnostic.")
  evaluator_name: string;
}

@doc("Inputs for an agreement diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model AgreementDiagnosticJobInputs extends EvaluatorDiagnosticJobInputBase {
  type: EvaluatorDiagnosticJobType.agreement;

  @doc("The exact target evaluator version and content-hash precondition.")
  target: EvaluatorDiagnosticVersionReference;

  @doc("The immutable registered annotation dataset.")
  dataset: ImmutableDatasetReference;

  @doc("The evaluation granularity. Required only when evaluator and dataset metadata do not resolve one unique shared level.")
  evaluation_level?: EvaluationLevel;
}

@doc("Inputs for a rubric-comparison diagnostic job.")
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
model RubricComparisonDiagnosticJobInputs
  extends EvaluatorDiagnosticJobInputBase {
  type: EvaluatorDiagnosticJobType.rubric_comparison;

  @doc("The exact baseline evaluator version and content-hash precondition.")
  baseline: EvaluatorDiagnosticVersionReference;

  @doc("The exact target evaluator version and content-hash precondition.")
  target: EvaluatorDiagnosticVersionReference;

  @doc("The immutable registered dataset used for both evaluator versions.")
  dataset: ImmutableDatasetReference;

  @doc("The evaluation granularity. Required only when evaluator and dataset metadata do not resolve one unique shared level.")
  evaluation_level?: EvaluationLevel;
}

@doc("Caller-supplied inputs for an evaluator diagnostic job.")
@oneOf
@extension("x-ms-foundry-meta", EvaluatorDiagnosticJobsRequiredPreviews)
union EvaluatorDiagnosticJobInputs {
  agreement: AgreementDiagnosticJobInputs,
  rubric_comparison: RubricComparisonDiagnosticJobInputs,
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
  ...OmitProperties<
    JobLike<EvaluatorDiagnosticJobResult, EvaluatorDiagnosticJobInputs>,
    "inputs"
  >;

  @doc("The immutable caller-supplied diagnostic job inputs.")
  inputs: EvaluatorDiagnosticJobInputs;
}
