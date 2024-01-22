import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Asset.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Asset Track resource.
 */
@parentResource(Asset)
model AssetTrack is ProxyResource<AssetTrackProperties> {
  /**
   * The Asset Track name.
   */
  @path
  @key("trackName")
  @segment("tracks")
  name: string;
}

@armResourceOperations
interface AssetTracks {
  /**
   * Get the details of a Track in the Asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tracks_Get")
  get is ArmResourceRead<AssetTrack>;

  /**
   * Create or update a Track in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tracks_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AssetTrack>;

  /**
   * Updates an existing Track in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Tracks_Update")
  update is ArmCustomPatchAsync<AssetTrack, AssetTrack>;

  /**
   * Deletes a Track in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tracks_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<AssetTrack>;

  /**
   * Lists the Tracks in the asset
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tracks_List")
  list is ArmResourceListByParent<AssetTrack>;

  /**
   * Update the track data. Call this API after any changes are made to the track data stored in the asset container. For example, you have modified the WebVTT captions file in the Azure blob storage container for the asset, viewers will not see the new version of the captions unless this API is called. Note, the changes may not be reflected immediately. CDN cache may also need to be purged if applicable.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Tracks_UpdateTrackData")
  updateTrackData is ArmResourceActionNoResponseContentAsync<AssetTrack, void>;
}

@@projectedName(AssetTracks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AssetTracks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AssetTracks.createOrUpdate::parameters.resource,
  "The request parameters"
);
@@projectedName(AssetTracks.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(AssetTracks.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AssetTracks.update::parameters.properties, "The request parameters");
