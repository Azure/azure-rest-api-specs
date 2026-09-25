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

@doc("A single dimension — one independent, measurable quality dimension within a rubric evaluator's scoring blueprint.")
model Dimension {
  @doc("Stable identifier for this dimension (snake_case, e.g., `correct_resolution`). Required. Provided by the user when manually creating a rubric evaluator or during human-in-the-loop review of a generated set; the generation pipeline produces an initial value the user can edit. Editable when saving new versions.")
  @minLength(1)
  @maxLength(128)
  @pattern("^[a-z][a-z0-9_]*$")
  id: string;

  @doc("What this dimension measures (e.g., 'Correctly identifies the user's reservation intent and pursues the appropriate workflow').")
  description: string;

  @doc("Relative weight of this dimension (1-10). The generation pipeline assigns exactly one dimension weight 8-10; all others use 1-6. User edits are not constrained by this heuristic.")
  @minValue(1)
  @maxValue(10)
  weight: int32;

  @doc("When true, the LLM judge always scores this dimension regardless of relevance (skips applicability assessment). The service-generated general quality/policy dimension has this set to true and is non-editable. Users may set this on their own custom dimensions. The service defaults to `false` if a value is not specified by the caller.")
  always_applicable?: boolean = false;
}

@doc("Rubric-based evaluator definition — stores dimensions produced by the generate API. Used for both quality and safety evaluators.")
model RubricBasedEvaluatorDefinition extends EvaluatorDefinition {
  type: EvaluatorDefinitionType.rubric;

  @doc("The set of dimensions — the scoring blueprint used by the LLM judge. Quality evaluators include a non-editable residual dimension with id 'general_quality' (always_applicable: true); safety evaluators include 'general_policy_compliance'. Both use the same Dimension structure.")
  dimensions: Dimension[];

  @doc("Pass/fail threshold for the aggregate rubric score, on the same normalized 0.0-1.0 scale as the emitted `score`. When the runtime weighted average meets or exceeds this value, the result is `pass`. Defaults to 0.5 (equivalent to a raw 1-5 weighted average of 3.0). The 'any dimension scored 1 → fail' rule still applies regardless of this threshold.")
  @minValue(0.0)
  @maxValue(1.0)
  pass_threshold?: float32 = 0.5;
}

// ============================================================================
// Evaluator diagnostics
// ============================================================================

@doc("The type of actor responsible for an evaluator lineage diagnostic.")
union EvaluatorDiagnosticActorType {
  string,

  @doc("An authenticated user initiated the change.")
  user: "user",

  @doc("A Foundry service component initiated the change.")
  service: "service",
}

@doc("The actor responsible for an evaluator lineage diagnostic.")
model EvaluatorDiagnosticActor {
  @doc("The type of actor.")
  type: EvaluatorDiagnosticActorType;

  @doc("A stable opaque principal or service identifier, when available.")
  id?: string;
}

@doc("The severity of an evaluator diagnostic message.")
union EvaluatorDiagnosticMessageSeverity {
  string,

  @doc("Informational diagnostic detail.")
  info: "info",

  @doc("A diagnostic condition that may require attention.")
  warning: "warning",
}

@doc("Known machine-readable classifications for evaluator diagnostic changes.")
union EvaluatorDiagnosticChangeType {
  string,

  @doc("A user created an evaluator version.")
  human_created: "human_created",

  @doc("A user added a rubric dimension.")
  human_added: "human_added",

  @doc("A user changed evaluator functional content.")
  human_edited: "human_edited",

  @doc("A user removed a rubric dimension.")
  human_removed: "human_removed",

  @doc("Evaluator generation created the resulting content.")
  generated: "generated",

  @doc("Evaluator generation changed an existing dimension.")
  regenerated: "regenerated",

  @doc("The generated rubric no longer contained an existing dimension.")
  not_present_in_generated_rubric: "not_present_in_generated_rubric",

  @doc("An evaluator version was published from completed generation.")
  generation_completed: "generation_completed",

  @doc("The diagnostic change is a baseline imported from legacy evaluator history.")
  history_imported: "history_imported",
}

@doc("The supported evaluator diagnostic change shapes.")
union EvaluatorDiagnosticType {
  string,

  @doc("An evaluator version was created.")
  version_created: "version_created",

  @doc("A rubric dimension was added.")
  dimension_added: "dimension_added",

  @doc("A rubric dimension was updated.")
  dimension_updated: "dimension_updated",

  @doc("A rubric dimension was removed.")
  dimension_removed: "dimension_removed",

  @doc("Functional evaluator fields outside individual dimensions were updated.")
  definition_updated: "definition_updated",
}

