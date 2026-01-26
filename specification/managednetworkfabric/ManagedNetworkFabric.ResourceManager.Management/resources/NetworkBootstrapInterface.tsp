import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the NetworkBootstrapInterface resource.")
@parentResource(NetworkBootstrapDevice)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkBootstrapInterfaceProperties
)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkBootstrapInterface
  extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the Network Bootstrap Interface.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkBootstrapInterfaceName")
  @segment("networkBootstrapInterfaces")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkBootstrapInterface properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkBootstrapInterfaceProperties;
}

@armResourceOperations
@added(Versions.v2025_07_15)
interface NetworkBootstrapInterfaces {
  @doc("Get the Network Bootstrap Interface resource details.")
  get is ArmResourceRead<NetworkBootstrapInterface>;

  @doc("Create a Network Bootstrap Interface resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkBootstrapInterface>;

  @doc("Update certain properties of the Network Bootstrap Interface resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkBootstrapInterface,
    NetworkBootstrapInterfacePatch
  >;

  @doc("Delete the Network Bootstrap Interface resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkBootstrapInterface>;

  @doc("List all the Network Bootstrap Interface resources in a given resource group.")
  listByNetworkBootstrapDevice is ArmResourceListByParent<NetworkBootstrapInterface>;

  @doc("Update the admin state of the Network Interface.")
  @action("updateAdministrativeState")
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkBootstrapInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(NetworkBootstrapInterfaces.create::parameters.resource,
  "Request payload."
);
@@doc(NetworkBootstrapInterfaces.update::parameters.properties,
  "NetworkBootstrapInterface properties to update. Only tags are supported."
);
@@doc(NetworkBootstrapInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
