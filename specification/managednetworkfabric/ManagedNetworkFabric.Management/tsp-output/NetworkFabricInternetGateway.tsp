import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The Internet Gateway resource definition.")
model NetworkFabricInternetGateway
  is TrackedResource<InternetGatewayProperties> {
  @doc("Name of the Internet Gateway.")
  @path
  @key("internetGatewayName")
  @segment("internetGateways")
  name: string;
}

@armResourceOperations
interface NetworkFabricInternetGateways {
  @doc("Implements Gateway GET method.")
  get is ArmResourceRead<NetworkFabricInternetGateway>;
  @doc("Execute patch on Network Fabric Service Internet Gateway.")
  update is ArmResourcePatchAsync<
    NetworkFabricInternetGateway,
    InternetGatewayProperties
  >;
  @doc("Displays Internet Gateways list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricInternetGateway>;
  @doc("Displays Internet Gateways list by subscription GET method.")
  listBySubscription is ArmListBySubscription<NetworkFabricInternetGateway>;
}
