import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Project.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * A task resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Project)
@includeInapplicableMetadataInPayload(false)
model ProjectTask extends Resource {
  /**
   * Name of the Task
   */
  @path
  @key("taskName")
  @segment("tasks")
  @visibility("read")
  name: string;

  /**
   * HTTP strong entity tag value. This is ignored if submitted.
   */
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Custom task properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ProjectTaskProperties;
}

@armResourceOperations
interface ProjectTasks {
  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The GET method retrieves information about a task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_Get")
  get is ArmResourceRead<
    ProjectTask,
    {
      ...BaseParameters<ProjectTask>;

      /**
       * Expand the response
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PUT method creates a new task or updates an existing one, although since tasks have no mutable custom properties, there is little reason to update an existing one.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ProjectTask>;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PATCH method updates an existing task, but since tasks have no mutable custom properties, there is little reason to do so.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Tasks_Update")
  update is ArmCustomPatchSync<ProjectTask, ProjectTask>;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The DELETE method deletes a task, canceling it first if it's running.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_Delete")
  delete is ArmResourceDeleteSync<
    ProjectTask,
    {
      ...BaseParameters<ProjectTask>;

      /**
       * Delete the resource even if it contains running tasks
       */
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    }
  >;

  /**
   * The services resource is the top-level resource that represents the Database Migration Service. This method returns a list of tasks owned by a service resource. Some tasks may have a status of Unknown, which indicates that an error occurred while querying the status of that task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_List")
  list is ArmResourceListByParent<
    ProjectTask,
    {
      ...BaseParameters<ProjectTask>;

      /**
       * Filter tasks by task type
       */
      @query("taskType")
      taskType?: string;
    }
  >;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method cancels a task if it's currently queued or running.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_Cancel")
  cancel is ArmResourceActionSync<ProjectTask, void, ProjectTask>;

  /**
   * The tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method executes a command on a running task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tasks_Command")
  command is ArmResourceActionSync<
    ProjectTask,
    CommandProperties,
    CommandProperties
  >;
}

@@projectedName(ProjectTasks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ProjectTasks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ProjectTasks.createOrUpdate::parameters.resource,
  "Information about the task"
);
@@projectedName(ProjectTasks.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ProjectTasks.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ProjectTasks.update::parameters.properties, "Information about the task");
@@projectedName(ProjectTasks.command::parameters.body, "json", "parameters");
@@extension(ProjectTasks.command::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ProjectTasks.command::parameters.body, "Command to execute");
