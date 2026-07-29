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
@doc("An AI model exposed by Microsoft.ContainerService. Read-only, globally-shared catalog entry that is platform-maintained and auto-provisioned by the resource provider. Can be referenced by `ModelDeployment` resources.")
@parentResource(SubscriptionLocationResource)
@resource("aiModels")
model AIModel is ProxyResource<AIModelProperties> {
  ...ResourceNameParameter<
    Resource = AIModel,
    KeyName = "aiModelName",
    SegmentName = "aiModels",
    NamePattern = "^[0-9a-f]{16}$"
  >;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "AIModel is platform-maintained and auto-provisioned by the resource provider; it does not expose a provisioning lifecycle to callers."
@added(Versions.v2026_05_02_preview)
@doc("AI model properties.")
model AIModelProperties {
  @visibility(Lifecycle.Read)
  @doc("The Hugging Face model identifier in `<org>/<repo>` form, e.g. `microsoft/Phi-4-mini-instruct`. Uniquely identifies the upstream model that backs this catalog entry.")
  modelId: string;

  @visibility(Lifecycle.Read)
  @doc("An optional, free-form description of the model.")
  description?: string;

  @visibility(Lifecycle.Read)
  @doc("Specification of the model.")
  spec: ModelSpec;
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Reserved as an extensibility envelope so future versions can add optional filters without changing the SDK method signature."
@added(Versions.v2026_05_02_preview)
@doc("Request body for the AI model `calculateCost` action.")
model CalculateCostRequest {
  // intentionally empty for v1; future versions may add filters
}

@added(Versions.v2026_05_02_preview)
@doc("Response body for the AI model `calculateCost` action.")
model CalculateCostResponse {
  @visibility(Lifecycle.Read)
  @doc("ISO 4217 currency code, e.g. \"USD\".")
  currency: string;

  @visibility(Lifecycle.Read)
  @doc("Ranked list of GPU SKU pricing plans. Feasible plans first, ordered by `totalHourlyPrice` ascending; infeasible plans last.")
  @identifiers(#["vmSize"])
  plans: CalculateCostPlan[];
}

@added(Versions.v2026_05_02_preview)
@doc("A GPU SKU pricing plan returned by the `calculateCost` action. Describes the cost of running a single model replica on the specified `vmSize`. To estimate the cost of running multiple replicas, scale `totalHourlyPrice` by the desired replica count, bounded by `maxAvailableReplicas`.")
model CalculateCostPlan {
  @visibility(Lifecycle.Read)
  @doc("Azure VM SKU, e.g. \"Standard_ND96isr_H100_v5\". Matches the value accepted by `ModelDeploymentProperties.vmSize`.")
  vmSize: string;

  @visibility(Lifecycle.Read)
  @doc("Resolved quantization on this SKU.")
  quantization?: string;

  @visibility(Lifecycle.Read)
  @minValue(1)
  @doc("Number of VMs required to host one replica on this SKU.")
  vmsPerReplica: int32;

  @visibility(Lifecycle.Read)
  @minValue(0)
  @doc("Maximum number of replicas the caller's subscription can deploy on this SKU today, computed from the available GPU quota in the target region.")
  maxAvailableReplicas: int32;

  @visibility(Lifecycle.Read)
  @doc("Estimated relative inference performance of a single model replica on this SKU. Omitted when an estimate is unavailable.")
  servingPerformanceEstimation?: ServingPerformanceEstimation;

  @visibility(Lifecycle.Read)
  @minValue(0)
  @doc("On-demand hourly price for a single VM of this SKU, in `currency`.")
  vmHourlyPrice: float64;

  @visibility(Lifecycle.Read)
  @minValue(0)
  @doc("Projected hourly cost for one replica (`vmsPerReplica` VMs), in `currency`.")
  totalHourlyPrice?: float64;

  @visibility(Lifecycle.Read)
  @doc("UTC timestamp of the price snapshot used for this plan.")
  priceAsOf?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("""
    Whether the caller can actually deploy this plan today (region availability, GPU quota, model fit, etc.). This field gates the mutually exclusive properties on this model:
    - When `feasible` is `true`: `totalHourlyPrice` is set and `infeasibilityReason` is omitted.
    - When `feasible` is `false`: `infeasibilityReason` is set and `totalHourlyPrice` is omitted.
    """)
  feasible: boolean;

  @visibility(Lifecycle.Read)
  @doc("Reason explaining why the plan is not deployable. This is a per-plan annotation, not an ARM error envelope.")
  infeasibilityReason?: InfeasibilityReason;
}

@added(Versions.v2026_05_02_preview)
@doc("Estimated relative inference performance of a single model replica on a given GPU SKU. Each metric is a scaling coefficient in the range `[0, 1]` relative to the best-performing SKU for this model, which scores `1`.")
model ServingPerformanceEstimation {
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(1)
  @doc("Relative inference latency score in `[0, 1]`. Higher is better (`1` matches the best-performing SKU's latency for this model). Note: this is a normalized score, not a raw latency ratio -- a larger value indicates lower latency.")
  relativeLatencyScore: float32;

  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(1)
  @doc("Relative inference throughput score in `[0, 1]`. Higher is better (`1` matches the best-performing SKU's throughput for this model).")
  relativeThroughputScore: float32;
}

@added(Versions.v2026_05_02_preview)
@doc("Reason explaining why a `CalculateCostPlan` is not deployable. This is a per-plan annotation surfaced inside a successful `calculateCost` response, not an ARM error envelope.")
model InfeasibilityReason {
  @visibility(Lifecycle.Read)
  @doc("Machine-readable reason code.")
  code: InfeasibleCode;

  @visibility(Lifecycle.Read)
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

  @doc("The deployment can start successfully on this SKU, but its estimated runtime performance falls below the acceptable threshold for serving this model.")
  InefficientDeployment: "InefficientDeployment",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "AIModel is a valid name"
@added(Versions.v2026_05_02_preview)
@armResourceOperations
interface AIModels {
  get is ArmResourceRead<AIModel>;

  list is ArmResourceListByParent<AIModel>;

  @doc("Returns a ranked list of GPU SKU pricing plans for deploying this model in the target region, each annotated with feasibility, per-replica hourly cost, and estimated relative performance. No Azure or Kubernetes resources are provisioned.")
  @post
  @action("calculateCost")
  calculateCost is ArmResourceActionSync<
    AIModel,
    CalculateCostRequest,
    ArmResponse<CalculateCostResponse>
  >;
}

@@maxLength(AIModel.name, 16);
@@minLength(AIModel.name, 16);
@@doc(
  AIModel.name,
  "The name of the AI model resource. A stable, format-defined identifier derived from `modelId` as the lowercase hex of the first 8 bytes (16 characters) of `SHA-256(modelId)` (e.g. upstream `microsoft/Phi-4-mini-instruct` produces `9806f0c862fdd920`). Callers should treat the name as opaque and use the `modelId` property as the human-readable reference. The encoding is a permanent contract of this resource provider and does not depend on any upstream naming policy."
);
