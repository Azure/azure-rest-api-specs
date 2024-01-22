import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BackupVaultResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataProtection;
/**
 * Deleted Backup Instance
 */
@parentResource(BackupVaultResource)
model DeletedBackupInstanceResource is ProxyResource<DeletedBackupInstance> {
  /**
   * The name of the deleted backup instance
   */
  @path
  @key("backupInstanceName")
  @segment("deletedBackupInstances")
  name: string;
}

@armResourceOperations
interface DeletedBackupInstanceResources {
  /**
   * Gets a deleted backup instance with name in a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeletedBackupInstances_Get")
  get is ArmResourceRead<DeletedBackupInstanceResource>;

  /**
   * Gets deleted backup instances belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeletedBackupInstances_List")
  list is ArmResourceListByParent<DeletedBackupInstanceResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DeletedBackupInstances_Undelete")
  undelete is ArmResourceActionAsync<DeletedBackupInstanceResource, void, void>;
}
