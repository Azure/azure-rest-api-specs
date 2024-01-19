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
@doc("The Network Rack resource definition.")
model NetworkRack is TrackedResource<NetworkRackProperties> {
  @doc("Name of the Network Rack.")
  @path
  @key("networkRackName")
  @segment("networkRacks")
  name: string;
}

@armResourceOperations
interface NetworkRacks {
  @doc("Get Network Rack resource details.")
  get is ArmResourceRead<NetworkRack>;

  @doc("Create Network Rack resource.")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkRack,
    BaseParameters<NetworkRack>,
    ArmAsyncOperationHeader
  >;

  @doc("Update certain properties of the Network Rack resource.")
  update is ArmCustomPatchAsync<
    NetworkRack,
    TagsUpdate,
    BaseParameters<NetworkRack>,
    ArmLroLocationHeader
  >;

  @doc("Delete Network Rack resource.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkRack,
    BaseParameters<NetworkRack>,
    ArmLroLocationHeader
  >;

  @doc("List all Network Rack resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkRack>;

  @doc("List all Network Rack resources in the given subscription")
  listBySubscription is ArmListBySubscription<NetworkRack>;
}

@@projectedName(NetworkRacks.create::parameters.resource, "json", "body");
@@extension(NetworkRacks.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkRacks.create::parameters.resource, "Request payload.");
@@projectedName(NetworkRacks.update::parameters.properties, "json", "body");
@@extension(NetworkRacks.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkRacks.update::parameters.properties,
  "Network Rack properties to update."
);
