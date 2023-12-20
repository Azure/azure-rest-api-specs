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
model ElasticSanVolumeGroup is ProxyResource<VolumeGroupProperties> {
  @doc("The name of the VolumeGroup.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$")
  @path
  @key("volumeGroupName")
  @segment("volumegroups")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface ElasticSanVolumeGroups {
  @doc("Get an VolumeGroups.")
  get is ArmResourceRead<ElasticSanVolumeGroup>;
  @doc("Create a Volume Group.")
  create is ArmResourceCreateOrUpdateAsync<ElasticSanVolumeGroup>;
  @doc("Update an VolumeGroup.")
  update is ArmResourcePatchAsync<ElasticSanVolumeGroup, VolumeGroupProperties>;
  @doc("Delete an VolumeGroup.")
  delete is ArmResourceDeleteAsync<ElasticSanVolumeGroup>;
  @doc("List VolumeGroups.")
  listByElasticSan is ArmResourceListByParent<ElasticSanVolumeGroup>;
}
