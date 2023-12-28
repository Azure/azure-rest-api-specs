import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ElasticSan;
@doc("Response for Volume Group request.")
@parentResource(ElasticSan)
model VolumeGroup is ProxyResource<VolumeGroupProperties> {
  @doc("The name of the VolumeGroup.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$")
  @key("volumeGroupName")
  @segment("volumegroups")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface VolumeGroups {
  @doc("Get an VolumeGroups.")
  get is ArmResourceRead<VolumeGroup>;
  @doc("Create a Volume Group.")
  create is ArmResourceCreateOrUpdateAsync<VolumeGroup>;
  @doc("Update an VolumeGroup.")
  update is ArmCustomPatchAsync<VolumeGroup, VolumeGroupUpdate>;
  @doc("Delete an VolumeGroup.")
  delete is ArmResourceDeleteAsync<VolumeGroup>;
  @doc("List VolumeGroups.")
  listByElasticSan is ArmResourceListByParent<VolumeGroup>;
}
