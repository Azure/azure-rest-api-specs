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

  /** Required when priority is Spot. Contains spot-specific configuration. */
  spotPriorityProfile?: SkuMixPlacementSpotPriorityProfile;

  /** The allocation strategy for determining the optimal SKU split. */
  allocationStrategy?: SkuMixPlacementAllocationStrategy;

  /** The OS type. Required when allocationStrategy is LowestPrice because pricing varies by OS. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
  osType?: SkuMixPlacementOSType;

  /** Zone allocation policy. Default: BestEffortBalanced. */
  zoneAllocationPolicy?: SkuMixPlacementZoneAllocationPolicy;
}

/** Spot priority configuration. Required when priority is Spot. */
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
  /** List of placement choice recommendations. */
  @identifiers(#["id"])
  placementChoices: SkuMixPlacementDeploymentChoice[];

  /** Date/time until which the recommendations are valid. Callers should request fresh recommendations after this time. */
  validUntil?: utcDateTime;

  /** Indicates whether the response is a complete or partial fulfillment. */
  partialFulfillmentReason: SkuMixPlacementPartialFulfillmentReason;
}

/** A single deployment choice recommendation. */
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementDeploymentChoice {
  /** Unique identifier for this deployment choice. */
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
  capacityMax?: int32;

  /** Logical zone (e.g. "1", "2", "3"). Omitted or empty for regional deployments. */
  zone?: string;
}

// ===================== Resource Properties =====================

/** Contains properties of the SkuMixPlacement resource. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not involve long-running operations and does not require provisioningState."
@added(Versions.v2026_05_05_preview)
model SkuMixPlacementProperties {
  /** Describes what resource types are supported by the mix placement scoring service. */
  supportedResourceTypes?: string[];
}
