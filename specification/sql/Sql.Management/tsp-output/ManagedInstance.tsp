import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("An Azure SQL managed instance.")
model ManagedInstance is TrackedResource<ManagedInstanceProperties> {
  @doc("The name of the managed instance.")
  @key("managedInstanceName")
  @segment("managedInstances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ManagedInstances {
  @doc("Gets a managed instance.")
  get is ArmResourceRead<
    ManagedInstance,
    {
      ...BaseParameters<ManagedInstance>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Creates or updates a managed instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedInstance>;

  @doc("Updates a managed instance.")
  update is ArmCustomPatchAsync<ManagedInstance, ManagedInstanceUpdate>;

  @doc("Deletes a managed instance.")
  delete is ArmResourceDeleteAsync<ManagedInstance>;

  @doc("Gets a list of managed instances in a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    ManagedInstance,
    {
      ...BaseParameters<ManagedInstance>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;

  @doc("Gets a list of all managed instances in the subscription.")
  list is ArmListBySubscription<ManagedInstance>;

  @doc("Failovers a managed instance.")
  failover is ArmResourceActionAsync<
    ManagedInstance,
    void,
    void,
    {
      ...BaseParameters<ManagedInstance>;

      @doc("The type of replica to be failed over.")
      @query("replicaType")
      replicaType?: ReplicaType;
    }
  >;

  @doc("Starts the managed instance.")
  start is ArmResourceActionNoResponseContentAsync<ManagedInstance, void>;

  @doc("Stops the managed instance.")
  stop is ArmResourceActionNoResponseContentAsync<ManagedInstance, void>;

  @doc("Gets the collection of outbound network dependencies for the given managed instance.")
  // FIXME: ManagedInstances_ListOutboundNetworkDependenciesByManagedInstance could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/outboundNetworkDependenciesEndpoints")
  @get
  ListOutboundNetworkDependenciesByManagedInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    OutboundEnvironmentEndpointCollection
  >;

  @doc("Get top resource consuming queries of a managed instance.")
  // FIXME: ManagedInstances_ListByManagedInstance could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/topqueries")
  @get
  ListByManagedInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("How many 'top queries' to return. Default is 5.")
      @query("numberOfQueries")
      numberOfQueries?: int32;

      @doc("Comma separated list of databases to be included into search. All DB's are included if this parameter is not specified.")
      @query("databases")
      databases?: string;

      @doc("Start time for observed period.")
      @query("startTime")
      startTime?: string;

      @doc("End time for observed period.")
      @query("endTime")
      endTime?: string;

      @doc("The time step to be used to summarize the metric values. Default value is PT1H")
      @query("interval")
      interval?: QueryTimeGrainType;

      @doc("Aggregation function to be used, default value is 'sum'")
      @query("aggregationFunction")
      aggregationFunction?: AggregationFunctionType;

      @doc("Metric to be used for ranking top queries. Default is 'cpu'")
      @query("observationMetric")
      observationMetric?: MetricType;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    TopQueriesListResult
  >;
}

@armResourceOperations
@projectedName("client", "ManagedInstanceTdeCertificates")
interface ManagedInstances_ManagedInstanceTdeCertificates {
  @doc("Creates a TDE certificate for a given server.")
  create is ArmResourceActionAsync<ManagedInstance, TdeCertificate, void>;
}

@armResourceOperations
@projectedName("client", "ServerTrustGroups")
interface ManagedInstances_ServerTrustGroups {
  @doc("Gets a server trust groups by instance name.")
  // FIXME: ServerTrustGroups_ListByInstance could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustGroups")
  @get
  ListByInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServerTrustGroup>
  >;
}

@armResourceOperations
@projectedName("client", "ManagedDatabases")
interface ManagedInstances_ManagedDatabases {
  @doc("Gets a list of inaccessible managed databases in a managed instance")
  // FIXME: ManagedDatabases_ListInaccessibleByInstance could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/inaccessibleManagedDatabases")
  @get
  ListInaccessibleByInstance is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedDatabase>
  >;
}
