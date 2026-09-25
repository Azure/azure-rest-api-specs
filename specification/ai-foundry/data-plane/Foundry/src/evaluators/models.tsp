import "@typespec/openapi";
import "@typespec/versioning";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Azure.AI.Projects;

@doc("The category of the evaluator")
union EvaluatorCategory {
  string,

  @doc("Quality")
  quality: "quality",

  @doc("Risk & Safety")
  safety: "safety",

  @doc("Agents")
  agents: "agents",
}

@doc("The type of the evaluator")
union EvaluatorType {
  string,

  @doc("Built-in evaluator (Microsoft provided)")
  built_in: "builtin",

  @doc("Custom evaluator")
  custom: "custom",
}

@doc("The type of evaluator definition")
union EvaluatorDefinitionType {
  string,

  @doc("Prompt-based definition")
  prompt: "prompt",

  @doc("Code-based definition")
  code: "code",

  @doc("Prompt & Code Based definition")
  prompt_and_code: "prompt_and_code",

  @doc("Service-based evaluator")
  service: "service",

  @doc("OpenAI graders")
  openai_graders: "openai_graders",

  @doc("Rubric-based evaluator definition. Stores dimensions (the scoring blueprint) for both quality and safety evaluators. Can be created via the generate API or manually via createVersion.")
  rubric: "rubric",

  @doc("Endpoint-based evaluator definition. References a customer-owned HTTP endpoint via a Project Connection.")
  endpoint: "endpoint",
}

#suppress "@azure-tools/typespec-azure-core/no-unknown"
@doc("Base evaluator configuration with discriminator")
@discriminator("type")
model EvaluatorDefinition {
  @doc("The type of evaluator definition")
  type: EvaluatorDefinitionType;

  @doc("The JSON schema (Draft 2020-12) for the evaluator's input parameters. This includes parameters like type, properties, required.")
  init_parameters?: Record<unknown>;

  @doc("The JSON schema (Draft 2020-12) for the evaluator's input data. This includes parameters like type, properties, required.")
  data_schema?: Record<unknown>;

  @doc("List of output metrics produced by this evaluator")
  metrics?: Record<EvaluatorMetric>;
}

@doc("Code-based evaluator definition using python code")
model CodeBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.code;

  @doc("Inline code text for the evaluator")
  code_text?: string;

  @doc("The entry point Python file name for the uploaded evaluator code (e.g. 'answer_length_evaluator.py')")
  entry_point?: string;

  @doc("The container image tag to use for evaluator code execution")
  image_tag?: string;

  @doc("The blob URI for the evaluator storage")
  blob_uri?: url;
}

@doc("Prompt-based evaluator")
model PromptBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.prompt;

  @doc("The prompt text used for evaluation")
  prompt_text: string;
}

// ============================================================================
// Dimensions + Rubric-based Evaluator Definition
// ============================================================================

const RubricScoringRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

@doc("The quality-scoring mode selected for an entire rubric.")
@added(Versions.v1)
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
union RubricScoringMode {
  string,

  @doc("Every applicable quality check must pass. Weights and thresholds are not accepted.")
  boolean: "boolean",

  @doc("Grade applicable quality dimensions from 1 through 5, with optional relative weights.")
  likert: "likert",
}

@doc("Simple rubric scoring choices. Omission preserves existing legacy scoring.")
@added(Versions.v1)
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model RubricScoring {
  @doc("Rubric-level scoring mode. Defaults to Likert when scoring is supplied. Omitting scoring preserves existing legacy behavior.")
  mode?: RubricScoringMode = RubricScoringMode.likert;
}

@doc("The deterministic overall rubric acceptance decision.")
@added(Versions.v1)
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
union RubricScoringDecision {
  string,

  @doc("Applicable dimensions meet the selected scoring rule.")
  pass: "pass",

  @doc("The selected scoring rule fails.")
  fail: "fail",

  @doc("No quality dimension applies and no known failure establishes rejection.")
  not_applicable: "not_applicable",

  @doc("No known failure establishes rejection, but evidence is insufficient.")
  indeterminate: "indeterminate",
}

