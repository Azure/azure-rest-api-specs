import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A long term retention policy.
 */
@parentResource(ManagedDatabase)
model ManagedInstanceLongTermRetentionPolicy
  is Azure.ResourceManager.ProxyResource<ManagedInstanceLongTermRetentionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ManagedInstanceLongTermRetentionPolicy,
    KeyName = "policyName",
    SegmentName = "backupLongTermRetentionPolicies",
    NamePattern = "",
    Type = ManagedInstanceLongTermRetentionPolicyName
  >;
}

@armResourceOperations
interface ManagedInstanceLongTermRetentionPolicies {
  /**
   * Gets a managed database's long term retention policy.
   */
  get is ArmResourceRead<ManagedInstanceLongTermRetentionPolicy>;

  /**
   * Sets a managed database's long term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedInstanceLongTermRetentionPolicy,
    Response = ArmResourceUpdatedResponse<ManagedInstanceLongTermRetentionPolicy> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ManagedInstanceLongTermRetentionPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a managed database's long term retention policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedInstanceLongTermRetentionPolicy,
    Response = ArmResponse<ManagedInstanceLongTermRetentionPolicy> | ArmDeleteAcceptedLroResponse
  >;

  /**
   * Gets a database's long term retention policy.
   */
  listByDatabase is ArmResourceListByParent<ManagedInstanceLongTermRetentionPolicy>;
}

@@doc(ManagedInstanceLongTermRetentionPolicy.name,
  "The policy name. Should always be Default."
);
@@doc(ManagedInstanceLongTermRetentionPolicy.properties,
  "Resource properties."
);
@@doc(ManagedInstanceLongTermRetentionPolicies.createOrUpdate::parameters.resource,
  "The long term retention policy info."
);
