import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./aimanager.tsp";
import "./aimanagernamespace.tsp";
import "./aimodel.tsp";
import "./modelsource.tsp";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_05_02_preview)
@doc("The ARM resource id of an AIModel.")
scalar AIModelResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/aiModels",
    }
  ]>;

@added(Versions.v2026_05_02_preview)
@doc("The ARM resource id of a ModelSource.")
scalar ModelSourceResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ContainerService/aiManagers/modelSources",
    }
  ]>;

// The model reference type. Phase 1 accepts an `AIModel` resource id only.
// Future model resource types (e.g. a user-registered BYO model) can be
// added by widening the underlying ARM type without a breaking change.

@added(Versions.v2026_05_02_preview)
@doc("A running deployment of a model in an AI Manager namespace.")
@resource("modelDeployments")
@parentResource(AIManagerNamespace)
model ModelDeployment is ProxyResource<ModelDeploymentProperties> {
  ...ResourceNameParameter<
    Resource = ModelDeployment,
    KeyName = "modelDeploymentName",
    SegmentName = "modelDeployments",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
  >;
  ...EntityTagProperty;
}

@added(Versions.v2026_05_02_preview)
@doc("Model deployment properties.")
model ModelDeploymentProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last reconciliation.")
  provisioningState?: ModelDeploymentProvisioningState;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Full ARM resource id of the model to deploy. Phase 1 accepts an `AIModel` resource id only. Immutable after creation.")
  modelResourceId: AIModelResourceId;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Full ARM resource id of a `ModelSource` to use when pulling artifacts for this deployment. Immutable after creation.")
  modelSourceResourceId?: ModelSourceResourceId;

  @doc("Runtime performance mode. Selects a default engine/quantization combination; use `overrides` to pin values.")
  performanceMode?: ModelDeploymentPerformanceMode = ModelDeploymentPerformanceMode.Balanced;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Azure VM SKU used to host the deployment, e.g. \"Standard_NC96ads_A100_v4\". Immutable after creation.")
  vmSize: string;

  @doc("Desired replica count. Ignored when `autoscaling.enabled` is true.")
  @minValue(1)
  replicas?: int32 = 1;

  @doc("The autoscaling configuration for the deployment.")
  autoscaling?: AutoscalingProfile;

  @doc("User overrides layered on top of profile resolution.")
  overrides?: ModelDeploymentOverrides;

  @visibility(Lifecycle.Read)
  @doc("Runtime status, populated once reconciliation begins.")
  status?: ModelDeploymentStatus;
}

@added(Versions.v2026_05_02_preview)
@doc("The provisioning state of a model deployment resource.")
union ModelDeploymentProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is updating.")
  Updating: "Updating",

  @doc("Resource is deleting.")
  Deleting: "Deleting",
}

@added(Versions.v2026_05_02_preview)
@doc("The runtime performance mode of a model deployment.")
union ModelDeploymentPerformanceMode {
  string,

  @doc("A balanced trade-off between latency and throughput (default).")
  Balanced: "Balanced",

  @doc("Optimize for low request latency.")
  Latency: "Latency",

  @doc("Optimize for high aggregate throughput.")
  Throughput: "Throughput",
}

@added(Versions.v2026_05_02_preview)
@doc("The runtime status of a model deployment. All fields are read-only and populated once reconciliation has started.")
model ModelDeploymentStatus {
  @visibility(Lifecycle.Read)
  @doc("The inference endpoint URL exposed by the deployment, once ready.")
  endpoint?: url;

  @visibility(Lifecycle.Read)
  @doc("The inference engine used to serve the model, e.g. \"vllm\".")
  engine?: string;

  @visibility(Lifecycle.Read)
  @doc("The version of the inference engine, e.g. \"0.17\".")
  engineVersion?: string;

  @visibility(Lifecycle.Read)
  @doc("The maximum model context length, in tokens, configured for this deployment.")
  maxModelLen?: int32;

  @visibility(Lifecycle.Read)
  @doc("The quantization level applied to the model weights, e.g. \"fp16\", \"awq-int4\".")
  quantization?: string;

  @visibility(Lifecycle.Read)
  @doc("The desired replica count reported by the controller. Equals `properties.replicas` when autoscaler is disabled; current target replica count otherwise.")
  desiredReplicas?: int32;

  @visibility(Lifecycle.Read)
  @doc("The peak tokens per minute measured by live stress test.")
  peakTokensPerMinute?: int32;

  @visibility(Lifecycle.Read)
  @doc("Estimated total time, in seconds, for the deployment to become ready end-to-end (GPU node provisioning, image/weight pull, engine warm-up).")
  estimatedProvisionTimeSeconds?: int32;
}

@added(Versions.v2026_05_02_preview)
@doc("User overrides for a model deployment.")
model ModelDeploymentOverrides {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form override key/value pairs."
  @doc("Free-form override key/value pairs. Recognized keys are documented per release.")
  values?: Record<string>;
}

@added(Versions.v2026_05_02_preview)
@doc("Autoscaling configuration for a model deployment.")
model AutoscalingProfile {
  @doc("Whether autoscaling is enabled for this deployment.")
  enabled?: boolean = false;

  @doc("The minimum number of replicas when autoscaling is enabled.")
  @minValue(1)
  minReplicas?: int32 = 1;

  @doc("The maximum number of replicas when autoscaling is enabled. If not specified, the service derives a default from the subscription GPU quota.")
  @minValue(1)
  maxReplicas?: int32;
}


@added(Versions.v2026_05_02_preview)
@armResourceOperations
interface ModelDeployments {
  get is ArmResourceRead<ModelDeployment>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ModelDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<ModelDeployment> &
      IfMatchParameters<ModelDeployment> &
      IfNoneMatchParameters<ModelDeployment>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    ModelDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<ModelDeployment> &
      IfMatchParameters<ModelDeployment>
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
  listByAIManagerNamespace is ArmResourceListByParent<ModelDeployment>;
}

@@maxLength(ModelDeployment.name, 63);
@@minLength(ModelDeployment.name, 1);
@@doc(ModelDeployment.name, "The name of the model deployment resource.");
