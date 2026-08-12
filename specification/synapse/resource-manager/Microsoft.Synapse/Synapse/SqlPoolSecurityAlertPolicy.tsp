import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A Sql pool security alert policy.
 */
@parentResource(SqlPool)
model SqlPoolSecurityAlertPolicy
  is Azure.ResourceManager.ProxyResource<SecurityAlertPolicyProperties> {
  ...ResourceNameParameter<
    Resource = SqlPoolSecurityAlertPolicy,
    KeyName = "securityAlertPolicyName",
    SegmentName = "securityAlertPolicies",
    NamePattern = "",
    Type = SqlPoolSecurityAlertPolicyName
  >;
}

@armResourceOperations
interface SqlPoolSecurityAlertPolicies {
  /**
   * Get a Sql pool's security alert policy.
   */
  get is ArmResourceRead<SqlPoolSecurityAlertPolicy>;

  /**
   * Create or update a Sql pool's security alert policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<SqlPoolSecurityAlertPolicy>;

  /**
   * Get a list of Sql pool's security alert policies.
   */
  list is ArmResourceListByParent<
    SqlPoolSecurityAlertPolicy,
    Response = ArmResponse<ListSqlPoolSecurityAlertPolicies>
  >;
}

@@doc(
  SqlPoolSecurityAlertPolicy.name,
  "The name of the security alert policy."
);
@@doc(SqlPoolSecurityAlertPolicy.properties, "Resource properties.");
@@doc(
  SqlPoolSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The Sql pool security alert policy."
);
