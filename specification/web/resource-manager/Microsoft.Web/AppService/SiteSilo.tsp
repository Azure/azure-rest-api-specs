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
 * Represents a silo of an App Service site.
 */
@added(Versions.v2026_06_01_preview)
@parentResource(Site)
model SiteSilo
  is Azure.ResourceManager.TrackedResource<SiteSiloProperties> {
  ...ResourceNameParameter<
    Resource = SiteSilo,
    KeyName = "siloName",
    SegmentName = "silos",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$"
  >;

  /** Kind of resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing pattern in Microsoft.Web"
  kind?: string;
}

@added(Versions.v2026_06_01_preview)
@armResourceOperations
interface SiteSiloOps
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
        /** Name of the silo. */
        @path
        @segment("silos")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$")
        siloName: string;
      }
    > {}

@added(Versions.v2026_06_01_preview)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface SiteSilos {
  /**
   * Get a specific silo for a web app.
   */
  @summary("Get a specific silo for a web app.")
  getSiteSilo is SiteSiloOps.Read<
    SiteSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Create or update a web app silo.
   */
  @summary("Create or update a web app silo.")
  createOrUpdateSiteSilo is SiteSiloOps.CreateOrUpdateAsync<
    SiteSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Delete a web app silo.
   */
  @summary("Delete a web app silo.")
  deleteSiteSilo is SiteSiloOps.DeleteWithoutOkAsync<
    SiteSilo,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Get all silos for a web app.
   */
  @summary("Get all silos for a web app.")
  listSiteSilos is SiteSiloOps.List<
    SiteSilo,
    Response = ArmResponse<SiteSiloCollection>,
    OverrideErrorType = DefaultErrorResponse
  >;
}

@@doc(SiteSilo.name, "Name of the silo.");
@@doc(SiteSilo.properties, "SiteSilo resource specific properties");
@@doc(SiteSilos.createOrUpdateSiteSilo::parameters.resource,
  "Details of the silo."
);
