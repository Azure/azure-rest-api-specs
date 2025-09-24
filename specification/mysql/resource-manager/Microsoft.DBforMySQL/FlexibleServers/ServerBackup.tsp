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
model ServerBackup
  is Azure.ResourceManager.ProxyResource<ServerBackupProperties> {
  ...ResourceNameParameter<
    Resource = ServerBackup,
    KeyName = "backupName",
    SegmentName = "backups",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Backups {
  /**
   * List all the backups for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<ServerBackup>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Create backup for a given server with specified backup name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  put is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ServerBackup,
    void,
    Response = ArmResourceUpdatedResponse<ServerBackup>
  >;

  /**
   * List all the backups for a given server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByServer is ArmResourceListByParent<
    ServerBackup,
    Response = ArmResponse<ServerBackupListResult>
  >;
}

@@doc(ServerBackup.name, "The name of the backup.");
@@doc(ServerBackup.properties, "The properties of a server backup.");
