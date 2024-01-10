import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataMigration;
@doc("A task resource")
@parentResource(Project)
model ProjectTask is ProxyResource<ProjectTaskProperties> {
  @doc("Name of the Task")
  @key("taskName")
  @segment("tasks")
  name: string;

  @doc("HTTP strong entity tag value. This is ignored if submitted.")
  etag?: string;
}

@armResourceOperations
@projectedName("client", "Tasks")
interface ProjectTasks_Tasks {
  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The GET method retrieves information about a task.")
  get is ArmResourceRead<
    ProjectTask,
    {
      ...BaseParameters<ProjectTask>;

      @doc("Expand the response")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PUT method creates a new task or updates an existing one, although since tasks have no mutable custom properties, there is little reason to update an existing one.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectTask>;

  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PATCH method updates an existing task, but since tasks have no mutable custom properties, there is little reason to do so.")
  update is ArmCustomPatchSync<ProjectTask, ProjectTask>;

  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The DELETE method deletes a task, canceling it first if it's running.")
  delete is ArmResourceDeleteSync<
    ProjectTask,
    {
      ...BaseParameters<ProjectTask>;

      @doc("Delete the resource even if it contains running tasks")
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;

  @doc("The services resource is the top-level resource that represents the Database Migration Service. This method returns a list of tasks owned by a service resource. Some tasks may have a status of Unknown, which indicates that an error occurred while querying the status of that task.")
  list is ArmResourceListByParent<
    ProjectTask,
    {
      ...BaseParameters<ProjectTask>;

      @doc("Filter tasks by task type")
      @query("taskType")
      taskType?: string;
    }
  >;

  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method cancels a task if it's currently queued or running.")
  cancel is ArmResourceActionSync<ProjectTask, void, ProjectTask>;

  @doc("The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method executes a command on a running task.")
  command is ArmResourceActionSync<
    ProjectTask,
    CommandProperties,
    CommandProperties
  >;
}