@doc("Explainable scoring results for a rubric. Boolean scoring requires every applicable check to pass; Likert scoring compares the weighted average with the threshold.")
@added(Versions.v1)
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model RubricScoringResult {
  @doc("The resolved scoring mode.")
  mode: RubricScoringMode;

  @doc("Quality score, equal to the top-level score when known. Rating uses a normalized 0-1 value; Boolean uses 1 for quality pass and 0 for quality fail, never a fraction of passed checks. Absent for unknown or N/A quality.")
  @minValue(0)
  @maxValue(1)
  quality_score?: float64;

  @doc("Whether the quality score meets its threshold. Absent when quality is unavailable.")
  quality_passed?: boolean;

  @doc("The configured rating threshold. Required for rating and absent for Boolean.")
  @minValue(0)
  @maxValue(1)
  quality_threshold?: float32;

  @doc("Overall decision from the selected scoring rule.")
  decision: RubricScoringDecision;

  @doc("One result list for every dimension, using the rubric's scoring mode.")
  dimension_results: RubricDimensionResult[];
}

@doc("A typed result for one dimension in the unified rubric.")
@added(Versions.v1)
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model RubricDimensionResult {
  @doc("The dimension identifier.")
  id: string;

  @doc("Whether the dimension applies.")
  applicable: boolean;

  @doc("Known Boolean verdict. Absent for N/A or insufficient evidence and for rating dimensions.")
  passed?: boolean;

  @doc("Applicable Likert grade. Absent for Boolean dimensions.")
  @minValue(1)
  @maxValue(5)
  raw_score?: int32;

  @doc("Explicitly configured rating weight. Omitted for every dimension when weights are implicit, and always absent for Boolean dimensions. If configured, all rating dimensions include a weight.")
  @minValue(1)
  @maxValue(10)
  weight?: int32;

  @doc("Normalized rating weight among applicable rating dimensions.")
  @minValue(0)
  @maxValue(1)
  effective_weight?: float64;

  @doc("Contribution to the rating aggregate.")
  @minValue(0)
  @maxValue(1)
  contribution?: float64;

  @doc("Brief evidence-based explanation.")
  reason?: string;
}

@doc("A single dimension — one independent, measurable quality dimension within a rubric evaluator's scoring blueprint.")
model Dimension {
  @doc("Stable identifier for this dimension (snake_case, e.g., `correct_resolution`). Required. Provided by the user when manually creating a rubric evaluator or during human-in-the-loop review of a generated set; the generation pipeline produces an initial value the user can edit. Editable when saving new versions.")
  id: string;

  @doc("What this dimension measures (e.g., 'Correctly identifies the user's reservation intent and pursues the appropriate workflow').")
  description: string;

  @doc("Relative weight of this dimension (1-10). The generation pipeline assigns exactly one dimension weight 8-10; all others use 1-6. User edits are not constrained by this heuristic.")
  @removed(Versions.v1)
  @renamedFrom(Versions.v1, "weight")
  @minValue(1)
  @maxValue(10)
  legacy_weight: int32;

  @doc("Optional configured rating weight. For new scoring definitions, omit every weight for equal contribution or supply a weight for every dimension. Partially weighted definitions are rejected, including a mix of explicit unit weights and omitted weights. Boolean mode rejects weights. No schema default is emitted.")
  @added(Versions.v1)
  @minValue(1)
  @maxValue(10)
  weight?: int32;

  @doc("When true, the LLM judge always scores this dimension regardless of relevance (skips applicability assessment). The service-generated general quality/policy dimension has this set to true and is non-editable. Users may set this on their own custom dimensions. The service defaults to `false` if a value is not specified by the caller.")
  always_applicable?: boolean = false;
}

