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
model AccessControlList is TrackedResource<AccessControlListProperties> {
  @doc("Name of the Access Control List.")
  @path
  @key("accessControlListName")
  @segment("accessControlLists")
  name: string;
}

@armResourceOperations
interface AccessControlLists {
  @doc("Implements Access Control List GET method.")
  get is ArmResourceRead<AccessControlList>;
  @doc("Implements Access Control List PUT method.")
  create is ArmResourceCreateOrUpdateAsync<AccessControlList>;
  @doc("API to update certain properties of the Access Control List resource.")
  update is ArmResourcePatchAsync<
    AccessControlList,
    AccessControlListProperties
  >;
  @doc("Implements Access Control List DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<AccessControlList>;
  @doc("Implements AccessControlLists list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<AccessControlList>;
  @doc("Implements AccessControlLists list by subscription GET method.")
  listBySubscription is ArmListBySubscription<AccessControlList>;
  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    AccessControlList,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  resync is ArmResourceActionAsync<
    AccessControlList,
    void,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  validateConfiguration is ArmResourceActionAsync<
    AccessControlList,
    void,
    ValidateConfigurationResponse
  >;
}
