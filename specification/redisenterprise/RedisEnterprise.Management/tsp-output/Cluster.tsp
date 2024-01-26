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

namespace Microsoft.Cache;
/**
 * Describes the RedisEnterprise cluster
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ClusterProperties)
model Cluster extends TrackedResourceBase {
  /**
   * The name of the RedisEnterprise cluster.
   */
  @path
  @key("clusterName")
  @segment("redisEnterprise")
  @visibility("read")
  name: string;

  /**
   * The Availability Zones where this cluster will be deployed.
   */
  zones?: string[];

  /**
   * Other properties of the cluster.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ClusterProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface Clusters {
  /**
   * Gets information about a RedisEnterprise cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RedisEnterprise_Get")
  get is ArmResourceRead<Cluster>;

  /**
   * Creates or updates an existing (overwrite/recreate, with potential downtime) cache cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RedisEnterprise_Create")
  create is ArmResourceCreateOrReplaceAsync<Cluster>;

  /**
   * Updates an existing RedisEnterprise cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("RedisEnterprise_Update")
  update is ArmCustomPatchAsync<
    Cluster,
    ClusterUpdate,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deletes a RedisEnterprise cache cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RedisEnterprise_Delete")
  delete is ArmResourceDeleteAsync<
    Cluster,
    BaseParameters<Cluster>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists all RedisEnterprise clusters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RedisEnterprise_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Gets all RedisEnterprise clusters in the specified subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RedisEnterprise_List")
  list is ArmListBySubscription<Cluster>;

  /**
   * Gets the private link resources that need to be created for a RedisEnterprise cluster.
   */
  // FIXME: PrivateLinkResources_ListByCluster could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByCluster")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cache/redisEnterprise/{clusterName}/privateLinkResources")
  @get
  listByCluster is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the RedisEnterprise cluster.
       */
      @path
      clusterName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}

@@projectedName(Clusters.create::parameters.resource, "json", "parameters");
@@extension(Clusters.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.create::parameters.resource,
  "Parameters supplied to the Create RedisEnterprise operation."
);
@@projectedName(Clusters.update::parameters.properties, "json", "parameters");
@@extension(Clusters.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Clusters.update::parameters.properties,
  "Parameters supplied to the Update RedisEnterprise operation."
);
