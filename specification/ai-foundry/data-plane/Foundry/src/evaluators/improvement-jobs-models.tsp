import "@typespec/openapi";
import "@typespec/versioning";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Http;
using OpenAPI;

namespace Azure.AI.Projects;

const EvaluatorImprovementRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An exact non-negative USD decimal. The service accepts at most six fractional digits and uses integer micro-USD internally.")
@minValue(0)
scalar EvaluatorImprovementUsdAmount extends decimal128;

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A rubric dimension weight accepted by the current evaluator contract.")
@minValue(1)
@maxValue(10)
scalar EvaluatorImprovementDimensionWeight extends int32;

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A rubric evaluator decision threshold. This is distinct from validation-profile acceptance thresholds.")
@minValue(0.0)
@maxValue(1.0)
scalar EvaluatorImprovementPassThreshold extends float32;

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The kind of an approved dimension-weight constraint.")
union EvaluatorImprovementWeightConstraintType {
  @doc("The approved values are an inclusive stepped range.")
  range: "range",

  @doc("The approved values are an explicit finite grid.")
  grid: "grid",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The kind of an approved evaluator pass-threshold calibration constraint.")
union EvaluatorImprovementPassThresholdConstraintType {
  @doc("The approved values are an inclusive stepped range.")
  range: "range",

  @doc("The approved values are an explicit finite grid.")
  grid: "grid",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The current phase of an evaluator improvement job.")
union EvaluatorImprovementPhase {
  string,

  @doc("The job is validating and freezing its inputs.")
  preparing: "preparing",

  @doc("The job is assessing reference compatibility and readiness.")
  assessing_evidence: "assessing_evidence",

  @doc("The job is searching bounded candidate attempts on development evidence.")
  searching: "searching",

  @doc("Exactly one finalist is frozen and independent confirmation is running.")
  confirming: "confirming",

  @doc("Bounded execution is complete.")
  completed: "completed",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The successful scientific and product outcome of an evaluator improvement job.")
union EvaluatorImprovementOutcome {
  @doc("Independent confirmation supports review of the exact stored finalist.")
  ready_for_review: "ready_for_review",

  @doc("Independent confirmation completed with adequate evidence and found no qualifying gain.")
  no_improvement: "no_improvement",

  @doc("The selected profile could not support the required claim because evidence was missing, incompatible, non-estimable, or insufficiently precise.")
  insufficient_evidence: "insufficient_evidence",

  @doc("Bounded work ended without a complete confirmation decision, for example because the attempt or inference-cost limit was reached.")
  incomplete: "incomplete",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The independent-confirmation state for the single frozen finalist.")
union EvaluatorImprovementConfirmationStatus {
  string,

  @doc("Confirmation did not start.")
  not_run: "not_run",

  @doc("Confirmation is in progress.")
  in_progress: "in_progress",

  @doc("Confirmation completed.")
  completed: "completed",

  @doc("Confirmation started but did not complete.")
  interrupted: "interrupted",

  @doc("Confirmation encountered a failure. Infrastructure failures remain represented by the parent job status and error.")
  failed: "failed",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Why bounded evaluator improvement work stopped.")
union EvaluatorImprovementStopReason {
  string,

  @doc("Independent confirmation supports review of the finalist.")
  candidate_confirmed: "candidate_confirmed",

  @doc("Independent confirmation found no qualifying improvement.")
  confirmed_no_improvement: "confirmed_no_improvement",

  @doc("Evidence could not satisfy the selected validation profile.")
  insufficient_evidence: "insufficient_evidence",

  @doc("The approved candidate-attempt limit was reached.")
  max_candidate_attempts_reached: "max_candidate_attempts_reached",

  @doc("The next conservative model-inference reservation did not fit the approved USD limit.")
  max_inference_cost_usd_reached: "max_inference_cost_usd_reached",

  @doc("Independent confirmation was interrupted.")
  confirmation_interrupted: "confirmation_interrupted",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The current human-review state for an evaluator improvement job.")
union EvaluatorImprovementReviewState {
  @doc("The job has no candidate eligible for review.")
  not_available: "not_available",

  @doc("The exact stored finalist is awaiting an explicit review action.")
  pending: "pending",

  @doc("An authenticated reviewer rejected the finalist.")
  rejected: "rejected",

  @doc("Publication of the exact stored finalist has been durably claimed.")
  publishing: "publishing",

  @doc("The exact stored finalist was published as a numbered evaluator version.")
  published: "published",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Whether the current caller and current authority permit publication.")
union EvaluatorImprovementPublicationEligibility {
  @doc("The exact stored finalist is currently eligible for publication.")
  eligible: "eligible",

  @doc("Publication is currently blocked.")
  blocked: "blocked",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The provenance class of an evaluator improvement strategy.")
union EvaluatorImprovementStrategySource {
  @doc("A fixed service-owned strategy.")
  fixed: "fixed",

  @doc("A separately trained and human-approved immutable strategy artifact.")
  approved_learned: "approved_learned",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The availability of authoritative model-inference pricing.")
union EvaluatorImprovementPricingStatus {
  string,

  @doc("The service catalog covers every requested model and billing dimension.")
  available: "available",

  @doc("The configuration requires a reference to an approved rate override.")
  approved_override_required: "approved_override_required",

  @doc("Authoritative pricing is unavailable, so the service cannot authorize model calls.")
  unavailable: "unavailable",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The authority that supplied a frozen model-inference price schedule.")
union EvaluatorImprovementPriceSource {
  @doc("The service's authoritative price catalog.")
  service_catalog: "service_catalog",

  @doc("A pre-approved immutable rate override.")
  approved_override: "approved_override",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The readiness of one frozen evidence source for the selected validation profile.")
union EvaluatorImprovementEvidenceReadinessStatus {
  @doc("The evidence meets the profile's compatibility, support, estimability, and precision requirements.")
  ready: "ready",

  @doc("The evidence can support the profile decision with recorded limitations.")
  ready_with_limitations: "ready_with_limitations",

  @doc("The evidence cannot support the profile decision.")
  not_ready: "not_ready",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A stable exclusion category for selected reference evidence.")
union EvaluatorImprovementEvidenceExclusionReason {
  string,

  @doc("The selected case or pair has no usable reference.")
  missing_reference: "missing_reference",

