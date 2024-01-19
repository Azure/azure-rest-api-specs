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

namespace Microsoft.NetworkCloud;
@doc("TrunkedNetwork represents a network that utilizes multiple isolation domains and specified VLANs to create a trunked network.")
model TrunkedNetwork is TrackedResource<TrunkedNetworkProperties> {
  @doc("The name of the trunked network.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("trunkedNetworkName")
  @segment("trunkedNetworks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface TrunkedNetworks {
  @doc("Get properties of the provided trunked network.")
  get is ArmResourceRead<TrunkedNetwork>;

  @doc("Create a new trunked network or update the properties of the existing trunked network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    TrunkedNetwork,
    BaseParameters<TrunkedNetwork>,
    ArmAsyncOperationHeader
  >;

  @doc("Update tags associated with the provided trunked network.")
  update is ArmCustomPatchSync<TrunkedNetwork, TrunkedNetworkPatchParameters>;

  @doc("Delete the provided trunked network.")
  delete is ArmResourceDeleteAsync<
    TrunkedNetwork,
    BaseParameters<TrunkedNetwork>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of trunked networks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<TrunkedNetwork>;

  @doc("Get a list of trunked networks in the provided subscription.")
  listBySubscription is ArmListBySubscription<TrunkedNetwork>;
}

@@projectedName(TrunkedNetworks.createOrUpdate::parameters.resource,
  "json",
  "trunkedNetworkParameters"
);
@@extension(TrunkedNetworks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "trunkedNetworkParameters"
);
@@doc(TrunkedNetworks.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(TrunkedNetworks.update::parameters.properties,
  "json",
  "trunkedNetworkUpdateParameters"
);
@@extension(TrunkedNetworks.update::parameters.properties,
  "x-ms-client-name",
  "trunkedNetworkUpdateParameters"
);
@@doc(TrunkedNetworks.update::parameters.properties, "The request body.");
