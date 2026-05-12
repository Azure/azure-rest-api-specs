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
  @doc("Platform-resolved specification of the model.")
  resolvedSpec?: ResolvedModelSpec;
}

@added(Versions.v2026_05_02_preview)
@doc("The platform-resolved specification of a model. All fields are read-only.")
model ResolvedModelSpec {
  @visibility(Lifecycle.Read)
  @doc("The license of the model, when known.")
  license?: string;

  @visibility(Lifecycle.Read)
  @doc("Whether the model is gated and requires explicit access approval.")
  gated?: boolean;

  @visibility(Lifecycle.Read)
  @doc("The maximum context length supported by the model, in tokens.")
  maxContextLength: int32;
}

@added(Versions.v2026_05_02_preview)
@doc("Request body for the AI model `calculateCost` action.")
model CalculateCostRequest {
  @doc("Number of replicas to price.")
  @minValue(1)
  replicas?: int32 = 1;
}

@added(Versions.v2026_05_02_preview)
@doc("Response body for the AI model `calculateCost` action.")
model CalculateCostResponse {
  @doc("Echoes the effective replica count used for totals.")
  replicas: int32;

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

  @doc("Number of cluster nodes required to host one replica on this SKU.")
  vmsPerReplica: int32;

  @doc("On-demand hourly price for a single node of this SKU, in `currency`.")
  vmHourlyPrice: float64;

  @doc("Projected hourly cost for `replicas * vmsPerReplica` nodes, in `currency`. Omitted when the plan is infeasible.")
  totalHourlyPrice?: float64;

  @doc("UTC timestamp of the price snapshot used for this plan. Overrides any response-level snapshot if present.")
  priceAsOf?: utcDateTime;

  @doc("Whether the caller can actually deploy this plan today (region availability, GPU quota, model fit, ...).")
  feasible: boolean;

  @doc("Machine-readable reason when `feasible=false`. Omitted when `feasible=true`.")
  infeasibleCode?: InfeasibleCode;

  @doc("Human-readable message accompanying `infeasibleCode`. Omitted when `feasible=true`.")
  infeasibleMessage?: string;
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
    CalculateCostRequest,
    ArmResponse<CalculateCostResponse>
  >;
}

@@maxLength(AIModel.name, 128);
@@minLength(AIModel.name, 1);
@@doc(AIModel.name,
  "The name of the AI model resource. Derived from the upstream model id by replacing the publisher separator `/` with `--` (e.g. upstream `microsoft/Phi-4-mini-instruct` becomes `microsoft--Phi-4-mini-instruct`). Because Hugging Face repo ids forbid `--`, this mapping is unambiguously reversible. Allowed characters: letters, digits, `.`, `-`, `_`."
);
