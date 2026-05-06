import "./models.tsp";
import "../common/models.tsp";
import "../jobs/models.tsp";

using TypeSpec.Http;
using Azure.Core;

namespace Azure.AI.Projects;

alias ModelTrainingAcceptedResponse = Foundations.AcceptedResponse &
  ModelTrainingOperation &
  Foundations.LongRunningStatusLocation<Model>;

@tag("Models")
interface Models {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a model by running managed supervised fine-tuning.")
  @post
  @route("/models:create_sft_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createSftTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed SFT model training request.")
      @bodyRoot
      request: SftModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a model by running managed pairwise preference training.")
  @post
  @route("/models:create_preference_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createPreferenceTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed pairwise preference model training request.")
      @bodyRoot
      request: PreferenceModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a model by running managed KTO training.")
  @post
  @route("/models:create_kto_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createKtoTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed KTO model training request.")
      @bodyRoot
      request: KtoModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a reward model by running managed reward-model training.")
  @post
  @route("/models:create_reward_model_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createRewardModelTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed reward-model training request.")
      @bodyRoot
      request: RewardModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a model by running managed GRPO training.")
  @post
  @route("/models:create_grpo_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createGrpoTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed GRPO model training request.")
      @bodyRoot
      request: GrpoModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a model by running managed online policy-gradient training.")
  @post
  @route("/models:create_policy_gradient_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createPolicyGradientTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed online policy-gradient model training request.")
      @bodyRoot
      request: PolicyGradientModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Managed model training is a product action that creates an underlying training job resource."
  @doc("Create a model by running managed PPO training.")
  @post
  @route("/models:create_ppo_training_job")
  @pollingOperation(Models.getTrainingOperationResult)
  createPpoTrainingJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("Idempotency key used to safely retry managed model training.")
      @header("Operation-Id")
      operationId?: string;

      @doc("The managed PPO model training request.")
      @bodyRoot
      request: PpoModelTrainingJobCreate;
    },
    ModelTrainingAcceptedResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry model training operations are exposed as product-action polling routes under models."
  @doc("Poll the result of a managed model training operation.")
  @get
  @route("/models/operations/{operationId}/result")
  getTrainingOperationResult is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.jobs_v1_preview,
    {
      @doc("The managed model training operation identifier.")
      @path
      operationId: string;
    },
    ModelTrainingOperation
  >;
}
