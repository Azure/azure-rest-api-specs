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
 * Response for the LTR backup Operation API call
 */
@parentResource(Server)
model BackupsLongTermRetentionOperation
  is Azure.ResourceManager.ProxyResource<LtrBackupOperationResponseProperties> {
  ...ResourceNameParameter<
    Resource = BackupsLongTermRetentionOperation,
    KeyName = "backupName",
    SegmentName = "ltrBackupOperations",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface BackupsLongTermRetentionOperations {
  /**
   * Gets the results of a long retention backup operation for a server.
   */
  get is ArmResourceRead<BackupsLongTermRetentionOperation>;

  /**
   * Lists the results of the long term retention backup operations for a server.
   */
  listByServer is ArmResourceListByParent<
    BackupsLongTermRetentionOperation,
    Response = ArmResponse<LtrServerBackupOperationList>
  >;
}

@@doc(BackupsLongTermRetentionOperation.name, "The name of the backup.");
@@doc(BackupsLongTermRetentionOperation.properties,
  "Long Term Retention Backup Operation Resource Properties"
);
@@minLength(BackupsLongTermRetentionOperation.name, 1);
@@maxLength(BackupsLongTermRetentionOperation.name, 128);
