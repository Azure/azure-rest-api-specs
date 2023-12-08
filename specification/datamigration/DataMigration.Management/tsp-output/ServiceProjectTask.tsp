import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
@doc("A task resource")
@parentResource(Project)
model ServiceProjectTask is ProxyResource<ProjectTaskProperties> {
  @doc("Name of the Task")
  @path
  @key("taskName")
  @segment("tasks")
  name: string;
}

@armResourceOperations
interface ServiceProjectTasks {
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The GET method retrieves information about a task.")
  get is ArmResourceRead<
    ServiceProjectTask,
    {
      ...BaseParameters<ServiceProjectTask>;

      @doc("Expand the response")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PUT method creates a new task or updates an existing one, although since tasks have no mutable custom properties, there is little reason to update an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ServiceProjectTask>;
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PATCH method updates an existing task, but since tasks have no mutable custom properties, there is little reason to do so.")
  update is ArmResourcePatchSync<ServiceProjectTask, ProjectTaskProperties>;
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The DELETE method deletes a task, canceling it first if it's running.")
  delete is ArmResourceDeleteSync<
    ServiceProjectTask,
    {
      ...BaseParameters<ServiceProjectTask>;

      @doc("Delete the resource even if it contains running tasks")
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;
  @doc("The services resource is the top-level resource that represents the Database Migration Service. This method returns a list of tasks owned by a service resource. Some tasks may have a status of Unknown, which indicates that an error occurred while querying the status of that task.")
  list is ArmResourceListByParent<
    ServiceProjectTask,
    {
      ...BaseParameters<ServiceProjectTask>;

      @doc("Filter tasks by task type")
      @query("taskType")
      taskType?: string;
    }
  >;
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method cancels a task if it's currently queued or running.")
  cancel is ArmResourceActionSync<ServiceProjectTask, {}, ServiceProjectTask>;
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method executes a command on a running task.")
  command is ArmResourceActionSync<
    ServiceProjectTask,
    CommandProperties,
    CommandProperties
  >;
}
