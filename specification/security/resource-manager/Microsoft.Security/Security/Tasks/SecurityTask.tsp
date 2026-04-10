import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

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

alias SecurityTaskOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
  {
    /** Name of the task object, will be a GUID */
    @path
    @segment("tasks")
    @key
    taskName: string;
  },
  {}
>;

alias SecurityTaskBuildingOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

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
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/tasks/{taskName}/{taskUpdateActionType}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true, omitTags: true })
interface SecurityTasks {
  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  @tag("Tasks")
  getSubscriptionLevelTask is SecurityTaskOps.Read<
    SecurityTask,
    OverrideErrorType = CloudError
  >;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  @tag("Tasks")
  listByHomeRegion is SecurityTaskOps.List<
    SecurityTask,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<SecurityTaskList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  @tag("Tasks")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Security/locations/{ascLocation}/tasks/{taskName}/{taskUpdateActionType}")
  updateSubscriptionLevelTaskState is SecurityTaskBuildingOps.ActionSync<
    SecurityTask,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Type of the action to do on the task
       */
      @path
      taskUpdateActionType: TaskUpdateActionType;
    },
    OverrideErrorType = CloudError
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

alias TaskBuildingOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

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
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/tasks/{taskName}/{taskUpdateActionType}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface Tasks {
  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  getResourceGroupLevelTask is TaskOps.Read<
    SecurityTask,
    OverrideErrorType = CloudError
  >;

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
    Response = ArmResponse<SecurityTaskList>,
    OverrideErrorType = CloudError
  >;

  /**
   * Recommended tasks that will help improve the security of the subscription proactively
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Security/locations/{ascLocation}/tasks/{taskName}/{taskUpdateActionType}")
  updateResourceGroupLevelTaskState is TaskBuildingOps.ActionSync<
    SecurityTask,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Type of the action to do on the task
       */
      @path
      taskUpdateActionType: TaskUpdateActionType;
    },
    OverrideErrorType = CloudError
  >;
}

@@doc(SecurityTask.name, "Name of the task object, will be a GUID");
@@doc(SecurityTask.properties, "Describes properties of a task.");


