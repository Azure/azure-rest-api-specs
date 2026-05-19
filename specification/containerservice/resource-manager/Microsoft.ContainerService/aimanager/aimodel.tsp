import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./helpers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ContainerService;

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_05_02_preview)
@doc("An AI model exposed by Microsoft.ContainerService. Read-only, globally-shared catalog entry that is platform-maintained and auto-provisioned by the resource provider; identical across regions and subscriptions. Can be referenced by `ModelDeployment` resources.")
@parentResource(SubscriptionLocationResource)
@resource("aiModels")
model AIModel is ProxyResource<AIModelProperties> {
  ...ResourceNameParameter<
    Resource = AIModel,
    KeyName = "aiModelName",
    SegmentName = "aiModels",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9._-]*$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AIModel is platform-maintained and auto-provisioned by the resource provider; it does not expose a provisioning lifecycle to callers."
@added(Versions.v2026_05_02_preview)
@doc("AI model properties.")
model AIModelProperties {
  @visibility(Lifecycle.Read)
  @doc("The Hugging Face model identifier in `<org>/<repo>` form, e.g. `microsoft/Phi-4-mini-instruct`. Uniquely identifies the upstream model that backs this catalog entry.")
  modelId?: string;

  @doc("An optional, free-form description of the model.")
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("Specification of the model.")
  spec?: ModelSpec;
}

@added(Versions.v2026_05_02_preview)
@doc("The specification of a model. All fields are read-only.")
model ModelSpec {
  @visibility(Lifecycle.Read)
  @doc("The license of the model, when known. SPDX license identifier, e.g. `mit`, `apache-2.0`.")
  license?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether access to the model is restricted and requires credential.")
  isRestricted: boolean;

  @visibility(Lifecycle.Read)
  @doc("The maximum context length supported by the model, in tokens.")
  maxContextLength: int32;
}

@added(Versions.v2026_05_02_preview)
@doc("Response body for the AI model `calculateCost` action.")
model CalculateCostResponse {
  @doc("ISO 4217 currency code, e.g. \"USD\".")
  currency: string;

  @doc("Ranked list of GPU SKU pricing plans. Feasible plans first, ordered by `totalHourlyPrice` ascending; infeasible plans last.")
  @identifiers(#["vmSize"])
  plans: CalculateCostPlan[];
}

@added(Versions.v2026_05_02_preview)
@doc("A GPU SKU pricing plan returned by the `calculateCost` action.")
model CalculateCostPlan {
  @doc("Azure VM SKU, e.g. \"Standard_ND96isr_H100_v5\". Matches the value accepted by `ModelDeploymentProperties.vmSize`.")
  vmSize: string;

  @doc("Resolved quantization on this SKU.")
  quantization?: string;

  @doc("Number of vms required to host one replica on this SKU.")
  vmsPerReplica: int32;

  @doc("On-demand hourly price for a single vm of this SKU, in `currency`.")
  vmHourlyPrice: float64;

  @doc("Projected hourly cost for one replica (`vmsPerReplica` vms), in `currency`. Omitted when the plan is infeasible.")
  totalHourlyPrice?: float64;

  @doc("UTC timestamp of the price snapshot used for this plan. Overrides any response-level snapshot if present.")
  priceAsOf?: utcDateTime;

  @doc("Whether the caller can actually deploy this plan today (region availability, GPU quota, model fit, ...).")
  feasible: boolean;

  @doc("Error detail explaining why the plan is not deployable. Omitted when `feasible=true`.")
  infeasibleError?: InfeasibleError;
}

@added(Versions.v2026_05_02_preview)
@doc("Error detail explaining why a `CalculateCostPlan` is not deployable.")
model InfeasibleError {
  @doc("Machine-readable reason code.")
  code: InfeasibleCode;

  @doc("Human-readable message accompanying `code`.")
  message: string;
}

@added(Versions.v2026_05_02_preview)
@doc("The reason a `CalculateCostPlan` is not deployable.")
union InfeasibleCode {
  string,

  @doc("The caller's subscription does not have enough GPU quota in the target region to deploy this plan.")
  InsufficientQuota: "InsufficientQuota",

  @doc("The VM SKU is not available in the target region.")
  RegionUnavailable: "RegionUnavailable",

  @doc("The deployment can start successfully on this SKU, but its measured runtime performance falls below the acceptable threshold for serving this model.")
  InefficientDeployment: "InefficientDeployment",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_05_02_preview)
@armResourceOperations
interface AIModels {
  get is ArmResourceRead<AIModel>;

  list is ArmResourceListByParent<AIModel>;

  @doc("Calculates projected hourly compute cost for deploying this model on the GPU SKUs available to the caller subscription. No Kubernetes or Azure resources are provisioned.")
  @post
  @action("calculateCost")
  calculateCost is ArmResourceActionSync<
    AIModel,
    void,
    ArmResponse<CalculateCostResponse>
  >;
}

@@maxLength(AIModel.name, 128);
@@minLength(AIModel.name, 1);
@@doc(AIModel.name,
  "The name of the AI model resource. Derived from the upstream model id by replacing the publisher separator `/` with `--` (e.g. upstream `microsoft/Phi-4-mini-instruct` becomes `microsoft--Phi-4-mini-instruct`). Because Hugging Face repo ids forbid `--`, this mapping is unambiguously reversible. Allowed characters: letters, digits, `.`, `-`, `_`."
);
