import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ManagedInstance)
@includeInapplicableMetadataInPayload(false)
model ManagedInstancePrivateLink extends ProxyResource {
  /**
   * The name of the private link resource.
   */
  @path
  @key("groupName")
  @segment("privateLinkResources")
  @visibility("read")
  name: string;

  /**
   * The private link resource group id.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedInstancePrivateLinkProperties;
}

@armResourceOperations
interface ManagedInstancePrivateLinks {
  /**
   * Gets a private link resource for SQL server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstancePrivateLinkResources_Get")
  get is ArmResourceRead<ManagedInstancePrivateLink>;

  /**
   * Gets the private link resources for SQL server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedInstancePrivateLinkResources_ListByManagedInstance")
  listByManagedInstance is ArmResourceListByParent<ManagedInstancePrivateLink>;
}
