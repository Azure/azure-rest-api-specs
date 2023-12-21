import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("L3Network represents a network that utilizes a single isolation domain set up for layer-3 resources.")
model L3Network is TrackedResource<L3NetworkProperties> {
  @doc("The name of the L3 network.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  @path
  @key("l3NetworkName")
  @segment("l3Networks")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface L3Networks {
  @doc("Get properties of the provided layer 3 (L3) network.")
  get is ArmResourceRead<L3Network>;
  @doc("Create a new layer 3 (L3) network or update the properties of the existing network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<L3Network>;
  @doc("Update tags associated with the provided layer 3 (L3) network.")
  update is ArmTagsPatchSync<L3Network>;
  @doc("Delete the provided layer 3 (L3) network.")
  delete is ArmResourceDeleteAsync<L3Network>;
  @doc("Get a list of layer 3 (L3) networks in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<L3Network>;
  @doc("Get a list of layer 3 (L3) networks in the provided subscription.")
  listBySubscription is ArmListBySubscription<L3Network>;
}
