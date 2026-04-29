import "@typespec/openapi";

import "../common/models.tsp";
import "../servicepatterns.tsp";
import "../openai-evaluations/models.tsp";

using TypeSpec.Rest;
using OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Child models
// ---------------------------------------------------------------------------

@doc("""
  Reference to a dataset. Uses an asset ID (e.g., azureai://accounts/{account}/projects/{project}/data/{name}/versions/{version}).
  To use the latest version, omit the version segment.
  """)
model DatasetReference {
  @doc("Dataset asset ID.")
  id: string;

  @doc("""
    Name of the schema file within the dataset's blob folder (e.g., "a3f2b1c4_schema.json").
    Optional — if not provided, schema is inferred at runtime from the data.
    Only applicable for uri_folder datasets.
    """)
  schemaFileName?: string;
}

// ---------------------------------------------------------------------------
// CRUD Resource model
// ---------------------------------------------------------------------------

@doc("""
  An evaluation suite bundles testing criteria — an optional dataset, one or more
  evaluator configs with thresholds and init params — into a reusable, named artifact that
  can gate agent changes across batch, scheduled, continuous, and CI/CD evals.
  """)
@resource("evaluationSuites")
model EvaluationSuiteVersion {
  @doc("""
    Human-readable display name.
    Does not need to be unique. Shown in Foundry portal list views and eval reports.
    """)
  displayName?: string;

  @doc("""
    Subtype of the evaluation suite. Follows the evaluator subtype pattern.
    For example, "benchmark" for benchmark suites.
    """)
  subtype?: string;

  @doc("""
    Dataset reference for evaluation.
    Optional — omit for evaluator-only suites where data comes from
    live production traces or is provided at run time.
    The referenced dataset must exist in the project's dataset registry.
    """)
  dataset?: DatasetReference;

  @doc("""
    Testing criteria — pass-through to eval group testing_criteria.
    Supports any grader type: azure_ai_evaluator, string_check, label_model, 
    score_model, text_similarity, python, etc. Stored as raw JSON.
    At least one entry is required.
    """)
  @minItems(1)
  testingCriteria: Record<string, unknown>[];

  @doc("""
    Target for this evaluation suite. Uses the existing Target discriminated type
    from eval runs. Supports azure_ai_agent, azure_ai_model, azure_ai_assistant.
    Optional — allows suites to exist without a target.
    """)
  target?: Target;

  @doc("""
    How to send dataset rows to the target (agent or model).
    Pass-through to eval run data_source input_messages.
    Supports template type (prompt with column placeholders) and
    item_reference type (column containing pre-built messages).
    """)
  inputMessages?: Record<string, unknown>;

  @doc("""
    Default evaluation level for this suite. Can be overridden at run time.
    Values: "turn" or "conversation".
    """)
  evaluationLevel?: string;

  // AssetBase provides: name (string, @key), version (string, read-only),
  // id (string, read-only), description (string, optional), tags (Record<string>, optional)
  ...AssetBase;
}

// ---------------------------------------------------------------------------
// Run API models
// ---------------------------------------------------------------------------

@doc("Request body for running an evaluation from a suite.")
model EvaluationSuiteRunRequest {
  @doc("Name for the eval group. Default: '{suiteName}-runs'.")
  groupName?: string;

  @doc("Suite version to run. Default: latest.")
  suiteVersion?: string;

  @doc("Overrides the suite's default evaluation level. Values: \"turn\" or \"conversation\". If omitted, uses the level from the suite.")
  evaluationLevel?: string;
}

@doc("Response from running an evaluation suite.")
model EvaluationSuiteRunResponse {
  @doc("The evaluation (group) ID created.")
  evaluationId: string;

  @doc("The eval run ID created.")
  runId: string;

  @doc("The eval group name.")
  groupName: string;

  @doc("The suite name used.")
  suiteName: string;

  @doc("The suite version resolved.")
  suiteVersion: string;

  @doc("Status of the run.")
  status: string;

  @doc("Unix timestamp when the run was created.")
  createdAt: int64;
}

// ---------------------------------------------------------------------------
// Generate API (LRO) models
// ---------------------------------------------------------------------------

// Source types follow the shared JobSource pattern from evaluator_generation_jobs
// and data_generation_jobs. Per-context discriminated base with shared shape spreads.

@doc("The supported source types for evaluation suite generation jobs.")
union EvaluationSuiteJobSourceType {
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

@doc("The base source model for evaluation suite generation jobs. Polymorphic over `type`.")
@discriminator("type")
model EvaluationSuiteJobSource {
  @doc("The type of source.")
  type: EvaluationSuiteJobSourceType;

  ...JobSourceDescription;
}

@doc("Prompt source for evaluation suite generation jobs — inline text provided by the user.")
model PromptEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...PromptJobSource;
}

@doc("Agent source for evaluation suite generation jobs — references an agent to fetch instructions and metadata from.")
model AgentEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...AgentJobSource;
}

@doc("Traces source for evaluation suite generation jobs — conversation traces from Application Insights.")
model TracesEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...TracesJobSource;
}

@doc("Dataset source for evaluation suite generation jobs — reference to a dataset.")
model DatasetEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...DatasetJobSource;
}

@doc("Caller-supplied inputs for an evaluation suite generation job.")
model EvaluationSuiteGenerationJobInputs {
  @doc("The suite name to create.")
  name: string;

  @doc("Source materials for generation — agent context, prompts, traces, or datasets.")
  sources: EvaluationSuiteJobSource[];

  @doc("The LLM model to use for rubric and data generation (e.g., 'gpt-4o'). Distinct from deployment_name in initializationParameters which is the LLM judge model used at eval time.")
  generationModel: string;

  @doc("Category: 'quality' (default) or 'safety'.")
  category?: string;

  @doc("""
    Optional initialization parameters applied to all generated evaluators.
    For example, deployment_name for LLM judge model, default threshold.
    """)
  initializationParameters?: Record<string, unknown>;
}

@doc("Result produced by a successful evaluation suite generation job.")
model EvaluationSuiteGenerationJobResult {
  @doc("The created suite name.")
  suiteName: string;

  @doc("The created suite version.")
  suiteVersion: string;

  @doc("The generated evaluator name.")
  evaluatorName: string;

  @doc("The generated evaluator version.")
  evaluatorVersion: string;

  @doc("The generated dataset ID.")
  datasetId?: string;
}

@doc("Evaluation suite generation job resource.")
model EvaluationSuiteGenerationJob
  is JobLike<EvaluationSuiteGenerationJobResult, EvaluationSuiteGenerationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}
