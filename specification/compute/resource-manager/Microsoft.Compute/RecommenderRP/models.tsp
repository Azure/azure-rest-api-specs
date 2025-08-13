import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Contains additional properties of a diagnostic
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DiagnosticProperties {
  /**
   * Describes what are the supported resource types for a diagnostic.
   */
  supportedResourceTypes?: string[];
}

/**
 * SpotPlacementScores API Input.
 */
model SpotPlacementScoresInput {
  /**
   * The desired regions
   */
  desiredLocations?: string[];

  /**
   * The desired virtual machine SKU sizes.
   */
  desiredSizes?: ResourceSize[];

  /**
   * Desired instance count per region/zone based on the scope.
   */
  desiredCount?: int32;

  /**
   * Defines if the scope is zonal or regional.
   */
  availabilityZones?: boolean;
}

/**
 * SpotPlacementRecommender API response.
 */
model ResourceSize {
  /**
   * The resource's CRP virtual machine SKU size.
   */
  sku?: string;
}

/**
 * SpotPlacementScores API response.
 */
model SpotPlacementScoresResponse {
  /**
   * The desired regions
   */
  desiredLocations?: string[];

  /**
   * The desired virtual machine SKU sizes.
   */
  desiredSizes?: ResourceSize[];

  /**
   * Desired instance count per region/zone based on the scope.
   */
  desiredCount?: int32;

  /**
   * Defines if the scope is zonal or regional.
   */
  availabilityZones?: boolean;

  /**
   * A placement score indicating the likelihood of successfully allocating the specified Spot VM(s), as well as the expected lifetimes of the Spot VM(s) after allocation.
   */
  placementScores?: PlacementScore[];
}

/**
 * The spot placement score for sku/region/zone combination.
 */
model PlacementScore {
  /**
   * The resource's CRP virtual machine SKU size.
   */
  sku?: string;

  /**
   * The region.
   */
  region?: string;

  /**
   * The availability zone.
   */
  availabilityZone?: string;

  /**
   * A placement score indicating the likelihood of successfully allocating the specified Spot VM(s), as well as the expected lifetimes of the Spot VM(s) after allocation.
   */
  score?: string;

  /**
   * Whether the desired quota is available.
   */
  isQuotaAvailable?: boolean;
}

/**
 * Lists available Capacity Blocks for a subscription.
 */
model CapacityBlocks is Azure.Core.Page<CapacityBlock>;

/**
 * Capacity block.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CapacityBlock extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Contains additional properties of a capacity block
   */
  properties?: CapacityBlockProperties;
}

/**
 * Contains additional properties of a capacity block
 */
model CapacityBlockProperties {
  /**
   * Logical Zone of the Capacity Block
   */
  @visibility(Lifecycle.Read)
  zone?: int32;

  /**
   * Location of the Capacity Block.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * SKU of the Capacity Block.
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * Schedule profile of the Capacity Block.
   */
  scheduleProfile?: ScheduleProfile;
}

/**
 * Schedule of Capacity Block Reservation.
 */
model ScheduleProfile {
  /**
   * Start DateTime of Capacity Block reservation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start?: utcDateTime;

  /**
   * End DateTime of Capacity Block Reservation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end?: utcDateTime;
}
