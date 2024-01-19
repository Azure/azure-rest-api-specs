import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
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
interface SiteExtensionInfos {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get site extension information by its ID for a web site, or a deployment slot.")
  @operationId("WebApps_GetSiteExtension")
  getSiteExtension is ArmResourceRead<SiteExtensionInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Install site extension on a web site, or a deployment slot.")
  @operationId("WebApps_InstallSiteExtension")
  installSiteExtension is ArmResourceCreateOrUpdateAsync<SiteExtensionInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Remove a site extension from a web site, or a deployment slot.")
  @operationId("WebApps_DeleteSiteExtension")
  deleteSiteExtension is ArmResourceDeleteSync<SiteExtensionInfo>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get list of siteextensions for a web site, or a deployment slot.")
  @operationId("WebApps_ListSiteExtensions")
  listSiteExtensions is ArmResourceListByParent<SiteExtensionInfo>;
}
