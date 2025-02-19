import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

namespace AzureAgFoodPlatformDataPlaneService;

alias ServiceTraits = SupportsRepeatableRequests;

alias Operations = Azure.Core.ResourceOperations<{}>;

interface CatalogsOperations {
  /**
   * Returns a paginated list of Catalog resources.
   */
  Catalogs_List is Operations.ResourceList<Catalog,QueryParametersTrait<
  {
    /**
     * Names of the resource.
     */
    @query(#{ name: "names", explode: true })
    names?: string[];

    /**
     * Filters on key-value pairs within the Properties object.
     * eg. "{testKey} eq {testValue}".
     */
    @query(#{ name: "propertyFilters", explode: true })
    propertyFilters?: string[];

    /**
     * Statuses of the resource.
     */
    @query(#{ name: "statuses", explode: true })
    statuses?: string[];

    /**
     * Ids of the resource.
     */
    @query(#{ name: "ids", explode: true })
    ids?: string[];

    /**
     * Minimum creation date of resource (inclusive).
     */
    @query("minCreatedDateTime")
    minCreatedDateTime?: utcDateTime;

    /**
     * Maximum creation date of resource (inclusive).
     */
    @query("maxCreatedDateTime")
    maxCreatedDateTime?: utcDateTime;

    /**
     * Minimum last modified date of resource (inclusive).
     */
    @query("minLastModifiedDateTime")
    minLastModifiedDateTime?: utcDateTime;

    /**
     * Maximum last modified date of resource (inclusive).
     */
    @query("maxLastModifiedDateTime")
    maxLastModifiedDateTime?: utcDateTime;

    /**
     * Maximum number of items needed (inclusive).
     * Minimum = 10, Maximum = 1000, Default value = 50.
     */
    @maxValue(1000)
    @minValue(10)
    @query("maxPageSize")
    maxPageSize?: int32 = 50;

    /**
     * Skip token for getting next set of results.
     */
    @query("skipToken")
    skipToken?: string;
  }>
  >;

  /**
   * Gets a specified Catalog resource.
   */
  Catalogs_Get is Operations.ResourceRead<Catalog>;

  /**
   * Creates or updates a Catalog resource.
   */
  Catalogs_CreateOrUpdate is Operations.ResourceCreateOrUpdate<Catalog>;

  /**
   * Deletes Catalog for given Catalog id.
   */
  Catalogs_Delete is Operations.ResourceDelete<Catalog>;
}

interface CollectionsOperations {
  /**
   * Returns a paginated list of Collection resources.
   */
  @operationId("Collections_List")
  @route("/catalogs/{catalogId}/collections")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Catalog.
       */
      @path
      catalogId: string;

      /**
       * Names of the resource.
       */
      @query(#{ name: "names", explode: true })
      names?: string[];

      /**
       * Filters on key-value pairs within the Properties object.
       * eg. "{testKey} eq {testValue}".
       */
      @query(#{ name: "propertyFilters", explode: true })
      propertyFilters?: string[];

      /**
       * Statuses of the resource.
       */
      @query(#{ name: "statuses", explode: true })
      statuses?: string[];

      /**
       * Ids of the resource.
       */
      @query(#{ name: "ids", explode: true })
      ids?: string[];

      /**
       * Minimum creation date of resource (inclusive).
       */
      @query("minCreatedDateTime")
      minCreatedDateTime?: utcDateTime;

      /**
       * Maximum creation date of resource (inclusive).
       */
      @query("maxCreatedDateTime")
      maxCreatedDateTime?: utcDateTime;

      /**
       * Minimum last modified date of resource (inclusive).
       */
      @query("minLastModifiedDateTime")
      minLastModifiedDateTime?: utcDateTime;

      /**
       * Maximum last modified date of resource (inclusive).
       */
      @query("maxLastModifiedDateTime")
      maxLastModifiedDateTime?: utcDateTime;

      /**
       * Maximum number of items needed (inclusive).
       * Minimum = 10, Maximum = 1000, Default value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("maxPageSize")
      maxPageSize?: int32 = 50;

      /**
       * Skip token for getting next set of results.
       */
      @query("skipToken")
      skipToken?: string;
    },
    CollectionListResponse
  >;

  /**
   * Gets a specified Collection resource.
   */
  @operationId("Collections_Get")
  @route("/catalogs/{catalogId}/collections/{collectionId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Catalog.
       */
      @path
      catalogId: string;

      /**
       * Id of the Collection.
       */
      @path
      collectionId: string;
    },
    Collection
  >;

  /**
   * Creates or updates a Collection resource.
   */
  @operationId("Collections_CreateOrUpdate")
  @route("/catalogs/{catalogId}/collections/{collectionId}")
  @patch
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Collection resource.
       */
      @path
      collectionId: string;

      /**
       * Id of the Catalog resource.
       */
      @path
      catalogId: string;

      /**
       * Collection resource payload to create or update.
       */
      @bodyRoot
      collection: Collection;
    },
    Collection
  >;

  /**
   * Deletes Collection for given Collection id.
   */
  @operationId("Collections_Delete")
  @route("/catalogs/{catalogId}/collections/{collectionId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of Catalog.
       */
      @path
      catalogId: string;

      /**
       * Id of Collection to be deleted.
       */
      @path
      collectionId: string;
    },
    void
  >;
}

interface FileOperations {
  /**
   * Deletes file.
   */
  @operationId("File_Delete")
  @route("/file:delete")
  @post
  delete is Azure.Core.Foundations.Operation<File, void>;

  /**
   * Downloads and returns file Stream as response for the given input filePath.
   */
  @operationId("File_Download")
  @route("/file:download")
  @post
  download is Azure.Core.Foundations.Operation<
    {
      /**
       * request.
       */
      @bodyRoot
      request: File;

      /**
       * Accept header
       */
      @header
      accept: "application/json, application/octet-stream";
    },
    void
  >;

  /**
   * Uploads a file.
   */
  @operationId("File_Upload")
  @route("/file:upload")
  @post
  upload is Azure.Core.Foundations.Operation<{}, File>;
}

interface ItemsOperations {
  /**
   * Creates or updates a Item resource.
   */
  @operationId("Items_Create")
  @route("/catalogs/{catalogId}/collections/{collectionId}/items/:create")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Collection resource.
       */
      @path
      collectionId: string;

      /**
       * Id of the Catalog resource.
       */
      @path
      catalogId: string;

      /**
       * Collection resource payload to create or update.
       */
      @bodyRoot
      item: Item;
    },
    Item
  >;

  /**
   * Gets a specified Item resource.
   */
  @operationId("Items_Get")
  @route("/catalogs/{catalogId}/collections/{collectionId}/items/{itemId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Catalog.
       */
      @path
      catalogId: string;

      /**
       * Id of the Collection.
       */
      @path
      collectionId: string;

      /**
       * Id of the Item.
       */
      @path
      itemId: string;
    },
    Item
  >;

  /**
   * Creates or updates a Item resource.
   */
  @operationId("Items_CreateOrUpdate")
  @route("/catalogs/{catalogId}/collections/{collectionId}/items/{itemId}")
  @patch
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Item resource.
       */
      @path
      itemId: string;

      /**
       * Id of the Collection resource.
       */
      @path
      collectionId: string;

      /**
       * Id of the Catalog resource.
       */
      @path
      catalogId: string;

      /**
       * Item resource payload to create or update.
       */
      @bodyRoot
      item: Item;
    },
    Item
  >;

  /**
   * Deletes Item for given Item id.
   */
  @operationId("Items_Delete")
  @route("/catalogs/{catalogId}/collections/{collectionId}/items/{itemId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of Catalog.
       */
      @path
      catalogId: string;

      /**
       * Id of Collection.
       */
      @path
      collectionId: string;

      /**
       * Id of Item to be deleted.
       */
      @path
      itemId: string;
    },
    void
  >;

  /**
   * Search for Items across all parties by intersecting geometry.
   */
  @operationId("Items_GetAllUnderCollection")
  @route("/catalogs/{catalogId}/collections/{collectionId}/items:search")
  @post
  getAllUnderCollection is Azure.Core.Foundations.Operation<
    {
      /**
       * catalogId.
       */
      @path
      catalogId: string;

      /**
       * collectionId.
       */
      @path
      collectionId: string;

      /**
       * Maximum number of items needed (inclusive). Minimum = 10, Maximum = 1000,
       * Default Value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("maxPageSize")
      maxPageSize?: int32 = 50;

      /**
       * Query filters.
       */
      @bodyRoot
      searchItemQuery: ItemQuery;
    },
    ItemListResponse
  >;

  /**
   * Search for Items across all collections.
   */
  @operationId("Items_SearchAcrossCollection")
  @route("/catalogs/{catalogId}/items:search")
  @post
  searchAcrossCollection is Azure.Core.Foundations.Operation<
    {
      /**
       * catalogId.
       */
      @path
      catalogId: string;

      /**
       * Maximum number of items needed (inclusive). Minimum = 10, Maximum = 1000,
       * Default Value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("maxPageSize")
      maxPageSize?: int32 = 50;

      /**
       * Query filters.
       */
      @bodyRoot
      searchItemQuery: CrossCollectionItemSearchQuery;
    },
    ItemListResponse
  >;
}

interface SatelliteOperations {
  /**
   * Fetches Satellite data.
   */
  @operationId("Satellite_FetchItems")
  @route("/external/satellite:fetch")
  @post
  fetchItems is Azure.Core.Foundations.Operation<
    {
      /**
       * Maximum number of items needed (inclusive). Minimum = 1, Maximum = 100, Default
       * value = 10.
       */
      @maxValue(100)
      @minValue(1)
      @query("maxpagesize")
      maxpagesize?: int32 = 10;

      /**
       * Skip token for getting next set of results.
       */
      @maxValue(2147483647)
      @minValue(1)
      @query("skip")
      skip?: int32;

      /**
       * Query filters.
       */
      @bodyRoot
      searchItemsQuery: SatelliteFetchRequest;
    },
    SatelliteFetchResponse
  >;

  /**
   * Searches for STAC items by collection id, bbox, intersecting geometry, start
   * and end datetime.
   */
  @operationId("Satellite_SearchItems")
  @route("/external/satellite:stac")
  @post
  searchItems is Azure.Core.Foundations.Operation<
    {
      /**
       * Maximum number of items needed (inclusive). Minimum = 1, Maximum = 100, Default
       * value = 10.
       */
      @maxValue(100)
      @minValue(1)
      @query("maxpagesize")
      maxpagesize?: int32 = 10;

      /**
       * Skip token for getting next set of results.
       */
      @maxValue(2147483647)
      @minValue(1)
      @query("skip")
      skip?: int32;

      /**
       * Request.
       */
      @bodyRoot
      request: SatelliteStacRequest;
    },
    SearchFeaturesResponse
  >;
}

interface SchemasOperations {
  /**
   * Returns a paginated list of Schema resources.
   */
  @operationId("Schemas_List")
  @route("/schemas")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Names of the resource.
       */
      @query(#{ name: "names", explode: true })
      names?: string[];

      /**
       * Filters on key-value pairs within the Properties object.
       * eg. "{testKey} eq {testValue}".
       */
      @query(#{ name: "propertyFilters", explode: true })
      propertyFilters?: string[];

      /**
       * Statuses of the resource.
       */
      @query(#{ name: "statuses", explode: true })
      statuses?: string[];

      /**
       * Ids of the resource.
       */
      @query(#{ name: "ids", explode: true })
      ids?: string[];

      /**
       * Minimum creation date of resource (inclusive).
       */
      @query("minCreatedDateTime")
      minCreatedDateTime?: utcDateTime;

      /**
       * Maximum creation date of resource (inclusive).
       */
      @query("maxCreatedDateTime")
      maxCreatedDateTime?: utcDateTime;

      /**
       * Minimum last modified date of resource (inclusive).
       */
      @query("minLastModifiedDateTime")
      minLastModifiedDateTime?: utcDateTime;

      /**
       * Maximum last modified date of resource (inclusive).
       */
      @query("maxLastModifiedDateTime")
      maxLastModifiedDateTime?: utcDateTime;

      /**
       * Maximum number of items needed (inclusive).
       * Minimum = 10, Maximum = 1000, Default value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("maxPageSize")
      maxPageSize?: int32 = 50;

      /**
       * Skip token for getting next set of results.
       */
      @query("skipToken")
      skipToken?: string;
    },
    SchemaListResponse
  >;

  /**
   * Gets a specified Schema resource.
   */
  @operationId("Schemas_Get")
  @route("/schemas/{schemaId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Schema.
       */
      @path
      schemaId: string;
    },
    Schema
  >;

  /**
   * Creates or updates a Schema resource.
   */
  @operationId("Schemas_CreateOrUpdate")
  @route("/schemas/{schemaId}")
  @patch
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of the Schema resource.
       */
      @path
      schemaId: string;

      /**
       * Schema resource payload to create or update.
       */
      @bodyRoot
      schema: Schema;
    },
    Schema
  >;

  /**
   * Deletes Schema for given Schema id.
   */
  @operationId("Schemas_Delete")
  @route("/schemas/{schemaId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Id of Schema to be deleted.
       */
      @path
      schemaId: string;
    },
    void
  >;
}

interface SolutionsOperations {
  /**
   * Cancel Solution job Async.
   */
  @operationId("Solutions_CancelJob")
  @route("/external/solutions:cancel-job")
  @post
  cancelJob is Azure.Core.Foundations.Operation<
    Solution,
    SamplePartnerResponse
  >;

  /**
   * Creates solution job async.
   */
  @operationId("Solutions_CreateJob")
  @route("/external/solutions:create-job")
  @post
  createJob is Azure.Core.Foundations.Operation<
    SolutionData,
    SamplePartnerResponse
  >;

  /**
   * Gets solution Data async.
   */
  @operationId("Solutions_GetData")
  @route("/external/solutions:get-data")
  @post
  getData is Azure.Core.Foundations.Operation<
    SolutionData,
    SamplePartnerResponse
  >;

  /**
   * Gets Solution get job response async.
   */
  @operationId("Solutions_GetJob")
  @route("/external/solutions:get-job")
  @post
  getJob is Azure.Core.Foundations.Operation<Solution, SamplePartnerResponse>;
}

interface WeatherOperations {
  /**
   * Returns a list of WeatherData.
   */
  @operationId("Weather_Get")
  @route("/external/weather:fetch")
  @post
  get is Azure.Core.Foundations.Operation<WeatherRequest, WeatherResponse>;
}
