import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

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
  update is ArmResourcePatchAsync<Scheduler, SchedulerProperties>;
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
