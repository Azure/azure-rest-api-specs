import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("Volume represents storage made available for use by resources running on the cluster.")
model Volume is TrackedResource<VolumeProperties> {
  @doc("The name of the volume.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,62}[a-zA-Z0-9])$")
  @key("volumeName")
  @segment("volumes")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Volumes {
  @doc("Get properties of the provided volume.")
  get is ArmResourceRead<Volume>;
  @doc("Create a new volume or update the properties of the existing one.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Volume>;
  @doc("Update tags associated with the provided volume.")
  update is ArmCustomPatchSync<Volume, VolumePatchParameters>;
  @doc("Delete the provided volume.")
  delete is ArmResourceDeleteAsync<Volume>;
  @doc("Get a list of volumes in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<Volume>;
  @doc("Get a list of volumes in the provided subscription.")
  listBySubscription is ArmListBySubscription<Volume>;
}