@doc("The shared fields for immutable evaluator publication lineage.")
@discriminator("type")
model EvaluatorDiagnostic {
  @doc("The stable server-assigned diagnostic identifier.")
  @minLength(1)
  id: string;

  @doc("The immutable published evaluator version to which the lineage entry applies.")
  evaluator_version: EvaluatorVersionNumber;

  @doc("The server-recorded time when the change occurred, expressed as Unix seconds.")
  occurred_at: FoundryTimestamp;

  @doc("A stable machine-readable classification describing why the change occurred.")
  change_type: EvaluatorDiagnosticChangeType;

  @doc("A bounded deterministic summary of the change.")
  explanation?: string;

  @doc("The diagnostic change shape.")
  type: EvaluatorDiagnosticType;
}

@doc("The shared fields for completed evaluator lineage diagnostics.")
@discriminator("type")
model EvaluatorLineageDiagnosticBase extends EvaluatorDiagnostic {
  @doc("The lineage diagnostic change shape.")
  type: EvaluatorDiagnosticType;

  @doc("The authenticated user or service responsible for the lineage event.")
  actor: EvaluatorDiagnosticActor;
}

@doc("A flat page of immutable evaluator lineage diagnostics.")
model CompletedEvaluatorDiagnosticsPage {
  @doc("The evaluator publication lineage entries.")
  @maxItems(100)
  @pageItems
  data: EvaluatorDiagnostic[];

  @doc("The first diagnostic identifier represented in this page.")
  @minLength(1)
  first_id?: string | null;

  @doc("The last diagnostic identifier represented in this page.")
  @minLength(1)
  @continuationToken
  last_id?: string | null;

  @doc("Whether more lineage entries are available.")
  has_more: boolean;
}

@doc("A change to one functional evaluator field.")
model EvaluatorFieldChange {
  @doc("A stable path identifying the changed field.")
  @minLength(1)
  field: string;

  @doc("The prior snapshot, mapping the exact `field` path to its JSON value. The mapped value may be a scalar, array, object, or null.")
  before: Record<unknown>;

  @doc("The resulting snapshot, mapping the exact `field` path to its JSON value. The mapped value may be a scalar, array, object, or null.")
  after: Record<unknown>;
}

@doc("How an evaluator generation source was used.")
union EvaluatorGenerationSourceUseStatus {
  string,

  @doc("The source was accepted and used.")
  accepted: "accepted",

  @doc("Only part of the source was used.")
  partially_used: "partially_used",

  @doc("The source was rejected.")
  rejected: "rejected",
}

@doc("A bounded evaluator generation source snapshot.")
model EvaluatorGenerationSourceSnapshot {
  @doc("The stable source identifier within the generation operation.")
  @minLength(1)
  source_id: string;

  @doc("The source type.")
  @minLength(1)
  source_type: string;

  @doc("The lowercase 64-character SHA-256 source content hash.")
  content_hash: Sha256Hash;

  @doc("How the source was used.")
  status: EvaluatorGenerationSourceUseStatus;
}

@doc("Whether one rubric dimension is covered by recorded generation sources.")
union EvaluatorDimensionSourceCoverageStatus {
  string,

  @doc("The dimension has recorded source coverage.")
  covered: "covered",

  @doc("The dimension has partial recorded source coverage.")
  partial: "partial",

  @doc("The service could not resolve the dimension's source coverage.")
  unresolved: "unresolved",

  @doc("The dimension has no recorded source coverage.")
  uncovered: "uncovered",
}

@doc("Recorded source coverage for one rubric dimension.")
model EvaluatorDimensionSourceCoverage {
  @doc("The stable rubric dimension identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("Stable source identifiers recorded for the dimension.")
  source_ids: string[];

  @doc("The recorded source-coverage status.")
  coverage_status: EvaluatorDimensionSourceCoverageStatus;

  @doc("A bounded explanation of the coverage status.")
  explanation?: string;
}

@doc("A bounded gap in evaluator source coverage.")
model EvaluatorSourceCoverageGap {
  @doc("The stable gap code.")
  @minLength(1)
  code: string;

  @doc("The gap severity.")
  severity: EvaluatorDiagnosticMessageSeverity;

  @doc("The related source identifier, when applicable.")
  @minLength(1)
  source_id?: string;

  @doc("The related dimension identifier, when applicable.")
  @minLength(1)
  @maxLength(128)
  dimension_id?: string;

  @doc("A bounded explanation.")
  explanation: string;
}

@doc("Bounded source lineage and coverage recorded by evaluator generation.")
model EvaluatorSourceLineageSummary {
  @doc("Recorded generation source snapshots.")
  sources: EvaluatorGenerationSourceSnapshot[];

  @doc("Recorded source coverage by rubric dimension.")
  dimension_coverage: EvaluatorDimensionSourceCoverage[];

  @doc("Recorded source-coverage gaps.")
  coverage_gaps: EvaluatorSourceCoverageGap[];

  @doc("Bounded limitations of the recorded lineage.")
  limitations: string[];
}

@doc("A diagnostic change recording the creation of an evaluator version.")
model VersionCreatedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.version_created;

  @doc("The preceding published evaluator version, when one exists.")
  prior_version?: EvaluatorVersionNumber;

  @doc("The evaluator generation job that created the version, when applicable.")
  @minLength(1)
  generation_job_id?: string;

  @doc("Bounded source lineage recorded by evaluator generation, when available.")
  source_lineage?: EvaluatorSourceLineageSummary;
}

