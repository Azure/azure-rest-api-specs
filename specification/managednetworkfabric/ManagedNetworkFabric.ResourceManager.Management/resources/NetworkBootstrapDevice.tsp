import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance is required here to maintain compatibility with existing API structure"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Bootstrap Device resource definition.")
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkBootstrapDeviceProperties
)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkBootstrapDevice
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Bootstrap Device.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkBootstrapDeviceName")
  @segment("networkBootstrapDevices")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkBootstrapDevice properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkBootstrapDeviceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
@added(Versions.v2025_07_15)
interface NetworkBootstrapDevices {
  @doc("Gets a Network Bootstrap Device resource details.")
  get is ArmResourceRead<NetworkBootstrapDevice>;

  @doc("Creates a Network Bootstrap Device resource")
  create is ArmResourceCreateOrReplaceAsync<NetworkBootstrapDevice>;

  @doc("Update certain properties of the Network Bootstrap Device resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkBootstrapDevice,
    NetworkBootstrapDevicePatch
  >;

  @doc("Deletes a Network Bootstrap Device resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkBootstrapDevice>;

  @doc("Lists all the Network Bootstrap Device resources in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkBootstrapDevice>;

  @doc("List all the Network Bootstrap Device resources in a given subscription.")
  listBySubscription is ArmListBySubscription<NetworkBootstrapDevice>;

  @doc("Reboot the Network Bootstrap Device.")
  reboot is ArmResourceActionAsync<
    NetworkBootstrapDevice,
    void,
    NetworkBootstrapDeviceRebootResponse
  >;

  @doc("Refreshes the configuration of Network Bootstrap Device.")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkBootstrapDevice,
    void,
    NetworkBootstrapDeviceRefreshConfigurationResponse
  >;

  @doc("Upgrades the version of the Network Bootstrap Device.")
  upgrade is ArmResourceActionAsync<
    NetworkBootstrapDevice,
    UpdateVersion,
    NetworkBootstrapDeviceUpgradeResponse
  >;

  @doc("Updates the Administrative state of the Network Bootstrap Device.")
  @action("updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkBootstrapDevice,
    UpdateDeviceAdministrativeState,
    NetworkBootstrapDeviceUpdateAdministrativeStateResponse
  >;

  @summary("Resync the latest passwords to the Network Bootstrap Device.")
  @doc("Updates the Network Bootstrap Device to use the latest passwords. Does not generate new passwords. Allows network bootstrap devices missed during a previous password rotation to be brought back into sync.")
  resyncPasswords is ArmResourceActionAsync<
    NetworkBootstrapDevice,
    void,
    NetworkBootstrapDeviceResyncPasswordsResponse
  >;
}

@@doc(NetworkBootstrapDevices.create::parameters.resource, "Request payload.");
@@doc(NetworkBootstrapDevices.update::parameters.properties,
  "Network Bootstrap Device properties to update."
);
@@doc(NetworkBootstrapDevices.reboot::parameters.body, "Request payload.");
@@doc(NetworkBootstrapDevices.upgrade::parameters.body, "Request payload.");
@@doc(NetworkBootstrapDevices.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkBootstrapDevices.resyncPasswords::parameters.body,
  "Request payload."
);
