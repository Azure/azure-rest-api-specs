import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.AgriculturePlatform;

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
  @action("delete")
  delete is Operations.ResourceCollectionAction<FileResource, File, NoContentResponse>;

  /**
   * Downloads and returns file Stream as response for the given input filePath.
   */
  @action("download")
  download is Operations.ResourceCollectionAction<
    FileResource,
    File,
    NoContentResponse,
    RequestHeadersTrait<{
      /**
       * Accept header
       */
      @header
      accept: "application/json, application/octet-stream";
    }>
  >;

  /**
   * Uploads a file.
   */
  @action("upload")
  upload is Operations.ResourceCollectionAction<FileResource, {} , File>;
}

interface ItemsOperations {
  /**
   * Creates or updates a Item resource.
   */
  @action("create")
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
  @action("search")
  getAllUnderCollection is Operations.ResourceCollectionAction<
    Item,
    ItemQuery,
    ItemListResponse,
    QueryParametersTrait<{
      /**
       * Maximum number of items needed (inclusive). Minimum = 10, Maximum = 1000,
       * Default Value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("maxPageSize")
      maximumPageSize?: int32 = 50;
    }>
  >;

  /**
   * Search for Items across all collections.
   */
  @action("search")
  searchAcrossCollection is Operations.ResourceCollectionAction<
    ItemsinCatalog,
    CrossCollectionItemSearchQuery,
    ItemListResponse,
    QueryParametersTrait<{
      /**
       * Maximum number of items needed (inclusive). Minimum = 10, Maximum = 1000,
       * Default Value = 50.
       */
      @maxValue(1000)
      @minValue(10)
      @query("maxPageSize")
      maximumPageSize?: int32 = 50;
    }>
  >;
}

interface SatelliteOperations {
  /**
   * Fetches Satellite data.
   */
  @action("fetch")
  fetchItems is Operations.ResourceCollectionAction<
  SatelliteResource,
    SatelliteFetchRequest,
    SatelliteFetchResponse,
    QueryParametersTrait<
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
    }
    >
  >;
  

  /**
   * Searches for STAC items by collection id, bbox, intersecting geometry, start
   * and end datetime.
   */
  @action("stac")
  searchItems is Operations.ResourceCollectionAction<
  SatelliteResource,
    SatelliteStacRequest,
    SearchFeaturesResponse,
    QueryParametersTrait<
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
      }
    >
  >;
}

interface SchemasOperations {
  /**
   * Returns a paginated list of Schema resources.
   */
  Schemas_List is Operations.ResourceList<Schema,QueryParametersTrait<
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
   * Gets a specified Schema resource.
   */
  Schemas_Get is Operations.ResourceRead<Schema>;

  /**
   * Creates or updates a Schema resource.
   */
  Schemas_CreateOrUpdate is Operations.ResourceCreateOrUpdate<Schema>;

  /**
   * Deletes Schema for given Schema id.
   */
  Schemas_Delete is Operations.ResourceDelete<Schema>;
}

interface SolutionsOperations {
  /**
   * Cancel Solution job Async.
   */
  @action("cancel-job")
  cancelJob is Operations.ResourceCollectionAction<
    SolutionResource,
    Solution,
    SamplePartnerResponse
  >;

  /**
   * Creates solution job async.
   */
  @action("create-job")
  createJob is Operations.ResourceCollectionAction<
    SolutionResource,
    SolutionData,
    SamplePartnerResponse
  >;

  /**
   * Gets solution Data async.
   */
  @action("get-data")
  getData is Operations.ResourceCollectionAction<
    SolutionResource,
    SolutionData,
    SamplePartnerResponse
  >;

  /**
   * Gets Solution get job response async.
   */
  @action("get-job")
  getJob is Operations.ResourceCollectionAction<
    SolutionResource,
    Solution,
    SamplePartnerResponse
  >;
}

interface WeatherOperations {
  /**
   * Returns a list of WeatherData.
   */
  @action("fetch")
  get is Operations.ResourceCollectionAction<
    WeatherResource,
    WeatherRequest,
    WeatherResponse
  >;
}
