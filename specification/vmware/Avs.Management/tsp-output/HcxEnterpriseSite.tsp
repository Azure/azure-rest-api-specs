import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
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

@@projectedName(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "json",
  "hcxEnterpriseSite"
);
@@extension(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "hcxEnterpriseSite"
);
@@doc(HcxEnterpriseSites.createOrUpdate::parameters.resource,
  "The HCX Enterprise Site"
);
