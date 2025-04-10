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

namespace Microsoft.DBforPostgreSQL;
/**
 * Server backup properties
 */
@parentResource(Server)
model ServerBackup
  is Azure.ResourceManager.ProxyResource<ServerBackupProperties> {
  ...ResourceNameParameter<
    Resource = ServerBackup,
    KeyName = "backupName",
    SegmentName = "backups",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface ServerBackups {
  /**
   * Get specific backup for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Backups_Get")
  get is ArmResourceRead<ServerBackup>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create a specific backup for PostgreSQL flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Backups_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ServerBackup,
    Response = ArmResourceUpdatedResponse<ServerBackup> | ArmResourceCreatedResponse<ServerBackup> | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a specific backup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Backups_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ServerBackup>;

  /**
   * List all the backups for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Backups_ListByServer")
  listByServer is ArmResourceListByParent<ServerBackup>;
}

@@minLength(ServerBackup.name, 1);
@@doc(ServerBackup.name, "The name of the backup.");
@@doc(ServerBackup.properties, "The properties of a server backup.");
