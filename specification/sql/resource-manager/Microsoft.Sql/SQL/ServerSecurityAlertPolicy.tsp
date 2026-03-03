import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server security alert policy.
 */
@parentResource(Server)
model ServerSecurityAlertPolicy
  is Azure.ResourceManager.ProxyResource<SecurityAlertsPolicyProperties> {
  ...ResourceNameParameter<
    Resource = ServerSecurityAlertPolicy,
    KeyName = "securityAlertPolicyName",
    SegmentName = "securityAlertPolicies",
    NamePattern = "",
    Type = SecurityAlertPolicyName
  >;
}

@armResourceOperations
interface ServerSecurityAlertPolicies {
  /**
   * Get a server's security alert policy.
   */
  get is ArmResourceRead<ServerSecurityAlertPolicy>;

  /**
   * Creates or updates a threat detection policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerSecurityAlertPolicy,
    Response = ArmResourceUpdatedResponse<ServerSecurityAlertPolicy> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ServerSecurityAlertPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get the server's threat detection policies.
   */
  listByServer is ArmResourceListByParent<ServerSecurityAlertPolicy>;
}

@@doc(ServerSecurityAlertPolicy.name, "The name of the security alert policy.");
@@doc(ServerSecurityAlertPolicy.properties, "Resource properties.");
@@doc(ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The server security alert policy."
);
