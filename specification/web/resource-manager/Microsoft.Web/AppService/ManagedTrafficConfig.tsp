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
 * Managed traffic configuration singleton resource.
 */
@added(Versions.v2026_08_01)
@singleton("default")
@parentResource(Site)
model ManagedTrafficConfigResource
  is Azure.ResourceManager.ProxyResource<ManagedTrafficConfigProperties> {
  ...ResourceNameParameter<
    Resource = ManagedTrafficConfigResource,
    KeyName = "managedTrafficConfigName",
    SegmentName = "managedTrafficConfig",
    NamePattern = ""
  >;
}

/**
 * Query parameter controlling whether the managed traffic configuration endpoint collection is returned unprojected. By default the endpoints are projected for the current trafficMode — only the relevant routing dimension is returned (weight for Active, priority for Passive). Pass `$expand=endpoints` to receive every persisted field.
 */
@added(Versions.v2026_08_01)
model ManagedTrafficConfigExpandParameter {
  /**
   * Set to `endpoints` to return the unprojected endpoint collection, including both weight and priority for every endpoint.
   */
  @query("$expand")
  $expand?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "ManagedTrafficConfig does not support delete."
@added(Versions.v2026_08_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface ManagedTrafficConfigResources {
  /**
   * Lists managed traffic configuration resources for a Web App.
   */
  listManagedTrafficConfigs is ArmResourceListByParent<
    ManagedTrafficConfigResource,
    Parameters = ManagedTrafficConfigExpandParameter,
    Response = ArmResponse<ManagedTrafficConfigCollection>,
    Error = DefaultErrorResponse
  >;

  /**
   * Gets managed traffic configuration for a Web App.
   */
  getManagedTrafficConfig is ArmResourceRead<
    ManagedTrafficConfigResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Updates managed traffic configuration for a Web App.
   */
  updateManagedTrafficConfig is ArmResourceCreateOrReplaceSync<
    ManagedTrafficConfigResource,
    Error = DefaultErrorResponse
  >;
}
