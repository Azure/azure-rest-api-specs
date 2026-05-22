import "../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Fabric Controller resource definition.")
model NetworkFabricController
  is Azure.ResourceManager.TrackedResource<
    NetworkFabricControllerProperties,
    false
  > {
  @doc("Name of the Network Fabric Controller.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricControllerName")
  @segment("networkFabricControllers")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@@doc(
  NetworkFabricController.properties,
  "The NetworkFabricController Properties"
);
@armResourceOperations
interface NetworkFabricControllers {
  @doc("Shows the provisioning status of Network Fabric Controller.")
  get is ArmResourceRead<NetworkFabricController>;

  @doc("Creates a Network Fabric Controller.")
  create is ArmResourceCreateOrReplaceAsync<NetworkFabricController>;

  @doc("Updates are currently not supported for the Network Fabric Controller resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkFabricController,
    NetworkFabricControllerPatch
  >;

  @doc("Deletes the Network Fabric Controller resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricController>;

  @doc("Lists all the NetworkFabricControllers thats available in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    NetworkFabricController,
    Response = NetworkFabricControllersListResult
  >;

  @doc("Lists all the NetworkFabricControllers by subscription.")
  listBySubscription is ArmListBySubscription<
    NetworkFabricController,
    Response = NetworkFabricControllersListResult
  >;
}

@@doc(NetworkFabricControllers.create::parameters.resource, "Request payload.");
@@doc(
  NetworkFabricControllers.update::parameters.properties,
  "Network Fabric Controller properties to update."
);
