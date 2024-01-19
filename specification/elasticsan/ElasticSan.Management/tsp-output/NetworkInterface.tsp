import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("Defines the NetworkInterface resource.")
@parentResource(NetworkDevice)
model NetworkInterface is ProxyResource<NetworkInterfaceProperties> {
  @doc("Name of the Network Interface.")
  @path
  @key("networkInterfaceName")
  @segment("networkInterfaces")
  name: string;
}

@armResourceOperations
interface NetworkInterfaces {
  @doc("Get the Network Interface resource details.")
  get is ArmResourceRead<NetworkInterface>;

  @doc("Create a Network Interface resource.")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkInterface,
    BaseParameters<NetworkInterface>,
    ArmAsyncOperationHeader
  >;

  @doc("Update certain properties of the Network Interface resource.")
  update is ArmCustomPatchAsync<
    NetworkInterface,
    NetworkInterfacePatch,
    BaseParameters<NetworkInterface>,
    ArmLroLocationHeader
  >;

  @doc("Delete the Network Interface resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkInterface,
    BaseParameters<NetworkInterface>,
    ArmLroLocationHeader
  >;

  @doc("List all the Network Interface resources in a given resource group.")
  listByNetworkDevice is ArmResourceListByParent<NetworkInterface>;

  @doc("Update the admin state of the Network Interface.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkInterface,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkInterface>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkInterfaces.create::parameters.resource, "json", "body");
@@extension(NetworkInterfaces.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkInterfaces.create::parameters.resource, "Request payload.");
@@projectedName(NetworkInterfaces.update::parameters.properties,
  "json",
  "body"
);
@@extension(NetworkInterfaces.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkInterfaces.update::parameters.properties,
  "NetworkInterface properties to update. Only tags are supported."
);
@@doc(NetworkInterfaces.updateAdministrativeState::parameters.body,
  "Request payload."
);
