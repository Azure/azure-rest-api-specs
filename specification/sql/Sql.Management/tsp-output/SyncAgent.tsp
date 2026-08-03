import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL Database sync agent.
 */
@parentResource(Server)
model SyncAgent is ProxyResource<SyncAgentProperties> {
  /**
   * The name of the sync agent.
   */
  @path
  @key("syncAgentName")
  @segment("syncAgents")
  name: string;
}

@armResourceOperations
interface SyncAgents {
  /**
   * Gets a sync agent.
   */
  get is ArmResourceRead<SyncAgent>;

  /**
   * Creates or updates a sync agent.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SyncAgent>;

  /**
   * Deletes a sync agent.
   */
  delete is ArmResourceDeleteAsync<SyncAgent>;

  /**
   * Lists sync agents in a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SyncAgents_ListByServer")
  listByServer is ArmResourceListByParent<SyncAgent>;

  /**
   * Generates a sync agent key.
   */
  generateKey is ArmResourceActionSync<SyncAgent, void, SyncAgentKeyProperties>;

  /**
   * Lists databases linked to a sync agent.
   */
  // FIXME: SyncAgents_ListLinkedDatabases could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/syncAgents/{syncAgentName}/linkedDatabases")
  @get
  listLinkedDatabases is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the server on which the sync agent is hosted.
       */
      @path
      serverName: string;

      /**
       * The name of the sync agent.
       */
      @path
      syncAgentName: string;

      /**
       * The subscription ID that identifies an Azure subscription.
       */
      @path
      subscriptionId: string;
    },
    SyncAgentLinkedDatabaseListResult
  >;
}

@@projectedName(SyncAgents.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SyncAgents.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SyncAgents.createOrUpdate::parameters.resource,
  "The requested sync agent resource state."
);
