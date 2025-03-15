import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.stac.tsp";
import "./models.common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MicrosoftPlanetaryComputerPro;

interface LandingPages {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Landing Page")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/")
  @get
  get is Azure.Core.Foundations.Operation<{}, LandingPage>;
}
interface ConformanceClass {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Conformance Classes")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/conformance")
  @get
  get is Azure.Core.Foundations.Operation<{}, ConformanceClasses>;
}
interface SearchOperations {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Search")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/search")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collections"?
       */
      @query("collections")
      collections?: string;

      /**
       * TODO: add description for "ids"?
       */
      @query("ids")
      ids?: string;

      /**
       * TODO: add description for "bbox"?
       */
      @query("bbox")
      bbox?: string;

      /**
       * TODO: add description for "intersects"?
       */
      @query("intersects")
      intersects?: string;

      /**
       * TODO: add description for "datetime"?
       */
      @query("datetime")
      datetime?: string;

      /**
       * TODO: add description for "limit"?
       */
      @query("limit")
      limit?: int32 = 250;

      /**
       * TODO: add description for "sign"?
       */
      @query("sign")
      sign?: boolean;

      /**
       * TODO: add description for "duration"?
       */
      @query("duration")
      duration?: int32;

      /**
       * TODO: add description for "query"?
       */
      @query("query")
      query?: string;

      /**
       * TODO: add description for "sortby"?
       */
      @query("sortby")
      sortby?: string;

      /**
       * TODO: add description for "fields"?
       */
      @query("fields")
      fields?: string;

      /**
       * TODO: add description for "filter"?
       */
      @query("filter")
      filter?: string;

      /**
       * TODO: add description for "token"?
       */
      @query("token")
      token?: string;

      /**
       * Accept header
       */
      @header
      accept: "application/geo+json";
    },
    void
  >;
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Search")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/search")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "body"
       */
      @body
      body: SearchPostRequest;

      /**
       * Accept header
       */
      @header
      accept: "application/geo+json";
    },
    void
  >;
}
interface CollectionOperations {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collections")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "sign"?
       */
      @query("sign")
      sign?: boolean;

