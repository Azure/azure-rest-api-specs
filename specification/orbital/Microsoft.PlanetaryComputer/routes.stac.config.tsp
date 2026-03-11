// STAC Collection Configuration interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.stac.spec.tsp";
import "./models.stac.config.tsp";
import "./models.common.images.tsp";

using TypeSpec.Http;
namespace Microsoft.PlanetaryComputer;

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "STAC queryable definitions contain mixed types (objects, booleans, strings)"
@doc("Queryable definitions response.")
model QueryableDefinitionsResponse is Record<unknown>;

interface StacCollectionAssets {
  /**
   * Create a new asset in the Collection metadata and write the associated
   * file to managed storage.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" ""
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "STAC specification"
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
      body: StacAssetData;
    },
    {
      ...CreatedResponse;

      @body
      body: StacCollection;
    }
  >;
  /**
   * Update an existing asset in a given collection.
   */
  #suppress "@azure-tools/typespec-azure-core/byos" ""
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "STAC specification"
  @summary("Update Collection Asset")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/assets/{assetId}")
  @put
  replace is Azure.Core.Foundations.Operation<
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
      body: StacAssetData;
    },
    StacCollection
  >;
  /**
   * Delete an asset from a given collection.
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
    StacCollection
  >;
}

interface StacCollectionThumbnails {
  /**
   * Get thumbnail for given collection.
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
    StacMosaic[]
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
      body: StacMosaic;
    },
    {
      ...CreatedResponse;

      @body
      body: StacMosaic;
    }
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
    StacMosaic
  >;
  /**
   * Update a mosaic definition from a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/mosaics/{mosaicId}")
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
      body: StacMosaic;
    },
    StacMosaic
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
    OkResponse
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
    RenderOption[]
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
    }
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
    RenderOption
  >;
  /**
   * Update a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/configurations/render-options/{renderOptionId}")
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
    RenderOption
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
    OkResponse
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
    OkResponse
  >;
}

interface StacQueryables {
  /**
   * List all queryables in the GeoCatalog instance
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/queryables")
  @get
  getAll is Azure.Core.Foundations.Operation<{}, QueryableDefinitionsResponse>;
  /**
   * Delete queryables by name for specified collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Queryables")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/queryables/{queryableName}")
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
       * Name of the queryable property to operate on.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      queryableName: string;
    },
    OkResponse
  >;
  /**
   * List all queryables in a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections/{collectionId}/queryables")
  @get
  getAllByCollection is Azure.Core.Foundations.Operation<
    {
      /**
       * Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    QueryableDefinitionsResponse
  >;
  /**
   * Set queryables for a collection given a list of queryable definitions
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Set Collection Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/collections/{collectionId}/queryables")
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
       * Request queryable definition body
       */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" ""
      @body
      body: StacQueryable[];
    },
    {
      ...CreatedResponse;

      @body
      body: StacQueryable[];
    }
  >;
  /**
   * Updates a queryable given a queryable definition and
   * corresponding collection id.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Queryables")
  @tag("STAC Collection Configuration")
  @route("/stac/collections/{collectionId}/queryables/{queryableName}")
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
       * Name of the queryable property to operate on.
       */
      @path
      @maxLength(500)
      @pattern(".*")
      queryableName: string;

      /**
       * Request queryable definition body
       */
      @body
      body: StacQueryable;
    },
    StacQueryable
  >;
}
