import "../common/models.tsp";
import "../jobs/models.tsp";

using TypeSpec.Rest;

namespace Azure.AI.Projects;

@doc("Compute placement for a managed model training job.")
model ModelTrainingComputeConfiguration {
  @doc("Compute resource ID used to run the managed training job.")
  id: string;

  @doc("Compute resource configuration for the managed training job.")
  resources?: JobResourceConfiguration;

  @doc("Number of GPUs requested by the managed training job.")
  gpuCount?: int32;

  @doc("Distribution configuration for the managed training job.")
  distribution?: DistributionConfiguration;

  @doc("Queue settings for the managed training job.")
  queueSettings?: QueueSettings;

  @doc("ARM resource ID of a user-assigned managed identity attached to the Foundry project.")
  userAssignedIdentityId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Model asset produced by managed model training.")
@Rest.resource("models")
model Model {
  @doc("Asset ID, a unique identifier for the model asset.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The name of the model asset.")
  @visibility(Lifecycle.Read)
  @key
  name: string;

  @doc("The version of the model asset.")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("The model asset description text.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Tags associated with the model asset.")
  @visibility(Lifecycle.Read)
  tags?: Record<string>;

  @doc("URI of the registered model artifact.")
  @visibility(Lifecycle.Read)
  uri?: string;

  @doc("Base model used to create this model, when the model was produced by managed training.")
  @visibility(Lifecycle.Read)
  baseModel?: string;

  @doc("Backing training job that produced this model, when available.")
  @visibility(Lifecycle.Read)
  trainingJob?: string;
}

@doc("Status of a managed model training operation.")
union ModelTrainingOperationStatus {
  queued: "queued",
  in_progress: "in_progress",

  @Azure.Core.lroSucceeded
  succeeded: "succeeded",

  @Azure.Core.lroFailed
  failed: "failed",

  @Azure.Core.lroCanceled
  canceled: "canceled",
}

@doc("Status resource for a managed model training operation.")
model ModelTrainingOperation {
  @doc("Operation identifier for the managed model training request.")
  operationId: string;

  @doc("Managed model training operation status.")
  @Azure.Core.lroStatus
  status: ModelTrainingOperationStatus;

  @doc("The model produced by managed training when the operation succeeds.")
  @Azure.Core.lroResult
  result?: Model;

  @doc("Error object that describes the failure when status is 'failed'.")
  @Azure.Core.lroErrorResult
  error?: ApiError;
}

@doc("Column mapping for managed SFT datasets. The training dataset must contain chat messages for each training example.")
model SftTrainingColumnMapping {
  @doc("Column containing chat messages used for supervised fine tuning.")
  messages: string;
}

@doc("Dataset configuration for managed supervised fine tuning.")
model SftTrainingDatasetConfiguration {
  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from SFT training fields to dataset columns.")
  columns: SftTrainingColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

@doc("Column mapping for managed GRPO datasets. The training dataset must contain prompts; reference answers or reward context can be passed to the judge.")
model GrpoTrainingColumnMapping {
  @doc("Column containing prompts for rollout generation.")
  prompt: string;

  @doc("Column containing reference answers or reward context passed to the judge.")
  reference?: string;
}

@doc("Dataset configuration for managed GRPO training.")
model GrpoTrainingDatasetConfiguration {
  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from GRPO training fields to dataset columns.")
  columns: GrpoTrainingColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

@doc("Preference optimization algorithm used by managed pairwise preference training.")
union PreferenceTrainingAlgorithm {
  @doc("Direct preference optimization.")
  dpo: "dpo",

  @doc("Odds ratio preference optimization.")
  orpo: "orpo",

  @doc("Contrastive preference optimization.")
  cpo: "cpo",

  @doc("Simple preference optimization.")
  simpo: "simpo",
}

@doc("Policy-gradient algorithm used by managed online reinforcement training.")
union PolicyGradientTrainingAlgorithm {
  @doc("REINFORCE leave-one-out.")
  rloo: "rloo",

  @doc("REINFORCE++.")
  reinforce_pp: "reinforce_pp",
}

@doc("Column mapping for pairwise preference datasets.")
model PairwisePreferenceColumnMapping {
  @doc("Column containing prompts.")
  prompt: string;

  @doc("Column containing the preferred response.")
  chosen: string;

  @doc("Column containing the rejected response.")
  rejected: string;
}

@doc("Dataset configuration for managed pairwise preference training.")
model PairwisePreferenceDatasetConfiguration {
  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from pairwise preference fields to dataset columns.")
  columns: PairwisePreferenceColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

@doc("Column mapping for KTO feedback datasets.")
model KtoFeedbackColumnMapping {
  @doc("Column containing prompts.")
  prompt: string;

  @doc("Column containing responses.")
  response: string;

  @doc("Column containing the binary desirability label.")
  label: string;
}

@doc("Dataset configuration for managed KTO training.")
model KtoTrainingDatasetConfiguration {
  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from KTO fields to dataset columns.")
  columns: KtoFeedbackColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

@doc("Column mapping for scored reward-model datasets.")
model ScoredRewardModelColumnMapping {
  @doc("Column containing prompts.")
  prompt: string;

  @doc("Column containing responses.")
  response: string;

  @doc("Column containing numeric reward scores.")
  score: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union for forward-compatible reward-model dataset shapes."
@doc("Dataset configuration for managed reward-model training.")
@discriminator("kind")
model RewardModelTrainingDatasetConfiguration {
  @doc("Reward-model dataset kind.")
  kind: string;
}

@doc("Pairwise preference dataset for managed reward-model training.")
model PairwiseRewardModelTrainingDatasetConfiguration
  extends RewardModelTrainingDatasetConfiguration {
  @doc("Reward-model dataset kind, always 'pairwise'.")
  kind: "pairwise";

  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from pairwise preference fields to dataset columns.")
  columns: PairwisePreferenceColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

@doc("Scored response dataset for managed reward-model training.")
model ScoredRewardModelTrainingDatasetConfiguration
  extends RewardModelTrainingDatasetConfiguration {
  @doc("Reward-model dataset kind, always 'scored'.")
  kind: "scored";

  @doc("Training dataset asset reference.")
  train: string;

  @doc("Optional evaluation dataset asset reference.")
  eval?: string;

  @doc("Mapping from scored response fields to dataset columns.")
  columns: ScoredRewardModelColumnMapping;

  @doc("Conversational data formatting options.")
  dataFormat?: TrainingDataFormatConfiguration;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Use an extensible union for forward-compatible reference policy kinds."
@doc("Reference policy used for preference optimization or online reinforcement training.")
@discriminator("kind")
model ModelTrainingReferenceConfiguration {
  @doc("Reference policy kind.")
  kind: string;
}

@doc("Use the submitted base model as the reference policy.")
model BaseModelReferenceConfiguration
  extends ModelTrainingReferenceConfiguration {
  @doc("Reference policy kind, always 'base_model'.")
  kind: "base_model";
}

@doc("Use an explicit model as the reference policy.")
model ExplicitModelReferenceConfiguration
  extends ModelTrainingReferenceConfiguration {
  @doc("Reference policy kind, always 'model'.")
  kind: "model";

  @doc("Reference model asset URI.")
  `model`: string;
}

@doc("Disable reference policy or KL anchoring.")
model NoReferenceConfiguration extends ModelTrainingReferenceConfiguration {
  @doc("Reference policy kind, always 'none'.")
  kind: "none";
}

@doc("Output packaging for a managed model training job.")
union ModelTrainingPackagingMode {
  @doc("Register a merged full model.")
  merged_model: "merged_model",

  @doc("Register only the adapter weights.")
  adapter: "adapter",

  @doc("Register both merged model and adapter weights.")
  model_and_adapter: "model_and_adapter",
}

@doc("Model artifact packaging options.")
model ModelTrainingPackagingConfiguration {
  @doc("How the trained model artifact should be packaged.")
  mode?: ModelTrainingPackagingMode = ModelTrainingPackagingMode.merged_model;
}

@doc("Loss function used for reward-model training.")
union RewardModelTrainingLoss {
  string,

  @doc("Bradley-Terry pairwise ranking loss.")
  bradley_terry: "bradley_terry",

  @doc("Regression loss over numeric scores.")
  regression: "regression",
}

@doc("Critic or value model configuration for managed PPO training.")
model PpoCriticConfiguration {
  @doc("Optional critic model asset reference. If omitted, the service initializes the critic from the policy model.")
  `model`?: string;

  @doc("Value loss coefficient.")
  valueLossCoefficient?: float64;

  @doc("GAE discount factor.")
  gamma?: float64;

  @doc("GAE lambda.")
  lambda?: float64;
}

@doc("Runtime options for managed supervised fine tuning.")
model SftTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Runtime options for managed pairwise preference training.")
model PreferenceTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("Reference policy used by algorithms that require KL anchoring or a reference model.")
  reference?: ModelTrainingReferenceConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Runtime options for managed KTO training.")
model KtoTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("Weight applied to desirable examples.")
  desirableWeight?: float64;

  @doc("Weight applied to undesirable examples.")
  undesirableWeight?: float64;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Runtime options for managed reward-model training.")
model RewardModelTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("Loss function used for reward-model training.")
  loss?: RewardModelTrainingLoss;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Runtime options for managed GRPO training.")
model GrpoTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("Judge used to score generated completions during GRPO training.")
  judge: TrainingRewardConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout?: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Reference policy used for KL anchoring.")
  reference?: ModelTrainingReferenceConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Runtime options for managed online policy-gradient training.")
model PolicyGradientTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("Judge used to score generated completions during online training.")
  judge: TrainingRewardConfiguration;

  @doc("Reference policy used for KL anchoring.")
  reference?: ModelTrainingReferenceConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Runtime options for managed PPO training.")
model PpoTrainingRuntimeConfiguration {
  @doc("Training framework implementation. If omitted, the service selects a compatible framework.")
  framework?: TrainingFramework;

  @doc("Algorithm-specific hyperparameters passed through to the selected framework.")
  hyperparameters?: Record<unknown>;

  @doc("Judge used to score generated completions during PPO training.")
  judge: TrainingRewardConfiguration;

  @doc("Reference policy used for KL anchoring.")
  reference?: ModelTrainingReferenceConfiguration;

  @doc("Critic or value model configuration.")
  critic?: PpoCriticConfiguration;

  @doc("LoRA adapter configuration.")
  lora?: TrainingLoraConfiguration;

  @doc("Rollout generation configuration.")
  rollout: TrainingRolloutConfiguration;

  @doc("Evaluation configuration.")
  eval?: TrainingEvalConfiguration;

  @doc("Model artifact packaging options.")
  packaging?: ModelTrainingPackagingConfiguration;
}

@doc("Request body for creating a managed SFT training job from a base model.")
model SftModelTrainingJobCreate {
  @doc("Optional name of the model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the model to create.")
  description?: string;

  @doc("Optional tags for the model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: SftTrainingDatasetConfiguration;

  @doc("Runtime options for managed SFT.")
  runtime?: SftTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}

@doc("Request body for creating a managed pairwise preference training job from a base model.")
model PreferenceModelTrainingJobCreate {
  @doc("Preference optimization algorithm to run.")
  algorithm: PreferenceTrainingAlgorithm;

  @doc("Optional name of the model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the model to create.")
  description?: string;

  @doc("Optional tags for the model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: PairwisePreferenceDatasetConfiguration;

  @doc("Runtime options for managed pairwise preference training.")
  runtime?: PreferenceTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}

@doc("Request body for creating a managed KTO training job from a base model.")
model KtoModelTrainingJobCreate {
  @doc("Optional name of the model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the model to create.")
  description?: string;

  @doc("Optional tags for the model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: KtoTrainingDatasetConfiguration;

  @doc("Runtime options for managed KTO.")
  runtime?: KtoTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}

@doc("Request body for creating a managed reward-model training job from a base model.")
model RewardModelTrainingJobCreate {
  @doc("Optional name of the reward model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the reward model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the reward model to create.")
  description?: string;

  @doc("Optional tags for the reward model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: RewardModelTrainingDatasetConfiguration;

  @doc("Runtime options for managed reward-model training.")
  runtime?: RewardModelTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}

@doc("Request body for creating a managed GRPO training job from a base model.")
model GrpoModelTrainingJobCreate {
  @doc("Optional name of the model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the model to create.")
  description?: string;

  @doc("Optional tags for the model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: GrpoTrainingDatasetConfiguration;

  @doc("Runtime options for managed GRPO.")
  runtime: GrpoTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}

@doc("Request body for creating a managed online policy-gradient training job from a base model.")
model PolicyGradientModelTrainingJobCreate {
  @doc("Policy-gradient algorithm to run.")
  algorithm: PolicyGradientTrainingAlgorithm;

  @doc("Optional name of the model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the model to create.")
  description?: string;

  @doc("Optional tags for the model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: GrpoTrainingDatasetConfiguration;

  @doc("Runtime options for managed online policy-gradient training.")
  runtime: PolicyGradientTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}

@doc("Request body for creating a managed PPO training job from a base model.")
model PpoModelTrainingJobCreate {
  @doc("Optional name of the model to create. If omitted, the service generates one.")
  name?: string;

  @doc("Optional version of the model to create. If omitted, the service generates one.")
  version?: string;

  @doc("Optional description for the model to create.")
  description?: string;

  @doc("Optional tags for the model to create.")
  tags?: Record<string>;

  @doc("Base model asset reference.")
  `model`: string;

  @doc("Training and optional evaluation datasets.")
  dataset: GrpoTrainingDatasetConfiguration;

  @doc("Runtime options for managed PPO.")
  runtime: PpoTrainingRuntimeConfiguration;

  @doc("Compute placement for the managed training job.")
  compute: ModelTrainingComputeConfiguration;
}
