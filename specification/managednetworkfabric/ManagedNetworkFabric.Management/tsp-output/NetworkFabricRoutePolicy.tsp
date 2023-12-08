import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The RoutePolicy resource definition.")
model NetworkFabricRoutePolicy is TrackedResource<RoutePolicyProperties> {
  @doc("Name of the Route Policy.")
  @path
  @key("routePolicyName")
  @segment("routePolicies")
  name: string;
}

@armResourceOperations
interface NetworkFabricRoutePolicies {
  @doc("Implements Route Policy GET method.")
  get is ArmResourceRead<NetworkFabricRoutePolicy>;
  @doc("Implements Route Policy PUT method.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricRoutePolicy>;
  @doc("API to update certain properties of the Route Policy resource.")
  update is ArmResourcePatchAsync<
    NetworkFabricRoutePolicy,
    RoutePolicyProperties
  >;
  @doc("Implements Route Policy DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricRoutePolicy>;
  @doc("Implements RoutePolicies list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricRoutePolicy>;
  @doc("Implements RoutePolicies list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkFabricRoutePolicy>;
  @doc("Updated the admin state for this Route Policy.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkFabricRoutePolicy,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;
  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabricRoutePolicy,
    {},
    ValidateConfigurationResponse
  >;
  @doc("Commits the configuration of the given resources.")
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabricRoutePolicy,
    {},
    CommonPostActionResponseForStateUpdate
  >;
}
