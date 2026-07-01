import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * A silo of a Web App resource.
 */
@added(Versions.v2026_06_01)
@parentResource(Site)
model SiteSilo is Azure.ResourceManager.ProxyResource<SiteSiloProperties> {
  ...ResourceNameParameter<
    Resource = SiteSilo,
    KeyName = "siloName",
    SegmentName = "silos",
    NamePattern = "^[A-Za-z0-9_@-]{1,50}$"
  >;
}

@added(Versions.v2026_06_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface SiteSiloResources {
  /**
   * Gets all silos for a Web App.
   */
  listSiteSilos is ArmResourceListByParent<
    SiteSilo,
    Response = ArmResponse<SiteSiloCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Gets a specific silo for a Web App.
   */
  getSiteSilo is ArmResourceRead<SiteSilo, Error = DefaultErrorResponse>;

  /**
   * Creates or updates a silo for a Web App.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The SiteSilo service returns 202 Accepted (not 201 Created) from its long-running create-or-update PUT; the contract is modeled to match the service's actual response codes."
  createOrUpdateSiteSilo is ArmResourceCreateOrReplaceAsync<
    SiteSilo,
    Response = ArmResourceUpdatedResponse<SiteSilo> | ArmAcceptedLroResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes a silo for a Web App.
   */
  deleteSiteSilo is ArmResourceDeleteSync<
    SiteSilo,
    Error = DefaultErrorResponse
  >;
}
