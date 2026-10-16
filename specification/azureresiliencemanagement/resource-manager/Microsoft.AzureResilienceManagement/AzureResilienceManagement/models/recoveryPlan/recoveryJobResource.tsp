import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../common/common.tsp";
import "../common/Job.tsp";
import "../common/JobResource.tsp";
import "./recoveryJob.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@doc("Properties of a recovery orchestration job resource associated with a recovery orchestration plan.")
model RecoveryJobResourceProperties extends JobResourceProperties {
  @doc("Discriminator for the Job object hierarchy.")
  jobResourceType: JobResourceType.RecoveryPlan;

  @doc("The provisioning state of the recovery job resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("A setting that indicates the protection solution selected.")
  @visibility(Lifecycle.Read)
  protectionSolutionType?: ResourceProtectionSolutionType;

  @added(Versions.v2026_03_01_preview)
  @doc("The recovery action settings.")
  @visibility(Lifecycle.Read)
  recoveryGroupActionSettings?: RecoveryGroupActionSettings;

  @added(Versions.v2026_11_30_preview)
  @doc("Resiliency-specific properties for the recovery job resource.")
  resiliencyJobResourceProperties?: RecoveryJobResourceResiliencyProperties;
}

@added(Versions.v2026_11_30_preview)
@discriminator("resiliencyType")
@doc("Resiliency-specific properties for a recovery job resource.")
model RecoveryJobResourceResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType;
}

@added(Versions.v2026_11_30_preview)
@doc("Infrastructure resiliency properties for a recovery job resource.")
model InfrastructureResiliencyJobResourceProperties extends RecoveryJobResourceResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.InfraResiliency;
}

@added(Versions.v2026_11_30_preview)
@doc("Cyber resiliency properties for a recovery job resource.")
model CyberResiliencyJobResourceProperties extends RecoveryJobResourceResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.CyberResiliency;

  @added(Versions.v2026_11_30_preview)
  @identifiers(#["resourceId"])
  @doc("The infrastructure resources created for this job resource.")
  @visibility(Lifecycle.Read)
  createdResources?: InfrastructureCreatedResource[];

  @added(Versions.v2026_11_30_preview)
  @doc("The restore tracking details for this job resource.")
  @visibility(Lifecycle.Read)
  restoreDetails?: RestoreJobResourceDetails;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery group identifier associated with this job resource.")
  @visibility(Lifecycle.Read)
  recoveryGroupId?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The order of the recovery group associated with this job resource.")
  @visibility(Lifecycle.Read)
  recoveryGroupOrderId?: int32;
}

@added(Versions.v2026_11_30_preview)
@doc("An infrastructure resource created during cyber recovery.")
model InfrastructureCreatedResource {
  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the recovery resource.")
  recoveryResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans/recoveryResources";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The profile property path that produced the resource.")
  propertyPath: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The full Azure resource type.")
  resourceType: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the created resource.")
  resourceId: armResourceIdentifier;
}

@added(Versions.v2026_11_30_preview)
@doc("Restore tracking details for a recovery job resource.")
model RestoreJobResourceDetails {
  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the source vault.")
  sourceVaultId: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults";
    },
    {
      type: "Microsoft.DataProtection/backupVaults";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the mapped vault.")
  mappedVaultId: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults";
    },
    {
      type: "Microsoft.DataProtection/backupVaults";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the backup instance.")
  backupInstanceId: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems";
    },
    {
      type: "Microsoft.DataProtection/backupVaults/backupInstances";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the backup job.")
  backupJobId: armResourceIdentifier<[
    {
      type: "Microsoft.RecoveryServices/vaults/backupJobs";
    },
    {
      type: "Microsoft.DataProtection/backupVaults/backupJobs";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery point identifier.")
  recoveryPointId: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the restored target.")
  targetArmId: armResourceIdentifier;

  @added(Versions.v2026_11_30_preview)
  @doc("The current restore state.")
  restoreState: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The serialized recovery configuration profile snapshot.")
  configProfileSnapshot: string;
}

@added(Versions.v2026_03_01_preview)
@doc("Settings for a recovery group action.")
model RecoveryGroupActionSettings {
  @added(Versions.v2026_03_01_preview)
  @doc("The action task associated with this job resource.")
  @visibility(Lifecycle.Read)
  actionTask?: ActionTask;

  @added(Versions.v2026_03_01_preview)
  @doc("Sequence number for the action.")
  @visibility(Lifecycle.Read)
  actionSequence?: int32;

  @added(Versions.v2026_03_01_preview)
  @doc("Type of the recovery group action.")
  @visibility(Lifecycle.Read)
  recoveryGroupActionType?: RecoveryGroupActionType;

  @added(Versions.v2026_03_01_preview)
  @doc("Name of the action.")
  @visibility(Lifecycle.Read)
  actionName?: string;

  @added(Versions.v2026_03_01_preview)
  @doc("User description of the action.")
  @visibility(Lifecycle.Read)
  actionDescription?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
@doc("Represents a recovery orchestration job resource in the Azure Resilience Management provider namespace.")
@parentResource(RecoveryJob)
model RecoveryJobResource is ProxyResource<RecoveryJobResourceProperties> {
  @doc("The unique name (GUID) of the recovery job resource.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("recoveryJobResourceName")
  @segment("recoveryJobResources")
  @path
  name: string;
}
