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
 * BaseBackupPolicy resource
 */
@parentResource(BackupVaultResource)
model BaseBackupPolicyResource is ProxyResource<BaseBackupPolicy> {
  @path
  @key("backupPolicyName")
  @segment("backupPolicies")
  name: string;
}

@armResourceOperations
interface BaseBackupPolicyResources {
  /**
   * Gets a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupPolicies_Get")
  get is ArmResourceRead<BaseBackupPolicyResource>;

  /**
   * Creates or Updates a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<BaseBackupPolicyResource>;

  /**
   * Deletes a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupPolicies_Delete")
  delete is ArmResourceDeleteSync<BaseBackupPolicyResource>;

  /**
   * Returns list of backup policies belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BackupPolicies_List")
  list is ArmResourceListByParent<BaseBackupPolicyResource>;
}

@@projectedName(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
