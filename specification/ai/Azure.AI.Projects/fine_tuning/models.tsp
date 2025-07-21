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
  
  @doc("Other parameters used for training the model.")
  additionalParameters?: Record<string>;
}

@doc("Configuration for the Supervised Fine-Tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobSFTTrainingMethod extends FineTuningJobTrainingMethod {
  type: "supervised";
  
  @doc("The hyperparameters used for the DPO fine-tuning job.")
  hyperparameters?: FineTuningJobSFTHyperParameters;
}

//
// DPO fine-tuning
//

@doc("Configuration for the Direct Preference Optimization fine-tuning method.")
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
  
  @doc("Other parameters used for training the model.")
  additionalParameters?: Record<string>;
}

@doc("Configuration for the Direct Preference Optimization fine-tuning method.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobDPOTrainingMethod extends FineTuningJobTrainingMethod {
  type: "dpo";

  @doc("The hyperparameters used for the DPO fine-tuning job.")
  hyperparameters?: FineTuningJobDPOHyperParameters;
}

//
// RFT fine-tuning
//

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

  @doc("Other parameters used for training the model.")
  additionalParameters?: Record<string>;
}

// RFT graders

@doc("The grader used for RFT fine-tuning. Abstract base class")
@discriminator("type")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTGrader {
  @doc("The grader type.")
  type: string;
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
  operation: string;

  @doc("The reference text. This may include template strings.")
  reference: string;
}

@doc("ScoreModelGrader uses a model to assign a score to the input.")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobRFTTextSimilarityGrader extends FineTuningJobRFTGrader {
  type: "text_similarity";

  @doc("The name of the grader.")
  name: string;

  @doc("The text being graded.")
  input: string;

  @doc("The text being graded against.")
  reference: string;

  @doc("TBD")
  passThreshold?: float64;
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
model FineTuningJobRFTTrainingMethod extends FineTuningJobTrainingMethod {
  type: "reinforcement";
  
  @doc("The grader used for the fine-tuning job.")
  grader: FineTuningJobRFTGrader;

  @doc("The hyperparameters used for the reinforcement fine-tuning job.")
  hyperparameters?: FineTuningJobRFTHyperParameters;
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

//
// Fine-Tuning job definition for create
//

@doc("Fine-Tuning Job")
@added(Versions.v2025_05_15_preview)
@removed(Versions.v1)
model FineTuningJobCreate {
  @doc("The file ID used for training. You can retrieve the training data with the Files API.")
  training_file: string;

  @doc("The file ID used for validation. You can retrieve the validation results with the Files API.")
  validation_file?: string;

  @doc("The base model that is being fine-tuned.")
  `model`: string;

  @doc("The seed used for the fine-tuning job.")
  seed: int32;

  @doc("The method used for fine-tuning.")
  method: FineTuningJobTrainingMethod;

  @doc("A list of integrations to enable for this fine-tuning job.")
  integrations?: Array<FineTuningJobIntegration>;

  @doc("A string of up to 64 characters that will be added to your fine-tuned model name.")
  suffix?: string;
}
