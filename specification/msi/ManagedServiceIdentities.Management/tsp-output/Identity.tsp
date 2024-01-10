import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedIdentity;
@doc("Describes an identity resource.")
model Identity is TrackedResource<UserAssignedIdentityProperties> {
  @doc("The name of the identity resource.")
  @key("resourceName")
  @segment("userAssignedIdentities")
  name: string;
}

@armResourceOperations
@projectedName("client", "UserAssignedIdentities")
interface Identities_UserAssignedIdentities {
  @doc("Gets the identity.")
  get is ArmResourceRead<Identity>;

  @doc("Create or update an identity in the specified subscription and resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Identity>;

  @doc("Update an identity in the specified subscription and resource group.")
  update is ArmCustomPatchSync<Identity, IdentityUpdate>;

  @doc("Deletes the identity.")
  delete is ArmResourceDeleteSync<Identity>;

  @doc("Lists all the userAssignedIdentities available under the specified ResourceGroup.")
  listByResourceGroup is ArmResourceListByParent<Identity>;

  @doc("Lists all the userAssignedIdentities available under the specified subscription.")
  listBySubscription is ArmListBySubscription<Identity>;
}