@doc("Rubric-based evaluator definition — stores dimensions produced by the generate API. Used for both quality and safety evaluators.")
model RubricBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.rubric;

  @doc("The quality checks or grading criteria. Rating generation includes a service residual; Boolean generation does not inject a generic residual. Existing v1 and legacy definitions retain their behavior.")
  dimensions: Dimension[];

  @doc("Quality threshold on the same normalized 0.0-1.0 scale as the emitted score. Defaults to 0.5, equivalent to a raw weighted grade of 3.0. The score >= threshold determines pass/fail; there is no implicit score-1 veto.")
  @removed(Versions.v1)
  @renamedFrom(Versions.v1, "pass_threshold")
  @minValue(0.0)
  @maxValue(1.0)
  legacy_pass_threshold?: float32 = 0.5;

  @doc("Optional rating threshold on the normalized 0-1 scale, interpreted as 0.5 when omitted. Boolean mode rejects this field.")
  @added(Versions.v1)
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold?: float32;

  @doc("Simple scoring choices. Omission preserves existing legacy scoring for existing clients. No policy version is required from the caller.")
  @added(Versions.v1)
  scoring?: RubricScoring;
}

@doc("Endpoint-based evaluator definition. The customer owns and hosts an HTTP endpoint that implements the evaluation contract. The evaluator references a Project Connection by name; the connection stores the endpoint URL and credentials (API Key or Entra ID). At execution time, the service resolves the connection to obtain the endpoint URL and authentication details, then calls the endpoint for each evaluation row.")
model EndpointBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.endpoint;

  @doc("Name of the Project Connection that stores the endpoint URL and credentials. The connection must exist on the project and have a non-empty target URL. Supported auth types: ApiKey (sends `api-key` header) and AAD/Entra ID (acquires a bearer token via the project's Managed Identity).")
  @minLength(1)
  connection_name: string;
}

// ============================================================================
// Generation artifacts (provenance for evaluators created via generation jobs)
// ============================================================================

@doc("Reference to a versioned Foundry Dataset.")
model DatasetReference {
  @doc("Dataset name.")
  name: string;

  @doc("Dataset version.")
  version: string;
}

@doc("Service-managed provenance artifacts produced by an evaluator generation job. Present only on EvaluatorVersion resources created via the generation pipeline. The combined-JSONL Foundry Dataset is read-only and resolves to a versioned dataset in a service-reserved namespace.")
model EvaluatorGenerationArtifacts {
  @doc("Reference to the single Foundry Dataset (one combined JSONL file, version-aligned to `EvaluatorVersion.version`) holding all artifacts produced by the generation pipeline. Each row in the JSONL carries a `kind` field discriminating its content (e.g. `spec`, `tools`, `context`).")
  dataset: DatasetReference;

  @doc("The kinds of rows present in `dataset`. Always contains `\"spec\"` (the generated evaluation specification, a Markdown document describing what the evaluator measures). May additionally contain `\"tools\"` (when the generation pipeline produced or inferred OpenAI tool schemas) and/or `\"context\"` (when supplementary materials such as file uploads or trace samples were used during generation).")
  kinds: string[];
}

// ============================================================================
// Evaluator Generation Job Sources (per-context copies of shared JobSource
// shapes — current emitters require a discriminated base per top-level union,
// so we spread the shared `XxxJobSource` shapes into evaluator-generation-
// specific subtypes. Same pattern as `DataGenerationJobSource`.)
// ============================================================================

@doc("The supported source types for evaluator generation jobs.")
union EvaluatorGenerationJobSourceType {
  string,

  @doc("Prompt source — inline text provided by the user.")
  prompt: "prompt",

  @doc("Agent source — references an agent to fetch instructions and metadata from.")
  agent: "agent",

  @doc("Traces source — conversation traces from Application Insights.")
  traces: "traces",

  @doc("Dataset source — reference to a dataset.")
  dataset: "dataset",
}

@doc("The base source model for evaluator generation jobs. Polymorphic over `type`.")
@discriminator("type")
model EvaluatorGenerationJobSource {
  @doc("The type of source.")
  type: EvaluatorGenerationJobSourceType;
}
// Note: `JobSourceDescription` is intentionally NOT spread here. Each
// concrete subtype already spreads its `XxxJobSource` shape from common/, and
// each of those already spreads `JobSourceDescription`. Spreading it again on
// the discriminated base would emit `description` twice in the union.

