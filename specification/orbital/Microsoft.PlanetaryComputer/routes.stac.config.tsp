// STAC Collection Configuration interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.stac.spec.tsp";
import "./models.stac.config.tsp";
import "./models.common.images.tsp";

using TypeSpec.Http;
namespace Microsoft.PlanetaryComputer;

interface StacCollectionAssets {
  /**
   * Create a new asset in the Collection metadata and write the associated
   * file to managed storage.
   *
   * Args:
   *     request: The incoming request.
   *     asset: The Asset object to write, without a valid href to the asset.
   *     file: The file to write.
   *     collection_id: The ID of the collection to write the asset to.
   *     content_type: The content type of the request.
   *
   * Returns:
   *     A Response object containing the newly created asset.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" ""
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Create Collection Asset")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/assets")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Content type of the multipart form data request.
       */
      @header
      contentType: "multipart/form-data";

      /**
       * Multi-part form data
       */
      @multipartBody
      body: FormData;
    },
    {
      ...CreatedResponse;

      @body
      body: StacCollection;
    } | StacCollection
  >;
  /**
   * Update an existing asset in a given collection.
   *
   * Args:
   *     request: The incoming request.
   *     asset: The Asset object to update.
   *     file: The file to update (optional).
   *     collection_id: The ID of the collection to update the asset in.
   *     asset_id: The ID of the asset to update.
   *     content_type: The content type of the request.
   *
   * Returns:
   *     A Response object containing the updated asset.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" ""
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Asset")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/assets/{assetId}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Asset ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      assetId: string;

      /**
       * Content type of the multipart form data request.
       */
      @header
      contentType: "multipart/form-data";

      /**
       * Multi-part form data
       */
      @multipartBody
      body: FormData;
    },
    {
      ...CreatedResponse;

      @body
      body: StacCollection;
    } | StacCollection
  >;
  /**
   * Delete an asset from a given collection.
   *
   * Args:
   *     request: The incoming request.
   *     collection_id: The ID of the collection to delete the asset from.
   *     asset_id: The ID of the asset to delete.
   *
   * Returns:
   *     A Response object indicating the success of the deletion.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Collection Asset")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/assets/{assetId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * STAC Asset ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      assetId: string;
    },
    OkResponse | NoContentResponse
  >;
}

interface StacCollectionThumbnails {
  /**
   * Get thumbnail for given collection.
   *
   * Args:
   *     request: The incoming request.
   *     collection_id: The ID of the collection to retrieve assets for.
   *
   * Returns:
   *     thumbnail image
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Thumbnail")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/thumbnail")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * STAC Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },

      | ImagePngResponse
      | ImageJpegResponse
      | ImageJpgResponse
      | ImageWebpResponse
      | ImageJp2Response
      | ImageTiffResponse
      | ApplicationXbinaryResponse
      | NoContentResponse
  >;
}

interface StacCollectionConfig {
  /**
   * Get the complete user configuration for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Config")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    UserCollectionSettings
  >;
}

interface StacCollectionMosaics {
  /**
   * Get the mosaic definitions for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Mosaics")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/mosaics")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    Mosaic[] | NoContentResponse
  >;
  /**
   * Add a mosaic definition to a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Add Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/mosaics")
  @post
  add is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Mosaic definition to be created or updated.
       */
      @body
      body: Mosaic;
    },
    {
      ...CreatedResponse;

      @body
      body: Mosaic;
    } | Mosaic
  >;
  /**
   * Get a mosaic definition from a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/mosaics/{mosaicId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Unique identifier for the mosaic configuration.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      mosaicId: string;
    },
    Mosaic
  >;
  /**
   * Update a mosaic definition from a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/mosaics/{mosaicId}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Unique identifier for the mosaic configuration.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      mosaicId: string;

      /**
       * Mosaic definition to be created or updated.
       */
      @body
      body: Mosaic;
    },
    {
      ...CreatedResponse;

      @body
      body: Mosaic;
    } | Mosaic
  >;
  /**
   * Delete a mosaic definition from a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/mosaics/{mosaicId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Unique identifier for the mosaic configuration.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      mosaicId: string;
    },
    OkResponse | NoContentResponse
  >;
}

interface StacCollectionRenderOptions {
  /**
   * Get all render options for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Render Options")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/render-options")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    RenderOption[] | NoContentResponse
  >;
  /**
   * Add a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Add Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/render-options")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Render option configuration to be created or updated.
       */
      @body
      body: RenderOption;
    },
    {
      ...CreatedResponse;

      @body
      body: RenderOption;
    } | RenderOption
  >;
  /**
   * Get a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/render-options/{renderOptionId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Unique identifier for the render option.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      renderOptionId: string;
    },
    RenderOption[]
  >;
  /**
   * Update a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/render-options/{renderOptionId}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Unique identifier for the render option.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      renderOptionId: string;

      /**
       * Render option configuration to be created or updated.
       */
      @body
      body: RenderOption;
    },
    {
      ...CreatedResponse;

      @body
      body: RenderOption;
    } | RenderOption
  >;
  /**
   * Delete a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/render-options/{renderOptionId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Unique identifier for the render option.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      renderOptionId: string;
    },
    OkResponse | NoContentResponse
  >;
}

interface StacCollectionTileSettings {
  /**
   * Get the tile settings for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Tile Settings")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/tile-settings")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    TileSettings
  >;

  /**
   * Update the tile settings for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Tile Settings")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/tile-settings")
  @put
  replace is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Tile settings configuration to be updated.
       */
      @body
      body: TileSettings;
    },
    TileSettings
  >;
}

