import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ManagedNetworkFabric;
@doc("The Internet Gateway Rule resource definition.")
model NetworkFabricInternetGatewayRule
  is TrackedResource<InternetGatewayRuleProperties> {
  @doc("Name of the Internet Gateway rule.")
  @path
  @key("internetGatewayRuleName")
  @segment("internetGatewayRules")
  name: string;
}

@armResourceOperations
interface NetworkFabricInternetGatewayRules {
  @doc("Gets an Internet Gateway Rule resource.")
  get is ArmResourceRead<NetworkFabricInternetGatewayRule>;
  @doc("Creates an Internet Gateway rule resource.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricInternetGatewayRule>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("API to update certain properties of the Internet Gateway Rule resource.")
  update is ArmCustomPatchAsync<
    NetworkFabricInternetGatewayRule,
    InternetGatewayRulePatch
  >;
  @doc("Implements Internet Gateway Rules DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricInternetGatewayRule>;
  @doc("Implements Internet Gateway Rules list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricInternetGatewayRule>;
  @doc("List all Internet Gateway rules in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkFabricInternetGatewayRule>;
}
