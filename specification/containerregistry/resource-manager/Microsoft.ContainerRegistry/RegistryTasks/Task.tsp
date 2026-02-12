import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerRegistry;
/**
 * The task that has the ARM resource and task properties.
 * The task will have all information to schedule a run against it.
 */
@parentResource(Registry)
model Task is Azure.ResourceManager.TrackedResource<TaskProperties> {
  ...ResourceNameParameter<
    Resource = Task,
    KeyName = "taskName",
    SegmentName = "tasks",
    NamePattern = "^[a-zA-Z0-9-_]*$"
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: IdentityProperties;
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
  create is ArmResourceCreateOrReplaceSync<Task>;

  /**
   * Updates a task with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Task, PatchModel = TaskUpdateParameters>;

  /**
   * Deletes a specified task.
   */
  delete is ArmResourceDeleteSync<Task>;

  /**
   * Lists all the tasks for a specified container registry.
   */
  @list
  list is ArmResourceListByParent<Task, Response = ArmResponse<TaskListResult>>;

  /**
   * Returns a task with extended information that includes all secrets.
   */
  @action("listDetails")
  getDetails is ArmResourceActionSync<Task, void, ArmResponse<Task>>;
}

@@maxLength(Task.name, 50);
@@minLength(Task.name, 5);
@@doc(Task.name, "The name of the container registry task.");
@@doc(Task.properties, "The properties of a task.");
@@doc(Tasks.create::parameters.resource, "The parameters for creating a task.");
@@doc(Tasks.update::parameters.properties,
  "The parameters for updating a task."
);
