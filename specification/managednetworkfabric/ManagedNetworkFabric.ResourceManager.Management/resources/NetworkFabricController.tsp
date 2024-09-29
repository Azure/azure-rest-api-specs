import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric Controller resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model NetworkFabricController
  extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Fabric Controller.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricControllerName")
  @segment("networkFabricControllers")
  @visibility("read")
  name: string;

  /** The NetworkFabricController Properties */
  properties: NetworkFabricControllerProperties;
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
  @parameterVisibility
  update is ArmCustomPatchAsync<
    NetworkFabricController,
    NetworkFabricControllerPatch
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

@@doc(NetworkFabricControllers.create::parameters.resource, "Request payload.");
@@doc(NetworkFabricControllers.update::parameters.properties,
  "Network Fabric Controller properties to update."
);
