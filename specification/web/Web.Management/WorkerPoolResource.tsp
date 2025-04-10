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

namespace Microsoft.CertificateRegistration;
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
        ...KeysOf<ResourceNameParameter<
          Resource = AppServiceEnvironmentResource,
          KeyName = "name",
          SegmentName = "hostingEnvironments",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkerPoolResource,
        KeyName = "default",
        SegmentName = "multiRolePools",
        NamePattern = ""
      >>
    > {}

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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("AppServiceEnvironments_UpdateMultiRolePool")
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
  listMultiRolePools is WorkerPoolResourceOps.List<
    WorkerPoolResource,
    Response = ArmResponse<WorkerPoolCollection>
  >;

  /**
   * Description for Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("metricdefinitions")
  @operationId("AppServiceEnvironments_ListMultiRolePoolInstanceMetricDefinitions")
  listMultiRolePoolInstanceMetricDefinitions is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    Parameters = {
      /**
       * Name of the instance in the multi-role pool.
       */
      @path
      instance: string;
    }
  >;

  /**
   * Description for Get metric definitions for a multi-role pool of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("metricdefinitions")
  @operationId("AppServiceEnvironments_ListMultiRoleMetricDefinitions")
  listMultiRoleMetricDefinitions is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>
  >;

  /**
   * Description for Get available SKUs for scaling a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("skus")
  @operationId("AppServiceEnvironments_ListMultiRolePoolSkus")
  listMultiRolePoolSkus is WorkerPoolResourceOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<SkuInfoCollection>
  >;

  /**
   * Description for Get usage metrics for a multi-role pool of an App Service Environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("usages")
  @operationId("AppServiceEnvironments_ListMultiRoleUsages")
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
        ...KeysOf<ResourceNameParameter<
          Resource = AppServiceEnvironmentResource,
          KeyName = "name",
          SegmentName = "hostingEnvironments",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = WorkerPoolResource,
        KeyName = "workerPoolName",
        SegmentName = "workerPools",
        NamePattern = ""
      >>
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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Description for Create or update a worker pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
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
  listWorkerPools is AppServiceEnvironmentOps.List<
    WorkerPoolResource,
    Response = ArmResponse<WorkerPoolCollection>
  >;

  /**
   * Description for Get metric definitions for a specific instance of a worker pool of an App Service Environment.
   */
  @get
  @action("metricdefinitions")
  listWorkerPoolInstanceMetricDefinitions is AppServiceEnvironmentOps.ActionSync<
    WorkerPoolResource,
    void,
    ArmResponse<ResourceMetricDefinitionCollection>,
    Parameters = {
      /**
       * Name of the instance in the worker pool.
       */
      @path
      instance: string;
    }
  >;

  /**
   * Description for Get metric definitions for a worker pool of an App Service Environment.
   */
  @get
  @action("metricdefinitions")
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
