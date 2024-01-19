import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Device resource definition.")
model NetworkDevice is TrackedResource<NetworkDeviceProperties> {
  @doc("Name of the Network Device.")
  @path
  @key("networkDeviceName")
  @segment("networkDevices")
  name: string;
}

@armResourceOperations
interface NetworkDevices {
  @doc("Gets the Network Device resource details.")
  get is ArmResourceRead<NetworkDevice>;

  @doc("Create a Network Device resource")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkDevice,
    BaseParameters<NetworkDevice>,
    ArmAsyncOperationHeader
  >;

  @doc("Update certain properties of the Network Device resource.")
  update is ArmCustomPatchAsync<
    NetworkDevice,
    NetworkDevicePatchParameters,
    BaseParameters<NetworkDevice>,
    ArmLroLocationHeader
  >;

  @doc("Delete the Network Device resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkDevice,
    BaseParameters<NetworkDevice>,
    ArmLroLocationHeader
  >;

  @doc("List all the Network Device resources in a given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkDevice>;

  @doc("List all the Network Device resources in a given subscription.")
  listBySubscription is ArmListBySubscription<NetworkDevice>;

  @doc("Reboot the Network Device.")
  reboot is ArmResourceActionAsync<
    NetworkDevice,
    RebootProperties,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkDevice>,
    ArmLroLocationHeader
  >;

  @doc("Refreshes the configuration the Network Device.")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkDevice,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkDevice>,
    ArmLroLocationHeader
  >;

  @doc("Updates the Administrative state of the Network Device.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkDevice,
    UpdateDeviceAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkDevice>,
    ArmLroLocationHeader
  >;

  @doc("Upgrades the version of the Network Device.")
  upgrade is ArmResourceActionAsync<
    NetworkDevice,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkDevice>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkDevices.create::parameters.resource, "json", "body");
@@extension(NetworkDevices.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkDevices.create::parameters.resource, "Request payload.");
@@projectedName(NetworkDevices.update::parameters.properties, "json", "body");
@@extension(NetworkDevices.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkDevices.update::parameters.properties,
  "Network Device properties to update."
);
@@doc(NetworkDevices.reboot::parameters.body, "Request payload.");
@@doc(NetworkDevices.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkDevices.upgrade::parameters.body, "Request payload.");
