import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Site Extension Information.")
@parentResource(Site)
model SiteExtensionInfo is ProxyResource<SiteExtensionInfoProperties> {
  @doc("Site extension name.")
  @path
  @key("siteExtensionId")
  @segment("siteextensions")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get site extension information by its ID for a web site, or a deployment slot.")
  getSiteExtension is ArmResourceRead<SiteExtensionInfo>;
  @doc("Description for Install site extension on a web site, or a deployment slot.")
  installSiteExtension is ArmResourceCreateOrUpdateAsync<SiteExtensionInfo>;
  @doc("Description for Remove a site extension from a web site, or a deployment slot.")
  deleteSiteExtension is ArmResourceDeleteSync<SiteExtensionInfo>;
  @doc("Description for Get list of siteextensions for a web site, or a deployment slot.")
  listSiteExtensions is ArmResourceListByParent<SiteExtensionInfo>;
}