@doc("Prompt source for evaluator generation jobs — inline text provided by the user.")
model PromptEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...PromptJobSource;
}

@doc("Agent source for evaluator generation jobs — references an agent to fetch instructions and metadata from.")
model AgentEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...AgentJobSource;
}

@doc("Traces source for evaluator generation jobs — conversation traces from Application Insights.")
model TracesEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...TracesJobSource;
}

@doc("Dataset source for evaluator generation jobs — reference to a dataset.")
model DatasetEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...DatasetJobSource;
}

// ============================================================================
// Evaluator Generation Job (LRO — follows DataGenerationJob pattern)
// ============================================================================

@doc("Caller-supplied inputs for an evaluator generation job.")
model EvaluatorGenerationInputs {
  @doc("Source materials for generation — agent descriptions, prompts, traces, or datasets. Each entry is an `EvaluatorGenerationJobSource` variant discriminated by `type`.")
  sources: EvaluatorGenerationJobSource[];

  @doc("The LLM model to use for rubric generation (e.g., 'gpt-4o'). Required — users must provide their own model rather than relying on service-owned capacity.")
  `model`: string;

  @doc("The evaluator name (immutable identifier). 1-256 characters; allowed characters are ASCII letters, digits, underscore (`_`), period (`.`), tilde (`~`), and hyphen (`-`). The prefix `builtin.` is reserved for system-managed evaluators and is rejected by the service. If an evaluator with this name already exists in the project (and is rubric-subtype), the service creates a new version under the same name and uses the prior version's `dimensions` as context for incremental improvement (foundation of the post-//build adaptive loop). Old versions remain queryable via `get_version(name, version)`. If the existing evaluator is not a rubric-subtype evaluator (built-in, prompt-based, code-based), the request is rejected with `400 Bad Request`.")
  @minLength(1)
  @maxLength(256)
  @pattern("^[A-Za-z0-9_.~-]+$")
  evaluator_name: string;

  @doc("Optional human-friendly display name for the resulting evaluator. Surfaced as `EvaluatorVersion.display_name` on the persisted evaluator. When omitted, the service uses `evaluator_name` as the display name. The `evaluator_` prefix disambiguates this from the immutable `evaluator_name` identifier.")
  evaluator_display_name?: string;

  @doc("Optional human-friendly description for the resulting evaluator. Surfaced as `EvaluatorVersion.description` on the persisted evaluator. Typically collected from the UI alongside `evaluator_display_name`. The `evaluator_` prefix disambiguates this from any other description fields on related models.")
  evaluator_description?: string;

  @doc("Scoring choices for the generated evaluator. Supplied scoring defaults to Likert. On first creation, omitted weights yield equal contribution without configured weight fields. On regeneration, prior scoring and weights are preserved unless explicitly changed in a reviewed evaluator definition. Omitting scoring preserves legacy generation on first creation and inherits saved choices on regeneration.")
  @added(Versions.v1)
  scoring?: RubricScoring;

  @doc("Caller-approved dimensions to preserve while generating other checks. All dimensions use the selected rubric scoring mode. Omission preserves prior approved dimensions on regeneration; an explicit list replaces the fixed set.")
  @added(Versions.v1)
  dimensions?: Dimension[];
}

@doc("Token consumption summary for an evaluator generation job. Populated when the job reaches a terminal state.")
model EvaluatorGenerationTokenUsage {
  @doc("Number of input (prompt) tokens consumed.")
  input_tokens: int64;

  @doc("Number of output (completion) tokens generated.")
  output_tokens: int64;

  @doc("Total tokens consumed (input + output).")
  total_tokens: int64;
}

// ============================================================================
// Rubric Generation Input-Quality Warnings
// Advisory read-only warnings surfaced on terminal EvaluatorGenerationJob.
// ============================================================================

@doc("Warning source attribution for a rubric-generation input-quality warning. Per-source values (`prompt`, `agent`, `dataset`) match the source category visible to the generation runtime. `aggregate` is a synthetic value used only for warnings computed across successfully resolved sources. `traces` is not exposed because trace sources resolve into dataset content upstream.")
union RubricGenerationInputQualityWarningSource {
  string,

