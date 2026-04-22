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
 * Managed traffic configuration for a site, controlling how traffic is routed across silos.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(Site)
model ManagedTrafficConfigResource
  is Azure.ResourceManager.ProxyResource<ManagedTrafficConfigProperties> {
  ...ResourceNameParameter<
    Resource = ManagedTrafficConfigResource,
    KeyName = "configName",
    SegmentName = "managedTrafficConfig",
    NamePattern = "^default$"
  >;

  /** Kind of resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing pattern in Microsoft.Web"
  kind?: string;
}

@added(Versions.v2026_06_01_preview)
@armResourceOperations
interface ManagedTrafficConfigOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter;
        ...SubscriptionIdParameter;
        ...ResourceGroupParameter;
        ...Azure.ResourceManager.Legacy.Provider;

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string;
      },
      {
        /** Name of the managed traffic configuration. Must be "default". */
        @path
        @segment("managedTrafficConfig")
        @key
        @pattern("^default$")
        configName: string;
      }
    > {}

@added(Versions.v2026_06_01_preview)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface ManagedTrafficConfigs {
  /**
   * Get the managed traffic configuration for a web app.
   */
  @summary("Get the managed traffic configuration for a web app.")
  getManagedTrafficConfig is ManagedTrafficConfigOps.Read<
    ManagedTrafficConfigResource,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update the managed traffic configuration for a web app.
   */
  @summary("Create or update the managed traffic configuration for a web app.")
  createOrUpdateManagedTrafficConfig is ManagedTrafficConfigOps.CreateOrUpdateSync<
    ManagedTrafficConfigResource,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(ManagedTrafficConfigResource.name,
  "Name of the managed traffic configuration."
);
@@doc(ManagedTrafficConfigResource.properties,
  "ManagedTrafficConfig resource specific properties"
);
@@doc(ManagedTrafficConfigs.createOrUpdateManagedTrafficConfig::parameters.resource,
  "Traffic configuration properties."
);
