import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../common/models.tsp";
import "../main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

@doc("Error information for a data generation job that failed.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DataGenerationJobError {
  @doc("A machine-readable error code.")
  code?: string;

  @doc("A human-readable error message.")
  message?: string;
}

@doc("The supported data generation job types.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union DataGenerationJobType {
  string,

  @doc("Question answers job type")
  QuestionAnswers: "QuestionAnswers",

  @doc("Multiple choice questions job type")
  MultipleChoiceQuestions: "MultipleChoiceQuestions",

  @doc("Question answers with tools job type")
  QuestionAnswersWithTools: "QuestionAnswersWithTools",
}

@doc("The supported output formats for generated data.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union DataGenerationOutputFormat {
  string,

  @doc("Fine-tuning supervised training output format")
  FineTuneSupervised: "FineTuneSupervised",

  @doc("Fine-tuning reinforcement training output format")
  FineTuneReinforcement: "FineTuneReinforcement",

  @doc("Evaluation dataset output format")
  Evaluation: "Evaluation",
}

@doc("Seed data source types.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union DataGenerationSeedDataSourceType {
  string,

  @doc("Seed data comes from a file previously uploaded.")
  file: "file",
}

@doc("A seed data source entry.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DataGenerationSeedDataSource {
  @doc("The seed data source type.")
  type: DataGenerationSeedDataSourceType;

  @doc("The identifier of the file when type is 'file'.")
  file_id: string;
}

@doc("Job options controlling how synthetic data is produced.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DataGenerationJobOptions {
  @doc("Number of synthetic samples to generate.")
  num_samples: int32;

  @doc("Desired output format for generated data.")
  output_format: DataGenerationOutputFormat;

  @doc("Prefix applied to any output file(s) produced.")
  output_file_prefix?: string;

  @doc("Number of conversational turns to simulate (if applicable to the chosen type).")
  num_turns?: int32;
}

@doc("Model generation sampling / configuration options.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DataGenerationModelOptions {
  @doc("Base model name used to generate synthetic data.")
  model: string;

  @doc("Sampling temperature used when generating content.")
  temperature?: float64;

  @doc("Maximum tokens to generate per sample.")
  max_tokens?: int32;
}

@doc("Status values for a data generation job.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
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

@doc("Data Generation Job create parameters.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DataGenerationJobCreateParams {
  @doc("The kind of data generation job to run.")
  type: DataGenerationJobType;

  @doc("Options controlling generation behavior.")
  options: DataGenerationJobOptions;

  @doc("Seed data sources used as input.")
  seed_data_sources: Array<DataGenerationSeedDataSource>;

  @doc("Underlying model configuration.")
  model_options: DataGenerationModelOptions;
}

@doc("Data Generation Job resource.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model DataGenerationJob {
  @doc("The object type, always 'data_generation.job'.")
  object: string = "data_generation.job";

  @doc("The job identifier.")
  id: string;

  @doc("The current status of the job.")
  status: DataGenerationJobStatus;

  @doc("Identifiers of any result files produced after successful completion.")
  result_files?: Array<string>;

  @doc("The kind of data generation job executed.")
  type: DataGenerationJobType;

  @doc("Options used during generation.")
  options: DataGenerationJobOptions;

  @doc("Seed data sources used as input.")
  seed_data_sources: Array<DataGenerationSeedDataSource>;

  @doc("Underlying model configuration.")
  model_options: DataGenerationModelOptions;

  @doc("Error information set only when status is 'failed'.")
  error?: DataGenerationJobError;
}
