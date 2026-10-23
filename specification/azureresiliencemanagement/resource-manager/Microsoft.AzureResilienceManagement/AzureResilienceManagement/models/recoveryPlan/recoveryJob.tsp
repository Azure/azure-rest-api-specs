import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../common/common.tsp";
import "../common/Job.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@doc("Definition of recovery job associated with Recovery Orchestration Plan.")
model RecoveryJobProperties extends JobProperties {
  @doc("Discriminator for the Job object hierarchy.")
  jobType: JobType.RecoveryPlan;

  @doc("The provisioning state of the recovery job.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Versions.v2026_11_30_preview)
  @doc("Resiliency-specific properties for the recovery job.")
  resiliencyJobProperties?: RecoveryJobResiliencyProperties;
}

@added(Versions.v2026_11_30_preview)
@discriminator("resiliencyType")
@doc("Resiliency-specific properties for a recovery job.")
model RecoveryJobResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType;
}

@added(Versions.v2026_11_30_preview)
@doc("Infrastructure resiliency properties for a recovery job.")
model InfrastructureResiliencyJobProperties extends RecoveryJobResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.InfraResiliency;
}

@added(Versions.v2026_11_30_preview)
@doc("Cyber resiliency properties for a recovery job.")
model CyberResiliencyJobProperties extends RecoveryJobResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.CyberResiliency;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the completed infrastructure-creation job used by this restore job.")
  @visibility(Lifecycle.Read)
  infrastructureCreationJobId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans/recoveryJobs";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery point selection recorded for this job.")
  @visibility(Lifecycle.Read)
  recoveryPointSelection?: RecoveryPointSelectionProperties;
}

@added(Versions.v2026_11_30_preview)
@doc("Recovery point selection criteria recorded for a restore job.")
model RecoveryPointSelectionProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The recovery point selection type.")
  selectionType: RecoveryPointSelectionType;

  @added(Versions.v2026_11_30_preview)
  @doc("The inclusive start of the recovery point time range.")
  startTime?: utcDateTime;

  @added(Versions.v2026_11_30_preview)
  @doc("The inclusive end of the recovery point time range.")
  endTime?: utcDateTime;
}

@added(Versions.v2026_11_30_preview)
@doc("Specifies how recovery points are selected.")
union RecoveryPointSelectionType {
  @added(Versions.v2026_11_30_preview)
  @doc("Selects recovery points within a time range.")
  TimeRange: "TimeRange",

  @added(Versions.v2026_11_30_preview)
  @doc("Selects the latest recovery point.")
  Latest: "Latest",

  @added(Versions.v2026_11_30_preview)
  @doc("Selects a specific recovery point.")
  Specific: "Specific",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("Resource inclusion or exclusion criteria recorded for a recovery job.")
model ResourceSelectionProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resource selection type. Defaults to Exclusion when omitted.")
  selectionType?: ResourceSelectionType = ResourceSelectionType.Exclusion;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifiers selected for the operation.")
  resourceIds?: armResourceIdentifier[];
}

@added(Versions.v2026_11_30_preview)
@doc("Specifies whether listed resources are included or excluded.")
union ResourceSelectionType {
  @added(Versions.v2026_11_30_preview)
  @doc("Includes the listed resources.")
  Inclusion: "Inclusion",

  @added(Versions.v2026_11_30_preview)
  @doc("Excludes the listed resources.")
  Exclusion: "Exclusion",

  string,
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
@parentResource(RecoveryPlan)
@doc("Represents a recovery job resource in the Azure Resilience Management provider namespace.")
model RecoveryJob is ProxyResource<RecoveryJobProperties> {
  @doc("The unique name (GUID) of the recovery job.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("recoveryJobName")
  @segment("recoveryJobs")
  @path
  name: string;
}
