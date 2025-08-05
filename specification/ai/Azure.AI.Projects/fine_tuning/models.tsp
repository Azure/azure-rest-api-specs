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

//
// fine-tuning types
//

@doc("The method used for fine-tuning. Abstract base class")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobTrainingMethod {
  @doc("The type of method. Is either supervised, dpo, or reinforcement.")
  type: string;
}

//
// SFT fine-tuning
//

@doc("The hyper parameter settings used in Supervised Fine-Tuning job.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobSFTHyperParameters {
  @doc("Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance.")
  batch_size?: int32;

  @doc("Scaling factor for the learning rate. A smaller learning rate may be useful to avoid overfitting.")
  learning_rate_multiplier?: int32;

  @doc("The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.")
  n_epochs?: int32;
}

@doc("Configuration for the supervised fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobSFTTrainingMethodConfiguration {
  @doc("The hyperparameters used for the SFT fine-tuning job.")
  hyperparameters?: FineTuningJobSFTHyperParameters;
}

@doc("Supervised Fine-Tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobSFTTrainingMethod extends FineTuningJobTrainingMethod {
  type: "supervised";
  
  @doc("Configuration for the supervised fine-tuning method.")
  supervised: FineTuningJobSFTTrainingMethodConfiguration;
}

//
// DPO fine-tuning
//

@doc("The hyper parameter settings used in Direct Preference Optimization fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobDPOHyperParameters { 
  @doc("Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance.")
  batch_size?: int32;

  @doc("The beta value for the DPO method. A higher beta value will increase the weight of the penalty between the policy and reference model.")
  beta?: float64;

  @doc("Scaling factor for the learning rate. A smaller learning rate may be useful to avoid overfitting.")
  learning_rate_multiplier?: float64;

  @doc("The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.")
  n_epochs?: int32;
}

@doc("Configuration for the Direct Preference Optimization fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobDPOTrainingMethodConfiguration {
  @doc("The hyperparameters used for the DPO fine-tuning job.")
  hyperparameters?: FineTuningJobDPOHyperParameters;
}

@doc("Configuration for the Direct Preference Optimization fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobDPOTrainingMethod extends FineTuningJobTrainingMethod {
  type: "dpo";

  @doc("Configuration for the DPO fine-tuning method.")
  dpo: FineTuningJobDPOTrainingMethodConfiguration;
}

//
// RFT fine-tuning
//

// RFT graders

@doc("The grader used for RFT fine-tuning. Abstract base class")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningGrader {
  @doc("The grader type.")
  type: string;
}

@doc("String operations used in RFT string check grader")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FineTuningStringOperation {
  string,

  @doc("Equal operator")
  eq: "eq",

  @doc("Not equal operator")
  ne: "ne",

  @doc("Like operator")
  like: "like",

  @doc("Not like operator")
  ilike: "ilike"
}

@doc("A StringCheckGrader object that performs a string comparison between input and reference using a specified operation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningStringCheckGrader extends FineTuningGrader {
  type: "string_check";

  @doc("The input text. This may include template strings.")
  input: string;

  @doc("The name of the grader.")
  name: string;

  @doc("The string check operation to perform. One of eq, ne, like, or ilike.")
  operation: FineTuningStringOperation;

  @doc("The reference text. This may include template strings.")
  reference: string;
}

@doc("The evaluation metric to use in RFT text similarity grader")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FineTuningEvaluationMetric {
  string,

    @doc("bleu")
    bleu: "bleu",

    @doc("fuzzy_match")
    fuzzy_match: "fuzzy_match",

    @doc("gleu")
    gleu: "gleu",

    @doc("meteor")
    meteor: "meteor",

    @doc("rouge_1")
    rouge_1: "rouge_1",

    @doc("rouge_2")
    rouge_2: "rouge_2",

    @doc("rouge_3")
    rouge_3: "rouge_3",

    @doc("rouge_4")
    rouge_4: "rouge_4",

    @doc("rouge_5")
    rouge_5: "rouge_5",

    @doc("rouge_l")
    rouge_l: "rouge_l",

    @doc("cosine")
    cosine: "cosine"
}

