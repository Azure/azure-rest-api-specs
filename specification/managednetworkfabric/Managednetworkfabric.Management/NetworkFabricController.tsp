import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric Controller resource definition.
 */
model NetworkFabricController
  is Azure.ResourceManager.TrackedResource<
    NetworkFabricControllerProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = NetworkFabricController,
    KeyName = "networkFabricControllerName",
    SegmentName = "networkFabricControllers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface NetworkFabricControllers {
  /**
   * Shows the provisioning status of Network Fabric Controller.
   */
  get is ArmResourceRead<NetworkFabricController>;

  /**
   * Creates a Network Fabric Controller.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkFabricController>;

  /**
   * Updates are currently not supported for the Network Fabric Controller resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkFabricController,
    PatchModel = NetworkFabricControllerPatch
  >;

  /**
   * Deletes the Network Fabric Controller resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabricController>;

  /**
   * Lists all the NetworkFabricControllers thats available in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkFabricController>;

  /**
   * Lists all the NetworkFabricControllers by subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFabricController>;
}

@@doc(NetworkFabricController.name, "Name of the Network Fabric Controller.");
@@doc(NetworkFabricController.properties, "Resource properties.");
@@doc(NetworkFabricControllers.create::parameters.resource, "Request payload.");
@@doc(NetworkFabricControllers.update::parameters.properties,
  "Network Fabric Controller properties to update."
);
