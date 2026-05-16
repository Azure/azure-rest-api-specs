import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../common/common.tsp";
import "../common/Job.tsp";
import "../common/ChildJob.tsp";
import "./recoveryJob.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

// Define the main model
@removed(Versions.v2026_04_01_preview)
@doc("Definition of recovery child job associated with Recovery Orchestration Plan.")
model RecoveryChildJobProperties extends ChildJobProperties {
  @doc("Discriminator for the Job Type hierarchy.")
  jobType: JobType.RecoveryPlanChild;

  @doc("The provisioning state of the recovery child job.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("A setting that indicates the protection solution selected.")
  @visibility(Lifecycle.Read)
  protectionSolutionType?: ResourceProtectionSolutionType;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Operation not supported for it"
@removed(Versions.v2026_04_01_preview)
@parentResource(RecoveryJob)
@doc("RecoveryPlan Child Job a AzureResilienceProviderHub resource")
model RecoveryChildJob is ProxyResource<RecoveryChildJobProperties> {
  @doc("The unique name (Guid) of the recovery child job")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("recoveryChildJobName")
  @segment("recoveryChildJobs")
  @path
  name: string;
}
