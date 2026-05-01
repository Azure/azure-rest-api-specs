import "@typespec/openapi";

import "../common/models.tsp";
import "../servicepatterns.tsp";
import "../openai-evaluations/models.tsp";

using TypeSpec.Rest;
using OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

@doc("The evaluation level for an evaluation suite.")
union EvaluationSuiteEvaluationLevel {
  string,

  @doc("Turn-level evaluation.")
  turn: "turn",

  @doc("Conversation-level evaluation.")
  conversation: "conversation",
}

@doc("The subtype of an evaluation suite.")
union EvaluationSuiteSubtype {
  string,

  @doc("Benchmark spec suite.")
  benchmarkspec: "benchmarkspec",
}

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
    Subtype of the evaluation suite.
    """)
  subtype?: EvaluationSuiteSubtype;

  @doc("""
    Dataset reference for evaluation.
    Optional — omit for evaluator-only suites where data comes from
    live production traces or is provided at run time.
    The referenced dataset must exist in the project's dataset registry.
    """)
  dataset?: DatasetReference;

  @doc("""
    Testing criteria — the evaluator configurations for this suite.
    Supports all grader types: azure_ai_evaluator, string_check, label_model,
    score_model, text_similarity, python, etc.
    At least one entry is required.
    """)
  @minItems(1)
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matching eval group testing_criteria pattern"
  testingCriteria: (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | TestingCriterionAzureAIEvaluator
  )[];

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
  inputMessages?: Record<unknown>;

  @doc("""
    Default evaluation level for this suite. Can be overridden at run time.
    """)
  evaluationLevel?: EvaluationSuiteEvaluationLevel;

  // AssetBase provides: name (string, @key), version (string, read-only),
  // id (string, read-only), description (string, optional), tags (Record<string>, optional)
  ...AssetBase;
}

// ---------------------------------------------------------------------------
// Run API models
// ---------------------------------------------------------------------------

@doc("Request body for running an evaluation from a suite.")
model EvaluationSuiteRunRequest {
  @doc("Name for the evaluation. Default: '{suiteName}-runs'.")
  evaluationName?: string;

  @doc("Suite version to run. Default: latest.")
  suiteVersion?: string;

  @doc("Overrides the suite's default evaluation level. If omitted, uses the level from the suite.")
  evaluationLevel?: EvaluationSuiteEvaluationLevel;
}

@doc("Response from running an evaluation suite.")
model EvaluationSuiteRunResponse {
  @doc("The evaluation ID created.")
  evalId: string;

  @doc("The eval run ID created.")
  runId: string;

  @doc("The evaluation name.")
  evaluationName: string;

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

// Source types use shared JobSource shapes from common/models.tsp via spread,
// with an evaluation-suite-specific discriminated base (same pattern as
// DataGenerationJobSource).

@doc("The supported source types for evaluation suite generation jobs.")
union EvaluationSuiteJobSourceType {
  string,

  @doc("Prompt source — inline text provided by the user.")
  prompt: "prompt",

  @doc("Agent source — references an agent.")
  agent: "agent",

  @doc("Traces source — conversation traces from Application Insights.")
  traces: "traces",

  @doc("Dataset source — reference to a dataset.")
  dataset: "dataset",

  @doc("File source — Azure OpenAI file.")
  file: "file",
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

@doc("File source for evaluation suite generation jobs — Azure OpenAI file input.")
model FileEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  @doc("The source type, which is file.")
  type: "file";

  @doc("Input Azure OpenAI file ID used for generation.")
  id: string;
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
  initializationParameters?: Record<unknown>;

  @doc("""
    Optional data generation options. Controls how the evaluation dataset is generated.
    If omitted, the service uses sensible defaults.
    """)
  dataGenerationOptions?: EvaluationSuiteDataGenerationOptions;
}

@doc("Options for dataset generation within an evaluation suite generation job.")
model EvaluationSuiteDataGenerationOptions {
  @doc("The data generation type: 'simple_qna', 'traces', 'tool_use', or 'task'.")
  type?: string;

  @doc("Maximum number of samples to generate.")
  maxSamples?: int32;
}

@doc("Evaluation suite generation job resource — a long-running job that generates testing criteria and optionally a dataset from source materials. On success, the result is the persisted EvaluationSuiteVersion.")
model EvaluationSuiteGenerationJob
  is JobLike<EvaluationSuiteVersion, EvaluationSuiteGenerationJobInputs> {
  @doc("The timestamp when the job was created, represented in Unix time.")
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  @doc("The timestamp when the job finished, represented in Unix time.")
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;
}
