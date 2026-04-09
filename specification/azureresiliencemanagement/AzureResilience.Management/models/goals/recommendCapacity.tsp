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
@doc("Request body for the recommendCapacity action.")
model RecommendCapacityRequest {
  @doc("One or more Azure ARM resource IDs whose capacities should be validated.")
  @minItems(1)
  resourceIds: armResourceIdentifier[];
}

@added(Versions.v2026_03_01_preview)
@doc("Capacity recommendation and AI assessment for a single Azure resource.")
model RecommendCapacityResourceResult {
  @doc("ARM resource ID.")
  resourceId: armResourceIdentifier;

  @doc("ARM resource type, e.g. 'Microsoft.Compute/virtualMachines'.")
  resourceType?: string;

  @doc("SKU name, e.g. 'Standard_D4s_v3'.")
  skuName?: string;

  @doc("Azure region.")
  location?: string;

  @doc("AI-generated assessment of this resource's capacity fitness. Null when the AI agent is unavailable.")
  capacityAssessment?: string;

  @doc("Per-item error if the resource lookup failed.")
  error?: string;
}

@added(Versions.v2026_03_01_preview)
@doc("Result payload for a completed recommendCapacity operation.")
model RecommendCapacityResult {
  @doc("Per-resource capacity details and AI assessments.")
  @identifiers(#["resourceId"])
  resourceCapacities: RecommendCapacityResourceResult[];

  @doc("AI-generated cross-cutting recommendations.")
  recommendations: string[];

  @doc("Populated when the AI agent call fails.")
  agentError?: string;
}
