import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Avs;
@doc("An HCX Enterprise Site resource")
@parentResource(PrivateCloud)
model HcxEnterpriseSite is ProxyResource<HcxEnterpriseSiteProperties> {
  @doc("Name of the HCX Enterprise Site in the private cloud")
  @path
  @key("hcxEnterpriseSiteName")
  @segment("hcxEnterpriseSites")
  name: string;
}

@armResourceOperations
interface HcxEnterpriseSites {
  @doc("Get an HCX Enterprise Site by name in a private cloud")
  get is ArmResourceRead<HcxEnterpriseSite>;
  @doc("Create or update an HCX Enterprise Site in a private cloud")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;
  @doc("Delete an HCX Enterprise Site in a private cloud")
  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;
  @doc("List HCX Enterprise Sites in a private cloud")
  list is ArmResourceListByParent<HcxEnterpriseSite>;
}
