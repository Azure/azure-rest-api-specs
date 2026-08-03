import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An elastic pool.
 */
@parentResource(Server)
model ElasticPool is TrackedResource<ElasticPoolProperties> {
  /**
   * The name of the elastic pool.
   */
  @path
  @key("elasticPoolName")
  @segment("elasticPools")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ElasticPools {
  /**
   * Gets an elastic pool.
   */
  get is ArmResourceRead<ElasticPool>;

  /**
   * Creates or updates an elastic pool.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ElasticPool,
    BaseParameters<ElasticPool>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates an elastic pool.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    ElasticPool,
    ElasticPoolUpdate,
    BaseParameters<ElasticPool>,
    ArmLroLocationHeader
  >;

  /**
   * Deletes an elastic pool.
   */
  delete is ArmResourceDeleteAsync<
    ElasticPool,
    BaseParameters<ElasticPool>,
    ArmLroLocationHeader
  >;

  /**
   * Gets all elastic pools in a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ElasticPools_ListByServer")
  listByServer is ArmResourceListByParent<
    ElasticPool,
    {
      ...BaseParameters<ElasticPool>;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int64;
    }
  >;

  /**
   * Cancels the asynchronous operation on the elastic pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ElasticPoolOperations_Cancel")
  cancel is ArmResourceActionSync<
    ElasticPool,
    void,
    void,
    {
      ...BaseParameters<ElasticPool>;

      /**
       * The operation identifier.
       */
      @path
      operationId: string;
    }
  >;

  /**
   * Failovers an elastic pool.
   */
  failover is ArmResourceActionAsync<ElasticPool, void, void>;

  /**
   * Returns elastic pool  metrics.
   */
  // FIXME: Metrics_ListElasticPool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Metrics_ListElasticPool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/metrics")
  @get
  listElasticPool is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the elastic pool.
       */
      @path
      elasticPoolName: string;

      /**
       * An OData filter expression that describes a subset of metrics to return.
       */
      @query("$filter")
      $filter: string;
    },
    MetricListResult
  >;

  /**
   * Returns elastic pool metric definitions.
   */
  // FIXME: MetricDefinitions_ListElasticPool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("MetricDefinitions_ListElasticPool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/metricDefinitions")
  @get
  listElasticPool is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the elastic pool.
       */
      @path
      elasticPoolName: string;
    },
    MetricDefinitionListResult
  >;

  /**
   * Returns elastic pool activities.
   */
  // FIXME: ElasticPoolActivities_ListByElasticPool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ElasticPoolActivities_ListByElasticPool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolActivity")
  @get
  listByElasticPool is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the elastic pool for which to get the current activity.
       */
      @path
      elasticPoolName: string;
    },
    ElasticPoolActivityListResult
  >;

  /**
   * Returns activity on databases inside of an elastic pool.
   */
  // FIXME: ElasticPoolDatabaseActivities_ListByElasticPool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ElasticPoolDatabaseActivities_ListByElasticPool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolDatabaseActivity")
  @get
  listByElasticPool is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the elastic pool.
       */
      @path
      elasticPoolName: string;
    },
    ElasticPoolDatabaseActivityListResult
  >;

  /**
   * Gets a list of operations performed on the elastic pool.
   */
  // FIXME: ElasticPoolOperations_ListByElasticPool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ElasticPoolOperations_ListByElasticPool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations")
  @get
  listByElasticPool is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      @path
      elasticPoolName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ElasticPoolOperationListResult
  >;

  /**
   * Gets a list of databases in an elastic pool.
   */
  // FIXME: Databases_ListByElasticPool could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Databases_ListByElasticPool")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases")
  @get
  listByElasticPool is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server.
       */
      @path
      serverName: string;

      /**
       * The name of the elastic pool.
       */
      @path
      elasticPoolName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Database>
  >;
}

@@projectedName(ElasticPools.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ElasticPools.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ElasticPools.createOrUpdate::parameters.resource,
  "The elastic pool parameters."
);
@@projectedName(ElasticPools.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ElasticPools.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ElasticPools.update::parameters.properties,
  "The elastic pool update parameters."
);
