import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DurableTask;

@doc("A Task Queue resource belonging to a Task Hub")
@added(Versions.v2026_07_01_Preview)
@parentResource(TaskHub)
model TaskQueue is Azure.ResourceManager.ProxyResource<TaskQueueProperties> {
  ...ResourceNameParameter<
    TaskQueue,
    "taskQueueName",
    "taskQueues",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
}

@doc("The properties of a Task Queue")
@added(Versions.v2026_07_01_Preview)
model TaskQueueProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("The throughput configuration of the Task Queue")
  throughput?: TaskQueueThroughput;
}

@doc("The throughput configuration of a Task Queue")
@added(Versions.v2026_07_01_Preview)
model TaskQueueThroughput {
  @doc("The rate of work-item handouts per second")
  actionsPerSecond?: int32;
}

@doc("The update request model for a Task Queue")
@added(Versions.v2026_07_01_Preview)
model TaskQueueUpdate
  is UpdateableProperties<Azure.ResourceManager.ProxyResource<TaskQueueProperties>>;

@added(Versions.v2026_07_01_Preview)
@armResourceOperations(TaskQueue)
interface TaskQueues {
  @doc("Get a Task Queue")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<TaskQueue>;
  @doc("Create or update a Task Queue")
  @errorsDoc("Validation error: required parameters are missing")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TaskQueue>;
  @doc("Update a Task Queue")
  @errorsDoc("Validation error: required parameters are missing")
  update is ArmCustomPatchAsync<TaskQueue, TaskQueueUpdate>;
  @doc("Delete a Task Queue")
  delete is ArmResourceDeleteWithoutOkAsync<TaskQueue>;
  @doc("List Task Queues by Task Hub")
  listByTaskHub is ArmResourceListByParent<TaskQueue>;
}
