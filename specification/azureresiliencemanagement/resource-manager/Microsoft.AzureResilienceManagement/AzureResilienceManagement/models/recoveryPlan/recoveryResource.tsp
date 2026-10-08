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

@added(Versions.v2026_10_31_preview)
@doc("Reason why a recovery resource cannot be included in a recovery plan.")
union ResourceInclusionDisabledReason {
  @added(Versions.v2026_10_31_preview)
  @doc("The resource is highly available and does not require recovery-plan inclusion.")
  ResourceHighlyAvailable: "ResourceHighlyAvailable",

  @added(Versions.v2026_10_31_preview)
  @doc("The resource uses active-active protection.")
  ResourceActiveActiveProtection: "ResourceActiveActiveProtection",

  string,
}

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

  @added(Versions.v2026_10_31_preview)
  @visibility(Lifecycle.Read)
  @doc("Reasons why inclusion of the resource in a recovery plan is disabled.")
  inclusionDisabledReasons?: ResourceInclusionDisabledReason[];

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

  @added(Versions.v2026_11_30_preview)
  @doc("Resiliency-specific properties for the recovery resource.")
  resiliencyResourceProperties?: RecoveryResourceResiliencyProperties;
}

@added(Versions.v2026_11_30_preview)
@discriminator("resiliencyType")
@doc("Resiliency-specific properties for a recovery resource.")
model RecoveryResourceResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType;
}

@added(Versions.v2026_11_30_preview)
@doc("Infrastructure resiliency properties for a recovery resource.")
model InfrastructureResiliencyResourceProperties extends RecoveryResourceResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.InfraResiliency;
}

@added(Versions.v2026_11_30_preview)
@doc("Indicates whether a recovery resource can be included for the configured targets.")
union RecoveryResourceInclusionEligibility {
  @added(Versions.v2026_11_30_preview)
  @doc("The recovery resource can be included.")
  CanBeIncluded: "CanBeIncluded",

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery resource cannot be included.")
  CannotBeIncluded: "CannotBeIncluded",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("Cyber resiliency properties for a recovery resource.")
model CyberResiliencyResourceProperties extends RecoveryResourceResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.CyberResiliency;

  @added(Versions.v2026_11_30_preview)
  @doc("The workload type of the Azure resource linked to the recovery resource.")
  @visibility(Lifecycle.Read)
  workloadType?: WorkloadType;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifiers of the backup vaults protecting the resource.")
  @visibility(Lifecycle.Read)
  vaultResourceIds?: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults";
    },
    {
      type: "Microsoft.DataProtection/backupVaults";
    }
  ]>[];

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifiers of the target-tenant mapped backup vaults.")
  @visibility(Lifecycle.Read)
  mappedVaultResourceIds?: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults";
    },
    {
      type: "Microsoft.DataProtection/backupVaults";
    }
  ]>[];

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the container for a non-Azure-resource child.")
  @visibility(Lifecycle.Read)
  containerResourceId?: armResourceIdentifier;

  @added(Versions.v2026_11_30_preview)
  @doc("The service group member identifiers through which this resource was discovered.")
  @visibility(Lifecycle.Read)
  membershipThroughServiceGroupMembers?: armResourceIdentifier[];

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the per-resource recovery configuration profile override.")
  recoveryConfigProfileId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans/recoveryConfigProfiles";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The identifiers of the protected items in the backup vaults.")
  @visibility(Lifecycle.Read)
  protectedItemIds?: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems";
    },
    {
      type: "Microsoft.DataProtection/backupVaults/backupInstances";
    }
  ]>[];

  @added(Versions.v2026_11_30_preview)
  @doc("The current backup protection state.")
  @visibility(Lifecycle.Read)
  protectionState?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("Indicates whether the resource can be included for the configured targets.")
  @visibility(Lifecycle.Read)
  canBeIncluded?: RecoveryResourceInclusionEligibility = RecoveryResourceInclusionEligibility.CannotBeIncluded;

  @added(Versions.v2026_11_30_preview)
  @doc("The target locations that support recovery of this resource.")
  @visibility(Lifecycle.Read)
  supportedTargetLocations?: string[];
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