      /**
       * TODO: add description for "duration"?
       */
      @query("duration")
      duration?: int32;
    },
    Collections
  >;
  /**
   * Add a new collection to the GeoCatalog instance
   *
   * Args:
   *     collection: the collection to create.
   *
   * Returns:
   *     The collection that was created.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Create Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections")
  @post
  create is Azure.Core.Foundations.Operation<
    GeoCatalogCollection,
    GeoCatalogCollection
  >;
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections/{collectionId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Collection ID
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "sign"?
       */
      @query("sign")
      sign?: boolean;

      /**
       * TODO: add description for "duration"?
       */
      @query("duration")
      duration?: int32;
    },
    Collection
  >;
  /**
   * Update a collection in the GeoCatalog instance
   *
   * Args:
   *     collection: the collection to update.
   *
   * Returns:
   *     The collection that was updated.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections/{collectionId}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: GeoCatalogCollection;
    },
    GeoCatalogCollection
  >;
  /**
   * Delete a collection from the GeoCatalog instance
   *
   * Args:
   *     collection_id: the collection id to delete.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Collection")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections/{collectionId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    void
  >;
}
interface Queryables {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/queryables")
  @get
  getAll is Azure.Core.Foundations.Operation<{}, void>;
  /**
   * Delete queryables by name for specified collection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Queryables")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/queryables/{queryableName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "queryableName"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      queryableName: string;
    },
    void
  >;
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Collection Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections/{collectionId}/queryables")
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
    void
  >;
  /**
   * Set queryables for a collection given a list of queryable definitions
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Set Collection Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/api/collections/{collectionId}/queryables")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "body"
       */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" ""
      @body
      body: QueryableDefinition[];
    },
    void
  >;
  /**
   * Updates a queryable given a queryable definition and
   * corresponding collection id.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Update Collection Queryables")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/queryables/{queryableName}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "queryableName"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      queryableName: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: QueryableDefinition;
    },
    QueryableDefinition
  >;
}
interface CollectionAssets {
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
  @route("/api/collections/{collectionId}/assets")
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
       * TODO: add description for contentType
       */
      @header
      contentType: "multipart/form-data";

      /**
       * TODO: add description for file
       */
      file: bytes;

      /**
       * TODO: add description for data
       */
      data: string;
    },
    GeoCatalogCollection
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
  @route("/api/collections/{collectionId}/assets/{assetId}")
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
       * TODO: add description for contentType
       */
      @header
      contentType: "multipart/form-data";

      /**
       * TODO: add description for file
       */
      file?: bytes;

      /**
       * TODO: add description for data
       */
      data: string;
    },
    GeoCatalogCollection
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
  @route("/api/collections/{collectionId}/assets/{assetId}")
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
    GeoCatalogCollection
  >;
}
interface CollectionThumbnails {
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
  @route("/api/collections/{collectionId}/thumbnail")
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
    void
  >;
}
interface AzmapsToken {
  /**
   * Fetch a token for the Azure Maps API service based on the current
   * service identity. This token is used for the Explorer to authenticate
   * with the Azure Maps API service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Azmaps Token")
  @tag("GeoCatalog Instance Configuration")
  @route("/api/config/map/token")
  @get
  get is Azure.Core.Foundations.Operation<{}, AzMapsToken>;
}
interface AzmapsClient {
  /**
   * Fetch the client id for the Azure Maps API service based on the current
   * on the current identity. This client id is used for the Explorer to
   * authenticate with the Azure Maps API service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Azmaps Client Id")
  @tag("GeoCatalog Instance Configuration")
  @route("/api/config/map/id")
  @get
  getId is Azure.Core.Foundations.Operation<{}, AzMapsClientId>;
}
interface AuthConfigOperations {
  /**
   * Get the app id and tenant id information to make a MSAL request for this
   * GeoCatalog instance.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Auth Config")
  @tag("GeoCatalog Instance Configuration")
  @route("/api/config/auth")
  @get
  get is Azure.Core.Foundations.Operation<{}, AuthConfig>;
}
interface Config {
  /**
   * Get the complete user configuration for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Config")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    UserCollectionSettings
  >;
}
interface CollectionMosaics {
  /**
   * Get the mosaic definitions for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Mosaics")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/mosaics")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    void
  >;
  /**
   * Add a mosaic definition to a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Add Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/mosaics")
  @post
  add is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: Mosaic;
    },
    Mosaic
  >;
  /**
   * Get a mosaic definition from a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/mosaics/{mosaicId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "mosaicId"
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
  @route("/api/collections/{collectionId}/config/mosaics/{mosaicId}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "mosaicId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      mosaicId: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: Mosaic;
    },
    Mosaic
  >;
  /**
   * Delete a mosaic definition from a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Delete Collection Mosaic")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/mosaics/{mosaicId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "mosaicId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      mosaicId: string;
    },
    void
  >;
}
interface CollectionRenderOptions {
  /**
   * Get all render options for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Render Options")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/render-options")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;
    },
    void
  >;
  /**
   * Add a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Add Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/render-options")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: RenderOption;
    },
    RenderOption
  >;
  /**
   * Get a render option for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Render Option")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/render-options/{renderOptionId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "renderOptionId"
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
  @route("/api/collections/{collectionId}/config/render-options/{renderOptionId}")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "renderOptionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      renderOptionId: string;

      /**
       * TODO: add description for "body"
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
  @route("/api/collections/{collectionId}/config/render-options/{renderOptionId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "renderOptionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      renderOptionId: string;
    },
    void
  >;
}
interface CollectionTileSettings {
  /**
   * Get the tile settings for a given collection
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Get Collection Tile Settings")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/tile-settings")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
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
  @route("/api/collections/{collectionId}/config/tile-settings")
  @put
  createOrReplace is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: TileSettings;
    },
    TileSettings
  >;
}
interface PartitionTypes {
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
  @route("/api/collections/{collectionId}/config/partition-type")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
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
  @summary("Create Partitiontype")
  @tag("STAC Collection Configuration")
  @route("/api/collections/{collectionId}/config/partition-type")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * TODO: add description for "collectionId"
       */
      @path
      @maxLength(500)
      @pattern(".*")
      collectionId: string;

      /**
       * TODO: add description for "body"
       */
      @body
      body: PartitionType;
    },
    void
  >;
}
