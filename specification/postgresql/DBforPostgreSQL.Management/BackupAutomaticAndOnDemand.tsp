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
 * Properties of a backup.
 */
@parentResource(Server)
model BackupAutomaticAndOnDemand
  is Azure.ResourceManager.ProxyResource<BackupAutomaticAndOnDemandProperties> {
  ...ResourceNameParameter<
    Resource = BackupAutomaticAndOnDemand,
    KeyName = "backupName",
    SegmentName = "backups",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface BackupAutomaticAndOnDemands {
  /**
   * Gets information of an on demand backup, given its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsAutomaticAndOnDemand_Get")
  get is ArmResourceRead<BackupAutomaticAndOnDemand>;

  // FIXME: (ArmResourceCreateOrReplace): ArmResourceCreateOrReplaceAsync/ArmResourceCreateOrReplaceSync should have a body parameter.
  /**
   * Creates an on demand backup of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BackupsAutomaticAndOnDemand_Create")
  create is ArmResourceCreateOrReplaceAsync<
    BackupAutomaticAndOnDemand,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * Deletes a specific backup, given its name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsAutomaticAndOnDemand_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<BackupAutomaticAndOnDemand>;

  /**
   * Lists all available backups of a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupsAutomaticAndOnDemand_ListByServer")
  listByServer is ArmResourceListByParent<
    BackupAutomaticAndOnDemand,
    Response = ArmResponse<BackupAutomaticAndOnDemandList>
  >;
}

@@maxLength(BackupAutomaticAndOnDemand.name, 128);
@@minLength(BackupAutomaticAndOnDemand.name, 1);
@@doc(BackupAutomaticAndOnDemand.name, "Name of the backup.");
@@doc(BackupAutomaticAndOnDemand.properties, "Properties of a backup.");
