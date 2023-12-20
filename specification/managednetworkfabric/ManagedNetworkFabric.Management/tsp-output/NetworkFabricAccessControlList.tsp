import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The Access Control List resource definition.")
model NetworkFabricAccessControlList
  is TrackedResource<AccessControlListProperties> {
  @doc("Name of the Access Control List.")
  @path
  @key("accessControlListName")
  @segment("accessControlLists")
  name: string;
}

@armResourceOperations
interface NetworkFabricAccessControlLists {
  @doc("Implements Access Control List GET method.")
  get is ArmResourceRead<NetworkFabricAccessControlList>;
  @doc("Implements Access Control List PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricAccessControlList>;
  @doc("API to update certain properties of the Access Control List resource.")
  update is ArmResourcePatchAsync<
    NetworkFabricAccessControlList,
    AccessControlListProperties
  >;
  @doc("Implements Access Control List DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricAccessControlList>;
  @doc("Implements AccessControlLists list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricAccessControlList>;
  @doc("Implements AccessControlLists list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkFabricAccessControlList>;
  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkFabricAccessControlList,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  resync is ArmResourceActionAsync<
    NetworkFabricAccessControlList,
    void,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabricAccessControlList,
    void,
    ValidateConfigurationResponse
  >;
}
