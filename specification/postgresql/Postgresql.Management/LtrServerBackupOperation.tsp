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
model LtrServerBackupOperation
  is Azure.ResourceManager.ProxyResource<LtrBackupOperationResponseProperties> {
  ...ResourceNameParameter<
    Resource = LtrServerBackupOperation,
    KeyName = "backupName",
    SegmentName = "ltrBackupOperations",
    NamePattern = "^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*"
  >;
}

@armResourceOperations
interface LtrServerBackupOperations {
  /**
   * Gets the result of the give long term retention backup operation for the flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ltrBackupOperations_Get")
  get is ArmResourceRead<LtrServerBackupOperation>;

  /**
   * Gets the result of the give long term retention backup operations for the flexible server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ltrBackupOperations_ListByServer")
  listByServer is ArmResourceListByParent<
    LtrServerBackupOperation,
    Response = ArmResponse<LtrServerBackupOperationList>
  >;
}

@@doc(LtrServerBackupOperation.name, "The name of the backup.");
@@doc(LtrServerBackupOperation.properties,
  "Long Term Retention Backup Operation Resource Properties"
);
