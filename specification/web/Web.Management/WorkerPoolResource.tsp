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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: SkuDescription;
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface WorkerPoolResources {
  /**
   * Description for Get properties of a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_GetMultiRolePool")
  getMultiRolePool is WorkerPoolResourceOps.Read<WorkerPoolResource>;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("AppServiceEnvironments_CreateOrUpdateMultiRolePool")
  createOrUpdateMultiRolePool is WorkerPoolResourceOps.CreateOrUpdateAsync<
    WorkerPoolResource,
    Response = ArmResourceUpdatedResponse<WorkerPoolResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: WorkerPoolResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = WorkerPoolResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @operationId("AppServiceEnvironments_UpdateMultiRolePool")
  @patch(#{ implicitOptionality: false })
  updateMultiRolePool is WorkerPoolResourceOps.CustomPatchSync<
    WorkerPoolResource,
    PatchModel = WorkerPoolResource,
    Response = ArmResponse<WorkerPoolResource> | (AcceptedResponse & {
      @bodyRoot
      _: WorkerPoolResource;
    })
  >;

  /**
   * Description for Get all multi-role pools.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_ListMultiRolePools")
  @segment("multiRolePools")
  listMultiRolePools is WorkerPoolResourceOps.List<
    WorkerPoolResource,
    Response = ArmResponse<WorkerPoolCollection>
  >;

  /**
   * Description for Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_ListMultiRolePoolInstanceMetricDefinitions")
  @get
  @action("metricdefinitions")
  @list
  listMultiRolePoolInstanceMetricDefinitions is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    Parameters = {
      /**
       * Name of the instance in the multi-role pool.
       */
      @path
      @segment("instances")
      instance: string;
    }
  >;

  /**
   * Description for Get metric definitions for a multi-role pool of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_ListMultiRoleMetricDefinitions")
  @get
  @action("metricdefinitions")
  @list
  listMultiRoleMetricDefinitions is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>
  >;

  /**
   * Description for Get available SKUs for scaling a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_ListMultiRolePoolSkus")
  @get
  @action("skus")
  @list
  listMultiRolePoolSkus is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<SkuInfoCollection>
  >;

  /**
   * Description for Get usage metrics for a multi-role pool of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AppServiceEnvironments_ListMultiRoleUsages")
  @get
  @action("usages")
  @list
  listMultiRoleUsages is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<UsageCollection>
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

@armResourceOperations
interface AppServiceEnvironments {
  /**
   * Description for Get properties of a worker pool.
   */
  getWorkerPool is AppServiceEnvironmentOps.Read<WorkerPoolResource>;

  /**
   * Description for Create or update a worker pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdateWorkerPool is AppServiceEnvironmentOps.CreateOrUpdateAsync<
    WorkerPoolResource,
    Response = ArmResourceUpdatedResponse<WorkerPoolResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: WorkerPoolResource;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = WorkerPoolResource> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Create or update a worker pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" ""
  @patch(#{ implicitOptionality: false })
  updateWorkerPool is AppServiceEnvironmentOps.CustomPatchSync<
    WorkerPoolResource,
    PatchModel = WorkerPoolResource,
    Response = ArmResponse<WorkerPoolResource> | (AcceptedResponse & {
      @bodyRoot
      _: WorkerPoolResource;
    })
  >;

  /**
   * Description for Get all worker pools of an App Service Environment.
   */
  @segment("workerPools")
  listWorkerPools is AppServiceEnvironmentOps.List<
    WorkerPoolResource,
    Response = ArmResponse<WorkerPoolCollection>
  >;

  /**
   * Description for Get metric definitions for a specific instance of a worker pool of an App Service Environment.
   */
  @get
  @action("metricdefinitions")
  @list
  listWorkerPoolInstanceMetricDefinitions is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    Parameters = {
      /**
       * Name of the instance in the worker pool.
       */
      @path
      @segment("instances")
      instance: string;
    }
  >;

  /**
   * Description for Get metric definitions for a worker pool of an App Service Environment.
   */
  @get
  @action("metricdefinitions")
  @list
  listWebWorkerMetricDefinitions is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>
  >;

  /**
   * Description for Get available SKUs for scaling a worker pool.
   */
  @get
  @action("skus")
  @list
  listWorkerPoolSkus is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<SkuInfoCollection>
  >;

  /**
   * Description for Get usage metrics for a worker pool of an App Service Environment.
   */
  @get
  @action("usages")
  @list
  listWebWorkerUsages is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<UsageCollection>
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
