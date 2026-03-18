import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed server security alert policy.
 */
@parentResource(ManagedInstance)
model ManagedServerSecurityAlertPolicy
  is Azure.ResourceManager.ProxyResource<SecurityAlertsPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ManagedServerSecurityAlertPolicy,
    KeyName = "securityAlertPolicyName",
    SegmentName = "securityAlertPolicies",
    NamePattern = "",
    Type = SecurityAlertPolicyName
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ManagedServerSecurityAlertPolicies {
  /**
   * Get a managed server's threat detection policy.
   */
  get is ArmResourceRead<ManagedServerSecurityAlertPolicy>;

  /**
   * Creates or updates a threat detection policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedServerSecurityAlertPolicy,
    Response = ArmResourceUpdatedResponse<ManagedServerSecurityAlertPolicy> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ManagedServerSecurityAlertPolicy> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Get the managed server's threat detection policies.
   */
  listByInstance is ArmResourceListByParent<ManagedServerSecurityAlertPolicy>;
}

@@doc(ManagedServerSecurityAlertPolicy.name,
  "The name of the security alert policy."
);
@@doc(ManagedServerSecurityAlertPolicy.properties, "Resource properties.");
@@doc(ManagedServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The managed server security alert policy."
);