  @doc("The reference uses incompatible scoring or decision semantics.")
  incompatible_reference: "incompatible_reference",

  @doc("The source or adapter returned an error.")
  reference_error: "reference_error",

  @doc("The evidence duplicates another selected unit or crosses a registered split boundary.")
  duplicate_reference: "duplicate_reference",

  @doc("The reference or judge abstained.")
  abstention: "abstention",

  @doc("Development and confirmation evidence overlap.")
  development_confirmation_overlap: "development_confirmation_overlap",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Whether one profile metric can be interpreted.")
union EvaluatorImprovementMetricStatus {
  string,

  @doc("The metric was computed and is interpretable.")
  assessed: "assessed",

  @doc("The metric was not assessed.")
  not_assessed: "not_assessed",

  @doc("The metric is mathematically undefined for the observed evidence.")
  non_estimable: "non_estimable",

  @doc("Only one required class or score was observed.")
  single_class: "single_class",

  @doc("Comparable support was insufficient.")
  insufficient_support: "insufficient_support",

  @doc("The registered precision requirement was not met.")
  insufficient_precision: "insufficient_precision",

  @doc("The source and evaluator use incompatible semantics.")
  incompatible_semantics: "incompatible_semantics",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Whether one validation-profile requirement was met.")
union EvaluatorImprovementRequirementStatus {
  string,

  @doc("The requirement was met.")
  met: "met",

  @doc("The requirement was not met.")
  not_met: "not_met",

  @doc("The requirement could not be assessed.")
  not_assessed: "not_assessed",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The role of an assessment in the improvement workflow.")
union EvaluatorImprovementAssessmentType {
  @doc("An assessment over development evidence that may guide candidate selection.")
  development: "development",

  @doc("An independent assessment over evidence that did not guide search.")
  confirmation: "confirmation",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The profile conclusion for one assessment.")
union EvaluatorImprovementAssessmentConclusion {
  string,

  @doc("The assessment supports a qualifying improvement.")
  improvement_supported: "improvement_supported",

  @doc("The assessment found no qualifying improvement.")
  no_improvement: "no_improvement",

  @doc("The assessment could not support a conclusion.")
  insufficient_evidence: "insufficient_evidence",

  @doc("The assessment has not completed.")
  not_assessed: "not_assessed",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The kind of evaluator snapshot referenced for analysis.")
union EvaluatorAnalysisSubjectType {
  @doc("An immutable numbered evaluator version.")
  published_version: "published_version",

  @doc("The unnumbered current evaluator captured under an ETag and incarnation.")
  current_capture: "current_capture",

  @doc("An immutable job-owned non-publishing candidate.")
  improvement_candidate: "improvement_candidate",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The authenticated actor type recorded for an evaluator improvement review action.")
union EvaluatorImprovementActorType {
  @doc("An authenticated user.")
  user: "user",

  @doc("A Foundry service component.")
  service: "service",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An explicit evaluator improvement review action.")
union EvaluatorImprovementReviewActionType {
  @doc("Reject the exact stored finalist without changing evaluator state.")
  reject: "reject",

