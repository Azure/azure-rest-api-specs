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
 * A virtual network rule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Server)
@includeInapplicableMetadataInPayload(false)
model VirtualNetworkRule extends ProxyResource {
  /**
   * The name of the virtual network rule.
   */
  @path
  @key("virtualNetworkRuleName")
  @segment("virtualNetworkRules")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VirtualNetworkRuleProperties;
}

@armResourceOperations
interface VirtualNetworkRules {
  /**
   * Gets a virtual network rule.
   */
  get is ArmResourceRead<VirtualNetworkRule>;

  /**
   * Creates or updates an existing virtual network rule.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VirtualNetworkRule>;

  /**
   * Deletes the virtual network rule with the given name.
   */
  delete is ArmResourceDeleteAsync<VirtualNetworkRule>;

  /**
   * Gets a list of virtual network rules in a server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualNetworkRules_ListByServer")
  listByServer is ArmResourceListByParent<VirtualNetworkRule>;
}

@@projectedName(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(VirtualNetworkRules.createOrUpdate::parameters.resource,
  "The requested virtual Network Rule Resource state."
);
