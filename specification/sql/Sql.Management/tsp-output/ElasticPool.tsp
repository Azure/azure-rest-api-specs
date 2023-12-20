import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An elastic pool.")
@parentResource(SqlServer)
model ElasticPool is TrackedResource<ElasticPoolProperties> {
  @doc("The name of the elastic pool.")
  @path
  @key("elasticPoolName")
  @segment("elasticPools")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ElasticPools {
  @doc("Gets an elastic pool.")
  get is ArmResourceRead<ElasticPool>;
  @doc("Creates or updates an elastic pool.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticPool>;
  @doc("Updates an elastic pool.")
  update is ArmResourcePatchAsync<ElasticPool, ElasticPoolProperties>;
  @doc("Deletes an elastic pool.")
  delete is ArmResourceDeleteAsync<ElasticPool>;
  @doc("Gets all elastic pools in a server.")
  listByServer is ArmResourceListByParent<
    ElasticPool,
    {
      ...BaseParameters<ElasticPool>;

      @doc("The number of elements in the collection to skip.")
      @query("$skip")
      $skip?: int32;
    }
  >;
  @doc("Cancels the asynchronous operation on the elastic pool.")
  cancel is ArmResourceActionSync<
    ElasticPool,
    void,
    void,
    {
      ...BaseParameters<ElasticPool>;

      @doc("The operation identifier.")
      @path
      operationId: string;
    }
  >;
  @doc("Failovers an elastic pool.")
  failover is ArmResourceActionAsync<ElasticPool, void, void>;
  @doc("Returns elastic pool  metrics.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/metrics")
  @get
  ListElasticPool is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the elastic pool.")
      @path
      elasticPoolName: string;

      @doc("An OData filter expression that describes a subset of metrics to return.")
      @query("$filter")
      $filter: string;
    },
    MetricListResult
  >;

  @doc("Returns elastic pool metric definitions.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/metricDefinitions")
  @get
  ListElasticPool is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the elastic pool.")
      @path
      elasticPoolName: string;
    },
    MetricDefinitionListResult
  >;

  @doc("Returns elastic pool activities.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolActivity")
  @get
  ListByElasticPool is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the elastic pool for which to get the current activity.")
      @path
      elasticPoolName: string;
    },
    ElasticPoolActivityListResult
  >;

  @doc("Returns activity on databases inside of an elastic pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/elasticPoolDatabaseActivity")
  @get
  ListByElasticPool is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the elastic pool.")
      @path
      elasticPoolName: string;
    },
    ElasticPoolDatabaseActivityListResult
  >;

  @doc("Gets a list of operations performed on the elastic pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/operations")
  @get
  ListByElasticPool is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @path
      elasticPoolName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ElasticPoolOperationListResult
  >;

  @doc("Gets a list of databases in an elastic pool.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/elasticPools/{elasticPoolName}/databases")
  @get
  ListByElasticPool is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the elastic pool.")
      @path
      elasticPoolName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseListResult
  >;
}