@doc("ScoreModelGrader uses a model to assign a score to the input.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningTextSimilarityGrader extends FineTuningGrader {
  type: "text_similarity";

  @doc("The evaluation metric to use")
  evaluation_metric: FineTuningEvaluationMetric;

  @doc("The text being graded.")
  input: string;

  @doc("The name of the grader.")
  name: string;

  @doc("The text being graded against.")
  reference: string;

  @doc("TBD")
  pass_threshold?: float64;
}

@doc("A PythonGrader object that runs a python script on the input.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningPythonGrader extends FineTuningGrader {
  type: "python";

  @doc("The name of the grader.")
  name: string;

  @doc("The source code of the python script.")
  source: string;

  @doc("The image tag to use for the python script.")
  image_tag?: string;
}

@doc("Training RFT message role options.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FineTuningJobGraderMessageRole {
   string,

   @doc("doc message role")
   user : "user",

   @doc("system message role")
   system : "system",

   @doc("developer message role")
   developer : "developer",

   @doc("assistant message role")
   assistant : "assistant"
}

@doc("Training RFT message content base class.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobGraderMessageContentBase {
}

@doc("Training RFT message content base class.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobGraderMessageTextContent is FineTuningJobGraderMessageContentBase {
   @doc("type field")
   type : string;

   @doc("text field")
   text : string;
}

@doc("Training RFT message content base class.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobGraderMessageSimpleContent is FineTuningJobGraderMessageContentBase {
   @doc("content field")
   content : string;
}

@doc("A ScoreModelGrader object that uses a model to assign a score to the input.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobGraderMessage {
   @doc("Message type")
   type : string;

   @doc("Message role")
   role : FineTuningJobGraderMessageRole;

   @doc("Message content")
   content : FineTuningJobGraderMessageContentBase;
}

@doc("The sampling parameters for the model.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FineTuningJobGraderReasoningEffort {
  string,

  @doc("Low reasoning effort")
  low: "low";

  @doc("Medium reasoning effort")
  medium: "medium";

  @doc("High reasoning effort")
  high: "high";
}

