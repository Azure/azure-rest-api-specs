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
model SiteSilo is Azure.ResourceManager.TrackedResource<SiteSiloProperties> {
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
   * Creates or updates a silo for a Web App. Returns 202 with polling headers when background work is queued, or 200 when no update is needed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "The implemented silo PUT returns 202 with a resource body and polling headers when work is queued, or 200 when no update is needed. It does not return 201; this exception requires ARM approval."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "CsmHelper.CreateAsyncResponse includes the silo resource body in the implemented 202 response."
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdateSiteSilo is ArmResourceCreateOrReplaceAsync<
    SiteSilo,
    Response =
      | ArmResourceUpdatedResponse<SiteSilo>
      | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = SiteSilo> &
          Azure.Core.Foundations.RetryAfterHeader> & {
          @bodyRoot
          body: SiteSilo;
        }),
    Error = DefaultErrorResponse
  >;

  /**
   * Updates only the tags of a Web App silo. Silo configuration and provisioning state are not modified.
   */
  @patch(#{ implicitOptionality: false })
  updateSiteSilo is ArmCustomPatchSync<
    SiteSilo,
    PatchModel = Azure.ResourceManager.Foundations.TagsUpdateModel<SiteSilo>,
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
  refreshSiteSilos is ArmResourceActionNoContentSync<
    Site,
    void,
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
        /** Name of the virtual network connection. */
        @path
        @segment("virtualNetworkConnections")
        @key
        virtualNetwork: "virtualNetwork",
      },
      ResourceName = "SiteSiloVirtualNetworkConnection"
    > {}

@added(Versions.v2026_08_01)
@tag("WebApps")
@armResourceOperations(#{ omitTags: true })
interface SiteSiloVirtualNetworkConnections {
  /**
   * Gets the virtual network the silo is connected to.
   */
  getSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.Read<
    SwiftVirtualNetwork,
    OverrideErrorType = DefaultErrorResponse
  >;

  /**
   * Adds a virtual network connection to a silo, or updates the connection properties.
   */
  createOrUpdateSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.CreateOrUpdateSync<
    SwiftVirtualNetwork,
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
   * Deletes the virtual network connection from a silo.
   */
  deleteSiteSiloVnetConnection is SiteSiloVirtualNetworkConnectionOps.DeleteSync<
    SwiftVirtualNetwork,
    Response = ArmDeletedResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = DefaultErrorResponse
  >;
}
