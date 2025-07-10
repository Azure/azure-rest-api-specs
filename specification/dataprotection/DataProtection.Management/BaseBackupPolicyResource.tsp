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
 * BaseBackupPolicy resource
 */
@parentResource(BackupVaultResource)
model BaseBackupPolicyResource
  is Azure.ResourceManager.ProxyResource<BaseBackupPolicy> {
  ...ResourceNameParameter<
    Resource = BaseBackupPolicyResource,
    KeyName = "backupPolicyName",
    SegmentName = "backupPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BaseBackupPolicyResources {
  /**
   * Gets a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupPolicies_Get")
  get is ArmResourceRead<BaseBackupPolicyResource>;

  /**
   * Creates or Updates a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BackupPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BaseBackupPolicyResource,
    Response = ArmResourceUpdatedResponse<BaseBackupPolicyResource>
  >;

  /**
   * Deletes a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupPolicies_Delete")
  delete is ArmResourceDeleteSync<BaseBackupPolicyResource>;

  /**
   * Returns list of backup policies belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupPolicies_List")
  @list
  list is ArmResourceListByParent<
    BaseBackupPolicyResource,
    Response = ArmResponse<BaseBackupPolicyResourceList>
  >;
}

@@doc(BaseBackupPolicyResource.name, "");
@@doc(BaseBackupPolicyResource.properties,
  "BaseBackupPolicyResource properties"
);
@@doc(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