interface StacCollectionPartitionTypes {
  /**
   * Get the partitiontype for a GeoCatalog Collection.
   *
   * Args:
   *     collection_id: the collection id to get the partitiontype for.
   *
   * Returns:
   *     The partitiontype for the collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Partitiontype")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/partition-type")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    PartitionType
  >;
  /**
   * Updates partition type for a GeoCatalog Collection. This will
   * determine the partitioning scheme for items within the database,
   * and can only be set before any items are loaded.
   *
   * Ideal partitioning schemes result in partitions of roughly 100k items each.
   *
   * The default partitioning scheme is "none" which does not partition items.
   *
   * Args:
   *     collection_id: the collection id to add the partitiontype to.
   *     partitiontype: the partitiontype to add.
   *
   * Returns:
   *     None
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
  @summary("Create Partitiontype")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/partition-type")
  @put
  replace is Azure.Core.Foundations.Operation<
    {
      /**
       * Unique identifier for the STAC collection.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * Partition type configuration determining how items are partitioned in storage.
       */
      @body
      body: PartitionType;
    },
    PartitionType | NoContentResponse
  >;
}

interface GeoCatalogAzmapsToken {
  /**
   * Fetch a token for the Azure Maps API service based on the current
   * service identity. This token is used for the Explorer to authenticate
   * with the Azure Maps API service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Azmaps Token")
  @tag("GeoCatalog Instance Configuration")
  @route("/geocatalog/map/token")
  @get
  get is Azure.Core.Foundations.Operation<{}, AzMapsToken>;
}

interface GeoCatalogAzmapsClient {
  /**
   * Fetch the client id for the Azure Maps API service based on the current
   * on the current identity. This client id is used for the Explorer to
   * authenticate with the Azure Maps API service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Azmaps Client Id")
  @tag("GeoCatalog Instance Configuration")
  @route("/geocatalog/map/id")
  @get
  getId is Azure.Core.Foundations.Operation<{}, AzMapsClientId>;
}

interface GeoCatalogAuthConfigOperations {
  /**
   * Get the app id and tenant id information to make a MSAL request for this
   * GeoCatalog instance.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Auth Config")
  @tag("GeoCatalog Instance Configuration")
  @route("/geocatalog/auth")
  @get
  get is Azure.Core.Foundations.Operation<{}, AuthConfig>;
}
