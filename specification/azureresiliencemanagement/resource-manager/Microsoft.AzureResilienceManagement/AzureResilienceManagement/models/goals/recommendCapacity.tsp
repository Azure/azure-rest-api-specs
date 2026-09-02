import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AzureResilienceManagement;

@added(Versions.v2026_03_01_preview)
@doc("Request body for the recommend capacity action. Provide specific resource IDs to evaluate, or pass an empty array to let the service automatically select non-resilient resources from the goal assignment.")
model RecommendCapacityRequest {
  @doc("Azure resource IDs to evaluate for resiliency. Pass an empty array to automatically discover and evaluate non-resilient resources in the service group. Maximum 50 resources per request.")
  @maxItems(50)
  resourceIds: armResourceIdentifier[];
}

@added(Versions.v2026_03_01_preview)
@doc("Resiliency assessment for a single Azure resource, including eligibility category, actionable guidance, and alternate configurations.")
model RecommendCapacityResourceResult {
  @doc("Fully qualified ARM resource ID of the evaluated resource.")
  resourceId: armResourceIdentifier;

  @doc("ARM resource type (e.g., 'Microsoft.Compute/virtualMachines', 'Microsoft.Storage/storageAccounts').")
  resourceType?: string;

  @doc("Current SKU or pricing tier of the resource (e.g., 'Standard_D4s_v3', 'Standard_LRS').")
  skuName?: string;

  @doc("Azure region where the resource is deployed (e.g., 'eastus', 'westeurope').")
  location?: string;

  @doc("Human-readable assessment of this resource's resiliency posture. Contains actionable recommendations when available, or null when the AI advisor is unavailable.")
  capacityAssessment?: string;

  @doc("Error message if the resource could not be evaluated (e.g., resource not found or access denied). Other fields may be empty when this is set.")
  error?: string;

  @doc("Resiliency eligibility classification for this resource. See ResiliencyEligibilityCategory for possible values.")
  category?: ResiliencyEligibilityCategory;

  @doc("Alternative Azure regions that support resiliency for this resource type. Populated when the current region does not support the required redundancy.")
  suggestedRegions?: string[];

  @doc("Alternative SKUs that support redundancy for this resource type in the current region. Populated when the current SKU is not eligible for resiliency.")
  suggestedSkus?: string[];

  @doc("Ordered list of actions to enable or improve resiliency for this resource.")
  steps?: string[];

  @doc("Links to relevant Azure documentation for configuring resiliency.")
  links?: string[];
}

@added(Versions.v2026_03_01_preview)
@doc("Result of a completed recommend capacity operation, containing per-resource assessments and cross-cutting recommendations.")
model RecommendCapacityResult {
  @doc("Individual resiliency assessment for each evaluated resource.")
  @identifiers(#["resourceId"])
  resourceCapacities: RecommendCapacityResourceResult[];

  @doc("High-level recommendations that apply across multiple resources (e.g., regional migration patterns, common SKU upgrades).")
  recommendations: string[];

  @doc("Error message from the AI advisor, if the advisory enrichment failed. The deterministic assessment results are still available even when this field is set.")
  agentError?: string;
}
