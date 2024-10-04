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
/**
 * An Azure SQL Database sync member.
 */
@parentResource(SyncGroup)
model SyncMember is ProxyResource<SyncMemberProperties> {
  /**
   * The name of the sync member.
   */
  @path
  @key("syncMemberName")
  @segment("syncMembers")
  name: string;
}

@armResourceOperations
interface SyncMembers {
  /**
   * Gets a sync member.
   */
  get is ArmResourceRead<SyncMember>;

  /**
   * Creates or updates a sync member.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SyncMember>;

  /**
   * Updates an existing sync member.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<SyncMember, SyncMember>;

  /**
   * Deletes a sync member.
   */
  delete is ArmResourceDeleteAsync<SyncMember>;

  /**
   * Lists sync members in the given sync group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SyncMembers_ListBySyncGroup")
  listBySyncGroup is ArmResourceListByParent<SyncMember>;

  /**
   * Refreshes a sync member database schema.
   */
  refreshMemberSchema is ArmResourceActionAsync<SyncMember, void, void>;

  /**
   * Gets a sync member database schema.
   */
  // FIXME: SyncMembers_ListMemberSchemas could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/syncGroups/{syncGroupName}/syncMembers/{syncMemberName}/schemas")
  @get
  listMemberSchemas is Azure.Core.Foundations.Operation<
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
       * The name of the sync group on which the sync member is hosted.
       */
      @path
      syncGroupName: string;

      /**
       * The name of the sync member.
       */
      @path
      syncMemberName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
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
