import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./managedapp.tsp";
import "./customoperations.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.ContainerService;

@parentResource(ManagedApp)
model Rollout is Azure.ResourceManager.ProxyResource<RolloutProperties> {
  ...ResourceNameParameter<Rollout>;
}

/** Properties of the Rollout */
model RolloutProperties {
  /** The rollout template to use for this rollout */
  rolloutTemplate: RolloutTemplateId;

  /** Stages in which to complete the rollout */
  @identifiers(#["deployment"])
  @visibility(Lifecycle.Read)
  stages: RolloutStage[];

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Rollouts {
  // Rollout Operations
  list is ArmResourceListByParent<Rollout>;
  get is ArmResourceRead<Rollout>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Rollout,
    Azure.ResourceManager.Foundations.BaseParameters<Rollout>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Rollout>;

  rollback is RollbackDeployment<
    Rollout,
    AppDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<Rollout>
  >;

  advanceStage is AdvanceRollout<
    Rollout,
    Rollout,
    Azure.ResourceManager.Foundations.BaseParameters<Rollout>
  >;
}

@parentResource(ManagedApp)
model RolloutTemplate is ProxyResource<RolloutTemplateProperties> {
  ...ResourceNameParameter<RolloutTemplate>;
}

scalar RolloutTemplateId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/managedApps/rolloutTemplates",
    }
  ]>;

/** Properties of the Rollout Template */
model RolloutTemplateProperties {
  /** Stages in which to complete the rollout */
  @identifiers(#["deployment"])
  stages: RolloutStage[];

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** A stage in the rollout */
model RolloutStage {
  /** The previous AppRevisionID of this deployment */
  previousAppRevisionId: AppRevisionId;

  /** The desired AppRevisionID of this deployment */
  desiredAppRevisionId: AppRevisionId;

  /** The app deployment to which this rollout stage applies */
  deployment: AppDeploymentId;

  /** Time to bake after deployment before proceeding to the next stage, in minutes */
  bakeTimeInMinutes: int32 = 1440;

  /** State of the Rollout Stage */
  state?: RolloutStageState;
}

/** State of the Rollout Stage */
union RolloutStageState {
  /** Pending */
  Pending: "pending",

  /** InProgress */
  InProgress: "inProgress",

  /** PassedHealthCheck */
  PassedHealthCheck: "passedHealthCheck",

  /** Unhealthy */
  Unhealthy: "unhealthy",

  /** Baking */
  Baking: "baking",

  /** Completed */
  Completed: "completed",

  /** Canceled */
  Canceled: "canceled",

  string,
}
