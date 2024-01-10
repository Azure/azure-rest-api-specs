import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Internet Gateway resource definition.")
model InternetGateway is TrackedResource<InternetGatewayProperties> {
  @doc("Name of the Internet Gateway.")
  @key("internetGatewayName")
  @segment("internetGateways")
  name: string;
}

@armResourceOperations
interface InternetGateways {
  @doc("Implements Gateway GET method.")
  get is ArmResourceRead<InternetGateway>;

  @doc("Execute patch on Network Fabric Service Internet Gateway.")
  update is ArmCustomPatchAsync<InternetGateway, InternetGatewayPatch>;

  @doc("Displays Internet Gateways list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<InternetGateway>;

  @doc("Displays Internet Gateways list by subscription GET method.")
  listBySubscription is ArmListBySubscription<InternetGateway>;
}
