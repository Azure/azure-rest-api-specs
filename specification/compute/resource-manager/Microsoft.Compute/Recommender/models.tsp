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

/**
 * Contains additional properties of a placement scores resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not involve long-running operations and does not require provisioningState."
model PlacementScoresProperties {
  /**
   * Describes the supported resource types for placement scoring.
   */
  supportedResourceTypes?: string[];
}

/**
 * SpotPlacementScores API Input.
 */
model SpotPlacementScoresInput {
  /**
   * The desired regions. If not set, the location from the request URI is used as the desired location. Each location in this list must be a valid Azure region.
   */
  desiredLocations?: string[];

  /**
   * The desired virtual machine SKU sizes.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "ResourceSize is a non-resource data structure representing SKU metadata; it is not individually addressable and does not require identifiers."
  @madeRequired(Versions.v2026_10_05_preview)
  desiredSizes: ResourceSize[];

  /**
   * Desired instance count per region/zone based on the scope. If not set, defaults to 1.
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
 * ComputePlacementScores API Input.
 */
@added(Versions.v2026_10_05_preview)
model ComputePlacementScoresInput is SpotPlacementScoresInput {}

/**
 * ComputePlacementScores API response.
 */
@added(Versions.v2026_10_05_preview)
model ComputePlacementScoresResponse is SpotPlacementScoresResponse {}

/**
 * Placement score value indicating the likelihood of successfully allocating the requested VM(s).
 */
@added(Versions.v2026_10_05_preview)
union PlacementScoreValue {
  string,

  /** High likelihood of successful allocation. */
  High: "High",

  /** Medium likelihood of successful allocation. */
  Medium: "Medium",

  /** Low likelihood of successful allocation. */
  Low: "Low",

  /** The requested SKU is restricted and not available. */
  RestrictedSkuNotAvailable: "RestrictedSkuNotAvailable",

  /** Insufficient quota is available to fulfill the request. */
  InsufficientQuota: "InsufficientQuota",

  /** Data was not found or is stale. */
  DataNotFoundOrStale: "DataNotFoundOrStale",
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
  @typeChangedFrom(Versions.v2026_10_05_preview, string)
  score?: PlacementScoreValue;

  /**
   * Placement preference from 0 to 10 (inclusive). Higher is better.
   */
  @added(Versions.v2026_10_05_preview)
  placementPreference?: int32;

  /**
   * Whether the desired quota is available.
   */
  @removed(Versions.v2026_10_05_preview)
  isQuotaAvailable?: boolean;
}
