import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A server security alert policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Server)
@Azure.ResourceManager.Private.armResourceInternal(
  SecurityAlertsPolicyProperties
)
@includeInapplicableMetadataInPayload(false)
model ServerSecurityAlertPolicy extends ProxyResource {
  /**
   * The name of the security alert policy.
   */
  @path
  @key("securityAlertPolicyName")
  @segment("securityAlertPolicies")
  name: SecurityAlertPolicyName;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SecurityAlertsPolicyProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerSecurityAlertPolicy>;

  /**
   * Get the server's threat detection policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerSecurityAlertPolicies_ListByServer")
  listByServer is ArmResourceListByParent<ServerSecurityAlertPolicy>;
}

@@projectedName(ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerSecurityAlertPolicies.createOrUpdate::parameters.resource,
  "The server security alert policy."
);
