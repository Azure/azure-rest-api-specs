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
 * Result status of the async operation.
 */
union ResultStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Success: "Success",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Api output result when Compute Diagnostic operation is completed.
 */
model ComputeDiagnosticsOperationResult {
  /**
   * The result of the disk inspection operation.
   */
  message?: string;

  /**
   * The response fields of the disk inspection operation.
   */
  responseFields?: string;

  /**
   * Result status of the async operation.
   */
  resultStatus?: ResultStatus;

  /**
   * The API error details.
   */
  errorDetail?: ErrorDetail;

  /**
   * The time when the disk inspection was completed.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style"
  createdUTC?: utcDateTime;
}

/**
 * Lists all available Compute diagnostics for a subscription in a location.
 */
model ComputeDiagnosticsList is Azure.Core.Page<ComputeDiagnosticBase>;

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
 * Data used for registering a Storage Account for a Subscription.
 */
model StorageConfigurationInput {
  /**
   * Fully qualified storage account Id. Example: "/subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Storage/storageAccounts/{storageAccountName}"
   */
  storageAccountId: string;
}

/**
 * Data used for requesting a Disk Inspection execution.
 */
model RunDiskInspectionInput {
  /**
   * Qualified ID of the resource.
   */
  resourceId: string;

  /**
   * Name of manifest in order to trigger Disk Inspection.
   */
  manifest: string;

  /**
   * SAS uri to the blob where results will be uploaded.
   */
  uploadSasUri: string;
}

/**
 * Api output result when there is an existing storage configuration entry.
 */
model StorageConfigurationResponse {
  /**
   * Fully qualified storage account Id. Example: "/subscriptions/{subId}/resourceGroups/{rgName}/providers/Microsoft.Storage/storageAccounts/{storageAccountName}"
   */
  storageAccountId?: string;
}

/**
 * SpotPlacementRecommender API Input.
 */
model SpotPlacementRecommenderInput {
  /**
   * The desired regions
   */
  desiredLocations?: string[];

  /**
   * The desired resource SKUs.
   */
  @identifiers(#[])
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
 * SpotPlacementRecommender API response.
 */
model SpotPlacementRecommenderResponse {
  /**
   * The desired regions
   */
  desiredLocations?: string[];

  /**
   * The desired resource SKUs.
   */
  @identifiers(#[])
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
   * The spot placement scores.
   */
  @identifiers(#[])
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
   * The availability region.
   */
  availabilityZone?: string;

  /**
   * The placement score.
   */
  score?: string;

  /**
   * Whether the desired quota is available.
   */
  isQuotaAvailable?: boolean;
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
   * The desired resource SKUs.
   */
  @identifiers(#[])
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
 * SpotPlacementScores API response.
 */
model SpotPlacementScoresResponse {
  /**
   * The desired regions
   */
  desiredLocations?: string[];

  /**
   * The desired resource SKUs.
   */
  @identifiers(#[])
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
   * The spot placement scores.
   */
  @identifiers(#[])
  placementScores?: PlacementScore[];
}
