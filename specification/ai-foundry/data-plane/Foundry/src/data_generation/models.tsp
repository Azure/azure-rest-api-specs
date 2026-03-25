import "../common/models.tsp";

namespace Azure.AI.Projects;

@doc("The supported data generation job types.")
union DataGenerationJobType {
  string,

  @doc("Simple question and answer between user and agent job type")
  SimpleQnA: "SimpleQnA",

  @doc("Tool use job type")
  ToolUse: "ToolUse",

  @doc("Multi turn conversation between agents and user.")
  MultiTurn: "MultiTurn",
}

@doc("LLM model options for data generation jobs.")
model DataGenerationModelOptions {
  @doc("Base model name used to generate data.")
  model_name: string;
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

  @doc("Job was cancelled.")
  cancelled: "cancelled",
}

@doc("Data Generation Job resource.")
model DataGenerationJob {
  @doc("The display name of the data generation job.")
  name: string;

  @doc("The data source used for the data generation job.")
  data_source: DataGenerationJobDataSource;

  @doc("The options for the data generation job.")
  options: DataGenerationJobOptions;

  @doc("The purpose of the data generation job. Either for fine-tuning supervised training or evaluation.")
  purpose: DataGenerationJobPurpose;

  @doc("The job identifier.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The current status of the job.")
  @visibility(Lifecycle.Read)
  status: DataGenerationJobStatus;

  @doc("The name of the output dataset to create. If not specified, a default name will be generated. If a dataset with the same name already exists, a new version of the dataset will be created with the generated data.")
  output_dataset_name?: string;

  @doc("Identifier of the output dataset produced after successful completion. This will be in the format of 'azureai://accounts/<account-name>/projects/<project-name>/data/<dataset-name>/versions/<version-no>'")
  @visibility(Lifecycle.Read)
  output_dataset_id?: string;

  @doc("The number of samples actually generated. This field will be populated only after the job is completed.")
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
  error?: ApiError;

  @doc("Additional warnings related to the data generation job execution. These are non-critical issues that do not cause the job to fail but may be important for users to be aware of.")
  @visibility(Lifecycle.Read)
  warnings?: {
    @doc("A human-readable warning message.")
    message?: string;
  };
}

@doc("Token usage information for a data generation job.")
model TokenUsage {
  @doc("The number of prompt tokens used.")
  @visibility(Lifecycle.Read)
  prompt_tokens?: int32;

  @doc("The number of completion tokens generated.")
  @visibility(Lifecycle.Read)
  completion_tokens?: int32;

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

@doc("Options for managing data generation jobs.")
@discriminator("type")
model DataGenerationJobOptions {
  @doc("The data generation job type.")
  type: DataGenerationJobType;

  @doc("Maximum number of samples to generate.")
  max_samples_count: int32;

  @doc("The model deployment options. Required only when the data source type is not Traces.")
  model_options?: DataGenerationModelOptions;
}

@doc("The options for a data generation job with SimpleQnA type.")
model SimpleQnADataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is SimpleQnA for this model.")
  type: "SimpleQnA";

  @doc("The question types to generate. If not specified, both short answer and long answer question types will be generated. Applicable only for simple QnA data generation jobs used for supervised fine-tuning training.")
  question_types?: Array<SimpleQnASupervisedFineTuningQuestionType>;
}

@doc("The options for ToolUse data generation job used for fine-tuning supervised training.")
model ToolUseFineTuningDataGenerationJobOptions
  extends DataGenerationJobOptions {
  @doc("The data generation job type, which is ToolUse for this model.")
  type: "ToolUse";
}

@doc("The options for a data generation job with MultiTurn type.")
model MultiTurnDataGenerationJobOptions extends DataGenerationJobOptions {
  @doc("The data generation job type, which is MultiTurn for this model.")
  type: "MultiTurn";
}

@doc("The base data source model for a data generation job.")
@discriminator("type")
model DataGenerationJobDataSource {
  @doc("The type of the data source.")
  type: DataGenerationJobDataSourceType;
}

@doc("The options for a data generation job with Traces datasource used for Evaluation and fine-tuning purposes, which includes the agent name and the time window for fetching traces.")
model TracesDataGenerationJobDataSource extends DataGenerationJobDataSource {
  @doc("The data source type for this job, which is Traces.")
  type: "Traces";

  @doc("The agent name to fetch the traces for data generation. The traces will be fetched based on the agent name from the project connected Application Insights within the specified time window. If both agent name and agent version are specified, the agent version will be used to fetch the traces.")
  agent_name: string;

  @doc("The agent version to fetch the traces for data generation. If not specified, the latest version of the agent will be used.")
  agent_version?: string;

  @doc("The start of the time window for fetching traces. This defines the beginning of the time range for which traces will be considered for data generation.")
  from_time: utcDateTime;

  @doc("The end of the time window for fetching traces. This defines the end of the time range for which traces will be considered for data generation. If not specified, it will default to the current time, meaning that traces up until now will be considered for data generation.")
  to_time?: utcDateTime;
}

@doc("The options for a data generation job with Prompt datasource used for Evaluation purpose, which includes the prompt or the agent name to fetch the prompt and other metadata for data generation.")
model PromptDataGenerationJobDataSource extends DataGenerationJobDataSource {
  @doc("The data source type for this job, which is Prompt.")
  type: "Prompt";

  @doc("The prompt used for data generation. Required if agent name is not specified.")
  prompt?: string;

  @doc("The agent name to fetch the traces for data generation. The traces will be fetched based on the agent name from the project connected Application Insights within the specified time window. If both agent name and agent version are specified, the agent version will be used to fetch the traces.")
  agent_name: string;

  @doc("The agent version to fetch the traces for data generation. If not specified, the latest version of the agent will be used.")
  agent_version?: string;
}

@doc("The options for a data generation job with SeedDataFiles datasource used for fine-tuning supervised training, which includes the input seed datasets for data generation.")
model SeedDataFilesDataGenerationJobDataSource
  extends DataGenerationJobDataSource {
  @doc("The data source type for this job, which is SeedDataFiles.")
  type: "SeedDataFiles";

  @doc("Input seed dataset references used for data generation. The dataset should already exist before creating the job.")
  seed_datasets: Array<string>;
}

@doc("The options for a data generation job with Prompt and Seed Data Files datasource used for Evaluation purpose, which includes the prompt, the input seed datasets and the agent name to fetch the prompt and other metadata for data generation.")
model PromptAndSeedDataFilesDataGenerationJobDataSource
  extends DataGenerationJobDataSource {
  @doc("The data source type for this job, which is a combination of prompts and seed data files.")
  type: "PromptAndSeedDataFiles";

  @doc("The prompt used for data generation. Required if agent name is not specified.")
  prompt?: string;

  @doc("The agent name to fetch the traces for data generation. The traces will be fetched based on the agent name from the project connected Application Insights within the specified time window. If both agent name and agent version are specified, the agent version will be used to fetch the traces.")
  agent_name: string;

  @doc("The agent version to fetch the traces for data generation. If not specified, the latest version of the agent will be used.")
  agent_version?: string;

  @doc("Input seed dataset references used for data generation. The dataset should already exist before creating the job.")
  seed_datasets: Array<string>;
}

@doc("The supported question types for SimpleQnA data generation jobs used for supervised fine-tuning training.")
union SimpleQnASupervisedFineTuningQuestionType {
  string,

  @doc("Short answer question type.")
  ShortAnswer: "ShortAnswer",

  @doc("Long answer question type.")
  LongAnswer: "LongAnswer",
}
