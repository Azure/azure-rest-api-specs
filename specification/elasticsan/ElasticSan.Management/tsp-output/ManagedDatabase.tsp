import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
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
  update is ArmCustomPatchAsync<ManagedDatabase, ManagedDatabaseUpdate>;

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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseColumns_ListByDatabase")
  @doc("List managed database columns")
  // FIXME: ManagedDatabaseColumns_ListByDatabase could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
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
    ResourceListResult<DatabaseColumn>
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseQueries_Get")
  @doc("Get query by query id.")
  // FIXME: ManagedDatabaseQueries_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}")
  @get
  get is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseQueries_ListByQuery")
  @doc("Get query execution statistics by query id.")
  // FIXME: ManagedDatabaseQueries_ListByQuery could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics")
  @get
  listByQuery is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSecurityEvents_ListByDatabase")
  @doc("Gets a list of security events.")
  // FIXME: ManagedDatabaseSecurityEvents_ListByDatabase could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_ListCurrent")
  @doc("Gets the sensitivity labels of a given database")
  // FIXME: ManagedDatabaseSensitivityLabels_ListCurrent could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels")
  @get
  listCurrent is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_ListRecommended")
  @doc("Gets the sensitivity labels of a given database")
  // FIXME: ManagedDatabaseSensitivityLabels_ListRecommended could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels")
  @get
  listRecommended is Azure.Core.Foundations.Operation<
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

@@projectedName(ManagedDatabases.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedDatabases.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabases.createOrUpdate::parameters.resource,
  "The requested database resource state."
);
@@projectedName(ManagedDatabases.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ManagedDatabases.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabases.update::parameters.properties,
  "The requested database resource state."
);
@@projectedName(ManagedDatabases.cancelMove::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedDatabases.cancelMove::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabases.cancelMove::parameters.body,
  "Parameters of the cancel managed database move operation."
);
@@projectedName(ManagedDatabases.completeMove::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedDatabases.completeMove::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabases.completeMove::parameters.body,
  "Parameters of the complete managed database move operation."
);
@@projectedName(ManagedDatabases.completeRestore::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedDatabases.completeRestore::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabases.completeRestore::parameters.body,
  "The definition for completing the restore of this managed database."
);
@@projectedName(ManagedDatabases.startMove::parameters.body,
  "json",
  "parameters"
);
@@extension(ManagedDatabases.startMove::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabases.startMove::parameters.body,
  "Parameters of the start managed database move operation."
);
