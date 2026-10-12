import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

// ===================== Enums =====================

/** Allocation strategy for determining the optimal SKU split. */
@added(Versions.v2026_05_05_preview)
union SkuMixPlacementAllocationStrategy {
  string,

  /** VMs allocated to optimize for lowest price. */
  LowestPrice: "LowestPrice",

  /** VMs allocated based on customer-specified rank for each VM size. */
  Prioritized: "Prioritized",

  /** VMs allocated to optimize for lowest eviction rate (Spot only). */
  EvictionOptimized: "EvictionOptimized",
}

/** The unit type for the capacity value. */
@added(Versions.v2026_05_05_preview)
union SkuMixPlacementCapacityType {
  string,

  /** Capacity measured in number of VMs. */
  Vm: "VM",

  /** Capacity measured in number of vCPUs. */
  VCpu: "VCpu",
}

/** Priority levels for VM allocation. */
@added(Versions.v2026_05_05_preview)
union SkuMixPlacementPriority {
  string,

  /** Regular priority VMs with guaranteed capacity. */
  Regular: "Regular",

  /** Spot priority VMs with lower cost but potential eviction. */
  Spot: "Spot",
}

/** The OS type of the VMs. */
@added(Versions.v2026_05_05_preview)
union SkuMixPlacementOSType {
  string,

  /** Windows OS. */
  Windows: "Windows",

  /** Linux OS. */
  Linux: "Linux",
}

/** Strategy for distributing capacity across availability zones. */
@added(Versions.v2026_05_05_preview)
union SkuMixPlacementZonalDistributionStrategy {
  string,

  /** Capacity distributed across zones on a best-effort balanced basis. */
  BestEffortBalanced: "BestEffortBalanced",

  /** Zones filled based on zone preferences/rank. Higher priority zones filled first. */
  Prioritized: "Prioritized",

  /** Capacity allocated within a single zone on a best-effort basis; may spill across zones if single-zone capacity is insufficient. */
  BestEffortSingleZone: "BestEffortSingleZone",
}

/** Reason for partial fulfillment of the requested capacity. */
@added(Versions.v2026_05_05_preview)
union SkuMixPlacementPartialFulfillmentReason {
  string,

  /** Full capacity was fulfilled. */
  None: "None",

  /** Not enough allocable capacity was available. */
  InsufficientCapacity: "InsufficientCapacity",

  /** Not enough quota was available. */
  InsufficientQuota: "InsufficientQuota",
}

/** Reason the capacity limit for a (VM size, zone) is below the requested capacity. */
@added(Versions.v2026_09_05_preview)
union SkuMixPlacementCapacityLimitReason {
  string,

  /** The full requested capacity is available for this (VM size, zone). */
  None: "None",

  /** Allocable capacity bounded the limit below the requested capacity. */
  InsufficientCapacity: "InsufficientCapacity",

  /** Quota bounded the limit below the requested capacity. Takes precedence when both capacity and quota are insufficient. */
  InsufficientQuota: "InsufficientQuota",

  /** This VM size is not available in this zone for the subscription. */
  SkuNotAvailable: "SkuNotAvailable",
}

// ===================== Request Models =====================

/** Sku Mix Placement API request. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementRequest {
  /** Optional logical zones to consider (e.g. ["1","2","3"]). Omitted or empty implies regional deployment. */
  zones?: string[];

  /** All capacity-related properties. */
  capacityProfile: SkuMixPlacementCapacityProfile;

  /** Describes how the service should choose candidate VM sizes. */
  instanceDescription: SkuMixPlacementInstanceDescription;
}

/** Capacity-related properties for the placement request. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementCapacityProfile {
  /** The capacity to run the workload. For VMs: [1..10,000]. For vCPUs: [1..100,000]. */
  capacity: int32;

  /** The unit type for the capacity value. */
  capacityType: SkuMixPlacementCapacityType;

  /** The priority of the VMs to allocate. */
  priority: SkuMixPlacementPriority;

  /** Contains spot-specific configuration. */
  spotPriorityProfile?: SkuMixPlacementSpotPriorityProfile;

  /** The allocation strategy for determining the optimal SKU split. */
  allocationStrategy?: SkuMixPlacementAllocationStrategy;

  /** The OS type. Required when allocationStrategy is LowestPrice because pricing varies by OS. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  osType?: SkuMixPlacementOSType;

  /** Zone allocation policy. Default: BestEffortBalanced. */
  zoneAllocationPolicy?: SkuMixPlacementZoneAllocationPolicy;
}

/** Spot priority configuration. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementSpotPriorityProfile {
  /** Maximum price per VM the customer is willing to pay. Default: -1 (no price restriction). */
  maxPricePerVm?: float64;
}

