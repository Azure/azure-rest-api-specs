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

namespace Microsoft.DBforMySQL;
/**
 * Server backup properties
 */
@parentResource(Server)
model ServerBackupV2
  is Azure.ResourceManager.ProxyResource<ServerBackupPropertiesV2> {
  ...ResourceNameParameter<
    Resource = ServerBackupV2,
    KeyName = "backupName",
    SegmentName = "backupsV2",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface ServerBackupV2s {
  /**
   * Get backup for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongRunningBackups_Get")
  get is ArmResourceRead<ServerBackupV2>;

  /**
   * Create backup for a given server with specified backup name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @operationId("LongRunningBackup_Create")
  create is ArmResourceCreateOrReplaceAsync<
    ServerBackupV2,
    Response = ArmResourceUpdatedResponse<ServerBackupV2> | ArmResourceCreatedResponse<ServerBackupV2> | ArmAcceptedLroResponse
  >;

  /**
   * List all the backups for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LongRunningBackups_List")
  list is ArmResourceListByParent<
    ServerBackupV2,
    Response = ArmResponse<ServerBackupV2ListResult>
  >;
}

@@doc(ServerBackupV2.name, "The name of the backup.");
@@doc(ServerBackupV2.properties, "The properties of a server backup.");
@@doc(ServerBackupV2s.create::parameters.resource,
  "The required parameters for creating and exporting backup of the given server."
);
