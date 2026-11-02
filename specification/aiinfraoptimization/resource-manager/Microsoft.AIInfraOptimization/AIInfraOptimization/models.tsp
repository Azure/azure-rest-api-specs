import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.AIInfraOptimization;

/** The parameters used to request an Azure virtual machine size recommendation for an AI workload. */
model RecommendVmSkuRequest {
  /** Model identity, sizing inputs, and optional maximum model context length. */
  `model`?: RecommendVmSkuModel;

  /** Inference request concurrency and token shape assumptions. */
  workload?: RecommendVmSkuWorkload;

  /** Deployment scale and Azure virtual machine procurement option. */
  deployment?: RecommendVmSkuDeployment;

  /** Ranking preference and optional deployment-wide hourly cost limit. */
  optimization?: RecommendVmSkuOptimization;

  /** The Azure virtual machine candidate set. When supplied, only these virtual machine sizes are ranked. Entries must be non-blank and unique, compared case-insensitively. */
  @minItems(1)
  @maxItems(50)
  @Azure.Core.uniqueItems
  targetVmSizes?: VmSizeName[];

  /** The subscription-scoped lookups to include in the recommendation. */
  subscriptionOptions?: RecommendVmSkuSubscriptionOptions;
}

/** An Azure virtual machine size name, for example `Standard_NC24ads_A100_v4`. */
@maxLength(128)
scalar VmSizeName extends string;

/** Model inputs used for metadata resolution and memory sizing. */
model RecommendVmSkuModel {
  /** The Hugging Face model identifier, for example `meta-llama/Llama-3.1-70B-Instruct`. */
  huggingFaceModelId?: string;

  /** The logical total model parameter count, including all mixture-of-experts experts. May be supplied with or without a model identifier. */
  @minValue(1)
  parameterCount?: int64;

  /** The precision the model weights are served at. Matched case-insensitively. */
  weightPrecision?: WeightPrecision;

  /** The model layer count, used for architecture-aware key-value cache sizing. Supply all architecture fields together with a parameter count. */
  @minValue(1)
  numLayers?: int32;

  /** The model key-value head count, used for architecture-aware key-value cache sizing. Supply all architecture fields together with a parameter count. */
  @minValue(1)
  numKeyValueHeads?: int32;

  /** The attention head dimension, used for architecture-aware key-value cache sizing. Supply all architecture fields together with a parameter count. */
  @minValue(1)
  headDim?: int32;

  /** The maximum context length the model supports, in tokens. Used only as an upper bound for the sizing context length when Hugging Face metadata provides no usable maximum. */
  @minValue(1)
  maxContextLength?: int32;
}

/** Inference workload assumptions that affect memory sizing. */
model RecommendVmSkuWorkload {
  /** The maximum number of simultaneous inference requests handled by each deployment replica. */
  @minValue(1)
  maxConcurrentRequestsPerReplica?: int32;

  /** The prompt and output token budget used for key-value cache sizing. */
  tokenBudget?: RecommendVmSkuTokenBudget;
}

/** The per-request token budget used to size the inference key-value cache. */
model RecommendVmSkuTokenBudget {
  /** The number of prompt, or input, tokens per inference request. Must be supplied together with `maxOutputTokens`, and the two must total from 1 through 131072. */
  @minValue(0)
  @maxValue(131072)
  promptTokens?: int32;

  /** The maximum number of generated output tokens per inference request. Must be supplied together with `promptTokens`, and the two must total from 1 through 131072. */
  @minValue(0)
  @maxValue(131072)
  maxOutputTokens?: int32;
}

/** Deployment scale and procurement inputs. */
model RecommendVmSkuDeployment {
  /** The number of deployment replicas used for cost, quota, and placement calculations. */
  @minValue(1)
  replicaCount?: int32;

  /** The Azure virtual machine procurement option. */
  procurementOption?: ProcurementOption;
}

/** Ranking preference and optional deployment-wide hourly cost limit. */
model RecommendVmSkuOptimization {
  /** The preference used to rank the recommended options. */
  rankingPreference?: RankingPreference;

  /** The deployment-wide hourly cost ceiling. */
  maxDeploymentCostPerHour?: RecommendVmSkuHourlyCost;
}

/** A currency-qualified deployment-wide hourly cost. */
model RecommendVmSkuHourlyCost {
  /** The maximum cost per hour for the whole deployment. Must be greater than zero when supplied. */
  @minValueExclusive(0)
  amount?: float64;

  /** The ISO 4217 currency code the amount is expressed in. The recommendation service currently supports `USD`. */
  @pattern("^[A-Za-z]{3}$")
  currencyCode?: string;
}

