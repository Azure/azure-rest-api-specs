import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../openai-evaluations/models.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Enums
// ---------------------------------------------------------------------------

@doc("The subtype of an evaluation suite.")
union EvaluationSuiteSubtype {
  string,

  @doc("Default suite type.")
  default: "default",

  @doc("Benchmark suite.")
  benchmark: "benchmark",
}

@doc("The category of evaluator generation.")
union EvaluationSuiteGenerationCategory {
  string,

  @doc("Quality-focused rubric criteria.")
  quality: "quality",

  @doc("Safety-focused policy criteria.")
  safety: "safety",
}

@doc("The data generation type.")
union EvaluationDataGenerationType {
  string,

  @doc("Simple question and answer generation.")
  simple_qna: "simple_qna",

  @doc("Traces-based generation.")
  traces: "traces",

  @doc("Tool use generation.")
  tool_use: "tool_use",

  @doc("Task-based generation.")
  task: "task",
}

// ---------------------------------------------------------------------------
// Child models
// ---------------------------------------------------------------------------

@doc("""
  Reference to a dataset by name and version.
  """)
model EvaluationDatasetReference {
  @doc("Dataset name.")
  name: string;

  @doc("Dataset version. If not provided, resolves to the latest version.")
  version?: string;

  @doc("""
    Name of the schema file within the dataset's blob folder (e.g., "a3f2b1c4_schema.json").
    Optional — if not provided, schema is inferred at runtime from the data.
    Only applicable for uri_folder datasets.
    """)
  schema_file_name?: string;
}

// ---------------------------------------------------------------------------
// CRUD Resource model
// ---------------------------------------------------------------------------

@doc("""
  An evaluation suite bundles testing criteria — an optional dataset, one or more
  evaluator configs with thresholds and init params — into a reusable, named artifact that
  can gate agent changes across batch, scheduled, continuous, and CI/CD evals.
  """)
@resource("evaluation_suites")
model EvaluationSuiteVersion {
  @doc("""
    Human-readable display name.
    Does not need to be unique. Shown in Foundry portal list views and eval reports.
    """)
  display_name?: string;

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
  dataset?: EvaluationDatasetReference;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matching eval group testing_criteria pattern"
  @doc("""
    Testing criteria — the evaluator configurations for this suite.
    Supports all grader types: azure_ai_evaluator, string_check, label_model,
    score_model, text_similarity, python, etc.
    At least one entry is required.
    """)
  @minItems(1)
  testing_criteria: (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | TestingCriterionAzureAIEvaluator)[];

  @doc("""
    Target for this evaluation suite. Uses the existing Target discriminated type
    from eval runs. Supports azure_ai_agent, azure_ai_model, azure_ai_assistant.
    Optional — allows suites to exist without a target.
    """)
  target?: Target;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Supporting both input message types"
  @doc("""
    How to send dataset rows to the target (agent or model).
    Supports template type (prompt with column placeholders) and
    item_reference type (column containing pre-built messages).
    """)
  input_messages?:
    | OpenAI.CreateEvalResponsesRunDataSourceInputMessagesTemplate
    | OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  @doc("""
    Default evaluation level for this suite. Can be overridden at run time.
    """)
  evaluation_level?: EvaluationLevel;

  @doc("The name of the resource.")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @doc("The version of the resource.")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("The asset description text.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @doc("Tag dictionary. Tags can be added, removed, and updated.")
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

// ---------------------------------------------------------------------------
// Run API models
// ---------------------------------------------------------------------------

@doc("Request body for running an evaluation from a suite.")
model EvaluationSuiteRunRequest {
  @doc("Name for the evaluation. Default: '{suiteName}-runs'.")
  evaluation_name?: string;

  @doc("Evaluation suite version to run. Default: latest.")
  evaluation_suite_version?: string;

  @doc("Overrides the suite's default evaluation level. If omitted, uses the level from the suite.")
  evaluation_level?: EvaluationLevel;
}

@doc("Response from running an evaluation suite.")
model EvaluationSuiteRunResponse {
  @doc("The evaluation suite name used.")
  evaluation_suite_name: string;

  @doc("The evaluation suite version resolved.")
  evaluation_suite_version: string;

  @doc("The run results. Currently a single-element array; will support multiple runs in the future.")
  results: EvaluationSuiteRunResult[];
}

@doc("Result of a single evaluation run within a suite execution.")
model EvaluationSuiteRunResult {
  @doc("The evaluation ID created.")
  eval_id: string;

  @doc("The eval run ID created.")
  run_id: string;

  @doc("Status of the run.")
  status: JobStatus;

  @doc("Timestamp when the run was created.")
  created_at: FoundryTimestamp;
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
  @doc("The evaluation suite name to create.")
  evaluation_suite_name: string;

  @doc("Source materials for generation — agent context, prompts, traces, or datasets.")
  sources: EvaluationSuiteJobSource[];

  @doc("The LLM model to use for rubric and data generation (e.g., 'gpt-4o').")
  generation_model: string;

  @doc("Category determines the generation focus. Default: quality.")
  category?: EvaluationSuiteGenerationCategory = EvaluationSuiteGenerationCategory.quality;

  @doc("""
    Optional initialization parameters applied to all generated evaluators.
    For example, deployment_name for LLM judge model, default threshold.
    """)
  initialization_parameters?: Record<unknown>;

  @doc("""
    Data generation options. Controls how the evaluation dataset is generated.
    If omitted, defaults are used (simple_qna, 100 max_samples).
    """)
  data_generation_options?: EvaluationSuiteDataGenerationOptions;

  @doc("""
    Target for the generated suite. Stored on the suite so it can be run
    immediately after generation completes.
    Supports azure_ai_agent, azure_ai_model, azure_ai_assistant.
    """)
  target?: Target;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Supporting both input message types"
  @doc("""
    How to send dataset rows to the target.
    If omitted and target is provided, defaults to a template using item.query.
    """)
  input_messages?:
    | OpenAI.CreateEvalResponsesRunDataSourceInputMessagesTemplate
    | OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  @doc("""
    Evaluation level for the generated suite.
    Default: turn (single-turn evaluation).
    Use conversation for multi-turn evaluation.
    """)
  evaluation_level?: EvaluationLevel;
}

@doc("Options for dataset generation within an evaluation suite generation job.")
model EvaluationSuiteDataGenerationOptions {
  @doc("The data generation type. Defaults to 'simple_qna' if not specified.")
  type?: EvaluationDataGenerationType;

  @doc("Maximum number of samples to generate. Valid range: 15-1000.")
  @minValue(15)
  @maxValue(1000)
  max_samples?: int32;
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

  @doc("Token consumption summary. Populated on terminal states.")
  @visibility(Lifecycle.Read)
  usage?: EvaluationSuiteGenerationTokenUsage;
}

@doc("Token usage summary for an evaluation suite generation job.")
model EvaluationSuiteGenerationTokenUsage {
  @doc("Number of input tokens consumed.")
  input_tokens?: int64;

  @doc("Number of output tokens consumed.")
  output_tokens?: int64;

  @doc("Total tokens consumed.")
  total_tokens?: int64;
}
