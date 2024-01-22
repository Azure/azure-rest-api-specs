import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataMigration;

interface ResourceSkusOperations {
  /**
   * The skus action returns the list of SKUs that DMS supports.
   */
  @summary("Get supported SKUs")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataMigration/skus")
  @get
  listSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceSkusResult
  >;
}

interface ServiceTasksOperations {
  /**
   * The services resource is the top-level resource that represents the Database Migration Service. This method returns a list of service level tasks owned by a service resource. Some tasks may have a status of Unknown, which indicates that an error occurred while querying the status of that task.
   */
  @summary("Get service level tasks for a service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/serviceTasks")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group
       */
      @path
      groupName: string;

      /**
       * Name of the service
       */
      @path
      serviceName: string;

      /**
       * Filter tasks by task type
       */
      @query("taskType")
      taskType?: string;
    },
    ResourceListResult<ProjectTask>
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PUT method creates a new service task or updates an existing one, although since service tasks have no mutable custom properties, there is little reason to update an existing one.
   */
  @summary("Create or update service task")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/serviceTasks/{taskName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group
       */
      @path
      groupName: string;

      /**
       * Name of the service
       */
      @path
      serviceName: string;

      /**
       * Name of the Task
       */
      @path
      taskName: string;

      /**
       * Information about the task
       */
      @body
      parameters: ProjectTask;
    },
    ProjectTask
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The GET method retrieves information about a service task.
   */
  @summary("Get service task information")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/serviceTasks/{taskName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group
       */
      @path
      groupName: string;

      /**
       * Name of the service
       */
      @path
      serviceName: string;

      /**
       * Name of the Task
       */
      @path
      taskName: string;

      /**
       * Expand the response
       */
      @query("$expand")
      $expand?: string;
    },
    ProjectTask
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The DELETE method deletes a service task, canceling it first if it's running.
   */
  @summary("Delete service task")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/serviceTasks/{taskName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group
       */
      @path
      groupName: string;

      /**
       * Name of the service
       */
      @path
      serviceName: string;

      /**
       * Name of the Task
       */
      @path
      taskName: string;

      /**
       * Delete the resource even if it contains running tasks
       */
      @query("deleteRunningTasks")
      deleteRunningTasks?: boolean;
    },
    void
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. The PATCH method updates an existing service task, but since service tasks have no mutable custom properties, there is little reason to do so.
   */
  @summary("Create or update service task")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/serviceTasks/{taskName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group
       */
      @path
      groupName: string;

      /**
       * Name of the service
       */
      @path
      serviceName: string;

      /**
       * Name of the Task
       */
      @path
      taskName: string;

      /**
       * Information about the task
       */
      @body
      parameters: ProjectTask;
    },
    ProjectTask
  >;

  /**
   * The service tasks resource is a nested, proxy-only resource representing work performed by a DMS instance. This method cancels a service task if it's currently queued or running.
   */
  @summary("Cancel a service task")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.DataMigration/services/{serviceName}/serviceTasks/{taskName}/cancel")
  @post
  cancel is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group
       */
      @path
      groupName: string;

      /**
       * Name of the service
       */
      @path
      serviceName: string;

      /**
       * Name of the Task
       */
      @path
      taskName: string;
    },
    ProjectTask
  >;
}

interface UsagesOperations {
  /**
   * This method returns region-specific quotas and resource usage information for the Database Migration Service.
   */
  @summary("Get resource quotas and usage information")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.DataMigration/locations/{location}/usages")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The Azure region of the operation
       */
      @path
      location: string;
    },
    QuotaList
  >;
}