  @doc("The warning applies to an inline prompt source.")
  prompt: "prompt",

  @doc("The warning applies to an agent source.")
  agent: "agent",

  @doc("The warning applies to a dataset source (including trace-derived datasets).")
  dataset: "dataset",

  @doc("The warning is computed across all successfully resolved sources.")
  aggregate: "aggregate",
}

@doc("Advisory severity for a rubric-generation input-quality warning. Initial value set: `warning`.")
union RubricGenerationInputQualityWarningSeverity {
  string,

  @doc("Non-fatal advisory; generation succeeded but output quality may be lower.")
  warning: "warning",
}

@doc("Stable searchable machine-readable warning code for a rubric-generation input-quality warning. Values are `snake_case`; clients must tolerate additional service-defined identifiers.")
union RubricGenerationInputQualityWarningCode {
  string,

  @doc("A prompt source was empty or whitespace-only.")
  empty_prompt: "empty_prompt",

  @doc("A prompt source was non-empty but below the recommended minimum signal threshold.")
  short_prompt: "short_prompt",

  @doc("An agent source resolved successfully but had no usable instructions.")
  empty_agent_instructions: "empty_agent_instructions",

  @doc("An agent source had instructions below the recommended minimum signal threshold.")
  short_agent_instructions: "short_agent_instructions",

  @doc("A dataset source resolved but contained no usable content for rubric generation.")
  empty_dataset_content: "empty_dataset_content",

  @doc("Dataset content was below the recommended minimum signal threshold.")
  short_dataset_content: "short_dataset_content",

  @doc("A row-structured dataset had very few rows, so the generated rubric may not generalize.")
  low_trace_count: "low_trace_count",

  @doc("Combined resolved input across successfully resolved sources was below the recommended minimum signal threshold.")
  insufficient_total_input: "insufficient_total_input",
}

@doc("A non-fatal advisory produced during rubric evaluator generation when resolved inputs are technically valid but likely too weak to produce a high-quality rubric. Read-only; service-generated. Persisted with the terminal EvaluatorGenerationJob.")
model RubricGenerationInputQualityWarning {
  @doc("Stable searchable machine-readable warning code.")
  code: RubricGenerationInputQualityWarningCode;

  @doc("Advisory severity. Initial values: `warning`.")
  severity: RubricGenerationInputQualityWarningSeverity;

  @doc("Human-readable message suitable for direct SDK/CLI/UI display. Must not include raw prompt, instruction, dataset, or trace text.")
  message: string;

  @doc("Which source category the warning applies to. `aggregate` is used only for cross-source warnings.")
  source: RubricGenerationInputQualityWarningSource;

  @doc("Zero-based index into `EvaluatorGenerationJob.inputs.sources` when the warning applies to a specific source. Omitted for aggregate warnings and for warnings not tied to one source.")
  @minValue(0)
  source_index?: int32;
}

@doc("Category of a warning surfaced on a generated evaluator version. Extensible so new warning categories (e.g., safety, output quality) can be introduced without a breaking change.")
union GenerationWarningType {
  string,

  @doc("The paired EvaluatorGenerationJob emitted one or more input-quality advisories. Follow `generation_job_id` to fetch the detailed warning payloads.")
  input_quality: "input_quality",
}

@doc("Evaluator Generation Job resource — a long-running job that generates rubric-based evaluator definitions from source materials. On success, the result is the persisted EvaluatorVersion.")
model EvaluatorGenerationJob is JobLike<
  EvaluatorVersion,
  EvaluatorGenerationInputs
> {
  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;

  @doc("Token consumption summary. Populated when the job reaches a terminal state.")
  @visibility(Lifecycle.Read)
  usage?: EvaluatorGenerationTokenUsage;

  @doc("Non-fatal input-quality advisories produced by the generation pipeline. Read-only; service-generated; populated only on terminal jobs when advisories fired. Omitted when generation was clean. Cleared when a subsequent `PATCH` to the paired `EvaluatorVersion.definition` invalidates the advisories.")
  @visibility(Lifecycle.Read)
  input_quality_warnings?: RubricGenerationInputQualityWarning[];
}