/** The subscription-scoped lookups to include in the recommendation. */
model RecommendVmSkuSubscriptionOptions {
  /** Whether to evaluate subscription quota for candidate virtual machine sizes. */
  includeQuota?: boolean = false;

  /** Whether to query placement scores for candidate virtual machine sizes with available quota. */
  includePlacement?: boolean = false;

  /** Whether to fetch subscription-scoped virtual machine pricing. */
  includePricing?: boolean = false;
}

/** The recommended Azure virtual machine sizes for the workload, with the sizing calculation they were derived from. */
model RecommendVmSkuResponse {
  /** The recommended virtual machine size options, ordered from the best to the worst match. */
  @identifiers(#["vmSize"])
  options: RecommendVmSkuOption[];

  /** The resolved workload sizing shared by every option. */
  sizing: RecommendVmSkuSizing;
}

/** One ranked virtual machine size recommendation. */
model RecommendVmSkuOption {
  /** The Azure virtual machine size name, for example `Standard_NC24ads_A100_v4`. */
  vmSize: string;

  /** The rank of this option within the response, where 1 is the best match. */
  recommendationRank: int32;

  /** How ready this option is to deploy. */
  readiness: RecommendVmSkuReadiness;

  /** The deployment topology for this option. */
  topology: RecommendVmSkuTopology;

  /** The deployment cost for this option. */
  cost: RecommendVmSkuCost;

  /** The subscription quota evidence for this option. Returned only when `subscriptionOptions.includeQuota` is set. */
  quota?: RecommendVmSkuQuota;

  /** The capacity placement evidence for this option. Returned only when `subscriptionOptions.includePlacement` is set. */
  placement?: RecommendVmSkuPlacement;

  /** Whether the Azure Machine Learning model catalog recommends this virtual machine size for the model. */
  azureMlRecommended?: boolean;

  /** The external benchmark evidence selected for this option. */
  benchmark?: RecommendVmSkuBenchmark;

  /** A URL to the Azure documentation page for this virtual machine size. */
  documentationUrl?: url;

  /** The advisory deployment throughput and per-request latency estimate for this option. */
  performanceEstimate?: RecommendVmSkuPerformanceEstimate;
}

/** An advisory deployment throughput and per-request latency estimate. */
model RecommendVmSkuPerformanceEstimate {
  /** The estimated number of output tokens generated per second across the whole deployment. */
  deploymentOutputTokensPerSecond: float64;

  /** The estimated time to first token for a single request, in milliseconds. */
  ttftMs: float64;
}

/** How ready a recommended option is to deploy. */
model RecommendVmSkuReadiness {
  /** The current actionability of the recommendation. */
  status: ReadinessStatus;

  /** A human-readable explanation of the readiness status. */
  reason: string;
}

/** The deployment topology for one virtual machine size option. */
model RecommendVmSkuTopology {
  /** The estimated number of virtual machine nodes required for a single replica. */
  estimatedNodeCountPerReplica: int32;

  /** The estimated total number of virtual machine nodes across all replicas. */
  estimatedTotalNodeCount: int64;

  /** The accelerator hardware available in each virtual machine. */
  accelerator: RecommendVmSkuAccelerator;
}

/** The accelerator hardware available in each virtual machine. */
model RecommendVmSkuAccelerator {
  /** The accelerator model name, for example `A100` or `H100`. */
  `model`: string;

  /** The number of accelerator devices in each virtual machine. */
  countPerVm: int32;

  /** The memory capacity of a single accelerator device, in gibibytes. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GiB is the IEC symbol for gibibyte and is fixed by the service wire contract."
  memoryGiBPerAccelerator: int32;
}

/** The deployment cost for one virtual machine size option. */
model RecommendVmSkuCost {
  /** The ISO 4217 currency code all amounts in this object are expressed in. */
  @pattern("^[A-Za-z]{3}$")
  currencyCode: string;

  /** The price per hour for a single virtual machine, in the stated currency. */
  vmHourly: float64;

  /** The price per hour for the whole deployment, in the stated currency. */
  deploymentHourly: float64;

  /** The source the price was resolved from. */
  source: CostSource;

  /** The date and time the price was observed. */
  priceAsOf?: utcDateTime;

  /** The error that prevented subscription-scoped pricing from being resolved, if any. */
  error?: RecommendVmSkuStageError;
}

/** The subscription quota evidence for one virtual machine size option. */
model RecommendVmSkuQuota {
  /** Whether subscription quota is sufficient for the requested deployment. */
  status: QuotaStatus;

  /** A human-readable explanation of the quota status. */
  reason?: string;

  /** The error that prevented quota from being evaluated, if any. */
  error?: RecommendVmSkuStageError;

  /** The maximum number of replicas that can be deployed with the available quota. */
  maxAvailableReplicaCount?: int32;

  /** The quota increase required before this option can be deployed. */
  increase?: RecommendVmSkuQuotaIncrease;
}

/** The quota limits to raise before retrying a deployment. */
model RecommendVmSkuQuotaIncrease {
  /** The individual quota limits that block the requested deployment. */
  @identifiers(#["name"])
  limits: RecommendVmSkuQuotaLimit[];

  /** A URL to the Azure portal page for submitting the quota increase. */
  portalUrl: url;
}

/** One quota limit that blocks the requested deployment. */
model RecommendVmSkuQuotaLimit {
  /** The name of the quota to raise. */
  name: string;

  /** The current usage against the quota. */
  currentUsage: int64;

  /** The current quota limit. */
  currentLimit: int64;

  /** The quota limit required to deploy the workload. */
  requiredLimit: int64;
}

/** The capacity placement evidence for one virtual machine size option. */
model RecommendVmSkuPlacement {
  /** The outcome of the placement query. */
  status: PlacementStatus;

  /** A human-readable explanation of the placement status. */
  reason?: string;

  /** The error that prevented placement from being evaluated, if any. */
  error?: RecommendVmSkuStageError;

  /** The availability zones recommended for the deployment, in preference order. */
  recommendedAvailabilityZones?: string[];
}

/** The external benchmark evidence selected for one virtual machine size option. */
model RecommendVmSkuBenchmark {
  /** How closely the benchmark evidence matches the recommended topology. */
  level: BenchmarkLevel;

  /** The model size class the benchmark covers, for example `70b`. */
  modelClass: string;

  /** The benchmark scenario, for example `Server` or `Offline`. */
  scenario: string;

  /** The number of submitters that published results for this configuration. */
  submitterCount: int32;

  /** The identifier of the selected benchmark submission. */
  submissionId?: string;

  /** The model the benchmark was measured on. */
  benchmarkModel?: string;

  /** The organization that published the benchmark submission. */
  submitter?: string;

  /** The system the benchmark was measured on. */
  system?: string;

  /** The throughput observed in the benchmark submission. */
  throughput?: float64;

  /** The unit the observed throughput is expressed in, for example `Tokens/s`. */
  throughputUnit?: string;

  /** The serving software the benchmark was measured with. */
  software?: string;

  /** The operating system the benchmark was measured on. */
  operatingSystem?: string;

  /** The weight data types used in the benchmark submission. */
  weightDataTypes?: string;

  /** The 99th-percentile time to first token observed in the benchmark, in milliseconds. */
  p99TtftMs?: float64;

  /** The 99th-percentile time per output token observed in the benchmark, in milliseconds. */
  p99TpotMs?: float64;
}

/** An error from an optional subscription-scoped recommendation stage. */
model RecommendVmSkuStageError {
  /** The reason the stage did not complete. */
  code: StageErrorCode;

  /** A human-readable description of the error. */
  message: string;
}

/** The resolved workload sizing shared by every recommended option. */
model RecommendVmSkuSizing {
  /** The resolved model identity and weight precision. */
  `model`: RecommendVmSkuSizingModel;

  /** The resolved per-replica workload inputs used for memory sizing. */
  workload: RecommendVmSkuSizingWorkload;

  /** The memory calculation shared by every returned option. */
  memory: RecommendVmSkuMemory;

  /** The sources used for the sizing calculation. */
  basis: RecommendVmSkuSizingBasis;
}

/** The resolved model identity and weight precision. */
model RecommendVmSkuSizingModel {
  /** The logical total model parameter count used for sizing. */
  parameterCount: int64;

  /** The precision the model weights were sized at. */
  weightPrecision: WeightPrecision;

  /** The Hugging Face model identifier the sizing metadata was resolved from. */
  huggingFaceModelId?: string;
}

/** The resolved per-replica workload inputs used for memory sizing. */
model RecommendVmSkuSizingWorkload {
  /** The maximum number of simultaneous inference requests handled by each replica. */
  maxConcurrentRequestsPerReplica: int32;

  /** The context length, in tokens, used to size the key-value cache: the sum of `promptTokens` and `maxOutputTokens` when a token budget is supplied, otherwise the service default. */
  contextLength: int32;
}

/** The memory calculation shared by every returned option. */
model RecommendVmSkuMemory {
  /** The memory required for the model weights, in gibibytes. */
  modelWeightsGiB: float64;

  /** The key-value cache memory required for a single concurrent request, in gibibytes. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GiB is the IEC symbol for gibibyte and is fixed by the service wire contract."
  kvCacheGiBPerRequest: float64;

  /** The key-value cache memory required for all concurrent requests on a replica, in gibibytes. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GiB is the IEC symbol for gibibyte and is fixed by the service wire contract."
  kvCacheGiBTotal: float64;

  /** The combined model-weight and key-value cache memory required per replica, in gibibytes. */
  modelAndKvCacheGiB: float64;
}

/** The sources used for the sizing calculation. */
model RecommendVmSkuSizingBasis {
  /** Where the model parameter count was resolved from. */
  parameterCountSource: ParameterCountSource;

  /** How the model weight memory was calculated. */
  modelWeightsCalculation: ModelWeightsCalculation;

  /** Where the context length was resolved from. */
  contextLengthSource: ContextLengthSource;
}

/** The precision a model's weights are served at. */
union WeightPrecision {
  /** 32-bit floating point. */
  FP32: "FP32",

  /** 16-bit floating point. */
  FP16: "FP16",

  /** 16-bit brain floating point. */
  BF16: "BF16",

  /** 8-bit floating point. */
  FP8: "FP8",

  /** 8-bit integer. */
  INT8: "INT8",

  /** 4-bit integer. */
  INT4: "INT4",

  /** 4-bit floating point. */
  FP4: "FP4",

  string,
}

/** The Azure virtual machine procurement option. */
union ProcurementOption {
  /** Use standard on-demand capacity. */
  OnDemand: "OnDemand",

  /** Use interruptible Spot capacity. */
  Spot: "Spot",

  string,
}

/** The preference used to rank the recommended options. */
union RankingPreference {
  /** Rank the options by deployment cost. */
  Cost: "Cost",

  /** Rank the options by inference latency. */
  Latency: "Latency",

  string,
}

/** The current actionability of a recommended option. */
union ReadinessStatus {
  /** The option can be attempted without a known prerequisite action. */
  ReadyToAttempt: "ReadyToAttempt",

  /** The option requires a quota increase before deployment. */
  QuotaIncreaseRequired: "QuotaIncreaseRequired",

  /** The option requires an external verification before deployment. */
  VerificationRequired: "VerificationRequired",

  /** The option is not available to the subscription in the requested region. */
  Unavailable: "Unavailable",

  string,
}

/** The source a price was resolved from. */
union CostSource {
  /** The price came from the public Azure retail catalog. */
  AzureRetail: "AzureRetail",

  /** The price came from the caller's Azure subscription. */
  AzureSubscription: "AzureSubscription",

  /** The price is fixed illustrative data for a contract preview. */
  StaticPreview: "StaticPreview",

  string,
}

/** Whether subscription quota is sufficient for a requested deployment. */
union QuotaStatus {
  /** Quota is sufficient for the requested replicas. */
  Available: "Available",

  /** Quota is insufficient for the requested replicas. */
  Unavailable: "Unavailable",

  /** Quota could not be determined. */
  Unknown: "Unknown",

  string,
}

/** The outcome of a capacity placement query. */
union PlacementStatus {
  /** The placement check completed successfully. */
  Evaluated: "Evaluated",

  /** The placement check failed. */
  Failed: "Failed",

  /** The placement check was not run. */
  NotEvaluated: "NotEvaluated",

  /** The placement check is not supported for this option. */
  Unsupported: "Unsupported",

  string,
}

/** How closely benchmark evidence matches a recommended topology. */
union BenchmarkLevel {
  /** The accelerator family has benchmark evidence at a different topology. */
  Benchmarked: "Benchmarked",

  /** The benchmark matches the recommended node and accelerator counts. */
  TopologyMatched: "TopologyMatched",

  string,
}

/** The reason an optional subscription-scoped stage did not complete. */
union StageErrorCode {
  /** The stage exceeded its deadline. */
  TimedOut: "TimedOut",

  /** The stage was throttled. */
  Throttled: "Throttled",

  /** The service reached its active caller partition capacity. */
  PartitionCapacityExceeded: "PartitionCapacityExceeded",

  /** A downstream dependency call failed. */
  DependencyError: "DependencyError",

  /** Required downstream data was unavailable. */
  DataUnavailable: "DataUnavailable",

  /** The optional evaluation call budget was exhausted. */
  EvaluationBudgetExceeded: "EvaluationBudgetExceeded",

  string,
}

/** Where a model parameter count was resolved from. */
union ParameterCountSource {
  /** The parameter count was supplied in the request. */
  Request: "Request",

  /** The parameter count was resolved from Hugging Face metadata. */
  HuggingFace: "HuggingFace",

  string,
}

/** How model weight memory was calculated. */
union ModelWeightsCalculation {
  /** The memory was calculated from the published model artifact size. */
  ArtifactSize: "ArtifactSize",

  /** The memory was estimated from the model parameter count. */
  EstimatedFromParameterCount: "EstimatedFromParameterCount",

  string,
}

/** Where a context length was resolved from. */
union ContextLengthSource {
  /** The context length is the sum of the request's `workload.tokenBudget.promptTokens` and `maxOutputTokens`. */
  Request: "Request",

  /** No token budget was supplied, so the service default context length was used. */
  Default: "Default",

  string,
}
