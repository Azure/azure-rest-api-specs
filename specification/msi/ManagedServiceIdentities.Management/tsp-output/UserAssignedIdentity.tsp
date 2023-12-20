import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedServiceIdentities;
@doc("Describes an identity resource.")
model UserAssignedIdentity is TrackedResource<UserAssignedIdentityProperties> {
  @doc("The name of the identity resource.")
  @path
  @key("resourceName")
  @segment("userAssignedIdentities")
  name: string;
}

@armResourceOperations
interface UserAssignedIdentities {
  @doc("Gets the identity.")
  get is ArmResourceRead<UserAssignedIdentity>;
  @doc("Create or update an identity in the specified subscription and resource group.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<UserAssignedIdentity>;
  @doc("Update an identity in the specified subscription and resource group.")
  update is ArmResourcePatchSync<
    UserAssignedIdentity,
    UserAssignedIdentityProperties
  >;
  @doc("Deletes the identity.")
  delete is ArmResourceDeleteSync<UserAssignedIdentity>;
  @doc("Lists all the userAssignedIdentities available under the specified ResourceGroup.")
  listByResourceGroup is ArmResourceListByParent<UserAssignedIdentity>;
  @doc("Lists all the userAssignedIdentities available under the specified subscription.")
  listBySubscription is ArmListBySubscription<UserAssignedIdentity>;
}
