import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SpringbootsitesModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.OffAzureSpringBoot;
@doc("The springbootapps envelope resource definition.")
@parentResource(SpringbootsitesModel)
model SpringbootappsModel is ProxyResource<SpringbootappsProperties> {
  @doc("The springbootapps name.")
  @maxLength(64)
  @minLength(3)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]*$")
  @path
  @key("springbootappsName")
  @segment("springbootapps")
  name: string;
}

@armResourceOperations
interface springbootapps {
  @doc("Get a springbootapps resource.")
  get is ArmResourceRead<SpringbootappsModel>;
  @doc("Update a springbootapps resource.")
  update is ArmResourcePatchAsync<
    SpringbootappsModel,
    SpringbootappsProperties
  >;
  @doc("List springbootapps resource by resourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootappsModel>;
  @doc("List springbootapps resource by subscription")
  listBySubscription is ArmListBySubscription<SpringbootappsModel>;
}
