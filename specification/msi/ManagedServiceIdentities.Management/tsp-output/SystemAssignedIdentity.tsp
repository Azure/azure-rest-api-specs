import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedIdentity;
/**
 * Describes a system assigned identity resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  SystemAssignedIdentityProperties
)
model SystemAssignedIdentity extends ExtensionResourceBase {
  @key("identity")
  @segment("identities")
  @visibility("read")
  name: string;

  /**
   * The properties associated with the identity.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SystemAssignedIdentityProperties;
}

@armResourceOperations
interface SystemAssignedIdentities {
  /**
   * Gets the systemAssignedIdentity available under the specified RP scope.
   */
  getByScope is ArmResourceRead<SystemAssignedIdentity>;
}