/** Zone allocation policy for the placement request. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementZoneAllocationPolicy {
  /** Distribution strategy for allocating capacity across zones. */
  distributionStrategy?: SkuMixPlacementZonalDistributionStrategy;

  /** Per-zone allocation preferences. Used with the Prioritized strategy. */
  @identifiers(#["zone"])
  zonePreferences?: SkuMixPlacementZonePreference[];
}

/** Per-zone allocation preference. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementZonePreference {
  /** Logical zone (e.g. "1", "2", "3"). */
  zone: string;

  /** Rank of the zone. Lower values = higher priority (0 is highest). */
  rank?: int32;

  /** Best-effort limit to avoid allocating more than this count within the zone. Used with the Prioritized strategy. */
  targetMaxCapacity?: int32;
}

/** Describes which VM sizes to consider. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementInstanceDescription {
  /** The list of VM sizes to consider for placement. */
  @identifiers(#["name"])
  vmSizes: SkuMixPlacementVMSize[];
}

/** A VM size with optional rank for prioritization. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementVMSize {
  /** SKU name (e.g. Standard_D2s_v3). */
  name: string;

  /** Rank of the VM size. Lower = higher priority (starting at 0). Only valid with Prioritized strategy. */
  rank?: int32;
}

// ===================== Response Models =====================

/** Sku Mix Placement API response. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementResponse {
  /**
   * Unique identifier for this placement response, including responses that contain no placement choices.
   * Replaces the per-choice id that was present on placementChoices in earlier API versions.
   */
  @added(Versions.v2026_09_05_preview)
  id: string;

  /** List of placement choice recommendations. */
  @identifiers(#[])
  placementChoices: SkuMixPlacementDeploymentChoice[];

  /** Date/time until which the recommendations are valid. Callers should request fresh recommendations after this time. */
  validUntil?: utcDateTime;

  /** Indicates whether the response is a complete or partial fulfillment. */
  partialFulfillmentReason: SkuMixPlacementPartialFulfillmentReason;

  /**
   * Capacity availability for each requested (VM size, zone) combination, independent of the recommended
   * placement. An entry is present for every requested combination, including those excluded by capacity
   * or quota. Only returned for requests that describe instances by VM sizes.
   */
  @added(Versions.v2026_09_05_preview)
  @identifiers(#["name", "zone"])
  capacityLimits?: SkuMixPlacementCapacityLimit[];
}

/** A single deployment choice recommendation. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementDeploymentChoice {
  /**
   * Unique identifier for this deployment choice.
   */
  @removed(Versions.v2026_09_05_preview)
  id: string;

  /** Placement score from 0 to 9 (inclusive). Higher is better. */
  @minValue(0)
  @maxValue(9)
  score: int32;

  /** The list of VM size / zone allocations that make up this deployment choice. */
  @identifiers(#["name", "zone"])
  skuSplit: SkuMixPlacementItem[];
}

/** A single VM size allocation within a deployment choice. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementItem {
  /** VM size name (e.g. Standard_D2s_v3). */
  name: string;

  /** Priority of this allocation (Regular or Spot). */
  priority: SkuMixPlacementPriority;

  /** Lower range of recommended allocation capacity. */
  capacity: int32;

  /** Upper range of recommended allocation capacity. */
  @removed(Versions.v2026_09_05_preview)
  capacityMax?: int32;

  /** Logical zone (e.g. "1", "2", "3"). Omitted or empty for regional deployments. */
  zone?: string;
}

/**
 * Capacity availability for a single requested (VM size, zone) combination, independent of the
 * recommended placement.
 */
@added(Versions.v2026_09_05_preview)
model SkuMixPlacementCapacityLimit {
  /** VM size name (e.g. Standard_D2s_v3). */
  name: string;

  /** Priority of this entry (Regular or Spot). */
  priority: SkuMixPlacementPriority;

  /** Logical zone (e.g. "1", "2", "3"). Omitted or empty for regional requests. */
  zone?: string;

  /**
   * Upper bound, in VMs, on how much capacity can be allocated for this (VM size, zone): the smallest of
   * the requested capacity, the available capacity, and the available quota, but never below the capacity
   * already recommended for the slot. 0 when nothing is available.
   */
  @minValue(0)
  limit: int32;

  /** Why the limit is below the requested capacity, or None when the request is fully available. */
  reason: SkuMixPlacementCapacityLimitReason;
}

// ===================== Resource Properties =====================

/** Contains properties of the SkuMixPlacement resource. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not involve long-running operations and does not require provisioningState."
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementProperties {
  /** Describes what resource types are supported by the mix placement scoring service. */
  supportedResourceTypes?: string[];
}
