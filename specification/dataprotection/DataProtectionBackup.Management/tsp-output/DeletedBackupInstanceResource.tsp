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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(BackupVaultResource)
@Azure.ResourceManager.Private.armResourceInternal(DeletedBackupInstance)
@includeInapplicableMetadataInPayload(false)
model DeletedBackupInstanceResource extends ProxyResourceBase {
  /**
   * The name of the deleted backup instance
   */
  @path
  @key("backupInstanceName")
  @segment("deletedBackupInstances")
  name: string;

  /**
   * DeletedBackupInstanceResource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: DeletedBackupInstance;
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
