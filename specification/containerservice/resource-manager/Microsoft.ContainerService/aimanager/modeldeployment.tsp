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

@added(Versions.v2026_05_02_preview)
@doc("""
  A running deployment of a model in an AI Manager namespace.
  
  PUT (create or update) on this resource is a full replace: the request body
  represents the complete desired state, and any optional property omitted
  from the body is reset to its default value (or cleared, if it has no
  default). Callers must always send the full desired state on every PUT.
  """)
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

  @doc("Runtime performance mode.")
  performanceMode?: ModelDeploymentPerformanceMode;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Azure VM SKU used to host the deployment, e.g. \"Standard_NC96ads_A100_v4\". Immutable after creation.")
  vmSize: string;

  @doc("Scaling configuration for the deployment. Provide either `manual` (fixed replica count) or `autoscale` (autoscaling between min/max replicas), but not both.")
  scale?: ScalingProfile;

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
  @doc("The desired replica count reported by the controller. Equals `properties.scale.manual.replicas` when manual scaling is used; current target replica count derived from autoscaler otherwise.")
  desiredReplicas?: int32;

  @visibility(Lifecycle.Read)
  @doc("The current number of ready replicas serving traffic.")
  currentReplicas?: int32;

  @visibility(Lifecycle.Read)
  @doc("The peak tokens per minute measured by live stress test.")
  peakTokensPerMinute?: int32;

  @visibility(Lifecycle.Read)
  @doc("Estimated total time, in seconds, for the deployment to become ready end-to-end (GPU vm provisioning, image/weight pull, engine warm-up).")
  estimatedProvisionTimeSeconds?: int32;
}

@added(Versions.v2026_05_02_preview)
@doc("User overrides for a model deployment.")
model ModelDeploymentOverrides {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form override key/value pairs."
  @doc("Experimental free-form override key/value pairs. Subject to change without notice; not part of the stable contract. Recognized keys are documented per release and may be added, renamed, or removed at any time.")
  values?: Record<string>;
}

@added(Versions.v2026_05_02_preview)
@doc("""
  Scaling configuration for a model deployment. Exactly one of `manual` or
  `autoscale` must be set.
  
  This mutual-exclusion constraint is enforced by the service at request
  validation time, not by the schema. A PUT request that sets both `manual`
  and `autoscale`, or sets neither, is rejected with HTTP 400 (Bad Request)
  and an `InvalidScalingProfile` error code;
  
  Scale-to-zero semantics differ between the two modes:
  - `manual` permits `replicas: 0`. This is an explicit operator action to
    stop serving traffic while keeping the `ModelDeployment` resource (and
    its configuration) in place. While at zero replicas the endpoint
    returns errors for inference requests, and the deployment releases its
    GPU capacity.
  - `autoscale` does not permit `minReplicas: 0`. Autoscaling decisions are
    driven by serving-server runtime metrics (request rate, queue depth,
    GPU utilization); at zero replicas there is no signal for the
    autoscaler to scale back up from. Combined with GPU cold-start time
    (on the order of minutes) and constrained regional GPU capacity, a
    scale-from-zero event would produce unacceptable first-request latency
    and a high risk of capacity unavailability. Callers that want
    autoscaling with an idle state should delete the `ModelDeployment`
    instead.
  """)
model ScalingProfile {
  @doc("Manual scaling configuration with a fixed replica count. Mutually exclusive with `autoscale`.")
  manual?: ManualScalingProfile;

  @doc("Autoscaling configuration. Mutually exclusive with `manual`.")
  autoscale?: AutoscaleProfile;
}

@added(Versions.v2026_05_02_preview)
@doc("Manual scaling configuration: fixed replica count.")
model ManualScalingProfile {
  @doc("Fixed number of replicas. May be `0` to stop serving traffic while keeping the deployment configuration (see `ScalingProfile`).")
  @minValue(0)
  replicas: int32;
}

@added(Versions.v2026_05_02_preview)
@doc("Autoscaling configuration: scale replica count between a minimum and maximum.")
model AutoscaleProfile {
  @doc("The minimum number of replicas. Must be at least `1`; scale-to-zero is not supported in autoscale mode (see `ScalingProfile`).")
  @minValue(1)
  minReplicas: int32;

  @doc("The maximum number of replicas. If not specified, the service derives a default from the subscription GPU quota.")
  @minValue(1)
  maxReplicas?: int32;
}

@added(Versions.v2026_05_02_preview)
@armResourceOperations
interface ModelDeployments {
  get is ArmResourceRead<ModelDeployment>;

  @doc("Create or update a `ModelDeployment`. This is a full-replace operation: any optional property omitted from the request body is reset to its default value, or cleared if it has no default. To safely modify a subset of fields, perform a GET, modify the returned resource, and PUT it back using the returned ETag via the `If-Match` header to avoid concurrent overwrites.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ModelDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<ModelDeployment> &
      IfMatchParameters<ModelDeployment> &
      IfNoneMatchParameters<ModelDeployment>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    ModelDeployment,
    Azure.ResourceManager.Foundations.BaseParameters<ModelDeployment> &
      IfMatchParameters<ModelDeployment>,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "AIManager is a valid name"
  listByAIManagerNamespace is ArmResourceListByParent<ModelDeployment>;
}

@@maxLength(ModelDeployment.name, 63);
@@minLength(ModelDeployment.name, 1);
@@doc(ModelDeployment.name, "The name of the model deployment resource.");
