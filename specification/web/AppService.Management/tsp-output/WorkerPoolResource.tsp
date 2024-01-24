import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceEnvironmentResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Worker pool of an App Service Environment ARM resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(AppServiceEnvironmentResource)
@Azure.ResourceManager.Private.armResourceInternal(WorkerPool)
@includeInapplicableMetadataInPayload(false)
model WorkerPoolResource extends ProxyOnlyResource {
  @key("multiRolePool")
  @segment("multiRolePools")
  name: string;

  /**
   * Description of a SKU for a scalable resource.
   */
  sku?: SkuDescription;

  /**
   * Core resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkerPool;
}

@armResourceOperations
interface WorkerPoolResources {
  /**
   * Description for Get properties of a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_GetMultiRolePool")
  getMultiRolePool is ArmResourceRead<WorkerPoolResource>;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_CreateOrUpdateMultiRolePool")
  createOrUpdateMultiRolePool is ArmResourceCreateOrReplaceAsync<WorkerPoolResource>;

  /**
   * Description for Create or update a multi-role pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AppServiceEnvironments_UpdateMultiRolePool")
  updateMultiRolePool is ArmCustomPatchSync<
    WorkerPoolResource,
    WorkerPoolResource
  >;

  /**
   * Description for Get all multi-role pools.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListMultiRolePools")
  listMultiRolePools is ArmResourceListByParent<WorkerPoolResource>;

  /**
   * Description for Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListMultiRolePoolInstanceMetricDefinitions could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListMultiRolePoolInstanceMetricDefinitions")
  @summary("Get metric definitions for a specific instance of a multi-role pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/instances/{instance}/metricdefinitions")
  @get
  listMultiRolePoolInstanceMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Name of the instance in the multi-role pool.
       */
      @path
      instance: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  /**
   * Description for Get metric definitions for a multi-role pool of an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListMultiRoleMetricDefinitions could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListMultiRoleMetricDefinitions")
  @summary("Get metric definitions for a multi-role pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/metricdefinitions")
  @get
  listMultiRoleMetricDefinitions is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    ResourceMetricDefinitionCollection
  >;

  /**
   * Description for Get available SKUs for scaling a multi-role pool.
   */
  // FIXME: AppServiceEnvironments_ListMultiRolePoolSkus could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListMultiRolePoolSkus")
  @summary("Get available SKUs for scaling a multi-role pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/skus")
  @get
  listMultiRolePoolSkus is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    SkuInfoCollection
  >;

  /**
   * Description for Get usage metrics for a multi-role pool of an App Service Environment.
   */
  // FIXME: AppServiceEnvironments_ListMultiRoleUsages could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AppServiceEnvironments_ListMultiRoleUsages")
  @summary("Get usage metrics for a multi-role pool of an App Service Environment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/usages")
  @get
  listMultiRoleUsages is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of the resource group to which the resource belongs.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * Name of the App Service Environment.
       */
      @path
      name: string;

      /**
       * Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).
       */
      @path
      subscriptionId: string;
    },
    UsageCollection
  >;
}

@@projectedName(WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "json",
  "multiRolePoolEnvelope"
);
@@extension(WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "x-ms-client-name",
  "multiRolePoolEnvelope"
);
@@doc(WorkerPoolResources.createOrUpdateMultiRolePool::parameters.resource,
  "Properties of the multi-role pool."
);
@@projectedName(WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "json",
  "multiRolePoolEnvelope"
);
@@extension(WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "x-ms-client-name",
  "multiRolePoolEnvelope"
);
@@doc(WorkerPoolResources.updateMultiRolePool::parameters.properties,
  "Properties of the multi-role pool."
);
