import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

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

@doc("The properties of Task Hub")
model TaskHubProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler dashboard")
  @visibility(Lifecycle.Read)
  dashboardUrl?: url;

  @added(Versions.v2026_05_01_Preview)
  @doc("A set of Task Hub capabilities that can be enabled or disabled for a Task Hub")
  capabilities?: string[];
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
