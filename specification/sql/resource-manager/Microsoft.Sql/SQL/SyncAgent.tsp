import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL Database sync agent.
 */
@parentResource(Server)
model SyncAgent is Azure.ResourceManager.ProxyResource<SyncAgentProperties> {
  ...ResourceNameParameter<
    Resource = SyncAgent,
    KeyName = "syncAgentName",
    SegmentName = "syncAgents",
    NamePattern = ""
  >;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SyncAgent,
    Response = ArmResourceUpdatedResponse<SyncAgent> | ArmResourceCreatedResponse<
      SyncAgent,
      ArmLroLocationHeader<FinalResult = SyncAgent> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a sync agent.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SyncAgent,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists sync agents in a server.
   */
  listByServer is ArmResourceListByParent<SyncAgent>;

  /**
   * Generates a sync agent key.
   */
  generateKey is ArmResourceActionSync<
    SyncAgent,
    void,
    ArmResponse<SyncAgentKeyProperties>
  >;

  /**
   * Lists databases linked to a sync agent.
   */
  @list
  @get
  @action("linkedDatabases")
  listLinkedDatabases is ArmResourceActionSync<
    SyncAgent,
    void,
    ArmResponse<ResourceListResult<SyncAgentLinkedDatabase>>
  >;
}

@@doc(SyncAgent.name, "The name of the sync agent.");
@@doc(SyncAgent.properties, "Resource properties.");
@@doc(SyncAgents.createOrUpdate::parameters.resource,
  "The requested sync agent resource state."
);
