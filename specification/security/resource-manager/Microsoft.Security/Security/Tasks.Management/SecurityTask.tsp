import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Security;
/**
 * Security task that we recommend to do in order to strengthen security
 */
@subscriptionResource
model SecurityTask
  is Azure.ResourceManager.ProxyResource<SecurityTaskProperties> {
  ...ResourceNameParameter<
    Resource = SecurityTask,
    KeyName = "taskName",
    SegmentName = "tasks",
    NamePattern = ""
  >;
}

alias SecurityTaskOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Security";

    /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
    @path
    @segment("locations")
    @key
    ascLocation: string;
  },
  {},
  {
    /** Name of the task object, will be a GUID */
    @path
    @segment("tasks")
    @key
    taskName: string;
  }
>;

@armResourceOperations
interface SecurityTasks {
  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_GetSubscriptionLevelTask")
  getSubscriptionLevelTask is SecurityTaskOps.Read<SecurityTask>;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_ListByHomeRegion")
  listByHomeRegion is SecurityTaskOps.List<
    SecurityTask,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<SecurityTaskList>
  >;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tasks_UpdateSubscriptionLevelTaskState")
  @action("{taskUpdateActionType}")
  updateSubscriptionLevelTaskState is SecurityTaskOps.ActionSync<
    SecurityTask,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Type of the action to do on the task
       */
      @path
      taskUpdateActionType: TaskUpdateActionType;
    }
  >;
}
alias TaskOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The location where ASC stores the data of the subscription. can be retrieved from Get locations */
    @path
    @segment("locations")
    @key
    ascLocation: string;
  },
  {
    /** Name of the task object, will be a GUID */
    @path
    @segment("tasks")
    @key
    taskName: string;
  }
>;

@armResourceOperations
interface Tasks {
  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  getResourceGroupLevelTask is TaskOps.Read<SecurityTask>;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  listByResourceGroup is TaskOps.List<
    SecurityTask,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<SecurityTaskList>
  >;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  @action("{taskUpdateActionType}")
  updateResourceGroupLevelTaskState is TaskOps.ActionSync<
    SecurityTask,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Type of the action to do on the task
       */
      @path
      taskUpdateActionType: TaskUpdateActionType;
    }
  >;
}

@@doc(SecurityTask.name, "Name of the task object, will be a GUID");
@@doc(SecurityTask.properties, "Describes properties of a task.");