  @doc("Publish the exact stored finalist as a numbered evaluator version.")
  publish: "publish",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An immutable reference to a versioned improvement artifact.")
model EvaluatorImprovementArtifactReference {
  @doc("The artifact identifier.")
  id: string;

  @doc("The immutable artifact version.")
  version: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An immutable reference to a registered Foundry dataset.")
model EvaluatorImprovementDatasetReference {
  @doc("The dataset name.")
  name: string;

  @doc("The exact immutable dataset version. Aliases and `latest` are not accepted.")
  version: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One development or confirmation evidence source. The service freezes the dataset, reference manifest, mapping, and guidance before model work starts.")
model EvaluatorImprovementEvidenceSourceReference {
  @doc("The immutable registered dataset.")
  dataset: EvaluatorImprovementDatasetReference;

  @doc("The immutable manifest defining item identities, reference semantics, mappings, split membership, and permitted metrics.")
  reference_manifest: EvaluatorImprovementArtifactReference;

  @doc("The immutable annotation or verifier guidance used to interpret the references.")
  guidance: EvaluatorImprovementArtifactReference;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A customer-selected model deployment used by the improvement workflow. Pricing and resolved model identity remain server-authoritative.")
model EvaluatorImprovementModelConfiguration {
  @doc("The Foundry model deployment name.")
  deployment_name: string;

  @doc("The expected model name when the caller needs to constrain deployment resolution.")
  `model`?: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An immutable validation-profile reference. Profile acceptance and science thresholds are service-owned and cannot be edited by this job.")
model EvaluatorImprovementProfileReference {
  @doc("The validation-profile identifier.")
  id: string;

  @doc("The immutable validation-profile version.")
  version: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Base model for an approved weight constraint on one existing model-owned rubric dimension.")
@discriminator("type")
model EvaluatorImprovementWeightConstraint {
  @doc("The constraint kind.")
  type: EvaluatorImprovementWeightConstraintType;

  @doc("The stable existing rubric dimension identifier.")
  dimension_id: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An inclusive stepped range of approved integer weights for one existing dimension.")
model EvaluatorImprovementWeightRangeConstraint
  extends EvaluatorImprovementWeightConstraint {
  type: EvaluatorImprovementWeightConstraintType.range;

  @doc("The inclusive minimum approved weight.")
  minimum: EvaluatorImprovementDimensionWeight;

  @doc("The inclusive maximum approved weight.")
  maximum: EvaluatorImprovementDimensionWeight;

  @doc("The positive step between approved weights.")
  @minValue(1)
  step: int32;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An explicit finite grid of approved integer weights for one existing dimension.")
model EvaluatorImprovementWeightGridConstraint
  extends EvaluatorImprovementWeightConstraint {
  type: EvaluatorImprovementWeightConstraintType.grid;

  @doc("The approved weight values.")
  @minItems(1)
  allowed_values: EvaluatorImprovementDimensionWeight[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Base model for approved calibration of the evaluator definition's `pass_threshold`. This never changes validation-profile acceptance thresholds.")
@discriminator("type")
model EvaluatorImprovementPassThresholdConstraint {
  @doc("The constraint kind.")
  type: EvaluatorImprovementPassThresholdConstraintType;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An inclusive stepped range of approved evaluator pass-threshold values.")
model EvaluatorImprovementPassThresholdRangeConstraint
  extends EvaluatorImprovementPassThresholdConstraint {
  type: EvaluatorImprovementPassThresholdConstraintType.range;

  @doc("The inclusive minimum approved evaluator pass threshold.")
  minimum: EvaluatorImprovementPassThreshold;

  @doc("The inclusive maximum approved evaluator pass threshold.")
  maximum: EvaluatorImprovementPassThreshold;

  @doc("The positive step between approved threshold values.")
  @minValue(0.000001)
  step: float32;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An explicit finite grid of approved evaluator pass-threshold values.")
model EvaluatorImprovementPassThresholdGridConstraint
  extends EvaluatorImprovementPassThresholdConstraint {
  type: EvaluatorImprovementPassThresholdConstraintType.grid;

  @doc("The approved evaluator pass-threshold values.")
  @minItems(1)
  allowed_values: EvaluatorImprovementPassThreshold[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The caller-approved edit and scoring-calibration scope. The service intersects this scope with profile and evaluator restrictions.")
model EvaluatorImprovementEditScope {
  @doc("Existing model-owned dimension identifiers whose descriptions may be changed.")
  description_dimension_ids: string[];

  @doc("Approved weight ranges or grids for selected existing model-owned dimensions.")
  weight_constraints: EvaluatorImprovementWeightConstraint[];

  @doc("Optional approved calibration of the evaluator definition's `pass_threshold`. Pairwise profiles omit this unless they define a separate compatible binary decision mapping.")
  pass_threshold_constraint?: EvaluatorImprovementPassThresholdConstraint;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A reference to a pre-approved immutable rate override. The caller cannot supply rates or assert approval.")
model EvaluatorImprovementApprovedRateOverrideReference {
  @doc("The approved override identifier.")
  id: string;

  @doc("The immutable approved override version.")
  version: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The customer-visible bounds for one improvement job.")
model EvaluatorImprovementBudget {
  @doc("The maximum number of proposed candidate configurations, including structurally rejected proposals and deterministic calibration variants.")
  @minValue(1)
  max_candidate_attempts: int32;

  @doc("The exact maximum USD amount for model inference. It excludes ACA, storage, networking, deterministic analysis, and human review.")
  max_inference_cost_usd: EvaluatorImprovementUsdAmount;

  @doc("An approved rate override reference required only when the authoritative service catalog does not cover the selected configuration.")
  approved_rate_override?: EvaluatorImprovementApprovedRateOverrideReference;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "The public contract uses the Request suffix."
@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The request for a bounded evaluator improvement job.")
model EvaluatorImprovementJobRequest {
  @doc("The model deployment used to generate and revise candidate rubric content.")
  generator: EvaluatorImprovementModelConfiguration;

  @doc("The model deployment used to score the baseline and candidates.")
  judge: EvaluatorImprovementModelConfiguration;

  @doc("Evidence available to candidate search and selection.")
  development_source: EvaluatorImprovementEvidenceSourceReference;

  @doc("Independent evidence reserved for exactly one frozen finalist. It cannot guide another candidate attempt.")
  confirmation_source: EvaluatorImprovementEvidenceSourceReference;

  @doc("Optional existing evaluator-generation guidance sources. Confirmation evidence and references cannot be used as guidance.")
  guidance_sources?: EvaluatorGenerationJobSource[];

  @doc("The explicit caller-approved edit and evaluator-threshold calibration scope.")
  edit_scope: EvaluatorImprovementEditScope;

  @doc("The immutable service-owned validation profile.")
  validation_profile: EvaluatorImprovementProfileReference;

  @doc("The candidate-attempt and exact model-inference USD limits.")
  budget: EvaluatorImprovementBudget;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A read-only approved strategy offered for future evaluator improvement jobs.")
model EvaluatorImprovementStrategyOption {
  @doc("The strategy identifier.")
  id: string;

  @doc("A human-friendly strategy name.")
  display_name: string;

  @doc("The immutable strategy version.")
  version: string;

  @doc("Whether the strategy is fixed or separately trained and approved.")
  source: EvaluatorImprovementStrategySource;

  @doc("The immutable approved strategy artifact, when the strategy is learned.")
  approved_artifact?: EvaluatorImprovementArtifactReference;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An editable field on an existing model-owned rubric dimension.")
union EvaluatorImprovementEditableDimensionField {
  @doc("The dimension description.")
  description: "description",

  @doc("The integer dimension weight.")
  weight: "weight",
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Editable fields and weight choices for one existing model-owned dimension.")
model EvaluatorImprovementEditableDimensionOption {
  @doc("The stable existing dimension identifier.")
  dimension_id: string;

  @doc("The fields currently available for selection.")
  fields: EvaluatorImprovementEditableDimensionField[];

  @doc("The current integer dimension weight.")
  current_weight: EvaluatorImprovementDimensionWeight;

  @doc("The approved weight constraints.")
  weight_constraints: EvaluatorImprovementWeightConstraint[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Evaluator pass-threshold calibration availability.")
model EvaluatorImprovementPassThresholdOption {
  @doc("Whether at least one profile supports evaluator pass-threshold calibration.")
  enabled: boolean;

  @doc("The current evaluator pass threshold.")
  current_value: EvaluatorImprovementPassThreshold;

  @doc("The maximum available calibration constraint when enabled.")
  constraint?: EvaluatorImprovementPassThresholdConstraint;

  @doc("Stable reasons threshold calibration is unavailable.")
  blocking_reasons: EvaluatorImprovementBlockingReason[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Current caller permissions relevant to evaluator improvement. Publish and reject reuse the existing evaluator asset-write permission in this preview.")
model EvaluatorImprovementPermissions {
  @doc("Whether the caller may start an improvement job.")
  can_start: boolean;

  @doc("Whether the caller may reject an eligible finalist.")
  can_reject: boolean;

  @doc("Whether the caller may publish an eligible finalist.")
  can_publish: boolean;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A stable reason that an improvement option or action is unavailable.")
model EvaluatorImprovementBlockingReason {
  @doc("A stable machine-readable reason code.")
  code: string;

  @doc("A bounded user-facing explanation.")
  message: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Authoritative pricing availability for a prospective improvement job.")
model EvaluatorImprovementPricingAvailability {
  @doc("Whether the selected or default model configuration has authoritative pricing.")
  status: EvaluatorImprovementPricingStatus;

  @doc("The applicable service price-catalog version, when available.")
  catalog_version?: string;

  @doc("The pricing scope. The initial value is `model_inference_only`.")
  scope: "model_inference_only";

  @doc("Pricing is an inference estimate under captured service rates and is not a guarantee of the customer's Azure invoice.")
  invoice_guarantee: false;

  @doc("Stable reasons that authoritative pricing is unavailable or requires an approved override.")
  blocking_reasons: EvaluatorImprovementBlockingReason[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One validation-profile option and the evaluator fields it currently permits the caller to select.")
model EvaluatorImprovementProfileOption {
  @doc("The immutable validation profile.")
  profile: EvaluatorImprovementProfileReference;

  @doc("A human-friendly profile name.")
  display_name: string;

  @doc("A bounded explanation of the profile's reference family, metrics, and decision semantics.")
  description: string;

  @doc("Metric families supported by the profile.")
  supported_metric_families: string[];

  @doc("The maximum edit and scoring-calibration scope currently available under this profile. A create request selects an explicit subset.")
  available_edit_scope: EvaluatorImprovementEditScope;

  @doc("Whether the profile is currently selectable.")
  enabled: boolean;

  @doc("Stable reasons the profile is unavailable.")
  blocking_reasons: EvaluatorImprovementBlockingReason[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "The approved public wire contract uses the Options suffix; C# may rename this model in client projection."
@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Evaluator-specific options for starting a bounded improvement job. Create and publish recheck every permission and authority.")
model EvaluatorImprovementOptions {
  @doc("Whether at least one improvement configuration is currently available.")
  enabled: boolean;

  @doc("Current caller permissions.")
  permissions: EvaluatorImprovementPermissions;

  @doc("Selectable service-owned validation profiles.")
  profiles: EvaluatorImprovementProfileOption[];

  @doc("The read-only strategy currently applicable to newly accepted jobs. This API does not select, train, or upload strategies.")
  strategy: EvaluatorImprovementStrategyOption;

  @doc("Supported candidate-generation deployments.")
  generators: EvaluatorImprovementModelConfiguration[];

  @doc("The frozen judge deployment used for development and confirmation.")
  judge: EvaluatorImprovementModelConfiguration;

  @doc("Existing model-owned dimensions available for description or weight changes.")
  editable_dimensions: EvaluatorImprovementEditableDimensionOption[];

  @doc("Evaluator pass-threshold calibration availability.")
  pass_threshold: EvaluatorImprovementPassThresholdOption;

  @doc("The default candidate-attempt and model-inference USD limits.")
  default_budget: EvaluatorImprovementBudget;

  @doc("Authoritative model-inference pricing availability.")
  pricing: EvaluatorImprovementPricingAvailability;

  @doc("Stable reasons improvement is unavailable.")
  blocking_reasons: EvaluatorImprovementBlockingReason[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "This is an HTTP error response envelope, not a successful result model."
@added(Versions.PuPr)
@removed(Versions.v1)
@error
@doc("A conflict response for an Operation-Id mismatch, review race, or already rejected or published job.")
model EvaluatorImprovementConflictResponse {
  ...Response<409>;
  ...ApiErrorResponse;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "This is an HTTP error response envelope, not a successful result model."
@added(Versions.PuPr)
@removed(Versions.v1)
@error
@doc("A precondition-failed response when the captured current-evaluator ETag or incarnation is no longer current.")
model EvaluatorImprovementPreconditionFailedResponse {
  ...Response<412>;
  ...ApiErrorResponse;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An immutable captured artifact with content identity.")
model EvaluatorImprovementArtifactSnapshot {
  @doc("The artifact identifier.")
  id: string;

  @doc("The immutable artifact version.")
  version: string;

  @doc("The lowercase SHA-256 content hash.")
  content_hash: Sha256Hash;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A registered dataset snapshot frozen for evaluator improvement.")
model EvaluatorImprovementDatasetSnapshot {
  @doc("The dataset name.")
  name: string;

  @doc("The exact immutable dataset version.")
  version: string;

  @doc("The lowercase SHA-256 dataset content hash.")
  content_hash: Sha256Hash;

  @doc("The registered dataset or reference schema version.")
  schema_version: string;

  @doc("The lowercase SHA-256 hash of the stable item and field mapping.")
  mapping_hash: Sha256Hash;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A development or confirmation source frozen at job acceptance.")
model EvaluatorImprovementEvidenceSourceSnapshot {
  @doc("The immutable registered dataset snapshot.")
  dataset: EvaluatorImprovementDatasetSnapshot;

  @doc("The immutable reference manifest snapshot.")
  reference_manifest: EvaluatorImprovementArtifactSnapshot;

  @doc("The immutable interpretation-guidance snapshot.")
  guidance: EvaluatorImprovementArtifactSnapshot;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A resolved model deployment frozen at job acceptance.")
model EvaluatorImprovementModelSnapshot {
  @doc("The Foundry model deployment name.")
  deployment_name: string;

  @doc("The resolved model identifier.")
  model_name: string;

  @doc("The resolved immutable model version or snapshot, when supplied by the provider.")
  model_version?: string;

  @doc("The resolved Azure region.")
  region: string;

  @doc("The resolved deployment type or billing tier.")
  deployment_type: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Service and worker versions frozen for reproducibility.")
model EvaluatorImprovementSoftwareProvenance {
  @doc("The RAISvc build or deployment version.")
  service_version: string;

  @doc("The evaluator-improvement engine version.")
  engine_version: string;

  @doc("The immutable worker image digest.")
  worker_image_digest: string;

  @doc("The candidate schema version.")
  candidate_schema_version: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Base reference to an evaluator snapshot used for analysis.")
@discriminator("type")
model EvaluatorAnalysisSubjectReference {
  @doc("The snapshot kind.")
  type: EvaluatorAnalysisSubjectType;

  @doc("The evaluator name.")
  evaluator_name: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A reference to an immutable numbered evaluator version.")
model PublishedEvaluatorAnalysisSubjectReference
  extends EvaluatorAnalysisSubjectReference {
  type: EvaluatorAnalysisSubjectType.published_version;

  @doc("The immutable evaluator version.")
  version: EvaluatorVersionNumber;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A reference to the unnumbered current evaluator captured under an ETag and incarnation.")
model EvaluatorCurrentCaptureAnalysisSubjectReference
  extends EvaluatorAnalysisSubjectReference {
  type: EvaluatorAnalysisSubjectType.current_capture;

  @doc("The immutable job-owned snapshot identifier.")
  snapshot_id: string;

  @doc("The evaluator resource incarnation captured at job acceptance.")
  incarnation_id: string;

  @doc("The current evaluator ETag supplied in the create request's `If-Match` header and captured by the service.")
  captured_etag: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A reference to an immutable job-owned candidate. Candidates have no evaluator version and no ETag.")
model ImprovementCandidateAnalysisSubjectReference
  extends EvaluatorAnalysisSubjectReference {
  type: EvaluatorAnalysisSubjectType.improvement_candidate;

  @doc("The parent improvement job identifier.")
  job_id: string;

  @doc("The immutable candidate identifier.")
  candidate_id: string;

  @doc("The immutable candidate snapshot identifier.")
  snapshot_id: string;

  @doc("The evaluator resource incarnation inherited from the captured current evaluator.")
  incarnation_id: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The exact current rubric evaluator captured as the baseline.")
model EvaluatorImprovementBaselineSnapshot {
  @doc("The non-publishing captured-current subject identity.")
  subject: EvaluatorCurrentCaptureAnalysisSubjectReference;

  @doc("The exact captured rubric evaluator definition.")
  definition: RubricBasedEvaluatorDefinition;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One bounded development signal used to explain strategy selection. This is rationale, not independent confirmation.")
model EvaluatorImprovementStrategyDevelopmentEvidence {
  @doc("A stable signal code.")
  code: string;

  @doc("A bounded explanation that does not expose raw evidence content.")
  summary: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The immutable strategy selected by the service for this job. Customers cannot upload or train strategies through this API.")
model EvaluatorImprovementStrategySnapshot {
  @doc("The strategy identifier.")
  id: string;

  @doc("A human-friendly strategy name.")
  display_name: string;

  @doc("The immutable strategy version.")
  version: string;

  @doc("Whether the strategy is fixed or separately trained and approved.")
  source: EvaluatorImprovementStrategySource;

  @doc("The allowlisted repair or calibration action selected by the strategy.")
  action: string;

  @doc("Why the strategy and action were selected for this job.")
  selection_reason: string;

  @doc("A bounded explanation of the intended repair mechanism. This is not measured evidence.")
  rationale: string;

  @doc("Development-only signals supporting the selection explanation.")
  development_evidence: EvaluatorImprovementStrategyDevelopmentEvidence[];

  @doc("The approved immutable strategy artifact. Required when `source` is `approved_learned` and omitted for a built-in fixed strategy.")
  approved_artifact?: EvaluatorImprovementArtifactSnapshot;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Frozen token rates for one resolved model deployment. Every value is exact USD per one million tokens.")
model EvaluatorImprovementModelPrice {
  @doc("The resolved deployment.")
  resolved_model: EvaluatorImprovementModelSnapshot;

  @doc("USD per one million input tokens.")
  input_usd_per_million_tokens: EvaluatorImprovementUsdAmount;

  @doc("USD per one million output tokens.")
  output_usd_per_million_tokens: EvaluatorImprovementUsdAmount;

  @doc("USD per one million cached-input tokens, when separately billed.")
  cached_input_usd_per_million_tokens?: EvaluatorImprovementUsdAmount;

  @doc("USD per one million cache-write tokens, when separately billed.")
  cache_write_usd_per_million_tokens?: EvaluatorImprovementUsdAmount;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The authoritative immutable price schedule captured before model work starts.")
model EvaluatorImprovementPriceSnapshot {
  @doc("The price snapshot identifier.")
  id: string;

  @doc("The price authority.")
  source: EvaluatorImprovementPriceSource;

  @doc("The authoritative catalog or approved-override identifier.")
  source_id: string;

  @doc("The immutable catalog or approved-override version.")
  source_version: string;

  @doc("When the price schedule was captured.")
  captured_at: utcDateTime;

  @doc("The currency. The initial value is `USD`.")
  currency: "USD";

  @doc("The budget scope. The initial value is `model_inference_only`.")
  scope: "model_inference_only";

  @doc("Frozen model rates used for reservation and reconciliation.")
  model_prices: EvaluatorImprovementModelPrice[];

  @doc("Costs excluded from the customer limit, including ACA, storage, networking, deterministic analysis, and human review.")
  excluded_cost_categories: string[];

  @doc("This estimate is not a guarantee of the customer's Azure invoice.")
  invoice_guarantee: false;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The server-frozen configuration used by an evaluator improvement job.")
model EvaluatorImprovementConfigurationSnapshot {
  @doc("The development evidence available to search.")
  development_source: EvaluatorImprovementEvidenceSourceSnapshot;

  @doc("The independent evidence reserved for the single frozen finalist.")
  confirmation_source: EvaluatorImprovementEvidenceSourceSnapshot;

  @doc("Immutable guidance artifacts made available to candidate generation.")
  guidance_sources: EvaluatorImprovementArtifactSnapshot[];

  @doc("The resolved generator deployment.")
  generator: EvaluatorImprovementModelSnapshot;

  @doc("The resolved judge deployment.")
  judge: EvaluatorImprovementModelSnapshot;

  @doc("The immutable judge configuration and scoring-contract snapshot.")
  judge_configuration: EvaluatorImprovementArtifactSnapshot;

  @doc("The immutable validation profile.")
  validation_profile: EvaluatorImprovementProfileReference;

  @doc("The effective edit and evaluator-threshold calibration scope after intersecting caller approval with service restrictions.")
  edit_scope: EvaluatorImprovementEditScope;

  @doc("Frozen service and worker versions.")
  software: EvaluatorImprovementSoftwareProvenance;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Progress for bounded candidate search and independent confirmation.")
model EvaluatorImprovementProgress {
  @doc("The number of candidate configurations allocated, including rejected proposals and deterministic calibration variants.")
  @minValue(0)
  candidate_attempts_started: int32;

  @doc("The number of candidate attempts that reached a terminal attempt state.")
  @minValue(0)
  candidate_attempts_completed: int32;

  @doc("The number of structurally invalid or out-of-scope candidate attempts.")
  @minValue(0)
  candidate_attempts_rejected: int32;

  @doc("The approved maximum number of candidate configurations.")
  @minValue(1)
  max_candidate_attempts: int32;

  @doc("Whether exactly one finalist has been frozen.")
  finalist_selected: boolean;

  @doc("Whether candidate search is permanently closed. It becomes true before confirmation starts and cannot return to false.")
  search_closed: boolean;

  @doc("The independent-confirmation status.")
  confirmation_status: EvaluatorImprovementConfirmationStatus;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Exact model-inference budget progress. `spent_usd + reserved_usd + remaining_usd` equals `max_inference_cost_usd`. `reconciled_usd` and `uncertain_usd` are identified subsets of `spent_usd` and must not be added to it.")
model EvaluatorImprovementCostProgress {
  @doc("The exact approved model-inference USD limit.")
  max_inference_cost_usd: EvaluatorImprovementUsdAmount;

  @doc("The current best-known model-inference cost already debited.")
  spent_usd: EvaluatorImprovementUsdAmount;

  @doc("The subset of `spent_usd` finalized from returned usage.")
  reconciled_usd: EvaluatorImprovementUsdAmount;

  @doc("The subset of `spent_usd` conservatively retained for possibly transmitted calls without final usage.")
  uncertain_usd: EvaluatorImprovementUsdAmount;

  @doc("The conservative maximum cost held for admitted but unfinished model calls.")
  reserved_usd: EvaluatorImprovementUsdAmount;

  @doc("The uncommitted amount: `max_inference_cost_usd - spent_usd - reserved_usd`.")
  remaining_usd: EvaluatorImprovementUsdAmount;

  @doc("The frozen authoritative price schedule.")
  price_snapshot: EvaluatorImprovementPriceSnapshot;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Counts of explicit evidence units. Zero is valid. No field defines a universal minimum.")
model EvaluatorImprovementEvidenceUnits {
  @doc("Selected cases.")
  @minValue(0)
  selected_cases: int32;

  @doc("Cases eligible after source and mapping validation.")
  @minValue(0)
  eligible_cases: int32;

  @doc("Selected response pairs for a pairwise source.")
  @minValue(0)
  selected_response_pairs: int32;

  @doc("Eligible response pairs for a pairwise source.")
  @minValue(0)
  eligible_response_pairs: int32;

  @doc("Comparable case-dimension reference judgments.")
  @minValue(0)
  case_dimension_comparisons: int32;

  @doc("Individual reviewer judgments.")
  @minValue(0)
  reviewer_judgments: int32;

  @doc("Independent sampling clusters or question families.")
  @minValue(0)
  independent_clusters: int32;

  @doc("References comparable under the selected profile.")
  @minValue(0)
  comparable_references: int32;

  @doc("Selected references excluded from comparison.")
  @minValue(0)
  excluded_references: int32;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A counted evidence exclusion.")
model EvaluatorImprovementEvidenceExclusion {
  @doc("The stable exclusion category.")
  reason: EvaluatorImprovementEvidenceExclusionReason;

  @doc("The number of excluded evidence units.")
  @minValue(0)
  count: int32;

  @doc("A bounded explanation or remediation hint.")
  message?: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Observed support for one registered class, ordinal score, preference label, or applicability state.")
model EvaluatorImprovementClassSupport {
  @doc("The class or score identifier from the registered scoring contract.")
  label: string;

  @doc("The number of compatible observations.")
  @minValue(0)
  count: int32;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One immutable validation-profile requirement and its observed status. These requirements are not editable candidate fields.")
model EvaluatorImprovementProfileRequirement {
  @doc("The stable profile requirement identifier.")
  id: string;

  @doc("The evidence unit used by the requirement.")
  unit: string;

  @doc("Whether the requirement was met.")
  status: EvaluatorImprovementRequirementStatus;

  @doc("The observed non-negative count or measurement, when represented as a count.")
  @minValue(0)
  observed_count?: int32;

  @doc("A bounded explanation or remediation hint.")
  message?: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Profile-specific compatibility, support, estimability, and precision for one frozen evidence source.")
model EvaluatorImprovementEvidenceReadiness {
  @doc("The immutable validation profile.")
  profile: EvaluatorImprovementProfileReference;

  @doc("The reference family, such as binary criterion satisfaction or paired-choice correctness.")
  reference_family: string;

  @doc("The immutable adapter identifier.")
  adapter_id: string;

  @doc("The immutable adapter version.")
  adapter_version: string;

  @doc("The registered decision mapping, when the profile has one.")
  decision_mapping?: string;

  @doc("The resolved evaluation level.")
  evaluation_level: EvaluationLevel;

  @doc("The immutable scoring-contract identity.")
  scoring_contract: EvaluatorImprovementArtifactSnapshot;

  @doc("The readiness result.")
  status: EvaluatorImprovementEvidenceReadinessStatus;

  @doc("Explicit evidence-unit counts.")
  units: EvaluatorImprovementEvidenceUnits;

  @doc("Counted missing, incompatible, error, duplicate, abstention, and overlap exclusions.")
  exclusions: EvaluatorImprovementEvidenceExclusion[];

  @doc("Observed class, score, preference, or applicability support.")
  class_support: EvaluatorImprovementClassSupport[];

  @doc("Metric identifiers supported by this evidence and profile.")
  supported_metric_ids: string[];

  @doc("Metric identifiers that cannot be interpreted for this evidence.")
  unsupported_metric_ids: string[];

  @doc("Profile-specific requirements and their observed status.")
  requirements: EvaluatorImprovementProfileRequirement[];

  @doc("Bounded readiness limitations and remediation guidance.")
  limitations: string[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One metric estimate with explicit support and uncertainty.")
model EvaluatorImprovementMetricEstimate {
  @doc("Whether the estimate is interpretable.")
  status: EvaluatorImprovementMetricStatus;

  @doc("The point estimate.")
  value?: float64;

  @doc("The metric numerator when the metric is a ratio.")
  @minValue(0)
  numerator?: int32;

  @doc("The metric denominator when the metric is a ratio.")
  @minValue(0)
  denominator?: int32;

  @doc("The number of comparable evidence units used by the estimate.")
  @minValue(0)
  sample_count: int32;

  @doc("The registered lower uncertainty bound.")
  lower_bound?: float64;

  @doc("The registered upper uncertainty bound.")
  upper_bound?: float64;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A baseline-versus-candidate metric computed on one frozen evidence source.")
model EvaluatorImprovementMetricComparison {
  @doc("The metric identifier defined by the immutable validation profile.")
  metric_id: string;

  @doc("The captured current evaluator estimate.")
  baseline: EvaluatorImprovementMetricEstimate;

  @doc("The exact finalist estimate.")
  candidate: EvaluatorImprovementMetricEstimate;

  @doc("Candidate minus baseline when defined for the metric.")
  delta?: float64;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A development or independent-confirmation assessment. Development evidence may guide search; confirmation evidence may not.")
model EvaluatorImprovementAssessment {
  @doc("Whether this is development or independent confirmation evidence.")
  type: EvaluatorImprovementAssessmentType;

  @doc("The frozen evidence source.")
  source: EvaluatorImprovementEvidenceSourceSnapshot;

  @doc("Profile-specific readiness and support.")
  readiness: EvaluatorImprovementEvidenceReadiness;

  @doc("The metric family actually used.")
  metric_family: string;

  @doc("Baseline-versus-finalist metric comparisons.")
  metrics: EvaluatorImprovementMetricComparison[];

  @doc("The immutable profile's conclusion.")
  conclusion: EvaluatorImprovementAssessmentConclusion;

  @doc("Bounded interpretation limitations.")
  limitations: string[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One approved description change on an existing model-owned rubric dimension.")
model EvaluatorImprovementDescriptionChange {
  @doc("The stable existing dimension identifier.")
  dimension_id: string;

  @doc("The captured description.")
  before: string;

  @doc("The proposed description.")
  after: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("One approved integer-weight change on an existing model-owned rubric dimension.")
model EvaluatorImprovementWeightChange {
  @doc("The stable existing dimension identifier.")
  dimension_id: string;

  @doc("The captured weight.")
  before: EvaluatorImprovementDimensionWeight;

  @doc("The proposed weight.")
  after: EvaluatorImprovementDimensionWeight;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An approved calibration change to the evaluator definition's `pass_threshold`. This is not a validation-profile acceptance-threshold change.")
model EvaluatorImprovementPassThresholdChange {
  @doc("The captured evaluator pass threshold.")
  before: EvaluatorImprovementPassThreshold;

  @doc("The proposed evaluator pass threshold.")
  after: EvaluatorImprovementPassThreshold;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The exact allowlisted difference between the captured current evaluator and the finalist.")
model EvaluatorImprovementCandidateChange {
  @doc("Approved description changes.")
  description_changes: EvaluatorImprovementDescriptionChange[];

  @doc("Approved integer-weight changes.")
  weight_changes: EvaluatorImprovementWeightChange[];

  @doc("An approved evaluator decision-threshold calibration, when supported by the profile's decision mapping.")
  pass_threshold_change?: EvaluatorImprovementPassThresholdChange;

  @doc("Stable paths or constraint identifiers verified unchanged, including IDs, order, ownership, applicability, vetoes, schemas, model bindings, and validation-profile rules.")
  preserved_constraints: string[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Immutable provenance for a job-owned candidate.")
model EvaluatorImprovementCandidateProvenance {
  @doc("The one-based candidate-attempt number.")
  @minValue(1)
  attempt_number: int32;

  @doc("When the candidate snapshot was created.")
  created_at: utcDateTime;

  @doc("The frozen generator deployment.")
  generator: EvaluatorImprovementModelSnapshot;

  @doc("The selected immutable strategy identifier.")
  strategy_id: string;

  @doc("The selected immutable strategy version.")
  strategy_version: string;

  @doc("The immutable validation profile.")
  validation_profile: EvaluatorImprovementProfileReference;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The exact immutable non-publishing finalist. Publication always reloads this stored snapshot; the client cannot replace its content.")
model EvaluatorImprovementCandidateSnapshot {
  @doc("The non-publishing candidate subject identity.")
  subject: ImprovementCandidateAnalysisSubjectReference;

  @doc("An opaque permission-checked reference for executing or inspecting this exact private candidate.")
  execution_reference: string;

  @doc("The complete exact rubric evaluator definition stored for the candidate.")
  definition: RubricBasedEvaluatorDefinition;

  @doc("The exact allowlisted difference from the captured current evaluator.")
  change: EvaluatorImprovementCandidateChange;

  @doc("A bounded explanation of the intended repair. This is not measured evidence.")
  rationale: string;

  @doc("The expected benefit stated before independent confirmation.")
  expected_benefit: string;

  @doc("Immutable candidate provenance.")
  provenance: EvaluatorImprovementCandidateProvenance;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A stable reason that publication is currently blocked.")
model EvaluatorImprovementReviewBlockingReason {
  @doc("A stable machine-readable reason code, such as `confirmation_not_completed`, `baseline_etag_changed`, `incarnation_changed`, `permission_denied`, `reference_authority_changed`, `profile_authority_changed`, or `strategy_authority_changed`.")
  code: string;

  @doc("A bounded user-facing explanation.")
  message: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("The authenticated actor recorded for a review action.")
model EvaluatorImprovementActor {
  @doc("The actor type.")
  type: EvaluatorImprovementActorType;

  @doc("A stable opaque principal or service identifier.")
  id: string;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("An immutable audit record for an explicit reject or publish action.")
model EvaluatorImprovementReviewActionRecord {
  @doc("The explicit action.")
  action: EvaluatorImprovementReviewActionType;

  @doc("The exact candidate snapshot reviewed.")
  candidate_snapshot_id: string;

  @doc("The authenticated actor.")
  actor: EvaluatorImprovementActor;

  @doc("When the action was durably recorded.")
  recorded_at: utcDateTime;

  @doc("A bounded reviewer note.")
  note?: string;

  @doc("The numbered evaluator version created by publication.")
  published_version?: EvaluatorVersionNumber;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Human review and current publication eligibility. Eligibility is recomputed without rewriting historical evidence.")
model EvaluatorImprovementReview {
  @doc("The durable review state.")
  state: EvaluatorImprovementReviewState;

  @doc("Whether the exact stored finalist is currently eligible for publication.")
  publication_eligibility: EvaluatorImprovementPublicationEligibility;

  @doc("Stable current blocking reasons.")
  blocking_reasons: EvaluatorImprovementReviewBlockingReason[];

  @doc("The accepted reject or publish action, when one exists.")
  action?: EvaluatorImprovementReviewActionRecord;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Base successful result for bounded evaluator improvement.")
@discriminator("outcome")
model EvaluatorImprovementJobResult {
  @doc("The scientific and product outcome.")
  outcome: EvaluatorImprovementOutcome;

  @doc("The independent-confirmation status.")
  confirmation_status: EvaluatorImprovementConfirmationStatus;

  @doc("Why bounded work stopped.")
  stop_reason: EvaluatorImprovementStopReason;

  @doc("The development assessment, when completed.")
  development_assessment?: EvaluatorImprovementAssessment;

  @doc("The independent confirmation assessment, when completed.")
  confirmation_assessment?: EvaluatorImprovementAssessment;

  @doc("Bounded result limitations.")
  limitations: string[];

  @doc("Bounded quality, cost, coverage, or operational tradeoffs for review.")
  tradeoffs: string[];
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A successful result with one independently confirmed finalist available for explicit review.")
model EvaluatorImprovementReadyForReviewResult
  extends EvaluatorImprovementJobResult {
  outcome: EvaluatorImprovementOutcome.ready_for_review;
  confirmation_status: EvaluatorImprovementConfirmationStatus.completed;

  @doc("The exact stored finalist.")
  candidate: EvaluatorImprovementCandidateSnapshot;

  @doc("The completed development assessment.")
  development_assessment: EvaluatorImprovementAssessment;

  @doc("The completed independent confirmation assessment.")
  confirmation_assessment: EvaluatorImprovementAssessment;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A successful result where adequate independent confirmation found no qualifying gain.")
model EvaluatorImprovementNoImprovementResult
  extends EvaluatorImprovementJobResult {
  outcome: EvaluatorImprovementOutcome.no_improvement;
  confirmation_status: EvaluatorImprovementConfirmationStatus.completed;

  @doc("The one frozen finalist that was independently confirmed. It is not publication-eligible.")
  candidate: EvaluatorImprovementCandidateSnapshot;

  @doc("The completed development assessment.")
  development_assessment: EvaluatorImprovementAssessment;

  @doc("The completed independent confirmation assessment.")
  confirmation_assessment: EvaluatorImprovementAssessment;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A successful result where evidence could not support the selected validation profile.")
model EvaluatorImprovementInsufficientEvidenceResult
  extends EvaluatorImprovementJobResult {
  outcome: EvaluatorImprovementOutcome.insufficient_evidence;

  @doc("The frozen finalist, when insufficiency was discovered during confirmation.")
  candidate?: EvaluatorImprovementCandidateSnapshot;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A successful bounded result without a complete confirmation decision. It never represents confirmed no gain or missing labels by default.")
model EvaluatorImprovementIncompleteResult
  extends EvaluatorImprovementJobResult {
  outcome: EvaluatorImprovementOutcome.incomplete;

  @doc("An eligible frozen finalist, when one existed before bounded work stopped.")
  candidate?: EvaluatorImprovementCandidateSnapshot;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A durable evaluator improvement job. Failure and cancellation retain the standard `JobStatus` and `ApiError` semantics.")
@extension("x-ms-foundry-meta", EvaluatorImprovementRequiredPreviews)
model EvaluatorImprovementJob is JobLike<
  EvaluatorImprovementJobResult,
  EvaluatorImprovementJobRequest
> {
  @doc("When the job was created.")
  @visibility(Lifecycle.Read)
  created_at: utcDateTime;

  @doc("When model or evidence work started.")
  @visibility(Lifecycle.Read)
  started_at?: utcDateTime;

  @doc("When the job reached a terminal state.")
  @visibility(Lifecycle.Read)
  finished_at?: utcDateTime;

  @doc("The current improvement phase.")
  @visibility(Lifecycle.Read)
  phase: EvaluatorImprovementPhase;

  @doc("The exact unnumbered current evaluator captured under the required `If-Match` header and server-side incarnation.")
  @visibility(Lifecycle.Read)
  baseline: EvaluatorImprovementBaselineSnapshot;

  @doc("The server-frozen sources, model identities, profile, edit scope, and software provenance.")
  @visibility(Lifecycle.Read)
  configuration: EvaluatorImprovementConfigurationSnapshot;

  @doc("The immutable strategy selected by the service.")
  @visibility(Lifecycle.Read)
  strategy: EvaluatorImprovementStrategySnapshot;

  @doc("Bounded attempt and confirmation progress.")
  @visibility(Lifecycle.Read)
  progress: EvaluatorImprovementProgress;

  @doc("Exact USD reservation and reconciliation progress.")
  @visibility(Lifecycle.Read)
  cost: EvaluatorImprovementCostProgress;

  @doc("Human review state and current publication eligibility.")
  @visibility(Lifecycle.Read)
  review: EvaluatorImprovementReview;
}

@added(Versions.PuPr)
@removed(Versions.v1)
@doc("A compact evaluator improvement job representation returned by list operations.")
model EvaluatorImprovementJobListItem {
  @doc("The server-assigned job identifier.")
  id: string;

  @doc("The standard job lifecycle status.")
  status: JobStatus;

  @doc("The current improvement phase.")
  phase: EvaluatorImprovementPhase;

  @doc("The successful result outcome, when available.")
  outcome?: EvaluatorImprovementOutcome;

  @doc("The independent-confirmation status.")
  confirmation_status: EvaluatorImprovementConfirmationStatus;

  @doc("The durable review state.")
  review_state: EvaluatorImprovementReviewState;

  @doc("When the job was created.")
  created_at: utcDateTime;

  @doc("When the job reached a terminal state.")
  finished_at?: utcDateTime;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "The public contract uses the Request suffix."
@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Publish the exact stored finalist. The request cannot replace evaluator content or the original baseline ETag.")
model PublishEvaluatorImprovementCandidateRequest {
  @doc("The exact candidate snapshot identifier returned by the improvement job.")
  candidate_snapshot_id: string;

  @doc("An optional bounded review note.")
  @maxLength(2000)
  review_note?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "The public contract uses the Request suffix."
@added(Versions.PuPr)
@removed(Versions.v1)
@doc("Reject the exact stored finalist without changing current or published evaluator state.")
model RejectEvaluatorImprovementCandidateRequest {
  @doc("The exact candidate snapshot identifier returned by the improvement job.")
  candidate_snapshot_id: string;

  @doc("An optional bounded rejection reason.")
  @maxLength(2000)
  reason?: string;
}
