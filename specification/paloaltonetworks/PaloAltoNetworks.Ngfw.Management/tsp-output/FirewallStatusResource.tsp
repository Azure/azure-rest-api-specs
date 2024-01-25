import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace PaloAltoNetworks.Cloudngfw;
/**
 * Firewall Status
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(FirewallResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(FirewallStatusProperty)
model FirewallStatusResource extends ProxyResourceBase {
  @key("status")
  @segment("statuses")
  @visibility("read")
  name: string;

  /**
   * The resource-specific properties for this resource.
   */
  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties: FirewallStatusProperty;
}

@armResourceOperations
interface FirewallStatusResources {
  /**
   * Get a FirewallStatusResource
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FirewallStatus_Get")
  get is ArmResourceRead<FirewallStatusResource>;

  /**
   * List FirewallStatusResource resources by Firewalls
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("FirewallStatus_ListByFirewalls")
  listByFirewalls is ArmResourceListByParent<FirewallStatusResource>;
}
