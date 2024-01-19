import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("An Azure SQL Database sync member.")
@parentResource(SyncGroup)
model SyncMember is ProxyResource<SyncMemberProperties> {
  @doc("The name of the sync member.")
  @path
  @key("syncMemberName")
  @segment("syncMembers")
  name: string;
}

@armResourceOperations
interface SyncMembers {
  @doc("Gets a sync member.")
  get is ArmResourceRead<SyncMember>;

  @doc("Creates or updates a sync member.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SyncMember>;

  @doc("Updates an existing sync member.")
  update is ArmCustomPatchAsync<SyncMember, SyncMember>;

  @doc("Deletes a sync member.")
  delete is ArmResourceDeleteAsync<SyncMember>;

  @doc("Lists sync members in the given sync group.")
  listBySyncGroup is ArmResourceListByParent<SyncMember>;

  @doc("Refreshes a sync member database schema.")
  refreshMemberSchema is ArmResourceActionAsync<SyncMember, void, void>;

  @doc("Gets a sync member database schema.")
  // FIXME: SyncMembers_ListMemberSchemas could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/schemas")
  @get
  listMemberSchemas is Azure.Core.Foundations.Operation<
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

      @doc("The name of the sync group on which the sync member is hosted.")
      @path
      syncGroupName: string;

      @doc("The name of the sync member.")
      @path
      syncMemberName: string;

      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;
    },
    SyncFullSchemaPropertiesListResult
  >;
}

@@projectedName(SyncMembers.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SyncMembers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncMembers.createOrUpdate::parameters.resource,
  "The requested sync member resource state."
);
@@projectedName(SyncMembers.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SyncMembers.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncMembers.update::parameters.properties,
  "The requested sync member resource state."
);
