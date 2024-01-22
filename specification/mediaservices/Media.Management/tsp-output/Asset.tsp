import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * An Asset.
 */
@parentResource(MediaService)
model Asset is ProxyResource<AssetProperties> {
  /**
   * The Asset name.
   */
  @path
  @key("assetName")
  @segment("assets")
  name: string;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Asset, Asset>;

  /**
   * Deletes an Asset in the Media Services account
   */
  delete is ArmResourceDeleteSync<Asset>;

  /**
   * List Assets in the Media Services account with optional filtering and ordering
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Assets_List")
  list is ArmResourceListByParent<
    Asset,
    {
      ...BaseParameters<Asset>;

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
    }
  >;

  /**
   * Lists storage container URLs with shared access signatures (SAS) for uploading and downloading Asset content. The signatures are derived from the storage account keys.
   */
  listContainerSas is ArmResourceActionSync<
    Asset,
    ListContainerSasInput,
    AssetContainerSas
  >;

  /**
   * Gets the Asset storage encryption keys used to decrypt content created by version 2 of the Media Services API
   */
  getEncryptionKey is ArmResourceActionSync<
    Asset,
    void,
    StorageEncryptedAssetDecryptionData
  >;

  /**
   * Lists Streaming Locators which are associated with this asset.
   */
  listStreamingLocators is ArmResourceActionSync<
    Asset,
    void,
    ListStreamingLocatorsResponse
  >;
}

@@projectedName(Assets.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Assets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Assets.createOrUpdate::parameters.resource, "The request parameters");
@@projectedName(Assets.update::parameters.properties, "json", "parameters");
@@extension(Assets.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Assets.update::parameters.properties, "The request parameters");
@@projectedName(Assets.listContainerSas::parameters.body, "json", "parameters");
@@extension(Assets.listContainerSas::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Assets.listContainerSas::parameters.body, "The request parameters");
