import "@typespec/openapi";
import "@typespec/versioning";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Azure.AI.Projects;

const EvaluatorsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

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
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model CodeBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.code;

  @doc("Inline code text for the evaluator")
  code_text?: string;

  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  @doc("The entry point Python file name for the uploaded evaluator code (e.g. 'answer_length_evaluator.py')")
  entry_point?: string;

  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  @doc("The container image tag to use for evaluator code execution")
  image_tag?: string;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  @doc("The blob URI for the evaluator storage")
  blob_uri?: url;
}

@doc("Prompt-based evaluator")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
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

@doc("The judgment mode selected for an entire rubric. Safety rubrics use Boolean judgments with separately reported allowed and disallowed behavior metrics.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
union RubricScoringMode {
  string,

  @doc("Ordinary rubrics require every applicable check to pass. Any failed check fails the rubric. Configured dimension weights are not supported; pass_threshold must be omitted or 1. The aggregate score is 1 for pass or 0 for fail. Safety rubrics instead report allowed and disallowed behavior violations separately, without an overall threshold or aggregate score.")
  boolean: "boolean",

  @doc("Grade applicable rubric dimensions from 1 through 5, with optional relative weights.")
  likert: "likert",
}

@doc("Simple rubric scoring choices. Omission preserves existing legacy scoring.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model RubricScoring {
  @doc("Rubric-level scoring mode. Defaults to Likert when scoring is supplied. Omitting scoring preserves existing legacy behavior.")
  mode?: RubricScoringMode = RubricScoringMode.likert;
}

alias RubricDimensionResultProperties = {
  @doc("The dimension identifier.")
  id: string;

  @doc("Whether the dimension applies.")
  applicable: boolean;

  @doc("Brief evidence-based explanation.")
  reason?: string;
};

@doc("A Boolean result for one rubric dimension.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model BooleanRubricDimensionResult {
  ...RubricDimensionResultProperties;

  @doc("Boolean verdict. Required when the dimension is applicable; absent for N/A.")
  passed?: boolean;
}

@doc("A Likert result for one rubric dimension.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model LikertRubricDimensionResult {
  ...RubricDimensionResultProperties;

  @doc("Explicitly configured Likert weight. Omitted for every dimension when weights are implicit. If configured, every dimension includes a weight.")
  @minValue(1)
  @maxValue(10)
  weight?: int32;

  @doc("Normalized weight among applicable Likert dimensions.")
  @minValue(0)
  @maxValue(1)
  effective_weight?: float64;

  @doc("Contribution to the normalized Likert aggregate: effective_weight * (raw_score - 1) / 4.")
  @minValue(0)
  @maxValue(1)
  contribution?: float64;

  @doc("Applicable Likert grade. Absent for N/A.")
  @minValue(1)
  @maxValue(5)
  raw_score?: int32;
}

@doc("Flat rubric result properties selected by the existing mode field.")
@discriminator("mode")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model RubricResultProperties {
  @doc("The resolved rubric scoring mode.")
  mode: RubricScoringMode;
}

@doc("Flat result properties for explicit Boolean rubric scoring.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model BooleanRubricResultProperties extends RubricResultProperties {
  @doc("The resolved Boolean scoring mode.")
  mode: RubricScoringMode.boolean;

  @doc("One Boolean judgment for every configured dimension.")
  dimension_results: BooleanRubricDimensionResult[];
}

@doc("Flat result properties for explicit Likert rubric scoring.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
model LikertRubricResultProperties extends RubricResultProperties {
  @doc("The resolved Likert scoring mode.")
  mode: RubricScoringMode.likert;

  @doc("One Likert judgment for every configured dimension.")
  dimension_results: LikertRubricDimensionResult[];
}

@doc("One measurable criterion within a rubric. Quality criteria may use rating weights; safety criteria classify a behavior as allowed or disallowed.")
model Dimension {
  @doc("Stable identifier for this dimension (snake_case, e.g., `correct_resolution`). Required. Provided by the user when manually creating a rubric evaluator or during human-in-the-loop review of a generated set; the generation pipeline produces an initial value the user can edit. Editable when saving new versions.")
  id: string;

  @doc("What this dimension measures (e.g., 'Correctly identifies the user's reservation intent and pursues the appropriate workflow').")
  description: string;

  @doc("Safety behavior classification: true means allowed behavior and false means disallowed behavior. Required on every safety criterion instead of weight. This is not an evaluation verdict. Omit for ordinary quality criteria; omission never defaults a safety criterion to false. Preserved through edits and regeneration.")
  @extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
  allowed?: boolean;

  @doc("Optional configured weight for legacy or Likert scoring. For Likert, omit every weight for equal contribution or supply a weight for every dimension; partially weighted definitions are rejected. Boolean scoring rejects every configured weight, including explicit unit weights. No schema default is emitted.")
  @minValue(1)
  @maxValue(10)
  weight?: int32;

  @doc("Read-only model-suggested weight (1-10) returned for unweighted Likert dimensions.")
  @visibility(Lifecycle.Read)
  @minValue(1)
  @maxValue(10)
  generated_weight?: int32;

  @doc("When true, the LLM judge always scores this dimension regardless of relevance (skips applicability assessment). The service-generated general quality/policy dimension has this set to true and is non-editable. Users may set this on their own custom dimensions. The service defaults to `false` if a value is not specified by the caller.")
  always_applicable?: boolean = false;
}

@doc("Rubric evaluator definition. Ordinary quality rubrics report one aggregate. Safety rubrics require Boolean scoring and an explicit allowed classification on every dimension, and report disallowed_behavior_violated and allowed_behavior_violated as two independent lower-is-better metrics. Safety rubrics have no weights, threshold, or combined safety score.")
model RubricBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.rubric;

  @doc("The rubric criteria. Safety dimensions require allowed and omit weight. Rating generation includes a service residual; Boolean generation does not inject a generic residual. Existing ordinary and legacy definitions retain their behavior.")
  dimensions: Dimension[];

  @doc("Optional normalized threshold for Likert scoring, interpreted as 0.5 when omitted. Ordinary Boolean scoring requires all applicable checks to pass: omit this field or set it to 1; its effective threshold is 1 and other values are rejected. Safety rubrics omit this field and report two separate metrics without an overall threshold.")
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold?: float32;

  @doc("Simple scoring choices. Omission preserves existing legacy scoring for existing clients. No policy version is required from the caller.")
  @extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
  scoring?: RubricScoring;
}

@doc("Endpoint-based evaluator definition. The customer owns and hosts an HTTP endpoint that implements the evaluation contract. The evaluator references a Project Connection by name; the connection stores the endpoint URL and credentials (API Key or Entra ID). At execution time, the service resolves the connection to obtain the endpoint URL and authentication details, then calls the endpoint for each evaluation row.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model EndpointBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.endpoint;

  @doc("Name of the Project Connection that stores the endpoint URL and credentials. The connection must exist on the project and have a non-empty target URL. Supported auth types: ApiKey (sends `api-key` header) and AAD/Entra ID (acquires a bearer token via the project's Managed Identity).")
  @minLength(1)
  connection_name: string;

  @doc("Version of the contract between the service and the evaluator endpoint. Optional on create; if omitted, the service uses `0.0.1`, so existing clients that do not send this property are unaffected. Stored evaluator versions keep the value they were created with. Registration rejects values the service does not support; the type stays extensible so responses can return newer versions. Version `0.0.2` requires `metrics` to contain exactly one metric, of type `ordinal` or `continuous`.")
  schema_version?: EndpointEvaluatorSchemaVersion = EndpointEvaluatorSchemaVersion.v0_0_1;
}

@doc("Contract version for an endpoint-based evaluator.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
union EndpointEvaluatorSchemaVersion {
  string,

  @doc("Contract version 0.0.1.")
  v0_0_1: "0.0.1",

  @doc("Contract version 0.0.2. Registration requires `metrics` to contain exactly one metric, of type `ordinal` or `continuous`.")
  v0_0_2: "0.0.2",
}

// ============================================================================
// Generation artifacts (provenance for evaluators created via generation jobs)
// ============================================================================

@doc("Service-managed provenance artifacts produced by an evaluator generation job. Present only on EvaluatorVersion resources created via the generation pipeline. The combined-JSONL Foundry Dataset is read-only and resolves to a versioned dataset in a service-reserved namespace.")
model EvaluatorGenerationArtifacts {
  @doc("Reference to the single Foundry Dataset (one combined JSONL file, version-aligned to `EvaluatorVersion.version`) holding all artifacts produced by the generation pipeline. Each row in the JSONL carries a `kind` field discriminating its content (e.g. `spec`, `tools`, `context`).")
  dataset: VersionedDatasetReference;

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

  @doc("Optional explicit list of trace IDs to include.")
  trace_ids?: string[];
}

@doc("Dataset source for evaluator generation jobs — reference to a dataset.")
model DatasetEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...DatasetJobSource;
}

// ============================================================================
// Evaluator Generation Job (LRO — follows DataGenerationJob pattern)
// ============================================================================

@doc("The requested evaluator generation category.")
@extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
union EvaluatorGenerationCategory {
  string,

  @doc("Generate an ordinary quality rubric, preserving existing scoring and regeneration behavior.")
  quality: "quality",

  @doc("Generate or regenerate a safety rubric with Boolean judgments, explicit allowed/disallowed classifications, and two separate violation metrics.")
  safety: "safety",
}

@doc("Caller-supplied inputs for an evaluator generation job.")
model EvaluatorGenerationInputs {
  @doc("Source materials for generation. Safety generation requires a nonempty prompt source for the objective and at least one agent or trace source for application context. An arbitrary dataset cannot replace safety application context. Ordinary generation keeps its existing supported sources.")
  sources: EvaluatorGenerationJobSource[];

  @doc("Generation intent. Omission preserves the existing quality path. Explicitly select safety for safety generation and regeneration. Safety output uses Boolean scoring, allowed classifications, and two named violation metrics.")
  @extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
  category?: EvaluatorGenerationCategory;

  @doc("The caller's model for quality rubric generation (e.g., 'gpt-4o'). Required by the service when category is quality or omitted. Safety generation and regeneration use centrally managed red teaming simulation capacity, ignore this field when supplied, and do not fall back to caller capacity. Safety rubric scoring separately uses centrally managed red teaming evaluator capacity.")
  `model`?: string;

  @doc("The evaluator name (immutable identifier). 1-256 characters; allowed characters are ASCII letters, digits, underscore (`_`), period (`.`), tilde (`~`), and hyphen (`-`). The prefix `builtin.` is reserved for system-managed evaluators and is rejected by the service. If an evaluator with this name already exists in the project (and is rubric-subtype), the service creates a new version under the same name and uses the prior version's `dimensions` as context for incremental improvement (foundation of the post-//build adaptive loop). Old versions remain queryable via `get_version(name, version)`. If the existing evaluator is not a rubric-subtype evaluator (built-in, prompt-based, code-based), the request is rejected with `400 Bad Request`.")
  @minLength(1)
  @maxLength(256)
  @pattern("^[A-Za-z0-9_.~-]+$")
  evaluator_name: string;

  @doc("Optional human-friendly display name for the resulting evaluator. Surfaced as `EvaluatorVersion.display_name` on the persisted evaluator. When omitted, the service uses `evaluator_name` as the display name. The `evaluator_` prefix disambiguates this from the immutable `evaluator_name` identifier.")
  evaluator_display_name?: string;

  @doc("Optional human-friendly description for the resulting evaluator. Surfaced as `EvaluatorVersion.description` on the persisted evaluator. Typically collected from the UI alongside `evaluator_display_name`. The `evaluator_` prefix disambiguates this from any other description fields on related models.")
  evaluator_description?: string;

  @doc("Scoring choices for the generated evaluator. For quality, supplied scoring defaults to Likert; omitted weights on first creation yield equal contribution, and regeneration preserves saved choices. Omitting scoring preserves existing quality generation behavior. Safety generation resolves omitted scoring to Boolean and rejects a conflicting supplied mode; its dimensions use allowed rather than weights and its two metric results are not combined.")
  @extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
  scoring?: RubricScoring;

  @doc("Optional normalized Likert threshold: omission uses 0.5 for fresh generation and inherits the saved threshold on regeneration. For ordinary Boolean generation, omit this field or set it to 1; other values are rejected and its all-pass threshold is fixed at 1. Safety generation omits this field because its two violation metrics have no overall threshold.")
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold?: float32;

  @doc("Caller-approved dimensions to preserve while generating other checks. Omission preserves prior approved dimensions on regeneration; an explicit list replaces the fixed set. Safety fixed dimensions require an explicit allowed Boolean, omit weights, and preserve classification as part of their policy meaning.")
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

  @doc("Zero-based index into `EvaluatorGenerationJob.sources` when the warning applies to a specific source. Omitted for aggregate warnings and for warnings not tied to one source.")
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
model EvaluatorGenerationJob is JobLike<EvaluatorVersion, never> {
  @doc("Source materials for generation — agent descriptions, prompts, traces, or datasets. Each entry is an `EvaluatorGenerationJobSource` variant discriminated by `type`.")
  sources: EvaluatorGenerationJobSource[];

  @doc("Generation intent selected or inherited for this generation attempt. Omitted when no category was supplied.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
  category?: EvaluatorGenerationCategory;

  @doc("The LLM model used for quality rubric generation (e.g., 'gpt-4o'). Empty when safety generation uses centrally managed simulation capacity.")
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

  @doc("Rubric scoring selected for this generation attempt, including an inherited saved mode. Omitted for legacy generation.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-foundry-meta", RubricScoringRequiredPreviews)
  scoring?: RubricScoring;

  @doc("Normalized pass threshold supplied or inherited for this generation attempt. Omitted when no threshold was supplied or saved. Boolean scoring always uses an effective threshold of 1.")
  @visibility(Lifecycle.Read)
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold?: float32;

  @doc("Caller-approved dimensions fixed for this generation attempt, not the complete generated result. Omission retains normal regeneration ownership handling; an empty list explicitly clears the fixed set.")
  @visibility(Lifecycle.Read)
  dimensions?: Dimension[];

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

  @doc("Service-owned evidence for a version saved unchanged from a successful calibration proposal. It remains after the job is deleted and is cleared if the evaluator definition changes. Callers cannot set, update, or copy this record.")
  @added(Versions.v1)
  @visibility(Lifecycle.Read)
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  calibration?: EvaluatorCalibrationEvidence;

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

// ============================================================================
// Evaluator calibration
// ============================================================================

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("An evaluation run in the current project.")
model EvaluationRunReference {
  @doc("The evaluation identifier.")
  @minLength(1)
  eval_id: string;

  @doc("The run identifier.")
  @minLength(1)
  run_id: string;
}

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Reviewer-label values are heterogeneous JSON scalars, not a model hierarchy."
@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A value in a reviewer-label column.")
union CalibrationLabelValue {
  string,
  boolean,
  int32,
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A supported source of human reviewer decisions.")
union CalibrationLabelSourceType {
  string,

  @doc("Reviewer feedback attached to traces.")
  annotated_traces: "annotated_traces",

  @doc("A label column in the evaluation run's input dataset.")
  golden_dataset: "golden_dataset",

  @doc("A separate saved dataset containing reviewer labels.")
  dataset: "dataset",

  @doc("Inline reviewed examples.")
  upload: "upload",
}

alias CalibrationLabelMappings = {
  @doc("Values interpreted as reviewer passes. When omitted, the service uses its recognized pass values.")
  @minItems(1)
  pass_values?: CalibrationLabelValue[];

  @doc("Values interpreted as reviewer failures. When omitted, the service uses its recognized fail values. A value cannot be mapped to both outcomes.")
  @minItems(1)
  fail_values?: CalibrationLabelValue[];
};

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@discriminator("type")
@doc("The shared discriminator for reviewer-label sources.")
model CalibrationLabelSourceBase {
  @doc("The reviewer-label source type.")
  type: CalibrationLabelSourceType;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Human feedback on traces. The trace ID matches the evaluation item ID. Clusters may help select traces for review but are never treated as reviewer labels.")
model AnnotatedTracesLabelSource extends CalibrationLabelSourceBase {
  @doc("Reviewer feedback attached to traces.")
  type: "annotated_traces";

  @doc("Optional agent name used to select reviewed traces.")
  agent_name?: string;

  @doc("Optional agent version used to select reviewed traces.")
  agent_version?: string;

  @doc("Inclusive start of the trace selection window, in Unix seconds.")
  start_time?: FoundryTimestamp;

  @doc("Inclusive end of the trace selection window, in Unix seconds.")
  end_time?: FoundryTimestamp;

  @doc("Optional explicit trace IDs.")
  trace_ids?: string[];
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Reviewer labels in the evaluation run's input dataset.")
model GoldenDatasetLabelSource extends CalibrationLabelSourceBase {
  @doc("A label column in the evaluation run's input dataset.")
  type: "golden_dataset";

  @doc("Reviewer-label column. If omitted, the service considers only human_label, reviewer_label, and <evaluator name>_label, and uses a column only when at least 90 percent of nonempty values are recognized. Generic task columns are never guessed.")
  label_column?: string;

  ...CalibrationLabelMappings;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Reviewer labels in a separate versioned dataset.")
model DatasetLabelSource extends CalibrationLabelSourceBase {
  @doc("A separate saved dataset containing reviewer labels.")
  type: "dataset";

  @doc("The dataset name.")
  @minLength(1)
  dataset_name: string;

  @doc("The concrete dataset version.")
  @minLength(1)
  dataset_version: string;

  @doc("The reviewer-label column in the dataset.")
  @minLength(1)
  label_column: string;

  @doc("The dataset column containing item identifiers.")
  @minLength(1)
  dataset_id_column: string;

  @doc("The evaluation-result column matched to dataset_id_column. When omitted, the recorded item ID is used.")
  join_column?: string;

  ...CalibrationLabelMappings;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("One inline human-reviewed item. If no evaluation run is supplied, rubric_result must contain the per-dimension scores for the saved rubric. Wording suggestions additionally require the evaluated input needed to rerun the judge.")
model UploadedCalibrationItem {
  @doc("Identifier used to match this review to an evaluation item.")
  @minLength(1)
  item_id: string;

  @doc("The human reviewer's decision: true for pass, false for fail.")
  human_label: boolean;

  @doc("Per-dimension rubric judgments, required when the request has no evaluation run.")
  rubric_result?: RubricResultProperties;

  @doc("Evaluated input and response needed when rechecking suggested wording.")
  inputs?: Record<unknown>;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Human-reviewed examples supplied inline, including scored items when no evaluation run is provided. Items are retained only with the job and are removed on deletion or expiry.")
model UploadLabelSource extends CalibrationLabelSourceBase {
  @doc("Inline reviewed examples.")
  type: "upload";

  @doc("The uploaded reviewed items.")
  @minItems(1)
  items: UploadedCalibrationItem[];
}

#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The project does not enable experimental union extends; each source model explicitly extends the shared base."
@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
@doc("A source of human reviewer labels. Multiple labels within a source use the majority decision; a tie or disagreements across sources exclude the item. The service never silently selects one reviewer over another.")
union CalibrationLabelSource {
  annotated_traces: AnnotatedTracesLabelSource,
  golden_dataset: GoldenDatasetLabelSource,
  dataset: DatasetLabelSource,
  upload: UploadLabelSource,
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@Azure.ClientGenerator.Core.clientName("WordingTuningConfig", "csharp")
@doc("Options for rechecking suggested criterion wording with a customer-selected judge deployment.")
model WordingTuningOptions {
  @doc("The customer's model deployment used to generate and recheck wording. Model quota and charges apply.")
  @minLength(1)
  judge_deployment: string;

  @doc("The maximum number of criteria to consider for wording changes.")
  @minValue(1)
  max_dimensions?: int32;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Inputs for a quality-rubric calibration job. Supply a completed evaluation run or uploaded items with per-dimension scores. Calibration requires at least 20 reviewed items, including at least 5 passes and 5 failures. Non-rubric and safety evaluators are not supported. Boolean rubrics reject enabled passing-bar or weight tuning with HTTP 400 and continue to pass only when every applicable check passes.")
model EvaluatorCalibrationInputs {
  @doc("Name of the saved rubric evaluator.")
  @minLength(1)
  evaluator_name: string;

  @doc("Version of the saved rubric evaluator.")
  @minLength(1)
  evaluator_version: string;

  @doc("Completed evaluation run whose results provide rubric judgments and item identities.")
  evaluation_run?: EvaluationRunReference;

  @doc("Sources of reviewer decisions. At least one source is required. Unreadable sources are reported and skipped if another source is usable; the job fails if none can be read.")
  @minItems(1)
  label_sources: CalibrationLabelSource[];

  @doc("Allow a proposed normalized passing bar for a Likert rubric. Enabling this for a Boolean rubric returns HTTP 400.")
  tune_passing_bar?: boolean = false;

  @doc("Allow changes to Likert criterion weights from 1 through 10. Enabling this for a Boolean rubric returns HTTP 400.")
  allow_weight_changes?: boolean = false;

  @doc("Allow removal of criteria that do not help agreement. Protected service-owned criteria remain unchanged, the proposal retains at least one criterion, and removed criteria are omitted rather than given a weight of zero.")
  allow_pruning?: boolean = false;

  @doc("Allow wording suggestions and recheck them with the selected judge. Omit to avoid model calls.")
  tune_wording?: WordingTuningOptions;

  @doc("Relative cost of passing an item the reviewer failed. Defaults to 1; only its ratio to false_fail_cost matters.")
  @minValue(0.1)
  @maxValue(10)
  false_pass_cost?: float64 = 1.0;

  @doc("Relative cost of failing an item the reviewer passed. Defaults to 1; only its ratio to false_pass_cost matters.")
  @minValue(0.1)
  @maxValue(10)
  false_fail_cost?: float64 = 1.0;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A confidence interval for the associated statistic. Bounds use the statistic's scale, and lower is no greater than upper.")
model CalibrationConfidenceInterval {
  @doc("Lower bound.")
  @minValue(-1)
  @maxValue(1)
  lower: float64;

  @doc("Upper bound.")
  @minValue(-1)
  @maxValue(1)
  upper: float64;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A pass-rate estimate combining reviewer decisions and rubric decisions on unreviewed items.")
model CalibrationPassRateEstimate {
  @doc("Estimated pass rate.")
  @minValue(0)
  @maxValue(1)
  estimate: float64;

  @doc("The 95 percent uncertainty interval for the estimate.")
  confidence_interval: CalibrationConfidenceInterval;

  @doc("Number of items without reviewer decisions used in the estimate.")
  @minValue(0)
  unreviewed_count: int32;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("The service-resolved identity, label mapping, and outcome for a reviewer-label source. No reviewed item content is included.")
model CalibrationSourceOutcome {
  @doc("The source type.")
  type: CalibrationLabelSourceType;

  @doc("Stable source identity used, together with the label mapping, to determine whether later reviews are comparable for drift.")
  source_id: string;

  @doc("Concrete source version when applicable.")
  source_version?: string;

  @doc("Reviewer-label column when applicable.")
  label_column?: string;

  @doc("Dataset item-identifier column used for matching, when applicable.")
  dataset_id_column?: string;

  @doc("Evaluation-result column used for matching, when applicable.")
  join_column?: string;

  ...CalibrationLabelMappings;

  @doc("Number of labels accepted from this source.")
  @minValue(0)
  accepted_count: int32;

  @doc("Number of labels rejected because their values were not recognized.")
  @minValue(0)
  rejected_count: int32;

  @doc("Number of labels that did not match an evaluation item.")
  @minValue(0)
  unmatched_count: int32;

  @doc("Number of items excluded because reviewer decisions tied or sources disagreed.")
  @minValue(0)
  conflicting_count: int32;

  @doc("Whether this source could not be read with the caller's access.")
  unavailable: boolean;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A proposed change to one rubric criterion.")
model CalibrationDimensionChange {
  @doc("Stable criterion identifier.")
  id: string;

  @doc("Current criterion wording.")
  current_description: string;

  @doc("Proposed wording, omitted when the criterion is removed.")
  proposed_description?: string;

  @doc("Current Likert weight, omitted for Boolean rubrics or implicit equal weights.")
  @minValue(1)
  @maxValue(10)
  current_weight?: int32;

  @doc("Proposed Likert weight, omitted for Boolean rubrics or a removed criterion.")
  @minValue(1)
  @maxValue(10)
  proposed_weight?: int32;

  @doc("Whether the criterion is omitted from the proposal.")
  pruned: boolean;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("An item where the rubric and a reviewer disagreed.")
model CalibrationDisagreement {
  @doc("Evaluation item identifier.")
  item_id: string;

  @doc("Human reviewer decision.")
  human_label: boolean;

  @doc("Rubric decision.")
  judge_passed: boolean;

  @doc("Identifiers of criteria that influenced the rubric decision.")
  deciding_dimensions: string[];
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("The recommended action after reviewing a proposal.")
union CalibrationRecommendation {
  string,

  @doc("The held-out evidence supports adopting the proposal after review.")
  adopt: "adopt",

  @doc("Keep the current rubric because the proposal is not reliably better.")
  keep_current: "keep_current",
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("The kind of rubric change proposed.")
union CalibrationStrategy {
  string,

  @doc("Keep the existing rubric.")
  keep_current: "keep_current",

  @doc("Change only the Likert passing bar.")
  threshold_only: "threshold_only",

  @doc("Change Likert weights and the passing bar.")
  weights_and_threshold: "weights_and_threshold",

  @doc("Keep a subset of the Boolean checks while preserving the all-applicable-checks-pass rule.")
  checks_subset: "checks_subset",
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A review-first calibration proposal. Agreement and improvement are evaluated on held-out reviewer decisions, not on the same decisions used to choose the changes.")
model EvaluatorCalibrationResult {
  @doc("Scoring mode of the saved rubric.")
  scoring_mode: RubricScoringMode;

  @doc("Number of distinct accepted reviewed items before evaluation.")
  @minValue(0)
  reviewed_count: int32;

  @doc("Number of reviewed items in the held-out comparison. This is the denominator for current_matches and proposed_matches.")
  @minValue(0)
  labeled_count: int32;

  @doc("Held-out reviewer decisions matching the current rubric.")
  @minValue(0)
  current_matches: int32;

  @doc("Held-out reviewer decisions matching the proposed rubric.")
  @minValue(0)
  proposed_matches: int32;

  @doc("Held-out agreement rate for the current rubric.")
  @minValue(0)
  @maxValue(1)
  current_agreement_rate: float64;

  @doc("Held-out agreement rate for the proposed rubric.")
  @minValue(0)
  @maxValue(1)
  proposed_agreement_rate: float64;

  @doc("Held-out Cohen's kappa for the current rubric, when defined.")
  @minValue(-1)
  @maxValue(1)
  current_kappa?: float64;

  @doc("Held-out Cohen's kappa for the proposed rubric, when defined.")
  @minValue(-1)
  @maxValue(1)
  proposed_kappa?: float64;

  @doc("The current held-out agreement rate's 95 percent uncertainty interval.")
  current_agreement_interval: CalibrationConfidenceInterval;

  @doc("The proposed held-out agreement rate's 95 percent uncertainty interval.")
  proposed_agreement_interval: CalibrationConfidenceInterval;

  @doc("The 95 percent uncertainty interval for the change in held-out agreement.")
  improvement_interval: CalibrationConfidenceInterval;

  @doc("Whether to adopt the proposal or keep the current rubric.")
  recommendation: CalibrationRecommendation;

  @doc("The proposed change strategy.")
  strategy: CalibrationStrategy;

  @doc("Whether any criterion wording changed.")
  wording_changed: boolean;

  @doc("Current normalized Likert passing bar. Omitted for Boolean rubrics.")
  @minValue(0)
  @maxValue(1)
  current_threshold?: float64;

  @doc("Proposed normalized Likert passing bar. Omitted for Boolean rubrics.")
  @minValue(0)
  @maxValue(1)
  proposed_threshold?: float64;

  @doc("Criterion-by-criterion changes.")
  dimensions: CalibrationDimensionChange[];

  @doc("Examples where the current rubric disagreed with a reviewer.")
  top_disagreements: CalibrationDisagreement[];

  @doc("Source identities, mappings, and label accounting.")
  label_sources: CalibrationSourceOutcome[];

  @doc("Non-fatal limitations and source-read warnings.")
  warnings: string[];

  @doc("Estimated pass rate and uncertainty, when estimable.")
  pass_rate?: CalibrationPassRateEstimate;

  @doc("Complete create-visible evaluator version payload. Save it unchanged with this job's ID to record calibration evidence; no evaluator version is saved by the job.")
  @Azure.ClientGenerator.Core.alternateType(EvaluatorVersion)
  proposed_evaluator_version: Create<TypeSpec.Http.PlainData<EvaluatorVersion>>;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Durable, service-owned evidence for a version saved from an unchanged calibration proposal. The record is not an editable tag and survives deletion of the job.")
model EvaluatorCalibrationEvidence {
  @doc("Identifier of the successful calibration job.")
  job_id: string;

  @doc("Time the proposal was calibrated, in Unix seconds.")
  calibrated_at: FoundryTimestamp;

  @doc("Evaluator version used as the calibration starting point.")
  parent_version: string;

  @doc("Number of reviewed items in the held-out comparison.")
  @minValue(0)
  labeled_count: int32;

  @doc("Held-out reviewer decisions matching the saved proposal.")
  @minValue(0)
  matches: int32;

  @doc("Held-out reviewer decisions matching the starting version.")
  @minValue(0)
  previous_matches: int32;

  @doc("Held-out Cohen's kappa for the saved proposal, when defined.")
  @minValue(-1)
  @maxValue(1)
  kappa?: float64;

  @doc("Estimated pass rate and uncertainty, when estimable.")
  pass_rate?: CalibrationPassRateEstimate;

  @doc("Service-resolved source identities, versions, mappings, and counts used for this record.")
  label_sources: CalibrationSourceOutcome[];
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A calibration job. A successful job returns a proposal but never publishes an evaluator version.")
model EvaluatorCalibrationJob {
  ...OmitProperties<
    JobLike<EvaluatorCalibrationResult, EvaluatorCalibrationInputs>,
    "inputs"
  >;

  @doc("The submitted calibration inputs.")
  inputs: EvaluatorCalibrationInputs;

  @doc("Job creation time, in Unix seconds.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("Job completion time, in Unix seconds, when finished.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Inputs for checking an existing rubric against reviewer decisions without changing it or calling a model.")
model EvaluatorAgreementCheckInputs {
  @doc("Completed evaluation run to compare.")
  evaluation_run: EvaluationRunReference;

  @doc("Optional explicit label sources. Omission checks trace reviews and recognized golden-dataset reviewer columns; an explicitly empty list is invalid.")
  @minItems(1)
  label_sources?: CalibrationLabelSource[];

  @doc("Maximum number of unreviewed items to suggest, from 0 to 50. Defaults to 10.")
  @minValue(0)
  @maxValue(50)
  review_suggestion_count?: int32 = 10;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Agreement status for a rubric and reviewer decisions.")
union EvaluatorAgreementStatus {
  string,

  @doc("No readable reviewer decisions were found.")
  no_reviews: "no_reviews",

  @doc("Fewer than 20 reviewed items, or fewer than 5 passes or 5 failures, were available.")
  not_enough_reviews: "not_enough_reviews",

  @doc("The run used a rubric version whose criteria differ from the requested version.")
  not_comparable: "not_comparable",

  @doc("At least 80 percent agreement and Cohen's kappa of at least 0.40.")
  in_sync: "in_sync",

  @doc("Agreement is below 80 percent or Cohen's kappa is below 0.40.")
  needs_tuning: "needs_tuning",
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("A comparison with the service-recorded agreement at calibration.")
model CalibrationDrift {
  @doc("Whether drift could be evaluated. Evaluation requires a calibration record and at least 30 unique reviewed items from the same source identities and label mappings, in addition to the agreement minimums.")
  evaluated: boolean;

  @doc("Whether the upper end of the current agreement's 95 percent uncertainty interval is below the recorded agreement. Omitted when drift was not evaluated.")
  detected?: boolean;

  @doc("Agreement recorded for the calibrated version, when available.")
  @minValue(0)
  @maxValue(1)
  recorded_agreement_rate?: float64;

  @doc("Current agreement rate, when available.")
  @minValue(0)
  @maxValue(1)
  current_agreement_rate?: float64;

  @doc("Upper bound of the current agreement's 95 percent uncertainty interval, when available.")
  @minValue(0)
  @maxValue(1)
  current_agreement_upper_bound?: float64;

  @doc("Why drift was not evaluated, when applicable.")
  reason?: string;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Why an unreviewed item is useful to review.")
union CalibrationReviewReason {
  string,

  @doc("A Likert score is close to the passing bar.")
  near_passing_bar: "near_passing_bar",

  @doc("Exactly one applicable Boolean check failed.")
  one_check_failed: "one_check_failed",

  @doc("The item passed with exactly one applicable Boolean check.")
  one_check_decides_pass: "one_check_decides_pass",
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("One unreviewed item suggested for human review.")
model CalibrationReviewSuggestion {
  @doc("Evaluation item identifier.")
  item_id: string;

  @doc("Machine-readable selection reason.")
  reason_code: CalibrationReviewReason;
}

@added(Versions.v1)
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
@doc("Agreement with human reviewers, source accounting, drift, and suggested items to review.")
model EvaluatorAgreementCheckResult {
  @doc("Agreement status. If no source can be read, this is no_reviews and warnings identify unavailable sources.")
  status: EvaluatorAgreementStatus;

  @doc("Number of distinct reviewer-labeled items.")
  @minValue(0)
  labeled_count: int32;

  @doc("Number of reviewer decisions matching the rubric, when comparable.")
  @minValue(0)
  matches?: int32;

  @doc("Number of reviewer decisions disagreeing with the rubric, when comparable.")
  @minValue(0)
  disagreement_count?: int32;

  @doc("Agreement rate, when comparable and defined.")
  @minValue(0)
  @maxValue(1)
  agreement_rate?: float64;

  @doc("Cohen's kappa, when comparable and defined.")
  @minValue(-1)
  @maxValue(1)
  kappa?: float64;

  @doc("Source identities, mappings, accounting, and availability.")
  label_sources: CalibrationSourceOutcome[];

  @doc("Comparison with the calibration record, if possible.")
  drift: CalibrationDrift;

  @doc("Unreviewed items ranked for human review, limited by review_suggestion_count.")
  @maxItems(50)
  review_suggestions: CalibrationReviewSuggestion[];

  @doc("Non-fatal limitations and unavailable sources.")
  warnings: string[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Request body for getting evaluator credentials")
model EvaluatorCredentialRequest {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
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
