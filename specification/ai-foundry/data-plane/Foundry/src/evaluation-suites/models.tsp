import "@typespec/openapi";

import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../task-sets/models.tsp";
import "../openai/evaluations/models.tsp";
import "./run-config.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

const EvaluationSuitesRequiredPreviews = EvaluationServiceV2RequiredPreviews;
const EvaluationSuiteGenerationJobsRequiredPreviews = EvaluationServiceV2RequiredPreviews;

/** Subtypes of the existing evaluation-suite preview. */
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
union EvaluationSuiteSubtype {
  string,

  /** A standard evaluation suite. */
  default: "default",

  /** A benchmark evaluation suite. */
  benchmark: "benchmark",
}

/** Categories supported by the existing suite-generation preview. */
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
union EvaluationSuiteGenerationCategory {
  string,

  /** Generate quality criteria. */
  quality: "quality",

  /** Generate safety criteria. */
  safety: "safety",
}

/** Types of data supported by the existing suite-generation preview. */
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
union EvaluationDataGenerationType {
  string,

  /** Generate question-and-answer data. */
  simple_qna: "simple_qna",

  /** Generate data from traces. */
  traces: "traces",

  /** Generate tool-use data. */
  tool_use: "tool_use",

  /** Generate task-based data. */
  task: "task",
}

/** A reference to an existing evaluation dataset. */
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
model EvaluationDatasetReference {
  /** The dataset name. */
  name: string;

  /** The dataset version; the latest version is used when omitted. */
  version?: string;

  /** The schema filename in a folder dataset. */
  schema_file_name?: string;
}

/** A reference to an exact task-set version. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationTaskSetReference {
  /** The task-set name. */
  name: string;

  /** The exact task-set version. */
  version: string;
}

/** A reference to an exact evaluation-suite version. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationSuiteReference {
  /** The evaluation-suite name. */
  name: string;

  /** The exact evaluation-suite version. */
  version: string;
}

/** The supported evaluation-suite aggregation rules. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union EvaluationAggregation {
  string,

  /** A task run passes only when every applicable grader passes. */
  all_pass: "all_pass",
}

/** Evaluation-suite scoring configuration. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationScoringConfiguration {
  /** The rule used to combine applicable grader verdicts. */
  aggregation: EvaluationAggregation.all_pass;
}

/** An immutable version of an evaluation suite. */
@resource("evaluation_suites")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvaluationSuiteVersion {
  /** The suite display name. */
  display_name?: string;

  /** The subtype used by existing suites. */
  subtype?: EvaluationSuiteSubtype;

  /** The dataset used by existing suites. */
  dataset?: EvaluationDatasetReference;

  /** Existing preview grading configuration; not used for task-set-based suites. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Existing preview grader variants remain unchanged."
  testing_criteria?: (
    | OpenAI.EvalGraderLabelModel
    | OpenAI.EvalGraderStringCheck
    | OpenAI.EvalGraderTextSimilarity
    | OpenAI.EvalGraderPython
    | OpenAI.EvalGraderScoreModel
    | TestingCriterionAzureAIEvaluator)[];

  /** The target used by existing suites. */
  target?: FoundryEvaluationTarget;

  /** The message mapping used by existing suites. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Existing preview input-message variants remain unchanged."
  input_messages?:
    | OpenAI.CreateEvalResponsesRunDataSourceInputMessagesTemplate
    | OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  /** The evaluation level used by existing suites. */
  evaluation_level?: EvaluationLevel;

  /** The evaluation-suite name. */
  @visibility(Lifecycle.Read)
  @key
  name: string;

  /** The immutable evaluation-suite version. */
  @visibility(Lifecycle.Read)
  version: string;

  /** The evaluation-suite description. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  description?: string;

  /** The exact task-set version evaluated by an Eval 2.0 suite. Required when using evaluation_runs. */
  task_set?: EvaluationTaskSetReference;

  /** Suite-level graders applied to every task run. */
  graders?: InlineEvaluationGrader[];

  /** The scoring rule applied to task runs. Required when using evaluation_runs. */
  scoring?: EvaluationScoringConfiguration;

  /** User-defined tags. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/** A reference to an exact HarnessTaskSet version. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model HarnessTaskSetReference {
  /** The HarnessTaskSet name. */
  name: string;

  /** The exact HarnessTaskSet version. */
  version: string;
}

/** A published HarnessTaskSet reference or inline tasks for a one-off suite. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
union HarnessTaskSetSource {
  HarnessTaskSetReference,
  InlineHarnessTaskSet,
}

/** A reference to an exact EvalSuite version. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalSuiteReference {
  /** The EvalSuite name. */
  name: string;

  /** The exact EvalSuite version. */
  version: string;
}

/** The MVP rule for combining grader verdicts. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model ScoringRule {
  /** The task passes only when every applicable grader passes. */
  aggregation: EvaluationAggregation.all_pass;
}

/** Shared grading and execution settings for published and inline EvalSuites. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalSuiteDefinition {
  /** Graders applied to every task in the suite. */
  graders?: InlineEvaluationGrader[];

  /** How grader verdicts determine the task-run outcome. */
  scoring: ScoringRule;

  /** The harness and default execution settings. */
  run_config: EvalRunConfig;

  // Future scheduling settings belong to the suite, not an individual EvalRun.
}

