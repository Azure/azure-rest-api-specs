import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A short term retention policy.
 */
@parentResource(Database)
model BackupShortTermRetentionPolicy
  is Azure.ResourceManager.ProxyResource<BackupShortTermRetentionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = BackupShortTermRetentionPolicy,
    KeyName = "policyName",
    SegmentName = "backupShortTermRetentionPolicies",
    NamePattern = "",
    Type = ShortTermRetentionPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface BackupShortTermRetentionPolicies {
  /**
   * Gets a database's short term retention policy.
   */
  get is ArmResourceRead<BackupShortTermRetentionPolicy>;

  /**
   * Updates a database's short term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BackupShortTermRetentionPolicy,
    Response = ArmResourceUpdatedResponse<BackupShortTermRetentionPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BackupShortTermRetentionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates a database's short term retention policy.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    BackupShortTermRetentionPolicy,
    PatchModel = BackupShortTermRetentionPolicy
  >;

  /**
   * Gets a database's short term retention policy.
   */
  listByDatabase is ArmResourceListByParent<BackupShortTermRetentionPolicy>;
}

@@doc(BackupShortTermRetentionPolicy.name,
  "The policy name. Should always be default."
);
@@doc(BackupShortTermRetentionPolicy.properties, "Resource properties.");
@@doc(BackupShortTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The short term retention policy info."
);
@@doc(BackupShortTermRetentionPolicies.update::parameters.properties,
  "The short term retention policy info."
);
