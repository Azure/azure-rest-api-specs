import "../common/models.tsp";

using Azure.Core.Experimental;

namespace Azure.AI.Projects;

@doc("Error information for a data generation job that failed.")
model DataGenerationJobError {
  @doc("A machine-readable error code.")
  code?: string;

  @doc("A human-readable error message.")
  message?: string;
}

@doc("The supported data generation job types.")
union DataGenerationJobType {
  string,

  @doc("SimpleQnA job type")
  SimpleQnA: "SimpleQnA",

  @doc("Tool use job type")
  ToolUse: "ToolUse",

  @doc("Multi turn Question and Answer generation job type")
  MultiTurnQnA: "MultiTurnQnA",
}

@doc("Model generation sampling / configuration options.")
model DataGenerationModelOptions {
  @doc("Base model deployment name used to generate synthetic data.")
  `model`: string;
}

@doc("Status values for a data generation job.")
union DataGenerationJobStatus {
  string,

  @doc("Job has been queued and is waiting to start.")
  queued: "queued",

  @doc("Job is currently running.")
  running: "running",

  @doc("Job completed successfully.")
  succeeded: "succeeded",

  @doc("Job failed.")
  failed: "failed",
}

@doc("Data Generation Job resource.")
@discriminator("type")
model DataGenerationJob {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The job identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The current status of the job.")
  @visibility(Lifecycle.Read)
  status: DataGenerationJobStatus;

  @doc("The name of the output dataset to create. If not specified, a default name will be generated. If dataset with the same name already exists then tries to create a new version of the dataset with the generated data.")
  output_dataset_name?: string;

  @doc("Identifier of the output dataset produced after successful completion. This will be in format of in the format of 'azureai://accounts/<account-name>/projects/<project-name>/data/<dataset-name>/versions/<version-no>'")
  @visibility(Lifecycle.Read)
  output_dataset_id?: string;

  @doc("The kind of data generation job executed.")
  type: DataGenerationJobType;

  @doc("The purpose of the data generation job. Either for fine-tuning supervised training or evaluation.")
  purpose: DataGenerationJobPurpose;

  @doc("Maximum number of synthetic samples to generate.")
  max_samples_count: int32;

  @doc("The number of synthetic samples actually generated. This field will be populated only after the job is completed.")
  @visibility(Lifecycle.Read)
  generated_samples_count?: int32;

  @doc("The token usage information for the data generation job.")
  @visibility(Lifecycle.Read)
  token_usage?: TokenUsage;

  @doc("The timestamp when the job was created, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  created_at: int64;

  @doc("The timestamp when the job was completed, represented in Unix time (seconds since January 1, 1970).")
  @visibility(Lifecycle.Read)
  completed_at?: int64;

  @doc("Error information set only when status is 'failed'.")
  @visibility(Lifecycle.Read)
  error?: DataGenerationJobError;

  @doc("Additional warnings related to the data generation job execution. These are non-critical issues that do not cause the job to fail but may be important for users to be aware of.")
  @visibility(Lifecycle.Read)
  warnings?: {
    @doc("A human-readable warning message.")
    message?: string;
  };
}

@doc("Token usage information for a data generation job.")
model TokenUsage {
  @doc("Number of input tokens used.")
  @visibility(Lifecycle.Read)
  input_tokens?: int32;

  @doc("Number of output tokens used.")
  @visibility(Lifecycle.Read)
  output_tokens?: int32;

  @doc("Total number of tokens used.")
  @visibility(Lifecycle.Read)
  total_tokens?: int32;
}

@doc("The supported purposes for a data generation job.")
union DataGenerationJobPurpose {
  string,

  @doc("Fine-tuning supervised training purpose.")
  SupervisedFineTuning: "SupervisedFineTuning",

  @doc("Reinforcement learning fine-tuning training purpose.")
  ReinforcementFineTuning: "ReinforcementFineTuning",

  @doc("Evaluation purpose.")
  Evaluation: "Evaluation",
}

@doc("The supported data source types for a data generation job.")
union DataGenerationJobDataSourceType {
  string,

  @doc("Traces Datasource type. Data is generated based on input traces such as conversations, tool calls, etc. ")
  Traces: "Traces",

  @doc("Prompt Datasource type. Data is generated based on input prompts provided by the user or will be extracted from the given Agent. Applicable only for evaluation purpose.")
  Prompt: "Prompt",

  @doc("Seed data files datasource type. Data is generated based on input seed data files from the given input datasets. Applicable only for fine-tuning training purpose.")
  SeedDataFiles: "SeedDataFiles",

  @doc("Datasource type that combines prompts and seed data files. Data is generated based on both input prompts and seed data files. Applicable only for evaluation purpose.")
  PromptAndSeedDataFiles: "PromptAndSeedDataFiles",
}

@doc("A data generation job of type SimpleQnA which generates simple question and answer pairs based on the specified datasource type.")
@discriminator("datasourceType")
model SimpleQnADataGenerationJob extends DataGenerationJob {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The datasource type for this job.")
  datasourceType: DataGenerationJobDataSourceType;
}

@doc("A data generation job of type SimpleQnA with Prompt datasource used for evaluation.")
model SimpleQnAPromptEvaluationDataGenerationJob
  extends SimpleQnADataGenerationJob {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The datasource type for this job, which is Prompt.")
  datasourceType: "Prompt";

  @doc("The purpose of the data generation job. For this type of job, the purpose is always evaluation.")
  purpose: "Evaluation";

  @doc("The options for a SimpleQnA data generation job with Prompt datasource used for evaluation.")
  options: SimpleQnAPromptEvaluationDataGenerationJobOptions;

  @doc("The model deployment options. Only models which support Responses API can be used for this type of job.")
  model_options: DataGenerationModelOptions;
}

@doc("A data generation job of type SimpleQnA with Prompt and Seed Data Files datasource used for evaluation.")
model SimpleQnAPromptAndSeedDataFilesEvaluationDataGenerationJob
  extends SimpleQnADataGenerationJob {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The datasource type for this job, which is a combination of prompts and seed data files.")
  datasourceType: "PromptAndSeedDataFiles";

  @doc("The purpose of the data generation job. For this type of job, the purpose is always evaluation.")
  purpose: "Evaluation";

  @doc("The options for a SimpleQnA data generation job with Prompt and Seed Data Files datasource used for evaluation.")
  options: SimpleQnAPromptAndSeedDataFilesEvaluationDataGenerationJobOptions;

  @doc("The model deployment options. Only models which support Responses API can be used for this type of job.")
  model_options: DataGenerationModelOptions;
}

@doc("A data generation job of type SimpleQnA with Prompt datasource used for evaluation.")
model SimpleQnAPromptEvaluationDataGenerationJobOptions {
  @doc("The prompt used for data generation. Required if agent id is not specified.")
  prompt?: string;

  @doc("The agent id to fetch the prompt and other metadata for data generation. The agent id should be in format of '<agentid>:<version>'")
  agent_id?: string;
}

@doc("A data generation job of type SimpleQnA with Prompt and Seed Data Files datasource used for evaluation.")
model SimpleQnAPromptAndSeedDataFilesEvaluationDataGenerationJobOptions
  extends SimpleQnAPromptEvaluationDataGenerationJobOptions {
  @doc("Input seed dataset references used for data generation. The dataset should already exist before creating the job.")
  seed_datasets: Array<string>;
}

@doc("A data generation job of type SimpleQnA with SeedDataFiles datasource used for supervised fine-tuning training.")
model SimpleQnASeedDataFilesSupervisedFineTuningDataGenerationJob
  extends SimpleQnADataGenerationJob {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The datasource type for this job, which is SeedDataFiles.")
  datasourceType: "SeedDataFiles";

  @doc("The purpose of the data generation job. For this type of job, the purpose is always supervised fine-tuning.")
  purpose: "SupervisedFineTuning";

  @doc("The options for a SimpleQnA data generation job with SeedDataFiles datasource used for supervised fine-tuning training.")
  options: SimpleQnASeedDataFilesSupervisedFineTuningDataGenerationJobOptions;
}

@doc("A data generation job of type SimpleQnA with SeedDataFiles datasource used for supervised fine-tuning training.")
model SimpleQnASeedDataFilesSupervisedFineTuningDataGenerationJobOptions {
  @doc("Input seed dataset references used for data generation. The dataset should already exist before creating the job.")
  seed_datasets: Array<string>;

  @doc("The model deployment options.")
  model_options: DataGenerationModelOptions;

  @doc("The question types to generate. If not specified, both short answer and long answer question types will be generated. Applicable only for simple QnA data generation jobs.")
  question_types?: Array<SimpleQnASupervisedFineTuningQuestionType>;

  @doc("The proportion of the generated data to use for training vs validation. Should be a value between 0 and 1, where a value of 0.8 means 80% of the generated data will be used for training and 20% will be used for validation. Applicable only when format is 'SupervisedFineTuning'.")
  train_split?: float32;
}

@doc("The supported question types for SimpleQnA data generation jobs used for supervised fine-tuning training.")
union SimpleQnASupervisedFineTuningQuestionType {
  string,

  @doc("Short answer question type.")
  ShortAnswer: "ShortAnswer",

  @doc("Long answer question type.")
  LongAnswer: "LongAnswer",
}

@doc("A data generation job of type SimpleQnA with Traces datasource used for evaluation or fine-tuning training based on the specified purpose.")
model SimpleQnATracesDataGenerationJob extends SimpleQnADataGenerationJob {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The datasource type for this job, which is Traces.")
  datasourceType: "Traces";

  @doc("The options for a SimpleQnA data generation job with Traces datasource.")
  options: TracesDataGenerationJobOptions;
}

@doc("The options for a data generation job with Traces datasource, which includes the agent id and the time window for fetching traces.")
model TracesDataGenerationJobOptions {
  @doc("The agent id to fetch the traces for data generation. The agent id should be in format of '<agentid>:<version>'")
  agent_id: string;

  @doc("The start of the time window for fetching traces. This defines the beginning of the time range for which traces will be considered for data generation.")
  from_time: utcDateTime;

  @doc("The end of the time window for fetching traces. This defines the end of the time range for which traces will be considered for data generation. If not specified, it will default to the current time, meaning that traces up until now will be considered for data generation.")
  to_time?: utcDateTime;
}

@doc("A data generation job of type MultiTurnQnA used for generating multi-turn question and answer pairs.")
model MultiTurnQnADataGenerationJob extends DataGenerationJob {
  type: "MultiTurnQnA";
  datasourceType: DataGenerationJobDataSourceType;
}

@doc("A data generation job of type MultiTurnQnA with Traces datasource used for evaluation or fine-tuning training based on the specified purpose.")
model MultiTurnQnATracesDataGenerationJob
  extends MultiTurnQnADataGenerationJob {
  @doc("The data generation job type, which is MultiTurnQnA for this model.")
  type: "MultiTurnQnA";

  @doc("The datasource type for this job, which is Traces.")
  datasourceType: "Traces";

  @doc("The options for a MultiTurnQnA data generation job with Traces datasource.")
  options: TracesDataGenerationJobOptions;
}

@doc("A data generation job of type ToolUse used for generating tool use data for fine-tuning supervised training.")
model ToolUseFineTuningDataGenerationJob extends DataGenerationJob {
  @doc("The data generation job type, which is ToolUse for this model.")
  type: "ToolUse";

  @doc("The datasource type for this job, which is SupervisedFineTuning.")
  purpose: "SupervisedFineTuning";

  @doc("The options for a ToolUse data generation job used for fine-tuning supervised training.")
  options: ToolUseFineTuningDataGenerationJobOptions;

  @doc("The model deployment options.")
  model_options: DataGenerationModelOptions;
}

@doc("The options for a ToolUse data generation job used for fine-tuning supervised training.")
model ToolUseFineTuningDataGenerationJobOptions {
  @doc("The input dataset references used for data generation. The dataset should already exist before creating the job.")
  seed_datasets: Array<string>;
}
