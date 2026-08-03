import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL instance pool.
 */
model InstancePool is TrackedResource<InstancePoolProperties> {
  /**
   * The name of the instance pool to be retrieved.
   */
  @path
  @key("instancePoolName")
  @segment("instancePools")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface InstancePools {
  /**
   * Gets an instance pool.
   */
  get is ArmResourceRead<InstancePool>;

  /**
   * Creates or updates an instance pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InstancePool>;

  /**
   * Updates an instance pool.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<InstancePool, InstancePoolUpdate>;

  /**
   * Deletes an instance pool
   */
  delete is ArmResourceDeleteAsync<InstancePool>;

  /**
   * Gets a list of instance pools in the resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InstancePools_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<InstancePool>;

  /**
   * Gets a list of all instance pools in the subscription.
   */
  list is ArmListBySubscription<InstancePool>;

  /**
   * Gets all instance pool usage metrics
   */
  // FIXME: Usages_ListByInstancePool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Usages_ListByInstancePool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/usages")
  @get
  listByInstancePool is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the instance pool to be retrieved.
       */
      @path
      instancePoolName: string;

      /**
       * Optional request parameter to include managed instance usages within the instance pool.
       */
      @query("expandChildren")
      expandChildren?: boolean;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    UsageListResult
  >;

  /**
   * Gets a list of all managed instances in an instance pool.
   */
  // FIXME: ManagedInstances_ListByInstancePool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstances_ListByInstancePool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/instancePools/{instancePoolName}/managedInstances")
  @get
  listByInstancePool is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The instance pool name.
       */
      @path
      instancePoolName: string;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedInstance>
  >;
}

@@projectedName(InstancePools.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(InstancePools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(InstancePools.createOrUpdate::parameters.resource,
  "The requested instance pool resource state."
);
@@projectedName(InstancePools.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(InstancePools.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(InstancePools.update::parameters.properties,
  "The requested instance pool resource state."
);
