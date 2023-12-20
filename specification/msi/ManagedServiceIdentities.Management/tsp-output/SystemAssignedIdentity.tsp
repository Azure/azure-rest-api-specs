import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedServiceIdentities;
@doc("Describes a system assigned identity resource.")
@singleton("default")
model SystemAssignedIdentity
  is ExtensionResource<SystemAssignedIdentityProperties> {
  @key("default")
  @segment("identities")
  name: string;
}

@armResourceOperations
interface SystemAssignedIdentities {
  @doc("Gets the systemAssignedIdentity available under the specified RP scope.")
  getByScope is ArmResourceRead<SystemAssignedIdentity>;
}
