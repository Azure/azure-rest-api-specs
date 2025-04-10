import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Asset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Asset Track resource.
 */
@parentResource(Asset)
model AssetTrack is Azure.ResourceManager.ProxyResource<AssetTrackProperties> {
  ...ResourceNameParameter<
    Resource = AssetTrack,
    KeyName = "trackName",
    SegmentName = "tracks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AssetTrackOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** mediaServices */
        @path @segment("mediaServices") accountName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = Asset,
          KeyName = "assetName",
          SegmentName = "assets",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = AssetTrack,
        KeyName = "trackName",
        SegmentName = "tracks",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface AssetTracks {
  /**
   * Get the details of a Track in the Asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tracks_Get")
  get is AssetTrackOps.Read<AssetTrack>;

  /**
   * Create or update a Track in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tracks_CreateOrUpdate")
  createOrUpdate is AssetTrackOps.CreateOrUpdateAsync<
    AssetTrack,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing Track in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Tracks_Update")
  update is AssetTrackOps.CustomPatchAsync<
    AssetTrack,
    PatchModel = AssetTrack,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: AssetTrack;
    }
  >;

  /**
   * Deletes a Track in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tracks_Delete")
  delete is AssetTrackOps.DeleteWithoutOkAsync<AssetTrack>;

  /**
   * Update the track data. Call this API after any changes are made to the track data stored in the asset container. For example, you have modified the WebVTT captions file in the Azure blob storage container for the asset, viewers will not see the new version of the captions unless this API is called. Note, the changes may not be reflected immediately. CDN cache may also need to be purged if applicable.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tracks_UpdateTrackData")
  updateTrackData is AssetTrackOps.ActionAsyncBase<
    AssetTrack,
    void,
    ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AssetTrack>
  >;

  /**
   * Get asset track operation status.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("{operationId}")
  @operationId("OperationStatuses_Get")
  operationStatusesGet is AssetTrackOps.ActionSync<
    AssetTrack,
    void,
    ArmResponse<AssetTrackOperationStatus>,
    Parameters = {
      /**
       * Operation Id.
       */
      @path
      operationId: string;
    }
  >;
}
@armResourceOperations
interface OperationResultOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** mediaServices */
        @path @segment("mediaServices") accountName: string,

        ...KeysOf<ResourceNameParameter<
          Resource = Asset,
          KeyName = "assetName",
          SegmentName = "assets",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = AssetTrack,
          KeyName = "trackName",
          SegmentName = "tracks",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = AssetTrack,
        KeyName = "operationId",
        SegmentName = "operationResults",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface OperationResults {
  /**
   * Get asset track operation result.
   */
  get is OperationResultOps.Read<
    AssetTrack,
    Response = ArmResponse<AssetTrack> | AcceptedResponse | ArmNoContentResponse
  >;

  /**
   * Lists the Tracks in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Tracks_List")
  list is OperationResultOps.List<
    AssetTrack,
    Response = ArmResponse<AssetTrackCollection>
  >;
}

@@doc(AssetTrack.name, "The Asset Track name.");
@@doc(AssetTrack.properties, "The resource properties.");
@@doc(AssetTracks.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@doc(AssetTracks.update::parameters.properties, "The request parameters");
