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
@singleton("default")
model SystemAssignedIdentity
  is ExtensionResource<SystemAssignedIdentityProperties> {
  @key("identity")
  @segment("identities")
  name: string;
}

@armResourceOperations
interface SystemAssignedIdentities {
  /**
   * Gets the systemAssignedIdentity available under the specified RP scope.
   */
  getByScope is ArmResourceRead<SystemAssignedIdentity>;
}
