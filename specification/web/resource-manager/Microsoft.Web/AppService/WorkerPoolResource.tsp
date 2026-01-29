import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Worker pool of an App Service Environment ARM resource.
 */
@singleton("default")
@parentResource(AppServiceEnvironmentResource)
model WorkerPoolResource is Azure.ResourceManager.ProxyResource<WorkerPool> {
  ...ResourceNameParameter<
    Resource = WorkerPoolResource,
    KeyName = "multiRolePool",
    SegmentName = "multiRolePools",
    NamePattern = ""
  >;

  /**
   * Description of a SKU for a scalable resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: SkuDescription;

  /** Kind of resource. If the resource is an app, you can refer to https://github.com/Azure/app-service-linux-docs/blob/master/Things_You_Should_Know/kind_property.md#app-service-resource-kind-reference for details supported values for kind. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

@armResourceOperations
interface WorkerPoolResourceOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service Environment. */
        @path
        @segment("hostingEnvironments")
        @key
        name: string,
      },
      {
        /** undefined */
        @path
        @segment("multiRolePools")
        @key
        default: "default",
      }
    > {}

alias WorkerPoolActionParamsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
  },
  {
    /** Name of the App Service Environment. */
    @path
    @segment("hostingEnvironments")
    @key
    name: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/hostingEnvironments",
  }
>;

alias WorkerPoolInstanceMetricActionParamsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** Name of the App Service Environment. */
    @path
    @segment("hostingEnvironments")
    @key
    name: string;
  },
  {
    /** Name of the worker pool. */
    @path
    @segment("workerPools")
    @key
    workerPoolName: string;
  },
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/hostingEnvironments/{name}/workerPools",
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ allowStaticRoutes: true })
interface WorkerPoolResources {
  /**
   * Description for Get properties of a multi-role pool.
   */
  @summary("Get properties of a multi-role pool.")
  getMultiRolePool is WorkerPoolResourceOps.Read<
    WorkerPoolResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a multi-role pool.")
  createOrUpdateMultiRolePool is WorkerPoolResourceOps.CreateOrUpdateAsync<
    WorkerPoolResource,
    Response = ArmResourceUpdatedResponse<WorkerPoolResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WorkerPoolResource>> & {
      @bodyRoot
      _: WorkerPoolResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a multi-role pool.")
  @patch(#{ implicitOptionality: false })
  updateMultiRolePool is WorkerPoolResourceOps.CustomPatchSync<
    WorkerPoolResource,
    PatchModel = WorkerPoolResource,
    Response = ArmResponse<WorkerPoolResource> | (AcceptedResponse & {
      @bodyRoot
      _: WorkerPoolResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all multi-role pools.
   */
  @summary("Get all multi-role pools.")
  @segment("multiRolePools")
  listMultiRolePools is WorkerPoolResourceOps.List<
    WorkerPoolResource,
    Response = ArmResponse<WorkerPoolCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.
   */
  @summary("Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.")
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/instances/{instance}/metricdefinitions")
  listMultiRolePoolInstanceMetricDefinitions is WorkerPoolActionParamsOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    Parameters = {
      /**
       * Name of the instance in the multi-role pool.
       */
      @path
      instance: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get metric definitions for a multi-role pool of an App Service Environment.
   */
  @summary("Get metric definitions for a multi-role pool of an App Service Environment.")
  @get
  @action("metricdefinitions")
  @list
  listMultiRoleMetricDefinitions is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get available SKUs for scaling a multi-role pool.
   */
  @summary("Get available SKUs for scaling a multi-role pool.")
  @get
  @action("skus")
  @list
  listMultiRolePoolSkus is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<SkuInfoCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get usage metrics for a multi-role pool of an App Service Environment.
   */
  @summary("Get usage metrics for a multi-role pool of an App Service Environment.")
  @get
  @action("usages")
  @list
  listMultiRoleUsages is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<UsageCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}
@armResourceOperations
interface AppServiceEnvironmentOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the App Service Environment. */
        @path
        @segment("hostingEnvironments")
        @key
        name: string,
      },
      {
        /** Name of the worker pool. */
        @path
        @segment("workerPools")
        @key
        workerPoolName: string,
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface AppServiceEnvironments {
  /**
   * Description for Get properties of a worker pool.
   */
  @summary("Get properties of a worker pool.")
  getWorkerPool is AppServiceEnvironmentOps.Read<
    WorkerPoolResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a worker pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a worker pool.")
  createOrUpdateWorkerPool is AppServiceEnvironmentOps.CreateOrUpdateAsync<
    WorkerPoolResource,
    Response = ArmResourceUpdatedResponse<WorkerPoolResource> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = WorkerPoolResource>> & {
      @bodyRoot
      _: WorkerPoolResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Create or update a worker pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a worker pool.")
  @patch(#{ implicitOptionality: false })
  updateWorkerPool is AppServiceEnvironmentOps.CustomPatchSync<
    WorkerPoolResource,
    PatchModel = WorkerPoolResource,
    Response = ArmResponse<WorkerPoolResource> | (AcceptedResponse & {
      @bodyRoot
      _: WorkerPoolResource;
    }),
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get all worker pools of an App Service Environment.
   */
  @summary("Get all worker pools of an App Service Environment.")
  @segment("workerPools")
  listWorkerPools is AppServiceEnvironmentOps.List<
    WorkerPoolResource,
    Response = ArmResponse<WorkerPoolCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get metric definitions for a specific instance of a worker pool of an App Service Environment.
   */
  @summary("Get metric definitions for a specific instance of a worker pool of an App Service Environment.")
  @get
  @action("metricdefinitions")
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Web/hostingEnvironments/{name}/workerPools/{workerPoolName}/instances/{instance}/metricdefinitions")
  listWorkerPoolInstanceMetricDefinitions is WorkerPoolInstanceMetricActionParamsOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    Parameters = {
      /**
       * Name of the instance in the worker pool.
       */
      @path
      instance: string;
    },
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get metric definitions for a worker pool of an App Service Environment.
   */
  @summary("Get metric definitions for a worker pool of an App Service Environment.")
  @get
  @action("metricdefinitions")
  @list
  listWebWorkerMetricDefinitions is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get available SKUs for scaling a worker pool.
   */
  @summary("Get available SKUs for scaling a worker pool.")
  @get
  @action("skus")
  @list
  listWorkerPoolSkus is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<SkuInfoCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Description for Get usage metrics for a worker pool of an App Service Environment.
   */
  @summary("Get usage metrics for a worker pool of an App Service Environment.")
  @get
  @action("usages")
  @list
  listWebWorkerUsages is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<UsageCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(WorkerPoolResource.name, "");
@@doc(WorkerPoolResource.properties, "Core resource properties");
@@doc(WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "Properties of the multi-role pool."
);
@@doc(WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "Properties of the multi-role pool."
);
@@doc(AppServiceEnvironments.createOrUpdateWorkerPool::parameters.resource,
  "Properties of the worker pool."
);
@@doc(AppServiceEnvironments.updateWorkerPool::parameters.properties,
  "Properties of the worker pool."
);
