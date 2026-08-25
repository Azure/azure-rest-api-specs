import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Site.tsp";
import "./SwiftVirtualNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/**
 * A silo of a Web App resource.
 */
@added(Versions.v2026_08_01)
@parentResource(Site)
model SiteSilo is Azure.ResourceManager.ProxyResource<SiteSiloProperties> {
  ...ResourceNameParameter<
    Resource = SiteSilo,
    KeyName = "siloName",
    SegmentName = "silos",
    NamePattern = "^[A-Za-z0-9-]{1,24}$"
  >;
}

@added(Versions.v2026_08_01)
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
  createOrUpdateSiteSilo is ArmResourceCreateOrReplaceAsync<
    SiteSilo,
    Error = DefaultErrorResponse
  >;

  /**
   * Deletes a silo for a Web App.
   */
  deleteSiteSilo is ArmResourceDeleteWithoutOkAsync<
    SiteSilo,
    Error = DefaultErrorResponse
  >;

  /**
   * Forces a fresh revision for an Active Backup primary Web App and re-syncs all of its silos. The refresh request is recorded synchronously; silos then converge asynchronously — track progress through each silo's revisionNumber.
   */
  @action("refreshSilos")
  refreshSiteSilos is ArmResourceActionSync<
    Site,
    void,
    {
      @body body: void;
    },
    Error = DefaultErrorResponse
  >;
}

@added(Versions.v2026_08_01)
@armResourceOperations
interface SiteSiloVirtualNetworkConnectionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** Name of the app. */
        @path
        @segment("sites")
        @key
        name: string,

        /** Name of the silo. */
        @path
        @segment("silos")
        @key
        @pattern("^[A-Za-z0-9-]{1,24}$")
        siloName: string,
      },
      {
        /** Name of the virtual network. */
        @path
        @segment("virtualNetworkConnections")
        @key
        @pattern("^[A-Za-z0-9][A-Za-z0-9._-]{0,62}[A-Za-z0-9_]$")
        vnetName: string,
      },
      ResourceName = "SiteSiloVirtualNetworkConnection"
    > {}

@added(Versions.v2026_08_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface SiteSiloVirtualNetworkConnections {
  /**
   * Gets a virtual network the silo is connected to, by name.
   */
  getSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.Read<
    SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Adds a virtual network connection to a silo, or updates the connection properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The silo virtual network connection is created synchronously and only returns 200; it never returns 201."
  createOrUpdateSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.CreateOrUpdateSync<
    SwiftVirtualNetwork,
    Response = ArmResourceUpdatedResponse<SwiftVirtualNetwork>,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Updates the properties of a virtual network connection on a silo.
   */
  @patch(#{ implicitOptionality: false })
  updateSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.CustomPatchSync<
    SwiftVirtualNetwork,
    PatchModel = SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Deletes a connection from a silo to a named virtual network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "The silo virtual network connection is deleted synchronously and returns 200 on success or 404 when it does not exist."
  deleteSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.DeleteSync<
    SwiftVirtualNetwork,
    Response = ArmDeletedResponse | ArmNotFoundResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
