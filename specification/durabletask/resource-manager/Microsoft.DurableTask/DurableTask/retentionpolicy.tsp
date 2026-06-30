import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

@doc("A retention policy resource belonging to the scheduler")
@added(Versions.v2025_04_01_Preview)
@parentResource(Scheduler)
@singleton
model RetentionPolicy
  is Azure.ResourceManager.ProxyResource<RetentionPolicyProperties> {
  ...ResourceNameParameter<
    RetentionPolicy,
    "retentionPolicyName",
    "retentionPolicies"
  >;
}

@doc("The retention policy settings for the resource")
@added(Versions.v2025_04_01_Preview)
model RetentionPolicyProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("The orchestration retention policies")
  @identifiers(#["retentionPeriodInDays", "orchestrationState"])
  retentionPolicies?: RetentionPolicyDetails[];
}

@doc("The properties of a retention policy")
@added(Versions.v2025_04_01_Preview)
model RetentionPolicyDetails {
  @doc("The retention period in days after which the orchestration will be purged automatically")
  retentionPeriodInDays: int32;

  @doc("The orchestration state to which this policy applies. If omitted, the policy applies to all purgeable orchestration states.")
  orchestrationState?: PurgeableOrchestrationState;
}

@doc("Purgeable orchestration state to be used in retention policies")
@added(Versions.v2025_04_01_Preview)
union PurgeableOrchestrationState {
  string,

  @doc("The orchestration is completed")
  Completed: "Completed",

  @doc("The orchestration is failed")
  Failed: "Failed",

  @doc("The orchestration is terminated")
  Terminated: "Terminated",

  @doc("The orchestration is canceled")
  Canceled: "Canceled",
}

@added(Versions.v2025_04_01_Preview)
@armResourceOperations(RetentionPolicy)
interface RetentionPolicies {
  @doc("Get a Retention Policy")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<RetentionPolicy>;
  @doc("Create or Update a Retention Policy")
  @errorsDoc("Validation error: required parameters are missing")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RetentionPolicy>;
  @doc("Update a Retention Policy")
  @errorsDoc("Validation error: required parameters are missing")
  update is ArmResourcePatchAsync<RetentionPolicy, RetentionPolicyProperties>;
  @doc("Delete a Retention Policy")
  delete is ArmResourceDeleteWithoutOkAsync<RetentionPolicy>;
  @doc("List Retention Policies")
  listByScheduler is ArmResourceListByParent<RetentionPolicy>;
}
