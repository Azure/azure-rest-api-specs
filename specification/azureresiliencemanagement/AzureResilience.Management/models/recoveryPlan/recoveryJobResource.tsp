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
  recoveryActionSettings: RecoveryActionSettings;
}

@added(Versions.v2026_03_01_preview)
@doc("Settings for a recovery action.")
model RecoveryActionSettings {
  @doc("The action task associated with this job resource.")
  actionTask: ActionTask;

  @doc("Sequence number for the action.")
  actionSequence: int32;

  @doc("Type of the action (ManualAction/CustomRunbook).")
  actionType: string;

  @doc("Name of the action.")
  actionName: string;
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
