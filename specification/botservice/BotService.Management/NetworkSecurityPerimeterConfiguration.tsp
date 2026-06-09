import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Bot.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.BotService;
@doc("Network Security Perimeter configuration")
@parentResource(Bot)
model NetworkSecurityPerimeterConfiguration
  is ProxyResource<NetworkSecurityPerimeterConfigurationProperties> {
  @doc("The resource association Name. Composed of parameter guid and association name.")
  @pattern(".*")
  @path
  @key("networkSecurityPerimeterConfigurationName")
  @segment("networkSecurityPerimeterConfigurations")
  name: string;
}

@armResourceOperations
interface NetworkSecurityPerimeterConfigurations {
  @doc("Gets the specified Network Security Perimeter configuration associated with the Bot.")
  get is ArmResourceRead<NetworkSecurityPerimeterConfiguration>;
  @doc("List Network Security Perimeter configurations associated with the Bot.")
  list is ArmResourceListByParent<NetworkSecurityPerimeterConfiguration>;
  @doc("Reconcile the specified Network Security Perimeter configuration associated with the Bot.")
  reconcile is ArmResourceActionAsync<
    NetworkSecurityPerimeterConfiguration,
    {},
    NetworkSecurityPerimeterConfiguration
  >;
}
