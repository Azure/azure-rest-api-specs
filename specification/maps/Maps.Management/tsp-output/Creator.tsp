import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Maps;
@doc("An Azure resource which represents Maps Creator product and provides ability to manage private location data.")
@parentResource(MapsAccount)
model Creator is TrackedResource<CreatorProperties> {
  @doc("The name of the Maps Creator instance.")
  @path
  @key("creatorName")
  @segment("creators")
  name: string;
}

@armResourceOperations
interface Creators {
  @doc("Get a Maps Creator resource.")
  get is ArmResourceRead<Creator>;
  @doc("Create or update a Maps Creator resource. Creator resource will manage Azure resources required to populate a custom set of mapping data. It requires an account to exist before it can be created.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Creator>;
  @doc("Updates the Maps Creator resource. Only a subset of the parameters may be updated after creation, such as Tags.")
  update is ArmResourcePatchSync<Creator, CreatorProperties>;
  @doc("Delete a Maps Creator resource.")
  delete is ArmResourceDeleteSync<Creator>;
  @doc("Get all Creator instances for an Azure Maps Account")
  listByAccount is ArmResourceListByParent<Creator>;
}
