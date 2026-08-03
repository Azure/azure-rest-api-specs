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
 * An Azure SQL managed instance.
 */
model ManagedInstance is TrackedResource<ManagedInstanceProperties> {
  /**
   * The name of the managed instance.
   */
  @path
  @key("managedInstanceName")
  @segment("managedInstances")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ManagedInstances {
  /**
   * Gets a managed instance.
   */
  get is ArmResourceRead<
    ManagedInstance,
    {
      ...BaseParameters<ManagedInstance>;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Creates or updates a managed instance.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedInstance>;

  /**
   * Updates a managed instance.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<ManagedInstance, ManagedInstanceUpdate>;

  /**
   * Deletes a managed instance.
   */
  delete is ArmResourceDeleteAsync<ManagedInstance>;

  /**
   * Gets a list of managed instances in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstances_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ManagedInstance,
    {
      ...BaseParameters<ManagedInstance>;

      /**
       * The child resources to include in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Gets a list of all managed instances in the subscription.
   */
  list is ArmListBySubscription<ManagedInstance>;

  /**
   * Creates a TDE certificate for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstanceTdeCertificates_Create")
  create is ArmResourceActionAsync<ManagedInstance, TdeCertificate, void>;

  /**
   * Failovers a managed instance.
   */
  failover is ArmResourceActionAsync<
    ManagedInstance,
    void,
    void,
    {
      ...BaseParameters<ManagedInstance>;

      /**
       * The type of replica to be failed over.
       */
      @query("replicaType")
      replicaType?: ReplicaType;
    }
  >;

  /**
   * Starts the managed instance.
   */
  start is ArmResourceActionNoResponseContentAsync<
    ManagedInstance,
    void,
    BaseParameters<ManagedInstance>,
    ArmLroLocationHeader
  >;

  /**
   * Stops the managed instance.
   */
  stop is ArmResourceActionNoResponseContentAsync<
    ManagedInstance,
    void,
    BaseParameters<ManagedInstance>,
    ArmLroLocationHeader
  >;

  /**
   * Gets a server trust groups by instance name.
   */
  // FIXME: ServerTrustGroups_ListByInstance could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerTrustGroups_ListByInstance")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/serverTrustGroups")
  @get
  listByInstance is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ServerTrustGroup>
  >;

  /**
   * Gets a list of inaccessible managed databases in a managed instance
   */
  // FIXME: ManagedDatabases_ListInaccessibleByInstance could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabases_ListInaccessibleByInstance")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/inaccessibleManagedDatabases")
  @get
  listInaccessibleByInstance is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<ManagedDatabase>
  >;

  /**
   * Gets the collection of outbound network dependencies for the given managed instance.
   */
  // FIXME: ManagedInstances_ListOutboundNetworkDependenciesByManagedInstance could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesByManagedInstance is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    OutboundEnvironmentEndpointCollection
  >;

  /**
   * Get top resource consuming queries of a managed instance.
   */
  // FIXME: ManagedInstances_ListByManagedInstance could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/topqueries")
  @get
  listByManagedInstance is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the managed instance.
       */
      @path
      managedInstanceName: string;

      /**
       * How many 'top queries' to return. Default is 5.
       */
      @query("numberOfQueries")
      numberOfQueries?: int32;

      /**
       * Comma separated list of databases to be included into search. All DB's are included if this parameter is not specified.
       */
      @query("databases")
      databases?: string;

      /**
       * Start time for observed period.
       */
      @query("startTime")
      startTime?: string;

      /**
       * End time for observed period.
       */
      @query("endTime")
      endTime?: string;

      /**
       * The time step to be used to summarize the metric values. Default value is PT1H
       */
      @query("interval")
      interval?: QueryTimeGrainType;

      /**
       * Aggregation function to be used, default value is 'sum'
       */
      @query("aggregationFunction")
      aggregationFunction?: AggregationFunctionType;

      /**
       * Metric to be used for ranking top queries. Default is 'cpu'
       */
      @query("observationMetric")
      observationMetric?: MetricType;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    TopQueriesListResult
  >;
}

@@projectedName(ManagedInstances.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedInstances.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstances.createOrUpdate::parameters.resource,
  "The requested managed instance resource state."
);
@@projectedName(ManagedInstances.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedInstances.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstances.update::parameters.properties,
  "The requested managed instance resource state."
);
@@projectedName(ManagedInstances.create::parameters.body, "json", "parameters");
@@extension(ManagedInstances.create::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedInstances.create::parameters.body,
  "The requested TDE certificate to be created or updated."
);
