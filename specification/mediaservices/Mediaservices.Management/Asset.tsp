import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Asset.
 */
model Asset is Azure.ResourceManager.ProxyResource<AssetProperties> {
  ...ResourceNameParameter<
    Resource = Asset,
    KeyName = "assetName",
    SegmentName = "assets",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Assets {
  /**
   * Get the details of an Asset in the Media Services account
   */
  get is ArmResourceRead<Asset>;

  /**
   * Creates or updates an Asset in the Media Services account
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Asset>;

  /**
   * Updates an existing Asset in the Media Services account
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Asset, PatchModel = Asset>;

  /**
   * Deletes an Asset in the Media Services account
   */
  delete is ArmResourceDeleteSync<Asset>;

  /**
   * List Assets in the Media Services account with optional filtering and ordering
   */
  list is ArmResourceListByParent<
    Asset,
    Parameters = {
      /**
       * Restricts the set of items returned.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies a non-negative integer n that limits the number of items returned from a collection. The service returns the number of available items up to but not greater than the specified value n.
       */
      @query("$top")
      $top?: int32;

      /**
       * Specifies the key by which the result collection should be ordered.
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<AssetCollection>
  >;

  /**
   * Lists storage container URLs with shared access signatures (SAS) for uploading and downloading Asset content. The signatures are derived from the storage account keys.
   */
  listContainerSas is ArmResourceActionSync<
    Asset,
    ListContainerSasInput,
    ArmResponse<AssetContainerSas>
  >;

  /**
   * Gets the Asset storage encryption keys used to decrypt content created by version 2 of the Media Services API
   */
  getEncryptionKey is ArmResourceActionSync<
    Asset,
    void,
    ArmResponse<StorageEncryptedAssetDecryptionData>
  >;

  /**
   * Lists Streaming Locators which are associated with this asset.
   */
  listStreamingLocators is ArmResourceActionSync<
    Asset,
    void,
    ArmResponse<ListStreamingLocatorsResponse>
  >;
}

@@doc(Asset.name, "The Asset name.");
@@doc(Asset.properties, "The resource properties.");
@@doc(Assets.createOrUpdate::parameters.resource, "The request parameters");
@@doc(Assets.update::parameters.properties, "The request parameters");
@@doc(Assets.listContainerSas::parameters.body, "The request parameters");
