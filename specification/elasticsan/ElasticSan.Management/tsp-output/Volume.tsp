import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ElasticSan;
@doc("Response for Volume request.")
@parentResource(VolumeGroup)
model Volume is ProxyResource<VolumeProperties> {
  @doc("The name of the Volume.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9A-Z]+)*$")
  @key("volumeName")
  @segment("volumes")
  name: string;
}

@armResourceOperations
interface Volumes {
  @doc("Get an Volume.")
  get is ArmResourceRead<Volume>;
  @doc("Create a Volume.")
  create is ArmResourceCreateOrUpdateAsync<Volume>;
  @doc("Update an Volume.")
  update is ArmCustomPatchAsync<Volume, VolumeUpdate>;
  @doc("Delete an Volume.")
  delete is ArmResourceDeleteAsync<
    Volume,
    {
      ...BaseParameters<Volume>;

      @doc("Optional, used to delete snapshots under volume. Allowed value are only true or false. Default value is false.")
      @header
      `x-ms-delete-snapshots`?: XMsDeleteSnapshots;

      @doc("Optional, used to delete volume if active sessions present. Allowed value are only true or false. Default value is false.")
      @header
      `x-ms-force-delete`?: XMsForceDelete;
    }
  >;
  @doc("List Volumes in a VolumeGroup.")
  listByVolumeGroup is ArmResourceListByParent<Volume>;
}
