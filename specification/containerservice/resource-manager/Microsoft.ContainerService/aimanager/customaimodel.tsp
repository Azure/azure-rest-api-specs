import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./aimanager.tsp";
import "./helpers.tsp";
import "./aimodel.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_08_02_preview)
@doc("""
  A custom AI model registered by the customer and scoped to a specific
  AIManager.
  """)
@resource("customAIModels")
@parentResource(AIManager)
model CustomAIModel is ProxyResource<CustomAIModelProperties> {
  ...ResourceNameParameter<
    Resource = CustomAIModel,
    KeyName = "customAIModelName",
    SegmentName = "customAIModels",
    NamePattern = "^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
  >;
  ...EntityTagProperty;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_08_02_preview)
@doc("Custom AI model properties.")
model CustomAIModelProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: CustomAIModelProvisioningState;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("""
    The model identifier, interpreted per the referenced ModelSource type.
    For `HuggingFace` sources this is the upstream `<org>/<repo>` id, e.g.
    `meta-llama/Llama-2-7b-chat`. For `MicrosoftFoundry` sources this is
    `modelName/version`, e.g. `private-llama/1` (the platform splits model and
    version on the final `/`). Immutable after creation.
    """)
  modelId: string;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The base model this custom model was trained from (id + config.json). Immutable after creation.")
  baseModel: BaseModelReference;

  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("Azure resource id of the ModelSource to use when pulling artifacts. Required for `MicrosoftFoundry` sources and for gated/private `HuggingFace` repositories; omitted for public models. Immutable after creation.")
  modelSourceResourceId?: ModelSourceResourceId;

  @doc("Optional. Free-form description of the model. Mutable via a full-replace PUT.")
  @maxLength(250)
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("Read-only. Platform-resolved specification of the model.")
  spec?: CustomAIModelSpec;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_08_02_preview)
@doc("Platform-resolved specification of a custom model. Extends `ModelSpec` with custom model-specific metadata. All fields are read-only.")
model CustomAIModelSpec is ModelSpec;

@added(Versions.v2026_08_02_preview)
@doc("The base model a custom model was trained from. Supplied by the customer because the platform may lack access to private source repositories (e.g. private Foundry projects); consumed by the dataplane for GPU sizing and vLLM configuration.")
model BaseModelReference {
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The HuggingFace `<org>/<repo>` id of the base model, e.g. `meta-llama/Llama-2-7b-chat`. Immutable after creation.")
  id: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "config.json is opaque upstream JSON"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The verbatim `config.json` of the base model, supplied by the customer. Stored by the platform and projected into the dataplane (ConfigMap) to determine GPU node count and vLLM configuration.")
  config?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_08_02_preview)
@doc("Provisioning state of a CustomAIModel resource.")
union CustomAIModelProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being created.")
  Creating: "Creating",

  @doc("Resource is updating.")
  Updating: "Updating",

  @doc("Resource is deleting.")
  Deleting: "Deleting",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_08_02_preview)
@armResourceOperations
interface CustomAIModels {
  get is ArmResourceRead<CustomAIModel>;

  @doc("Create or update a `CustomAIModel`. This is a full-replace operation: any optional property omitted from the request body is reset to its default value, or cleared if it has no default. To safely modify a subset of fields (e.g. `description`), perform a GET, modify the returned resource, and PUT it back using the returned ETag via the `If-Match` header. A PUT that changes the immutable `modelId` or `modelSourceResourceId` is rejected.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CustomAIModel,
    Azure.ResourceManager.Foundations.BaseParameters<CustomAIModel> &
      IfMatchParameters<CustomAIModel> &
      IfNoneMatchParameters<CustomAIModel>
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    CustomAIModel,
    Azure.ResourceManager.Foundations.BaseParameters<CustomAIModel> &
      IfMatchParameters<CustomAIModel>
  >;

  list is ArmResourceListByParent<CustomAIModel>;

  @doc("Returns a ranked list of GPU SKU pricing plans for deploying this custom model in the target region, each annotated with feasibility and per-replica hourly cost. Feasibility is determined by region availability, GPU quota, and model architecture fit (verified at registration time). `servingPerformanceEstimation` is omitted for custom models. No Azure or Kubernetes resources are provisioned.")
  @post
  @action("calculateCost")
  calculateCost is ArmResourceActionSync<
    CustomAIModel,
    CalculateCostRequest,
    ArmResponse<CalculateCostResponse>
  >;
}

@@maxLength(CustomAIModel.name, 63);
@@minLength(CustomAIModel.name, 1);
@@doc(CustomAIModel.name, "The name of the custom AI model resource.");
