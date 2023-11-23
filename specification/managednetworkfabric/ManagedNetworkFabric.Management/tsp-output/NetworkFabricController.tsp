import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Fabric Controller resource definition.")
model NetworkFabricController
  is TrackedResource<NetworkFabricControllerProperties> {
  @doc("Name of the Network Fabric Controller.")
  @path
  @key("networkFabricControllerName")
  @segment("networkFabricControllers")
  name: string;
}

@armResourceOperations
interface NetworkFabricControllers {
  @doc("Shows the provisioning status of Network Fabric Controller.")
  get is ArmResourceRead<NetworkFabricController>;
  @doc("Creates a Network Fabric Controller.")
  create is ArmResourceCreateOrUpdateAsync<NetworkFabricController>;
  @doc("Updates are currently not supported for the Network Fabric Controller resource.")
  update is ArmResourcePatchAsync<
    NetworkFabricController,
    NetworkFabricControllerProperties
  >;
  @doc("Deletes the Network Fabric Controller resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricController>;
  @doc("Lists all the NetworkFabricControllers thats available in the resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabricController>;
  @doc("Lists all the NetworkFabricControllers by subscription.")
  listBySubscription is ArmListBySubscription<NetworkFabricController>;
}