@doc("Evaluator Definition")
@resource("evaluators")
model EvaluatorVersion {
  @doc("Display Name for evaluator. It helps to find the evaluator easily in AI Foundry. It does not need to be unique.")
  display_name?: string;

  @doc("Metadata about the evaluator")
  metadata?: Record<string>;

  @doc("The type of the evaluator")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  evaluator_type: EvaluatorType;

  @doc("The categories of the evaluator")
  categories: EvaluatorCategory[];

  @doc("Evaluation levels this evaluator supports (e.g., `turn`, `conversation`). When omitted on create, the service defaults to `[\"turn\"]`. On update, omitting this field leaves it unchanged; an empty list is rejected. Custom code-based evaluators support only `turn`; custom prompt-based evaluators support exactly one level (`turn` or `conversation`).")
  supported_evaluation_levels?: EvaluationLevel[] = #[EvaluationLevel.turn];

  @doc("Definition of the evaluator")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definition: EvaluatorDefinition;

  @doc("Provenance artifacts from the generation pipeline. Read-only; present only on evaluator versions created via an EvaluatorGenerationJob. Each artifact resolves to a versioned Foundry Dataset.")
  @visibility(Lifecycle.Read)
  generation_artifacts?: EvaluatorGenerationArtifacts;

  @doc("Read-only provenance link back to the EvaluatorGenerationJob that produced this version. Present only on evaluator versions created via the generation pipeline; absent for manually-created versions and unaffected by subsequent `PATCH` calls.")
  @visibility(Lifecycle.Read)
  generation_job_id?: string;

  @doc("Categories of warnings surfaced on this generated evaluator version. Present only on versions created via an EvaluatorGenerationJob when the paired job produced non-empty warnings. Absent (treat as no warnings) when the version is not from generation, when the paired job was clean, or when a subsequent `PATCH` to `definition` cleared the paired job's advisories. Follow `generation_job_id` to fetch the detailed warning payloads.")
  @visibility(Lifecycle.Read)
  warnings?: GenerationWarningType[];

  @visibility(Lifecycle.Read)
  @doc("Creator of the evaluator")
  created_by: string;

  @visibility(Lifecycle.Read)
  @doc("Creation date/time of the evaluator")
  created_at: string;

  @visibility(Lifecycle.Read)
  @doc("Last modified date/time of the evaluator")
  modified_at: string;

  ...AssetBase;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request body for getting evaluator credentials")
model EvaluatorCredentialRequest {
  @doc("The blob URI for the evaluator storage. Example: `https://account.blob.core.windows.net:443/container`")
  blob_uri: url;
}

@doc("Evaluator Metric")
model EvaluatorMetric {
  @doc("Type of the metric.")
  type?: EvaluatorMetricType;

  @doc("It indicates whether a higher value is better or a lower value is better for this metric.")
  desirable_direction?: EvaluatorMetricDirection;

  @doc("Minimum value for the metric")
  min_value?: float32;

  @doc("Maximum value for the metric. If not specified, it is assumed to be unbounded.")
  max_value?: float32;

  @doc("Default pass/fail threshold for this metric.")
  threshold?: float32;

  @doc("Indicates if this metric is primary when there are multiple metrics.")
  is_primary?: boolean;
}

@doc("The type of the evaluator")
union EvaluatorMetricType {
  string,

  @doc("Ordinal metric representing categories that can be ordered or ranked.")
  ordinal: "ordinal",

  @doc("Continuous metric representing values in a continuous range.")
  continuous: "continuous",

  @doc("Boolean metric representing true/false values")
  boolean: "boolean",
}

@doc("The direction of the metric indicating whether a higher value is better, a lower value is better, or neutral")
union EvaluatorMetricDirection {
  string,

  @doc("It indicates a higher value is better for this metric")
  increase: "increase",

  @doc("It indicates a lower value is better for this metric")
  decrease: "decrease",

  @doc("It indicates no preference for this metric direction")
  neutral: "neutral",
}
