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
  @path
  @key("internetGatewayName")
  @segment("internetGateways")
  name: string;
}

@armResourceOperations
interface InternetGateways {
  @doc("Implements Gateway GET method.")
  get is ArmResourceRead<InternetGateway>;
  @doc("Creates a Network Fabric Service Internet Gateway resource instance.")
  create is ArmResourceCreateOrUpdateAsync<InternetGateway>;
  @doc("Execute patch on Network Fabric Service Internet Gateway.")
  update is ArmResourcePatchAsync<InternetGateway, InternetGatewayProperties>;
  @doc("Execute a delete on Network Fabric Service Internet Gateway.")
  delete is ArmResourceDeleteWithoutOkAsync<InternetGateway>;
  @doc("Displays Internet Gateways list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<InternetGateway>;
  @doc("Displays Internet Gateways list by subscription GET method.")
  listBySubscription is ArmListBySubscription<InternetGateway>;
}
