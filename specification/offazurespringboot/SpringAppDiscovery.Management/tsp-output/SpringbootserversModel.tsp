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
@doc("The springbootservers envelope resource definition.")
@parentResource(SpringbootsitesModel)
model SpringbootserversModel is ProxyResource<SpringbootserversProperties> {
  @doc("The springbootservers name.")
  @maxLength(64)
  @minLength(3)
  @pattern("^[A-Za-z0-9][A-Za-z0-9-]*$")
  @key("springbootserversName")
  @segment("springbootservers")
  name: string;
}

@armResourceOperations
@projectedName("client", "springbootservers")
interface SpringbootserversModels_springbootservers {
  @doc("List springbootservers resource.")
  get is ArmResourceRead<SpringbootserversModel>;

  @doc("Create springbootservers resource.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SpringbootserversModel>;

  @doc("Update springbootservers resource.")
  update is ArmCustomPatchAsync<SpringbootserversModel, SpringbootserversPatch>;

  @doc("Delete springbootservers resource.")
  delete is ArmResourceDeleteWithoutOkAsync<SpringbootserversModel>;

  @doc("List springbootservers resource by resourceGroup")
  listByResourceGroup is ArmResourceListByParent<SpringbootserversModel>;

  @doc("List springbootservers resource by subscription")
  listBySubscription is ArmListBySubscription<SpringbootserversModel>;
}
