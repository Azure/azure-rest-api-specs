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
/**
 * Site Extension Information.
 */
@parentResource(Site)
model SiteExtensionInfo is ProxyResource<SiteExtensionInfoProperties> {
  /**
   * Site extension name.
   */
  @path
  @key("siteExtensionId")
  @segment("siteextensions")
  name: string;
}

@armResourceOperations
interface SiteExtensionInfos {
  /**
   * Description for Get site extension information by its ID for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetSiteExtension")
  getSiteExtension is ArmResourceRead<SiteExtensionInfo>;

  /**
   * Description for Install site extension on a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_InstallSiteExtension")
  installSiteExtension is ArmResourceCreateOrReplaceAsync<SiteExtensionInfo>;

  /**
   * Description for Remove a site extension from a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeleteSiteExtension")
  deleteSiteExtension is ArmResourceDeleteSync<SiteExtensionInfo>;

  /**
   * Description for Get list of siteextensions for a web site, or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSiteExtensions")
  listSiteExtensions is ArmResourceListByParent<SiteExtensionInfo>;
}
