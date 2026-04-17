import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL instance pool.
 */
model InstancePool
  is Azure.ResourceManager.TrackedResource<InstancePoolProperties> {
  ...ResourceNameParameter<
    Resource = InstancePool,
    KeyName = "instancePoolName",
    SegmentName = "instancePools",
    NamePattern = ""
  >;

  /**
   * The name and tier of the SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;
}

@armResourceOperations(#{ omitTags: true })
interface InstancePools {
  /**
   * Gets an instance pool.
   */
  @tag("InstancePools")
  get is ArmResourceRead<InstancePool>;

  /**
   * Creates or updates an instance pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("InstancePools")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InstancePool,
    Response = ArmResourceUpdatedResponse<InstancePool> | ArmResourceCreatedResponse<
      InstancePool,
      ArmLroLocationHeader<FinalResult = InstancePool> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates an instance pool.
   */
  @patch(#{ implicitOptionality: false })
  @tag("InstancePools")
  update is ArmCustomPatchAsync<InstancePool, PatchModel = InstancePoolUpdate>;

  /**
   * Deletes an instance pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("InstancePools")
  delete is ArmResourceDeleteWithoutOkAsync<
    InstancePool,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of instance pools in the resource group
   */
  @tag("InstancePools")
  listByResourceGroup is ArmResourceListByParent<InstancePool>;

  /**
   * Gets a list of all instance pools in the subscription.
   */
  @tag("InstancePools")
  list is ArmListBySubscription<InstancePool>;

  /**
   * Gets a list of all managed instances in an instance pool.
   */
  @tag("ManagedInstances")
  @list
  @get
  @action("managedInstances")
  listByInstancePool is ArmResourceActionSync<
    InstancePool,
    void,
    ArmResponse<ResourceListResult<ManagedInstance>>,
    Parameters = {
      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets all instance pool usage metrics
   */
  @tag("Usages")
  @list
  @get
  @action("usages")
  usagesListByInstancePool is ArmResourceActionSync<
    InstancePool,
    void,
    ArmResponse<UsageListResult>,
    Parameters = {
      /**
       * Optional request parameter to include managed instance usages within the instance pool.
       */
      @query("expandChildren")
      expandChildren?: boolean;
    }
  >;
}

@@doc(InstancePool.name, "The name of the instance pool to be retrieved.");
@@doc(InstancePool.properties, "Resource properties.");
@@doc(InstancePools.createOrUpdate::parameters.resource,
  "The requested instance pool resource state."
);
@@doc(InstancePools.update::parameters.properties,
  "The requested instance pool resource state."
);
