import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed database resource.")
@parentResource(ManagedInstance)
model ManagedDatabase is TrackedResource<ManagedDatabaseProperties> {
  @doc("The name of the database.")
  @path
  @key("databaseName")
  @segment("databases")
  name: string;
}

@armResourceOperations
interface ManagedDatabases {
  @doc("Gets a managed database.")
  get is ArmResourceRead<ManagedDatabase>;
  @doc("Creates a new database or updates an existing database.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ManagedDatabase>;
  @doc("Updates an existing database.")
  update is ArmResourcePatchAsync<ManagedDatabase, ManagedDatabaseProperties>;
  @doc("Deletes a managed database.")
  delete is ArmResourceDeleteAsync<ManagedDatabase>;
  @doc("Gets a list of managed databases.")
  listByInstance is ArmResourceListByParent<ManagedDatabase>;
  @doc("Cancels a managed database move operation.")
  cancelMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    void
  >;
  @doc("Completes a managed database move operation.")
  completeMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    void
  >;
  @doc("Completes the restore operation on a managed database.")
  completeRestore is ArmResourceActionAsync<
    ManagedDatabase,
    CompleteDatabaseRestoreDefinition,
    void
  >;
  @doc("Starts a managed database move operation.")
  startMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseStartMoveDefinition,
    void
  >;
}

@armResourceOperations
interface ManagedDatabaseColumns {
  @doc("List managed database columns")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns")
  @get
  ListByDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @query({
        name: "schema",
        format: "multi",
      })
      schema?: string[];

      @query({
        name: "table",
        format: "multi",
      })
      table?: string[];

      @query({
        name: "column",
        format: "multi",
      })
      column?: string[];

      @query({
        name: "orderBy",
        format: "multi",
      })
      orderBy?: string[];

      @doc("An opaque token that identifies a starting point in the collection.")
      @query("$skiptoken")
      $skiptoken?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    DatabaseColumnListResult
  >;
}

@armResourceOperations
interface ManagedDatabaseQueries {
  @doc("Get query by query id.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @path
      queryId: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ManagedInstanceQuery
  >;

  @doc("Get query execution statistics by query id.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics")
  @get
  ListByQuery is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @path
      queryId: string;

      @doc("Start time for observed period.")
      @query("startTime")
      startTime?: string;

      @doc("End time for observed period.")
      @query("endTime")
      endTime?: string;

      @doc("The time step to be used to summarize the metric values.")
      @query("interval")
      interval?: QueryTimeGrainType;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    ManagedInstanceQueryStatistics
  >;
}

@armResourceOperations
interface ManagedDatabaseSecurityEvents {
  @doc("Gets a list of security events.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents")
  @get
  ListByDatabase is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the managed database for which the security events are retrieved.")
      @path
      databaseName: string;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;

      @doc("The number of elements in the collection to skip.")
      @query("$skip")
      $skip?: int32;

      @doc("The number of elements to return from the collection.")
      @query("$top")
      $top?: int32;

      @doc("An opaque token that identifies a starting point in the collection.")
      @query("$skiptoken")
      $skiptoken?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SecurityEventCollection
  >;
}

@armResourceOperations
interface ManagedDatabaseSensitivityLabels {
  @doc("Gets the sensitivity labels of a given database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels")
  @get
  ListCurrent is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @query("$skipToken")
      $skipToken?: string;

      @query("$count")
      $count?: boolean;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SensitivityLabelListResult
  >;

  @doc("Gets the sensitivity labels of a given database")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels")
  @get
  ListRecommended is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the managed instance.")
      @path
      managedInstanceName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @query("$skipToken")
      $skipToken?: string;

      @doc("Specifies whether to include disabled recommendations or not.")
      @query("includeDisabledRecommendations")
      includeDisabledRecommendations?: boolean;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SensitivityLabelListResult
  >;
}
