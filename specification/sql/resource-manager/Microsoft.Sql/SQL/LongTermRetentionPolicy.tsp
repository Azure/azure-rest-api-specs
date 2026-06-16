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
 * A long term retention policy.
 */
@parentResource(Database)
model LongTermRetentionPolicy
  is Azure.ResourceManager.ProxyResource<LongTermRetentionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = LongTermRetentionPolicy,
    KeyName = "policyName",
    SegmentName = "backupLongTermRetentionPolicies",
    NamePattern = "",
    Type = LongTermRetentionPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface LongTermRetentionPolicies {
  /**
   * Gets a database's long term retention policy.
   */
  get is ArmResourceRead<LongTermRetentionPolicy>;

  /**
   * Set or update a database's long term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LongTermRetentionPolicy,
    Response = ArmResourceUpdatedResponse<LongTermRetentionPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = LongTermRetentionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Gets a database's long term retention policy.
   */
  listByDatabase is ArmResourceListByParent<LongTermRetentionPolicy>;
}

@@doc(LongTermRetentionPolicy.name,
  "The policy name. Should always be Default."
);
@@doc(LongTermRetentionPolicy.properties, "Resource properties.");
@@doc(LongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The long term retention policy info."
);
