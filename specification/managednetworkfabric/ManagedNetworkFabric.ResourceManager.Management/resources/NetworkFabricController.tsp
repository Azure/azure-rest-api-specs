import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Fabric Controller resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkFabricController
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Fabric Controller.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricControllerName")
  @segment("networkFabricControllers")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The NetworkFabricController Properties")
  properties: NetworkFabricControllerProperties;
}

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
  listByResourceGroup is ArmResourceListByParent<NetworkFabricController>;

  @doc("Lists all the NetworkFabricControllers by subscription.")
  listBySubscription is ArmListBySubscription<NetworkFabricController>;
}

@@doc(NetworkFabricControllers.create::parameters.resource, "Request payload.");
@@doc(NetworkFabricControllers.update::parameters.properties,
  "Network Fabric Controller properties to update."
);
