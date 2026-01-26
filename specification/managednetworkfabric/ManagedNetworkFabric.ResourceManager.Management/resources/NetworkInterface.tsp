import "../models/common.tsp";
import "./NetworkDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("Defines the NetworkInterface resource.")
@parentResource(NetworkDevice)
@Azure.ResourceManager.Private.armResourceInternal(NetworkInterfaceProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkInterface extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the Network Interface.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkInterface properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: NetworkInterfaceProperties;

  /** The NetworkInterface properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkInterfaceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkInterfaces {
  @doc("Get the Network Interface resource details.")
  get is ArmResourceRead<NetworkInterface>;

  @doc("Create a Network Interface resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkInterface>;

  @doc("Update certain properties of the Network Interface resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkInterface, NetworkInterfacePatch>;

  @doc("Delete the Network Interface resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkInterface>;

  @doc("List all the Network Interface resources in a given resource group.")
  listByNetworkDevice is ArmResourceListByParent<NetworkInterface>;

  @doc("Update the admin state of the Network Interface.")
  @action("updateAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    NetworkInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Update the admin state of the Network Interface.")
  @action("updateAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkInterface,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;
}

@@doc(NetworkInterfaces.create::parameters.resource, "Request payload.");
@@doc(NetworkInterfaces.update::parameters.properties,
  "NetworkInterface properties to update. Only tags are supported."
);
@@doc(NetworkInterfaces.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