@doc("A diagnostic change recording the addition of a rubric dimension.")
model DimensionAddedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.dimension_added;

  @doc("The public dimension identifier associated with the change. It remains stable until explicitly changed; changing an identifier produces a removal change for the prior identifier and an addition change for the new identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("The resulting complete dimension snapshot.")
  after: Dimension;

  @doc("The public dimension fields changed, when reported.")
  @minItems(1)
  @maxItems(3)
  changed_fields?: string[];
}

@doc("A diagnostic change recording an update to a rubric dimension.")
model DimensionUpdatedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.dimension_updated;

  @doc("The public dimension identifier associated with the change. It remains stable until explicitly changed; changing an identifier produces a removal change for the prior identifier and an addition change for the new identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("The complete dimension snapshot before the update.")
  before: Dimension;

  @doc("The complete dimension snapshot after the update.")
  after: Dimension;

  @doc("The public dimension fields changed, when reported.")
  @minItems(1)
  @maxItems(3)
  changed_fields?: string[];
}

@doc("A diagnostic change recording the removal of a rubric dimension.")
model DimensionRemovedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.dimension_removed;

  @doc("The public dimension identifier associated with the change. It remains stable until explicitly changed; changing an identifier produces a removal change for the prior identifier and an addition change for the new identifier.")
  @minLength(1)
  @maxLength(128)
  dimension_id: string;

  @doc("The complete dimension snapshot before removal.")
  before: Dimension;

  @doc("The public dimension fields changed, when reported.")
  @minItems(1)
  @maxItems(3)
  changed_fields?: string[];
}

