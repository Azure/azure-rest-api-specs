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
model FineTuningJobRFTGrader {
  @doc("The grader type.")
  type: string;
}

@doc("String operations used in RFT string check grader")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FineTuningJobRFTStringCheckGraderOperation {
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
model FineTuningJobRFTStringCheckGrader extends FineTuningJobRFTGrader {
  type: "string_check";

  @doc("The input text. This may include template strings.")
  input: string;

  @doc("The name of the grader.")
  name: string;

  @doc("The string check operation to perform. One of eq, ne, like, or ilike.")
  operation: FineTuningJobRFTStringCheckGraderOperation;

  @doc("The reference text. This may include template strings.")
  reference: string;
}

@doc("The evaluation metric to use in RFT text similarity grader")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
union FineTuningJobRFTTextSimilarityGraderEvaluationMetric {
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
model FineTuningJobRFTTextSimilarityGrader extends FineTuningJobRFTGrader {
  type: "text_similarity";

  @doc("The evaluation metric to use")
  evaluation_metric: FineTuningJobRFTTextSimilarityGraderEvaluationMetric;

  @doc("The text being graded.")
  input: string;

  @doc("The name of the grader.")
  name: string;

  @doc("The text being graded against.")
  reference: string;

  @doc("TBD")
  pass_threshold?: float64;
}

@doc("TextSimilarityGrader grades text based on similarity metrics.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTScoreModelGrader extends FineTuningJobRFTGrader {
  type: "score_model";
  
  //@doc("The input text. This may include template strings.")
  //input: Array<FineTuningJobModelGraderMessage>;

  @doc("The name of the grader.")
  name: string;

  @doc("The model to use for the evaluation.")
  `model`: string;

  @doc("The model to use for the evaluation.")
  range: Array<float64>;
  
  // TBD: sampling_params

  @doc("TBD")
  passThreshold?: float64;
}

@doc("ScoreModelGrader uses a model to assign a score to the input.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTLabelModelGraderGrader extends FineTuningJobRFTGrader {
  type: "label_model";

  @doc("The name of the grader.")
  name: string;

  @doc("The model to use for the evaluation. Must support structured outputs.")
  `model`: string;

  //@doc("The text being graded.")
  //input: string;

  //@doc("The text being graded against.")
  //labels: string;
  
  //passing_labels

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
  grader: FineTuningJobRFTGrader;

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
@resource("jobs")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJob {
  @doc("The job identifier.")
  @key("id")
  @encodedName("application/json", "id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The object type, which is always 'fine_tuning.job'. Parity with OAI SDK")
  object: string;

  @doc("The Unix timestamp (in seconds) for when the fine-tuning job was created.")
  created_at: utcDateTime;

  @doc("The current status of the fine-tuning job, which can be either validating_files, queued, running, succeeded, failed, or cancelled.")
  status: string;

  @doc("The file ID used for training. You can retrieve the training data with the Files API.")
  training_file: string;

  @doc("The file ID used for validation. You can retrieve the validation results with the Files API.")
  validation_file?: string;

  @doc("The Unix timestamp (in seconds) for when the fine-tuning job is estimated to finish. The value will be null if the fine-tuning job is not running.")
  estimated_finish?: utcDateTime;

  @doc("The Unix timestamp (in seconds) for when the fine-tuning job was finished. The value will be null if the fine-tuning job is still running.")
  finished_at?: utcDateTime;

  @doc("The name of the fine-tuned model that is being created. The value will be null if the fine-tuning job is still running.")
  fine_tuned_model?: string;

  @doc("The base model that is being fine-tuned.")
  `model`: string;

  @doc("The base model provider.")
  modelProvider?: string;

  @doc("The seed used for the fine-tuning job.")
  seed: int32;

  @doc("The total number of billable tokens processed by this fine-tuning job. The value will be null if the fine-tuning job is still running.")
  trained_tokens?: int32;

  @doc("The method used for fine-tuning.")
  method: FineTuningJobTrainingMethod;

  @doc("The compiled results file ID(s) for the fine-tuning job. The file is only available for successfully completed fine-tune runs.")
  result_files?: Array<string>;

  @doc("A list of integrations to enable for this fine-tuning job.")
  integrations?: Array<FineTuningJobIntegration>;

  @doc("For fine-tuning jobs that have failed, this will contain more information on the cause of the failure.")
  error?: FineTuningJobError
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
