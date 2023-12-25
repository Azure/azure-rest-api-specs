import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.OffAzureSpringBoot;
@doc("The springbootsites envelope resource definition.")
model SpringbootsitesModel is TrackedResource<SpringbootsitesProperties> {
  @doc("The springbootsites name.")
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-z][a-z0-9-]*$")
  @path
  @key("springbootsitesName")
  @segment("springbootsites")
  name: string;

  @doc("The extended location definition.")
  extendedLocation?: SpringbootsitesModelExtendedLocation;
}

@armResourceOperations
interface springbootsites {
  @doc("Get a springbootsites resource.")
  get is ArmResourceRead<SpringbootsitesModel>;
  @doc("Create a springbootsites resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SpringbootsitesModel>;
  @doc("Update a springbootsites resource.")
  update is ArmResourcePatchAsync<
    SpringbootsitesModel,
    SpringbootsitesProperties
  >;
  @doc("Delete a springbootsites resource.")
  delete is ArmResourceDeleteWithoutOkAsync<SpringbootsitesModel>;
  @doc("List springbootsites resource by resourceGroup.")
  listByResourceGroup is ArmResourceListByParent<SpringbootsitesModel>;
  @doc("List springbootsites resource by subscription")
  listBySubscription is ArmListBySubscription<SpringbootsitesModel>;
  @doc("Trigger refresh springbootsites action")
  triggerRefreshSite is ArmResourceActionNoResponseContentAsync<
    SpringbootsitesModel,
    void
  >;
}
