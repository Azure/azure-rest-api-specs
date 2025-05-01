import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.DurableTask" })
@versioned(Versions)
namespace Microsoft.DurableTask;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-10-01-preview")
  v2024_10_01_Preview: "2024-10-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-04-01-preview")
  v2025_04_01_Preview: "2025-04-01-preview",
}

@doc("A Durable Task Scheduler resource")
@added(Versions.v2024_10_01_Preview)
model Scheduler is Azure.ResourceManager.TrackedResource<SchedulerProperties> {
  ...ResourceNameParameter<
    Scheduler,
    "schedulerName",
    "schedulers",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
}

@doc("Details of the Scheduler")
@added(Versions.v2024_10_01_Preview)
model SchedulerProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("IP allow list for durable task scheduler. Values can be IPv4, IPv6 or CIDR")
  ipAllowlist: string[];

  @doc("SKU of the durable task scheduler")
  sku: SchedulerSku;
}

@doc("The SKU (Stock Keeping Unit) assigned to this durable task scheduler")
@added(Versions.v2024_10_01_Preview)
model SchedulerSku {
  @doc("The name of the SKU")
  name: string;

  @doc("The SKU capacity. This allows scale out/in for the resource and impacts zone redundancy")
  capacity?: int32;

  @doc("Indicates whether the current SKU configuration is zone redundant")
  @visibility(Lifecycle.Read)
  redundancyState?: RedundancyState;
}

@doc("A Task Hub resource belonging to the scheduler")
@added(Versions.v2024_10_01_Preview)
@parentResource(Scheduler)
model TaskHub is Azure.ResourceManager.ProxyResource<TaskHubProperties> {
  ...ResourceNameParameter<
    TaskHub,
    "taskHubName",
    "taskHubs",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
}

@doc("The state of the resource redundancy")
union RedundancyState {
  string,

  @doc("The resource is not redundant")
  None: "None",

  @doc("The resource is zone redundant")
  Zone: "Zone",
}

@doc("The properties of Task Hub")
model TaskHubProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler dashboard")
  @visibility(Lifecycle.Read)
  dashboardUrl?: url;
}

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
  @OpenAPI.extension(
    "x-ms-identifiers",
    #["retentionPeriodInDays", "orchestrationState"]
  )
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

@doc("The status of the current operation")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("The update request model for the Scheduler resource")
model SchedulerUpdate
  is UpdateableProperties<Azure.ResourceManager.TrackedResource<SchedulerPropertiesUpdate>>;

@doc("The Scheduler resource properties to be updated")
model SchedulerPropertiesUpdate {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("IP allow list for durable task scheduler. Values can be IPv4, IPv6 or CIDR")
  ipAllowlist?: string[];

  @doc("SKU of the durable task scheduler")
  sku?: SchedulerSkuUpdate;
}

@doc("The SKU (Stock Keeping Unit) properties to be updated")
model SchedulerSkuUpdate {
  @doc("The name of the SKU")
  name?: string;

  @doc("The SKU capacity. This allows scale out/in for the resource and impacts zone redundancy")
  capacity?: int32;

  @doc("Indicates whether the current SKU configuration is zone redundant")
  @visibility(Lifecycle.Read)
  redundancyState?: RedundancyState;
}

@armResourceOperations(Scheduler)
interface Schedulers {
  @doc("Get a Scheduler")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<Scheduler>;
  @doc("Create or update a Scheduler")
  @errorsDoc("Validation error: required parameters are missing")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Scheduler>;
  @doc("Update a Scheduler")
  @errorsDoc("Validation error: required parameters are missing")
  update is ArmCustomPatchAsync<Scheduler, SchedulerUpdate>;
  @doc("Delete a Scheduler")
  delete is ArmResourceDeleteWithoutOkAsync<Scheduler>;
  @doc("List Schedulers by resource group")
  listByResourceGroup is ArmResourceListByParent<Scheduler>;
  @doc("List Schedulers by subscription")
  listBySubscription is ArmListBySubscription<Scheduler>;
}

@armResourceOperations(TaskHub)
interface TaskHubs {
  @doc("Get a Task Hub")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<TaskHub>;
  @doc("Create or Update a Task Hub")
  @errorsDoc("Validation error: required parameters are missing")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TaskHub>;
  @doc("Delete a Task Hub")
  delete is ArmResourceDeleteWithoutOkAsync<TaskHub>;
  @doc("List Task Hubs")
  listByScheduler is ArmResourceListByParent<TaskHub>;
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
