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
@added(Versions.v2026_06_01)
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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "ManagedTrafficConfig does not support delete."
@added(Versions.v2026_06_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface ManagedTrafficConfigResources {
  /**
   * Lists managed traffic configuration resources for a Web App.
   */
  listManagedTrafficConfigs is ArmResourceListByParent<
    ManagedTrafficConfigResource,
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