@doc("The sampling parameters for the model.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobGraderModelSamplingParam
{
   @doc("Seed parameter")
   seed?: int32;

   @doc("Temperature parameter")
   temperature? : float64;

   @doc("Max completions tokens parameter")
   max_completions_tokens?: int32;

   @doc("Top parameter")
   top_p? : float64;

   @doc("Reasoning effort parameter")
   reasoning_effort?: FineTuningJobGraderReasoningEffort;
}

@doc("A ScoreModelGrader object that uses a model to assign a score to the input.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningScoreModelGrader extends FineTuningGrader {
  type: "score_model";
  
  //@doc("The input text. This may include template strings.")
  input: Array<FineTuningJobGraderMessage>;

  @doc("The model to use for the evaluation.")
  `model`: string;

  @doc("The name of the grader.")
  name: string;

  @doc("The model to use for the evaluation.")
  range?: Array<float64>;
  
  @doc("The sampling parameters for the model.")
  sampling_params? : FineTuningJobGraderModelSamplingParam;

  @doc("TBD")
  pass_threshold?: float64;
}

@doc("A MultiGrader object combines the output of multiple graders to produce a single score.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningMultiGrader extends FineTuningGrader
{
   type : "multi";

   @doc("A formula to calculate the output based on grader results.")
   calculate_output : string;

   @doc("Graders to be combined")
   graders : Record<FineTuningGrader>;

   @doc("The name of the grader.")
   name : string;
}

@doc("A LabelModelGrader object which uses a model to assign labels to each item in the evaluation.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningLabelModelGrader extends FineTuningGrader
{
   type : "label_model";

   @doc("input labels")
   input : Array<FineTuningJobGraderMessage>;

   @doc("The labels to assign to each item in the evaluation.")
   labels : Array<string>;

   @doc("The model to use for the evaluation. Must support structured outputs.")
  `model`: string;

   @doc("The name of the grader.")
   name : string;

   @doc("The labels that indicate a passing result. Must be a subset of labels.")
   passing_labels : Array<string>;
}

// RFT graders end 

@doc("Configuration for the Reinforcement fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTHyperParameters { 
  @doc("Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance.")
  batch_size?: int32;

  @doc("Multiplier on amount of compute used for exploring search space during training.")
  compute_multiplier?: float64;

  @doc("The number of training steps between evaluation runs.")
  eval_interval?: int32;

  @doc("Number of evaluation samples to generate per training step.")
  eval_samples?: int32;

  @doc("Scaling factor for the learning rate. A smaller learning rate may be useful to avoid overfitting.")
  learning_rate_multiplier?: float64;

  @doc("The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset.")
  n_epochs?: int32;

  @doc("Level of reasoning effort.")
  reasoning_effort?: string;
}

@doc("Gets the response format for the Reinforcement fine-tuning method.")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTResponseFormat {
  @doc("Response format request - Currently only JSON schema is supported")
  type: string;
}

@doc("Gets the response format for the Reinforcement fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTResponseJsonSchema extends FineTuningJobRFTResponseFormat {
  type: "json_schema";

  @doc("JSON schema response for RFT")
  json_schema: Record<unknown>
}

@doc("Configuration for the reinforcement fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTTrainingMethodConfiguration { 
  @doc("The grader used for the fine-tuning job.")
  grader: FineTuningGrader;

  @doc("The hyperparameters used for the reinforcement fine-tuning job.")
  hyperparameters?: FineTuningJobRFTHyperParameters;

  @doc("Gets the response format for the Reinforcement fine-tuning job.")
  response_format?: FineTuningJobRFTResponseFormat;
}

@doc("Configuration for the Reinforcement fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTTrainingMethod extends FineTuningJobTrainingMethod {
  type: "reinforcement";

  @doc("Configuration for the reinforcement fine-tuning method.")
  reinforcement: FineTuningJobRFTTrainingMethodConfiguration;
}

//////////////////

@doc("For fine-tuning jobs that have failed, this will contain more information on the cause of the failure.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobError {
  @doc("A machine-readable error code.")
  code?: string;

  @doc("A human-readable error message.")
  message?: string;

  @doc("The parameter that was invalid, usually training_file or validation_file. This field will be null if the failure was not parameter-specific.")
  param?: string;
}

//
// Fine-tuning integration with W&B
//

@doc("The settings for your integration with Weights and Biases. This payload specifies the project that metrics will be sent to. Optionally, you can set an explicit display name for your run, add tags to your run, and set a default entity (team, username, etc) to be associated with your run.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobIntegrationWeightsAndBiases {
  @doc("The name of the project that the new run will be created under.")
  project: string;

  @doc("The entity to use for the run. This allows you to set the team or username of the WandB user that you would like associated with the run. If not set, the default entity for the registered WandB API key is used.")
  entity?: string;

  @doc("A display name to set for the run. If not set, we will use the Job ID as the name.")
  name?: string;

  @doc("A list of tags to be attached to the newly created run. These tags are passed through directly to WandB. Some default tags are generated by OpenAI: 'openai/finetune', 'openai/{base-model}', 'openai/{ftjob}.")
  tags?: Array<string>;
}

@doc("Integration to enable for fine-tuning job.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobIntegration {
  @doc("The type of integration to enable. Currently, only 'wandb' (Weights and Biases) is supported.")
  type: string;

  @doc("The settings for your integration with Weights and Biases. This payload specifies the project that metrics will be sent to. Optionally, you can set an explicit display name for your run, add tags to your run, and set a default entity (team, username, etc) to be associated with your run.")
  wandb: FineTuningJobIntegrationWeightsAndBiases;
}

// Fine-tuning integration with W&B ends

//
// Fine-Tuning job
//

@doc("Fine-Tuning Job")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJob {
  @doc("The job identifier.")
  id: string;

  @doc("The object type, which is always 'fine_tuning.job'.")
  object: string = "fine_tuning.job";

  @doc("The time when the fine-tuning job was created.")
  created_at: utcDateTime;

  @doc("For fine-tuning jobs that have failed, this will contain more information on the cause of the failure.")
  error?: FineTuningJobError;

  @doc("The time when the fine-tuning job is estimated to finish. The value will be null if the fine-tuning job is not running.")
  estimated_finish?: utcDateTime;

  @doc("The name of the fine-tuned model that is being created. The value will be null if the fine-tuning job is still running.")
  fine_tuned_model?: string;

  @doc("The time when the fine-tuning job was finished. The value will be null if the fine-tuning job is still running.")
  finished_at?: utcDateTime;

  @doc("The hyperparameters used for the fine-tuning job. This value will only be returned when running supervised jobs")
  hyperparameters? : FineTuningJobSFTHyperParameters;

  @doc("A list of integrations to enable for this fine-tuning job.")
  integrations?: Array<FineTuningJobIntegration>;

  /**
  * Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format, and querying for objects via API or the dashboard.
  *
  * Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  metadata?: Record<string>;

  @doc("The method used for fine-tuning.")
  method: FineTuningJobTrainingMethod;

  @doc("The base model that is being fine-tuned.")
  `model`: string;

  @doc("The organization that owns the fine-tuning job.")
  organization_id : string;

  @doc("The compiled results file ID(s) for the fine-tuning job. The file is only available for successfully completed fine-tune runs.")
  result_files?: Array<string>;

  @doc("The seed used for the fine-tuning job.")
  seed: int32;

  @doc("The current status of the fine-tuning job, which can be either validating_files, queued, running, succeeded, failed, or cancelled.")
  status: string;

  @doc("The total number of billable tokens processed by this fine-tuning job. The value will be null if the fine-tuning job is still running.")
  trained_tokens?: int32;

  @doc("The file ID used for training. You can retrieve the training data with the Files API.")
  training_file: string;

  @doc("The file ID used for validation. You can retrieve the validation results with the Files API.")
  validation_file?: string;

  @doc("The additional 1P parameters used to train the fine-tuned model. This is Azure AI specific parameter.")
  additional_Parameters? : Record<string>;

  @doc("A string of up to 64 characters that will be added to your fine-tuned model name.")
  suffix? : string;

  @doc("The SKU used for training. This is Azure AI specific parameter")
  TrainingType? : TrainingType;

  @doc("Inference configurations. This is Azure AI specific parameter")
  inference_configs? : InferenceConfigs;
}

@doc("SKU available for training")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union TrainingType {
  string,

  @doc("Standard training job uses dedicated training capacity in a region")
  Standard: "Standard",

  @doc("GlobalStandard training job uses dedicated capacity from a different region")
  GlobalStandard: "GlobalStandard",

  @doc("DeveloperTier training job uses inference capacity when available")
  DeveloperTier: "DeveloperTier"
}

@doc("SKU available for training")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union InferenceSku {
  string,

  @doc("DeveloperTier refers to a cross-region developer inference sku.")
  DeveloperTier: "DeveloperTier",

  @doc("Standard refers to regional pay-go inference sku.")
  Standard: "Standard",

  @doc("Global Standard refers to a cross-region pay-go inference sku.")
  GlobalStandard: "GlobalStandard"
}

@doc("Inference configurations")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model InferenceConfigs {
  @doc("Is model deployed after tuning completes")
  auto_inference_enabled?: boolean,

  @doc("SKU used for inference")
  inference_sku?: InferenceSku,

  @doc("Deployment identifier")
  auto_deployment_id?: string,

  @doc("Deployment status")
  auto_deployment_status?: string,

  @doc("Deployment error information")
  auto_deployment_error_message?: string
}

//
// Fine-Tuning job definition for create
//

@doc("Fine-Tuning Job")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobCreation {
  @doc("The base model that is being fine-tuned.")
  `model`: string;

  @doc("The file ID used for training. You can retrieve the training data with the Files API.")
  training_file: string;

  @doc("The hyperparameters used for the SFT fine-tuning job. This value is now deprecated in favor of method, and should be passed in under the method parameter.")
  hyperparameters?: FineTuningJobSFTHyperParameters;

  @doc("A list of integrations to enable for this fine-tuning job.")
  integrations?: Array<FineTuningJobIntegration>;

  /**
  * Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format, and querying for objects via API or the dashboard.
  *
  * Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
  */
  metadata?: Record<string>;

  @doc("The method used for fine-tuning.")
  method: FineTuningJobTrainingMethod;

  @doc("The seed used for the fine-tuning job.")
  seed: int32;

  @doc("A string of up to 64 characters that will be added to your fine-tuned model name.")
  suffix?: string;

  @doc("The file ID used for validation. You can retrieve the validation results with the Files API.")
  validation_file?: string;

  @doc("The SKU used for training. This is Azure AI specific parameter")
  TrainingType? : TrainingType;

  @doc("Inference configurations. This is Azure AI specific parameter")
  inference_configs? : InferenceConfigs;
}

@doc("The response data for a requested list of items.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningPaginatedResponse<T> {
  @doc("Response type")
  object : string = "list";

  @doc("Items list.")
  @pageItems
  data: Array<T>;

  @doc("A value indicating whether there are additional values available.")
  has_more: boolean;
}

@doc("Fine-tuning job event object.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobEvent {
  @doc("The object type, which is always fine_tuning.job.event")
  object : string = "fine_tuning.job.event";

  @doc("The time when the fine-tuning event was created.")
  created_at: utcDateTime;

  @doc("The data associated with the event.")
  #suppress "@azure-tools/typespec-azure-core/no-unknown"
  data: unknown;

  @doc("The object identifier.")
  id : string;

  @doc("The log level of the event.")
  level : string;

  @doc("The message of the event.")
  message : string;

  @doc("The type of event.")
  type : string;
}

@doc("Metrics at the step number during the fine-tuning job.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobCheckpointMetric {
  @doc("metric full validation loss")
  full_valid_loss : float64;

  @doc("metric full valid mean token accuracy")
  full_valid_mean_token_accuracy : float64;

  @doc("metric step")
  step : float64;

  @doc("metric train loss")
  train_loss : float64;

  @doc("metric train mean token accuracy")
  train_mean_token_accuracy : float64;

  @doc("metric valid loss")
  valid_loss : float64;

  @doc("metric valid mean token accuracy")
  valid_mean_token_accuracy : float64;
}

@doc("The fine_tuning.job.checkpoint object represents a model checkpoint for a fine-tuning job that is ready to use.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobCheckpoint {
  @doc("The object type, which is always fine_tuning.job.checkpoint")
  object : string = "fine_tuning.job.checkpoint";

  @doc("The time when the fine-tuning checkpoint was created.")
  created_at: utcDateTime;

  @doc("The name of the fine-tuned checkpoint model that is created.")
  fine_tuned_model_checkpoint : string;

  @doc("The name of the fine-tuning job that this checkpoint was created from.")
  fine_tuning_job_id : string;

  @doc("The checkpoint identifier, which can be referenced in the API endpoints.")
  id : string;

  @doc("Metrics at the step number during the fine-tuning job.")
  metrics : FineTuningJobCheckpointMetric;

  @doc("The step number that the checkpoint was created at.")
  step_number : int32;
}
