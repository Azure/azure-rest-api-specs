import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Compute;

/**
 * Contains additional properties of a diagnostic
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not involve long-running operations and does not require provisioningState."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "ResourceSize is a non-resource data structure representing SKU metadata; it is not individually addressable and does not require identifiers."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "ResourceSize is a non-resource data structure representing SKU metadata; it is not individually addressable and does not require identifiers."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "PlacementScore is a non-resource data model used for telemetry and scoring; items are not uniquely addressable and do not require x-ms-identifiers."
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
