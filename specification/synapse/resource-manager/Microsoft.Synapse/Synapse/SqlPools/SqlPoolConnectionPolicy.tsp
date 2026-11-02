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
 * A Sql pool connection policy.
 */
@parentResource(SqlPool)
model SqlPoolConnectionPolicy
  is Azure.ResourceManager.ProxyResource<SqlPoolConnectionPolicyProperties> {
  ...ResourceNameParameter<
    Resource = SqlPoolConnectionPolicy,
    KeyName = "connectionPolicyName",
    SegmentName = "connectionPolicies",
    NamePattern = "",
    Type = ConnectionPolicyName
  >;

  /**
   * Resource kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface SqlPoolConnectionPolicies {
  /**
   * Get a Sql pool's connection policy, which is used with table auditing.
   */
  get is ArmResourceRead<SqlPoolConnectionPolicy>;
}

@@doc(SqlPoolConnectionPolicy.name, "The name of the connection policy.");
@@doc(SqlPoolConnectionPolicy.properties, "Resource properties.");
