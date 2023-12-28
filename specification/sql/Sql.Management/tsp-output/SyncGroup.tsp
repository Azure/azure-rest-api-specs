import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("An Azure SQL Database sync group.")
@parentResource(Database)
model SyncGroup is ProxyResource<SyncGroupProperties> {
  @doc("The name of the sync group.")
  @key("syncGroupName")
  @segment("syncGroups")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SyncGroups {
  @doc("Gets a sync group.")
  get is ArmResourceRead<SyncGroup>;
  @doc("Creates or updates a sync group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SyncGroup>;
  @doc("Updates a sync group.")
  update is ArmCustomPatchAsync<SyncGroup, SyncGroup>;
  @doc("Deletes a sync group.")
  delete is ArmResourceDeleteAsync<SyncGroup>;
  @doc("Lists sync groups under a hub database.")
  listByDatabase is ArmResourceListByParent<SyncGroup>;
  @doc("Gets a collection of sync database ids.")
  listSyncDatabaseIds is ArmResourceListAtScope<
    SyncGroup,
    LocationScope<SyncGroup>,
    {
      ...BaseParameters<SyncGroup>;

      @doc("The name of the region where the resource is located.")
      @path
      locationName: string;
    }
  >;
  @doc("Refreshes a hub database schema.")
  refreshHubSchema is ArmResourceActionAsync<SyncGroup, void, void>;
  @doc("Cancels a sync group synchronization.")
  cancelSync is ArmResourceActionSync<SyncGroup, void, void>;
  @doc("Triggers a sync group synchronization.")
  triggerSync is ArmResourceActionSync<SyncGroup, void, void>;
  @doc("Gets a collection of hub database schemas.")
  // FIXME: SyncGroups_ListHubSchemas could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/hubSchemas")
  @get
  ListHubSchemas is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database on which the sync group is hosted.")
      @path
      databaseName: string;

      @doc("The name of the sync group.")
      @path
      syncGroupName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SyncFullSchemaPropertiesListResult
  >;

  @doc("Gets a collection of sync group logs.")
  // FIXME: SyncGroups_ListLogs could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/logs")
  @get
  ListLogs is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database on which the sync group is hosted.")
      @path
      databaseName: string;

      @doc("The name of the sync group.")
      @path
      syncGroupName: string;

      @doc("Get logs generated after this time.")
      @query("startTime")
      startTime: string;

      @doc("Get logs generated before this time.")
      @query("endTime")
      endTime: string;

      @doc("The types of logs to retrieve.")
      @query("type")
      type: SyncGroupsType;

      @doc("The continuation token for this operation.")
      @query("continuationToken")
      continuationToken?: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SyncGroupLogListResult
  >;
}