/** An immutable version of a reusable evaluation job definition. */
@resource("eval_suites")
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model EvalSuiteVersion {
  ...EvalSuiteDefinition;

  /** The suite name. */
  @visibility(Lifecycle.Read)
  @key
  name: string;

  /** The immutable suite version. */
  @visibility(Lifecycle.Read)
  version: string;

  /** The suite description. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  description?: string;

  /** The exact published HarnessTaskSet version to evaluate. */
  harness_task_set: HarnessTaskSetReference;

  /** User-defined tags. */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/** A complete one-off suite definition that is retained only with the run. */
@extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
model InlineEvalSuite {
  ...EvalSuiteDefinition;

  /** A published HarnessTaskSet version or tasks supplied just for this run. */
  harness_task_set: HarnessTaskSetSource;
}

/** Request to run a suite through the existing evaluation preview. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing preview model name remains stable."
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
model EvaluationSuiteRunRequest {
  /** The created evaluation name. */
  evaluation_name?: string;

  /** The suite version to run; defaults to the latest version. */
  evaluation_suite_version?: string;

  /** The evaluation level used for this run. */
  evaluation_level?: EvaluationLevel;
}

/** One run started through the existing suite preview. */
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
model EvaluationSuiteRunResult {
  /** The created evaluation identifier. */
  eval_id: string;

  /** The created run identifier. */
  run_id: string;

  /** The run execution status. */
  status: JobStatus;

  /** The run creation time in Unix seconds. */
  created_at: FoundryTimestamp;
}

/** Response to a run request on an existing preview suite. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing preview model name remains stable."
@extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
model EvaluationSuiteRunResponse {
  /** The suite name used. */
  evaluation_suite_name: string;

  /** The suite version resolved. */
  evaluation_suite_version: string;

  /** The runs started by the request. */
  results: EvaluationSuiteRunResult[];
}

/** Source types for existing suite-generation jobs. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
union EvaluationSuiteJobSourceType {
  string,

  /** User-provided text. */
  prompt: "prompt",

  /** A Foundry agent. */
  agent: "agent",

  /** Application Insights traces. */
  traces: "traces",

  /** An existing dataset. */
  dataset: "dataset",
}

/** Shared source properties for suite-generation jobs. */
@discriminator("type")
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model EvaluationSuiteJobSource {
  /** The source type. */
  type: EvaluationSuiteJobSourceType;

  ...JobSourceDescription;
}

/** Text source for a suite-generation job. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model PromptEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...PromptJobSource;
}

/** Agent source for a suite-generation job. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model AgentEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...AgentJobSource;
}

/** Trace source for a suite-generation job. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model TracesEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...TracesJobSource;
}

/** Dataset source for a suite-generation job. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model DatasetEvaluationSuiteJobSource extends EvaluationSuiteJobSource {
  ...DatasetJobSource;
}

/** Data-generation settings for the existing suite-generation job. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing preview model name remains stable."
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model EvaluationSuiteDataGenerationOptions {
  /** The generation type; defaults to simple_qna. */
  type?: EvaluationDataGenerationType;

  /** The maximum number of samples. */
  @minValue(15)
  @maxValue(1000)
  max_samples?: int32;
}

/** Caller inputs for a suite-generation job. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model EvaluationSuiteGenerationJobInputs {
  /** The name of the suite to create. */
  evaluation_suite_name: string;

  /** Sources used for data and criteria generation. */
  sources: EvaluationSuiteJobSource[];

  /** The model deployment used for generation. */
  generation_model: string;

  /** The type of criteria to generate. */
  category?: EvaluationSuiteGenerationCategory = EvaluationSuiteGenerationCategory.quality;

  /** Evaluator initialization options. */
  initialization_parameters?: Record<unknown>;

  /** Options for generating data samples. */
  data_generation_options?: EvaluationSuiteDataGenerationOptions;

  /** The target of the generated suite. */
  target?: FoundryEvaluationTarget;

  /** The generated suite message mapping. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Existing preview input-message variants remain unchanged."
  input_messages?:
    | OpenAI.CreateEvalResponsesRunDataSourceInputMessagesTemplate
    | OpenAI.CreateEvalCompletionsRunDataSourceInputMessagesItemReference;

  /** The evaluation level of the generated suite. */
  evaluation_level?: EvaluationLevel;
}

/** Token use for a suite-generation job. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model EvaluationSuiteGenerationTokenUsage {
  /** The number of input tokens. */
  input_tokens?: int64;

  /** The number of output tokens. */
  output_tokens?: int64;

  /** The total number of tokens. */
  total_tokens?: int64;
}

/** An existing preview job that generates an evaluation suite. */
@extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
model EvaluationSuiteGenerationJob is JobLike<
  EvaluationSuiteVersion,
  EvaluationSuiteGenerationJobInputs
> {
  /** The creation time in Unix seconds. */
  @visibility(Lifecycle.Read)
  created_at: FoundryTimestamp;

  /** The completion time in Unix seconds. */
  @visibility(Lifecycle.Read)
  finished_at?: FoundryTimestamp;

  /** Token use on terminal states. */
  @visibility(Lifecycle.Read)
  usage?: EvaluationSuiteGenerationTokenUsage;
}
