import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL Database sync group.
 */
@parentResource(Database)
model SyncGroup is ProxyResource<SyncGroupProperties> {
  /**
   * The name of the sync group.
   */
  @path
  @key("syncGroupName")
  @segment("syncGroups")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SyncGroups {
  /**
   * Gets a sync group.
   */
  get is ArmResourceRead<SyncGroup>;

  /**
   * Creates or updates a sync group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SyncGroup>;

  /**
   * Updates a sync group.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<SyncGroup, SyncGroup>;

  /**
   * Deletes a sync group.
   */
  delete is ArmResourceDeleteAsync<SyncGroup>;

  /**
   * Lists sync groups under a hub database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SyncGroups_ListByDatabase")
  listByDatabase is ArmResourceListByParent<SyncGroup>;

  /**
   * Gets a collection of sync database ids.
   */
  listSyncDatabaseIds is ArmResourceListAtScope<
    SyncGroup,
    LocationScope<SyncGroup>,
    {
      ...BaseParameters<SyncGroup>;

      /**
       * The name of the region where the resource is located.
       */
      @path
      locationName: string;
    }
  >;

  /**
   * Refreshes a hub database schema.
   */
  refreshHubSchema is ArmResourceActionAsync<SyncGroup, void, void>;

  /**
   * Cancels a sync group synchronization.
   */
  cancelSync is ArmResourceActionSync<SyncGroup, void, void>;

  /**
   * Triggers a sync group synchronization.
   */
  triggerSync is ArmResourceActionSync<SyncGroup, void, void>;

  /**
   * Gets a collection of hub database schemas.
   */
  // FIXME: SyncGroups_ListHubSchemas could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/hubSchemas")
  @get
  listHubSchemas is Azure.Core.Foundations.Operation<
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
       * The name of the database on which the sync group is hosted.
       */
      @path
      databaseName: string;

      /**
       * The name of the sync group.
       */
      @path
      syncGroupName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SyncFullSchemaPropertiesListResult
  >;

  /**
   * Gets a collection of sync group logs.
   */
  // FIXME: SyncGroups_ListLogs could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/logs")
  @get
  listLogs is Azure.Core.Foundations.Operation<
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
       * The name of the database on which the sync group is hosted.
       */
      @path
      databaseName: string;

      /**
       * The name of the sync group.
       */
      @path
      syncGroupName: string;

      /**
       * Get logs generated after this time.
       */
      @query("startTime")
      startTime: string;

      /**
       * Get logs generated before this time.
       */
      @query("endTime")
      endTime: string;

      /**
       * The types of logs to retrieve.
       */
      @query("type")
      type: SyncGroupsType;

      /**
       * The continuation token for this operation.
       */
      @query("continuationToken")
      continuationToken?: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SyncGroupLogListResult
  >;
}

@@projectedName(SyncGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SyncGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncGroups.createOrUpdate::parameters.resource,
  "The requested sync group resource state."
);
@@projectedName(SyncGroups.update::parameters.properties, "json", "parameters");
@@extension(SyncGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncGroups.update::parameters.properties,
  "The requested sync group resource state."
);
