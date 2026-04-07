import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A task resource
 */
@parentResource(Project)
model ProjectTask
  is Azure.ResourceManager.ProxyResource<ProjectTaskProperties> {
  ...ResourceNameParameter<
    Resource = ProjectTask,
    KeyName = "taskName",
    SegmentName = "tasks",
    NamePattern = ""
  >;

  /**
   * HTTP strong entity tag value. This is ignored if submitted.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias ProjectTaskOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** Name of the resource group */
    @path
    @segment("resourceGroups")
    @key
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the service */
    @path
    @segment("services")
    @key
    serviceName: string;

    /** Name of the project */
    @path
    @segment("projects")
    @key
    projectName: string;
  },
  {
    /** Name of the Task */
    @path
    @segment("tasks")
    @key
    taskName: string;
  },
  ApiError
>;

@armResourceOperations(#{ omitTags: true })
interface ProjectTasks {
  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The GET method retrieves information about a task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_Get")
  @summary("Get task information")
  @tag("Task resource")
  @tag("Standard operation")
  @tag("GET")
  get is ProjectTaskOps.Read<
    ProjectTask,
    Parameters = {
      /**
       * Expand the response
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The PUT method creates a new task or updates an existing one, although since tasks have no mutable custom properties, there is little reason to update an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_CreateOrUpdate")
  @summary("Create or update task")
  @tag("Task resource")
  @tag("Standard operation")
  @tag("PUT")
  createOrUpdate is ProjectTaskOps.CreateOrUpdateSync<ProjectTask>;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The PATCH method updates an existing task, but since tasks have no mutable custom properties, there is little reason to do so.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_Update")
  @summary("Create or update task")
  @tag("Task resource")
  @tag("Standard operation")
  @tag("PATCH")
  @patch(#{ implicitOptionality: false })
  update is ProjectTaskOps.CustomPatchSync<
    ProjectTask,
    PatchModel = ProjectTask
  >;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The DELETE method deletes a task, canceling it first if it's running.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_Delete")
  @summary("Delete task")
  @tag("Task resource")
  @tag("Standard operation")
  @tag("DELETE")
  delete is ProjectTaskOps.DeleteSync<
    ProjectTask,
    Parameters = {
      /**
       * Delete the resource even if it contains running tasks
       */
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). This method returns a list of tasks owned by a service resource. Some tasks may have a status of Unknown, which indicates that an error occurred while querying the status of that task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_List")
  @summary("Get tasks in a service")
  @tag("Service resource")
  @tag("Standard operation")
  @tag("GET")
  list is ProjectTaskOps.List<
    ProjectTask,
    Parameters = {
      /**
       * Filter tasks by task type
       */
      @query("taskType")
      taskType?: string;
    },
    Response = ArmResponse<TaskList>
  >;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. This method cancels a task if it's currently queued or running.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_Cancel")
  @summary("Cancel a task")
  @tag("Task resource")
  @tag("Custom operation")
  @tag("POST")
  cancel is ProjectTaskOps.ActionSync<
    ProjectTask,
    void,
    ArmResponse<ProjectTask>
  >;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. This method executes a command on a running task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_Command")
  @summary("Execute a command on a task")
  @tag("Task resource")
  @tag("Custom operation")
  @tag("POST")
  command is ProjectTaskOps.ActionSync<
    ProjectTask,
    CommandProperties,
    ArmResponse<CommandProperties>
  >;
}
alias ServiceTaskOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** Name of the resource group */
    @path
    @segment("resourceGroups")
    @key
    groupName: string;

    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the service */
    @path
    @segment("services")
    @key
    serviceName: string;
  },
  {
    /** Name of the Task */
    @path
    @segment("serviceTasks")
    @key
    taskName: string;
  },
  ApiError
>;

@armResourceOperations(#{ omitTags: true })
interface ServiceTasks {
  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The GET method retrieves information about a service task.
   */
  @tag("Service Task resource")
  @tag("Standard operation")
  @tag("GET")
  @summary("Get service task information")
  get is ServiceTaskOps.Read<
    ProjectTask,
    Parameters = {
      /**
       * Expand the response
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The PUT method creates a new service task or updates an existing one, although since service tasks have no mutable custom properties, there is little reason to update an existing one.
   */
  @tag("Service Task resource")
  @tag("Standard operation")
  @tag("PUT")
  @summary("Create or update service task")
  createOrUpdate is ServiceTaskOps.CreateOrUpdateSync<ProjectTask>;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The PATCH method updates an existing service task, but since service tasks have no mutable custom properties, there is little reason to do so.
   */
  @tag("Service Task resource")
  @tag("Standard operation")
  @tag("PATCH")
  @summary("Create or update service task")
  @patch(#{ implicitOptionality: false })
  update is ServiceTaskOps.CustomPatchSync<
    ProjectTask,
    PatchModel = ProjectTask
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. The DELETE method deletes a service task, canceling it first if it's running.
   */
  @tag("Service Task resource")
  @tag("Standard operation")
  @tag("DELETE")
  @summary("Delete service task")
  delete is ServiceTaskOps.DeleteSync<
    ProjectTask,
    Parameters = {
      /**
       * Delete the resource even if it contains running tasks
       */
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;

  /**
   * The services resource is the top-level resource that represents the Azure Database Migration Service (classic). This method returns a list of service level tasks owned by a service resource. Some tasks may have a status of Unknown, which indicates that an error occurred while querying the status of that task.
   */
  @tag("Service resource")
  @tag("Standard operation")
  @tag("GET")
  @summary("Get service level tasks for a service")
  list is ServiceTaskOps.List<
    ProjectTask,
    Parameters = {
      /**
       * Filter tasks by task type
       */
      @query("taskType")
      taskType?: string;
    },
    Response = ArmResponse<TaskList>
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS (classic) instance. This method cancels a service task if it's currently queued or running.
   */
  @tag("Service Task resource")
  @tag("Custom operation")
  @tag("POST")
  @summary("Cancel a service task")
  cancel is ServiceTaskOps.ActionSync<
    ProjectTask,
    void,
    ArmResponse<ProjectTask>
  >;
}

@@doc(ProjectTask.name, "Name of the Task");
@@doc(ProjectTask.properties, "Custom task properties");
@@doc(ProjectTasks.createOrUpdate::parameters.resource,
  "Information about the task"
);
@@doc(ProjectTasks.update::parameters.properties, "Information about the task");
@@doc(ProjectTasks.command::parameters.body, "Command to execute");
@@doc(ServiceTasks.createOrUpdate::parameters.resource,
  "Information about the task"
);
@@doc(ServiceTasks.update::parameters.properties, "Information about the task");
