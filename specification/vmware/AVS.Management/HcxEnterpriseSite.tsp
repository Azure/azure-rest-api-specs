import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("An HCX Enterprise Site resource")
@parentResource(PrivateCloud)
model HcxEnterpriseSite is ProxyResource<HcxEnterpriseSiteProperties> {
  @doc("Name of the HCX Enterprise Site in the private cloud")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("hcxEnterpriseSiteName")
  @segment("hcxEnterpriseSites")
  name: string;
}

@armResourceOperations
interface HcxEnterpriseSites {
  @doc("Get an HCX on-premises key by name in a private cloud")
  get is ArmResourceRead<HcxEnterpriseSite>;
  @doc("Create or update an activation key for on-premises HCX site")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HcxEnterpriseSite>;
  @doc("Delete HCX on-premises key in a private cloud")
  delete is ArmResourceDeleteSync<HcxEnterpriseSite>;
  @doc("List HCX on-premises key in a private cloud")
  list is ArmResourceListByParent<HcxEnterpriseSite>;
}
