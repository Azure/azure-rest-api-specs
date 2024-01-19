import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
@doc("Response for Volume Group request.")
@parentResource(ElasticSan)
model VolumeGroup is ProxyResource<VolumeGroupProperties> {
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
interface VolumeGroups {
  @doc("Get an VolumeGroups.")
  get is ArmResourceRead<VolumeGroup>;

  @doc("Create a Volume Group.")
  create is ArmResourceCreateOrUpdateAsync<
    VolumeGroup,
    BaseParameters<VolumeGroup>,
    ArmLroLocationHeader
  >;

  @doc("Update an VolumeGroup.")
  update is ArmCustomPatchAsync<
    VolumeGroup,
    VolumeGroupUpdate,
    BaseParameters<VolumeGroup>,
    ArmLroLocationHeader
  >;

  @doc("Delete an VolumeGroup.")
  delete is ArmResourceDeleteAsync<
    VolumeGroup,
    BaseParameters<VolumeGroup>,
    ArmLroLocationHeader
  >;

  @doc("List VolumeGroups.")
  listByElasticSan is ArmResourceListByParent<VolumeGroup>;
}

@@projectedName(VolumeGroups.create::parameters.resource, "json", "parameters");
@@extension(VolumeGroups.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(VolumeGroups.create::parameters.resource, "Volume Group object.");
@@projectedName(VolumeGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(VolumeGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(VolumeGroups.update::parameters.properties, "Volume Group object.");
