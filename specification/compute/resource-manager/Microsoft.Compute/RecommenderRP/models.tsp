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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DiagnosticProperties {
  /**
   * Describes what are the supported resource types for a diagnostic.
   */
  supportedResourceTypes?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
