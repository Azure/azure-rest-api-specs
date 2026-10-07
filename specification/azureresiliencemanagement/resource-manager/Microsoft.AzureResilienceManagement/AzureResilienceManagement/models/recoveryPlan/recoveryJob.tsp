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
  @doc("Properties specific to a cyber recovery job.")
  cyberRecoveryJobProperties?: CyberRecoveryJobProperties;
}

@added(Versions.v2026_11_30_preview)
@doc("Properties specific to a cyber recovery job.")
model CyberRecoveryJobProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the completed create-infrastructure job used by this restore job.")
  @visibility(Lifecycle.Read)
  createInfraJobId?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery point selection recorded for this job.")
  @visibility(Lifecycle.Read)
  recoveryPointSelectionProperties?: RecoveryPointSelectionProperties;
}

@added(Versions.v2026_11_30_preview)
@doc("Recovery point selection criteria recorded for a restore job.")
model RecoveryPointSelectionProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The selection kind, such as TimeRange, Latest, or Specific.")
  selectedListType: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The inclusive start of the recovery point time range.")
  startTime?: utcDateTime;

  @added(Versions.v2026_11_30_preview)
  @doc("The inclusive end of the recovery point time range.")
  endTime?: utcDateTime;
}

@added(Versions.v2026_11_30_preview)
@doc("Resource inclusion or exclusion criteria recorded for a recovery job.")
model ResourceSelectionProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The selection kind, either Inclusion or Exclusion.")
  selectedListType: string = "Exclusion";

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifiers selected for the operation.")
  selectedResourceIds?: string[];
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
