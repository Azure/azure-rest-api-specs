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
  Collections_List is Operations.ResourceList<Collection,QueryParametersTrait<
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
   * Gets a specified Collection resource.
   */
  Collections_Get is Operations.ResourceRead<Collection>;

  /**
   * Creates or updates a Collection resource.
   */
  Collections_CreateOrUpdate is Operations.ResourceCreateOrUpdate<Collection>;

  /**
   * Deletes Collection for given Collection id.
   */
  Collections_Delete is Operations.ResourceDelete<Collection>;
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
  create is Operations.ResourceCollectionAction<Item, ItemParameters, ItemResponse>;

  /**
   * Gets a specified Item resource.
   */
  Items_Get is Operations.ResourceRead<Item>;

  /**
   * Creates or updates a Item resource.
   */
  Items_CreateOrUpdate is Operations.ResourceCreateOrUpdate<Item>;

  /**
   * Deletes Item for given Item id.
   */
  Items_Delete is Operations.ResourceDelete<Item>;

  /**
   * Search for Items across all parties by intersecting geometry.
   */
  search is Operations.ResourceCollectionAction<
    Item,
    ItemQuery,
    ItemListResponse,
    // QueryParametersTrait<{
    //   /**
    //    * Maximum number of items needed (inclusive). Minimum = 10, Maximum = 1000,
    //    * Default Value = 50.
    //    */
    //   @maxValue(1000)
    //   @minValue(10)
    //   @query("maxPageSize")
    //   maxPageSize?: int32 = 50;
    // }>
  >;

  
}

interface ItemsOperationInCatalog {
  /**
   * Search for Items across all collections.
   */
  search is Operations.ResourceCollectionAction<
    ItemsinCatalog,
    CrossCollectionItemSearchQuery,
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