@doc("A diagnostic change recording functional evaluator changes outside individual dimensions.")
model DefinitionUpdatedDiagnosticChange extends EvaluatorLineageDiagnosticBase {
  type: EvaluatorDiagnosticType.definition_updated;

  @doc("The functional field changes applied.")
  @minItems(1)
  field_changes: EvaluatorFieldChange[];
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

@doc("Service-managed provenance artifacts produced by an evaluator generation job. Present on generated current evaluator state and copied into a published version when that state is published. The combined-JSONL Foundry Dataset is read-only and resolves to a versioned dataset in a service-reserved namespace.")
model EvaluatorGenerationArtifacts {
  @doc("Reference to the single Foundry Dataset holding all artifacts produced by the generation pipeline. Each row in the JSONL carries a `kind` field discriminating its content (e.g. `spec`, `tools`, `context`).")
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
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
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
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model EvaluatorGenerationJobSource {
  @doc("The type of source.")
  type: EvaluatorGenerationJobSourceType;
}
// Note: `JobSourceDescription` is intentionally NOT spread here. Each
// concrete subtype already spreads its `XxxJobSource` shape from common/, and
// each of those already spreads `JobSourceDescription`. Spreading it again on
// the discriminated base would emit `description` twice in the union.

@doc("Prompt source for evaluator generation jobs — inline text provided by the user.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model PromptEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...PromptJobSource;
}

@doc("Agent source for evaluator generation jobs — references an agent to fetch instructions and metadata from.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model AgentEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...AgentJobSource;
}

@doc("Traces source for evaluator generation jobs — conversation traces from Application Insights.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model TracesEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...TracesJobSource;
}

@doc("Dataset source for evaluator generation jobs — reference to a dataset.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model DatasetEvaluatorGenerationJobSource extends EvaluatorGenerationJobSource {
  ...DatasetJobSource;
}

// ============================================================================
// Evaluator Generation Job (LRO — follows DataGenerationJob pattern)
// ============================================================================

@doc("Caller-supplied inputs for an evaluator generation job.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model EvaluatorGenerationInputs {
  @doc("Source materials for generation: agent descriptions, prompts, traces, or datasets. Each entry is an `EvaluatorGenerationJobSource` variant discriminated by `type`.")
  sources: EvaluatorGenerationJobSource[];

  @doc("The LLM model to use for rubric generation (e.g., 'gpt-4o'). Required — users must provide their own model rather than relying on service-owned capacity.")
  `model`: string;

  @doc("The evaluator name (immutable identifier). 1-256 characters; allowed characters are ASCII letters, digits, underscore (`_`), period (`.`), tilde (`~`), and hyphen (`-`). The prefix `builtin.` is reserved for system-managed evaluators and is rejected by the service. If a current rubric evaluator with this name exists, generation replaces that mutable current state and uses its dimensions as context for incremental improvement. Published versions remain immutable and queryable through `get_version(name, version)`. If the existing current evaluator is not rubric-based, the request is rejected with `400 Bad Request`.")
  @minLength(1)
  @maxLength(256)
  @pattern("^[A-Za-z0-9_.~-]+$")
  evaluator_name: string;

  @doc("Optional human-friendly display name for the resulting current evaluator. Surfaced as `Evaluator.display_name`. When omitted, the service uses `evaluator_name` as the display name. The `evaluator_` prefix disambiguates this from the immutable `evaluator_name` identifier.")
  evaluator_display_name?: string;

  @doc("Optional human-friendly description for the resulting current evaluator. Surfaced as `Evaluator.description`. Typically collected from the UI alongside `evaluator_display_name`. The `evaluator_` prefix disambiguates this from any other description fields on related models.")
  evaluator_description?: string;
}

@doc("Token consumption summary for an evaluator generation job. Populated when the job reaches a terminal state.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
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
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
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
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
union RubricGenerationInputQualityWarningSeverity {
  string,

  @doc("Non-fatal advisory; generation succeeded but output quality may be lower.")
  warning: "warning",
}

@doc("Stable searchable machine-readable warning code for a rubric-generation input-quality warning. Values are `snake_case`; clients must tolerate additional service-defined identifiers.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
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
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
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

@doc("Evaluator Generation Job resource — a long-running job that generates rubric-based evaluator definitions from source materials. On success, the result is the persisted unnumbered current Evaluator. Publishing that state is a separate operation.")
@extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
model EvaluatorGenerationJob is JobLike<Evaluator, EvaluatorGenerationInputs> {
  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;

  @doc("Token consumption summary. Populated when the job reaches a terminal state.")
  @visibility(Lifecycle.Read)
  usage?: EvaluatorGenerationTokenUsage;

  @doc("Non-fatal input-quality advisories produced by the generation pipeline. Read-only; service-generated; populated only on terminal jobs when advisories fired and omitted when generation was clean.")
  @visibility(Lifecycle.Read)
  input_quality_warnings?: RubricGenerationInputQualityWarning[];
}

alias EvaluatorProperties = {
  @doc("Display Name for evaluator. It helps to find the evaluator easily in AI Foundry. It does not need to be unique.")
  display_name?: string;

  @doc("Metadata about the evaluator")
  metadata?: Record<string>;

  @doc("The type of the evaluator")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  evaluator_type: EvaluatorType;

  @doc("The categories of the evaluator")
  categories: EvaluatorCategory[];

  @doc("Evaluation levels this evaluator supports (e.g., `turn`, `conversation`). When omitted on create, the service defaults to `[\"turn\"]`. Custom code-based evaluators support only `turn`; custom prompt-based evaluators support exactly one level (`turn` or `conversation`).")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  supported_evaluation_levels?: EvaluationLevel[] = #[EvaluationLevel.turn];

  @doc("The evaluator's functional definition. Current evaluator state is mutable under ETag concurrency; the definition is immutable after publication in an EvaluatorVersion.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  definition: EvaluatorDefinition;

  @doc("Provenance artifacts from the generation pipeline. Read-only; present on generated current state and copied into published versions. Each artifact resolves to a versioned Foundry Dataset.")
  @visibility(Lifecycle.Read)
  generation_artifacts?: EvaluatorGenerationArtifacts;

  @doc("Read-only provenance link back to the EvaluatorGenerationJob that produced this content. Absent for manually-authored content.")
  @visibility(Lifecycle.Read)
  generation_job_id?: string;

  @doc("Categories of warnings surfaced on generated evaluator content. Present when the paired generation job produced non-empty warnings. Follow `generation_job_id` to fetch detailed warning payloads.")
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

  @doc("The evaluator catalog description.")
  description?: string;

  @doc("Evaluator catalog tags.")
  tags?: Record<string>;
};

@doc("The mutable unnumbered current evaluator state.")
@resource("evaluators")
model Evaluator {
  ...EvaluatorProperties;

  @doc("The evaluator resource identifier.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The evaluator name.")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  ...Azure.Core.EtagProperty;
}

@doc("An immutable published evaluator version.")
model EvaluatorVersion {
  ...EvaluatorProperties;

  @doc("The published evaluator version resource identifier.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The evaluator name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The immutable published version number.")
  @visibility(Lifecycle.Read)
  version: EvaluatorVersionNumber;
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
