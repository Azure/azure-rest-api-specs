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
/**
 * A managed database resource.
 */
@parentResource(ManagedInstance)
model ManagedDatabase is TrackedResource<ManagedDatabaseProperties> {
  /**
   * The name of the database.
   */
  @path
  @key("databaseName")
  @segment("databases")
  name: string;
}

@armResourceOperations
interface ManagedDatabases {
  /**
   * Gets a managed database.
   */
  get is ArmResourceRead<ManagedDatabase>;

  /**
   * Creates a new database or updates an existing database.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedDatabase>;

  /**
   * Updates an existing database.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<ManagedDatabase, ManagedDatabaseUpdate>;

  /**
   * Deletes a managed database.
   */
  delete is ArmResourceDeleteAsync<ManagedDatabase>;

  /**
   * Gets a list of managed databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabases_ListByInstance")
  listByInstance is ArmResourceListByParent<ManagedDatabase>;

  /**
   * Cancels a managed database move operation.
   */
  cancelMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    void
  >;

  /**
   * Completes a managed database move operation.
   */
  completeMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseMoveDefinition,
    void
  >;

  /**
   * Completes the restore operation on a managed database.
   */
  completeRestore is ArmResourceActionAsync<
    ManagedDatabase,
    CompleteDatabaseRestoreDefinition,
    void
  >;

  /**
   * Starts a managed database move operation.
   */
  startMove is ArmResourceActionAsync<
    ManagedDatabase,
    ManagedDatabaseStartMoveDefinition,
    void
  >;

  /**
   * List managed database columns
   */
  // FIXME: ManagedDatabaseColumns_ListByDatabase could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseColumns_ListByDatabase")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/columns")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
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
       * The name of the database.
       */
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

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<DatabaseColumn>
  >;

  /**
   * Get query by query id.
   */
  // FIXME: ManagedDatabaseQueries_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseQueries_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}")
  @get
  get is Azure.Core.Foundations.Operation<
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
       * The name of the database.
       */
      @path
      databaseName: string;

      @path
      queryId: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ManagedInstanceQuery
  >;

  /**
   * Get query execution statistics by query id.
   */
  // FIXME: ManagedDatabaseQueries_ListByQuery could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseQueries_ListByQuery")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/queries/{queryId}/statistics")
  @get
  listByQuery is Azure.Core.Foundations.Operation<
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
       * The name of the database.
       */
      @path
      databaseName: string;

      @path
      queryId: string;

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
       * The time step to be used to summarize the metric values.
       */
      @query("interval")
      interval?: QueryTimeGrainType;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    ManagedInstanceQueryStatistics
  >;

  /**
   * Gets a list of security events.
   */
  // FIXME: ManagedDatabaseSecurityEvents_ListByDatabase could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSecurityEvents_ListByDatabase")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/securityEvents")
  @get
  listByDatabase is Azure.Core.Foundations.Operation<
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
       * The name of the managed database for which the security events are retrieved.
       */
      @path
      databaseName: string;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of elements in the collection to skip.
       */
      @query("$skip")
      $skip?: int32;

      /**
       * The number of elements to return from the collection.
       */
      @query("$top")
      $top?: int32;

      /**
       * An opaque token that identifies a starting point in the collection.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SecurityEventCollection
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  // FIXME: ManagedDatabaseSensitivityLabels_ListCurrent could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_ListCurrent")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/currentSensitivityLabels")
  @get
  listCurrent is Azure.Core.Foundations.Operation<
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
       * The name of the database.
       */
      @path
      databaseName: string;

      @query("$skipToken")
      $skipToken?: string;

      @query("$count")
      $count?: boolean;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SensitivityLabelListResult
  >;

  /**
   * Gets the sensitivity labels of a given database
   */
  // FIXME: ManagedDatabaseSensitivityLabels_ListRecommended could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseSensitivityLabels_ListRecommended")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/managedInstances/{managedInstanceName}/databases/{databaseName}/recommendedSensitivityLabels")
  @get
  listRecommended is Azure.Core.Foundations.Operation<
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
       * The name of the database.
       */
      @path
      databaseName: string;

      @query("$skipToken")
      $skipToken?: string;

      /**
       * Specifies whether to include disabled recommendations or not.
       */
      @query("includeDisabledRecommendations")
      includeDisabledRecommendations?: boolean;

      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
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
