import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
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
  get is ArmResourceRead<
    Resource = BaseBackupPolicyResource,
    Error = CloudError
  >;

  /**
   * Creates or Updates a backup policy belonging to a backup vault
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BaseBackupPolicyResource,
    Response = ArmResourceUpdatedResponse<BaseBackupPolicyResource>,
    Error = CloudError
  >;

  /**
   * Deletes a backup policy belonging to a backup vault
   */
  delete is ArmResourceDeleteSync<
    Resource = BaseBackupPolicyResource,
    Error = CloudError
  >;

  /**
   * Returns list of backup policies belonging to a backup vault
   */
  @list
  list is ArmResourceListByParent<
    BaseBackupPolicyResource,
    Response = ArmResponse<BaseBackupPolicyResourceList>,
    Error = CloudError
  >;
}

@@doc(BaseBackupPolicyResource.name, "");
@@doc(BaseBackupPolicyResource.properties,
  "BaseBackupPolicyResource properties"
);
@@doc(BaseBackupPolicyResources.createOrUpdate::parameters.resource,
  "Request body for operation"
);
