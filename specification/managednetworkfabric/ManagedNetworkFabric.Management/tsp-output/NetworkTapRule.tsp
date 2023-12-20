import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The NetworkTapRule resource definition.")
model NetworkTapRule is TrackedResource<NetworkTapRuleProperties> {
  @doc("Name of the Network Tap Rule.")
  @path
  @key("networkTapRuleName")
  @segment("networkTapRules")
  name: string;
}

@armResourceOperations
interface NetworkTapRules {
  @doc("Get Network Tap Rule resource details.")
  get is ArmResourceRead<NetworkTapRule>;
  @doc("Create Network Tap Rule resource.")
  create is ArmResourceCreateOrUpdateAsync<NetworkTapRule>;
  @doc("Update certain properties of the Network Tap Rule resource.")
  update is ArmResourcePatchAsync<NetworkTapRule, NetworkTapRuleProperties>;
  @doc("Delete Network Tap Rule resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkTapRule>;
  @doc("List all the Network Tap Rule resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkTapRule>;
  @doc("List all the Network Tap Rule resources in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkTapRule>;
  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTapRule,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  resync is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    CommonPostActionResponseForStateUpdate
  >;
  @doc("Implements the operation to the underlying resources.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ValidateConfigurationResponse
  >;
}
