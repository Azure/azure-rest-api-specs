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
