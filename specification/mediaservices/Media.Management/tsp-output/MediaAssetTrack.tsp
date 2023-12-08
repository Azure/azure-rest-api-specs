import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./MediaAsset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Media;
@doc("An Asset Track resource.")
@parentResource(MediaAsset)
model MediaAssetTrack is ProxyResource<AssetTrackProperties> {
  @doc("The Asset Track name.")
  @path
  @key("trackName")
  @segment("tracks")
  name: string;
}

@armResourceOperations
interface MediaAssetTracks {
  @doc("Get the details of a Track in the Asset")
  get is ArmResourceRead<MediaAssetTrack>;
  @doc("Create or update a Track in the asset")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<MediaAssetTrack>;
  @doc("Updates an existing Track in the asset")
  update is ArmResourcePatchAsync<MediaAssetTrack, AssetTrackProperties>;
  @doc("Deletes a Track in the asset")
  delete is ArmResourceDeleteWithoutOkAsync<MediaAssetTrack>;
  @doc("Lists the Tracks in the asset")
  list is ArmResourceListByParent<MediaAssetTrack>;
  @doc("Update the track data. Call this API after any changes are made to the track data stored in the asset container. For example, you have modified the WebVTT captions file in the Azure blob storage container for the asset, viewers will not see the new version of the captions unless this API is called. Note, the changes may not be reflected immediately. CDN cache may also need to be purged if applicable.")
  updateTrackData is ArmResourceActionNoResponseContentAsync<
    MediaAssetTrack,
    {}
  >;
}
