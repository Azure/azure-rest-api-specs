import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Deleted Backup Instance
 */
@parentResource(BackupVaultResource)
model DeletedBackupInstanceResource
  is Azure.ResourceManager.ProxyResource<DeletedBackupInstance> {
  ...ResourceNameParameter<
    Resource = DeletedBackupInstanceResource,
    KeyName = "backupInstanceName",
    SegmentName = "deletedBackupInstances",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedBackupInstanceResources {
  /**
   * Gets a deleted backup instance with name in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedBackupInstances_Get")
  get is ArmResourceRead<
    Resource = DeletedBackupInstanceResource,
    Error = CloudError
  >;

  /**
   * Gets deleted backup instances belonging to a backup vault
   */
  // /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{vaultName}/deletedBackupInstances
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedBackupInstances_List")
  @list
  list is ArmResourceListByParent<
    DeletedBackupInstanceResource,
    Response = ArmResponse<DeletedBackupInstanceResourceList>,
    Error = CloudError
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DeletedBackupInstances_Undelete")
  undelete is ArmResourceActionAsync<
    DeletedBackupInstanceResource,
    void,
    OkResponse,
    Error = CloudError
  >;
}

@@doc(DeletedBackupInstanceResource.name,
  "The name of the deleted backup instance"
);
@@doc(DeletedBackupInstanceResource.properties,
  "DeletedBackupInstanceResource properties"
);
