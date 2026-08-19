import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../../recoveryPlans.tsp";
import "./resourceProtection.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@doc("Definition of recovery orchestration resource property associated with recovery orchestration plan.")
model RecoveryResourceProperties {
  @doc("A unique id for the recovery resource, which is a GUID.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  recoveryResourceUniqueId: string;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Resource ID of the Azure resource associated with the recovery orchestration plan and linked to the recovery resource.")
  @visibility(Lifecycle.Read)
  resourceId?: armResourceIdentifier;

  @doc("Original location of the Azure resource associated with the recovery orchestration plan and linked to the recovery resource.")
  @visibility(Lifecycle.Read)
  resourceLocation?: string;

  @added(Versions.v2026_03_01_preview)
  @doc("Physical zones of the Azure resource associated with the recovery orchestration plan and linked to the recovery resource.")
  @visibility(Lifecycle.Read)
  resourcePhysicalZones?: string[];

  @doc("A state that indicates the resource status with respect to the recovery orchestration plan.")
  inclusionState?: ResourceInclusionState;

  @doc("Indicating if resource needs user attention and action, details will be found in attentionReasons")
  @visibility(Lifecycle.Read)
  needsAttention?: boolean = false;

  @doc("Reason for the resource to be in need of attention")
  @visibility(Lifecycle.Read)
  attentionReasons?: string[];

  @doc("A status that indicates the protection status of a resource with an Azure solution for regional or zonal recovery.")
  @visibility(Lifecycle.Read)
  protectionStatus?: ResourceProtectionStatus;

  @doc("A list of ResourceProtectionSolutions with which the recovery orchestration resource is protected.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  resourceProtectionSolutions?: ResourceProtectionSolutionSettings[];

  @doc("A setting that indicates the protection solution selected.")
  selectedProtectionSolutionType?: ResourceProtectionSolutionType;

  @doc("Resource protection solution settings of the protection solutions recovery orchestration resource is protected with.")
  selectedProtectionSolutionSetting?: ResourceBaseProtectionSolutionSetting;

  @doc("The recovery orchestration group id associated with the recovery resources.")
  @pattern("[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  recoveryGroupId?: string;

  @doc("Identity details associated to the resource, which will be used for performing any operations on it")
  associatedIdentity?: AssociatedIdentity;

  @doc("Error details associated with the resource.")
  @visibility(Lifecycle.Read)
  errorDetails?: CommonTypes.ErrorDetail;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
@parentResource(RecoveryPlan)
@doc("RecoveryPlan Resource a AzureResilienceProviderHub resource")
model RecoveryResource is ProxyResource<RecoveryResourceProperties> {
  @doc("The unique name (Guid) of the recovery resource")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("recoveryResourceName")
  @segment("recoveryResources")
  @path
  name: string;
}

@doc("RecoveryResources post action request to update in batch.")
model UpdateRecoveryResourcesRequest {
  @doc("A list of recovery orchestration resources whose properties need to be updated.")
  @identifiers(#[])
  resourcesToUpdate?: RecoveryResource[];

  @doc("A list of recovery orchestration resources that need to be removed from the recovery orchestration plan.")
  resourcesToRemove?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans/recoveryResources";
    }
  ]>[];
}

@doc("RecoveryResources post action request to update in batch.")
model UpdateRecoveryResourcesResponse {
  @doc("A list of error details associated with resources for which the update has failed.")
  @identifiers(#[])
  failedResources?: RecoveryResource[];
}
