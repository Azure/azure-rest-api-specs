import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Registry.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
* The task that has the ARM resource and task properties. 
The task will have all information to schedule a run against it.
*/
@parentResource(Registry)
model Task is TrackedResource<TaskProperties> {
  /**
   * The name of the container registry task.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9-_]*$")
  @path
  @key("taskName")
  @segment("tasks")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface Tasks {
  /**
   * Get the properties of a specified task.
   */
  get is ArmResourceRead<Task>;

  /**
   * Creates a task for a container registry with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<Task>;

  /**
   * Updates a task with the specified parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Task, TaskUpdateParameters>;

  /**
   * Deletes a specified task.
   */
  delete is ArmResourceDeleteAsync<Task>;

  /**
   * Lists all the tasks for a specified container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_List")
  list is ArmResourceListByParent<Task>;

  /**
   * Returns a task with extended information that includes all secrets.
   */
  getDetails is ArmResourceActionSync<Task, void, Task>;
}

@@projectedName(Tasks.create::parameters.resource,
  "json",
  "taskCreateParameters"
);
@@extension(Tasks.create::parameters.resource,
  "x-ms-client-name",
  "taskCreateParameters"
);
@@doc(Tasks.create::parameters.resource, "The parameters for creating a task.");
@@projectedName(Tasks.update::parameters.properties,
  "json",
  "taskUpdateParameters"
);
@@extension(Tasks.update::parameters.properties,
  "x-ms-client-name",
  "taskUpdateParameters"
);
@@doc(Tasks.update::parameters.properties,
  "The parameters for updating a task."
);
