import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core.Traits;

namespace Microsoft.AgriculturePlatform;

alias ServiceTraits = NoRepeatableRequests &
  NoClientRequestId &
  NoConditionalRequests;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits, ErrorResponse>;

interface CatalogsOperations {
  /**
   * Returns a paginated list of Catalog resources.
   */
  list is Operations.ResourceList<
    Catalog,
    QueryParametersTrait<ListOperationQueryParameters> &
      ListOperationResponseTraits
  >;

  /**
   * Gets a specified Catalog resource.
   */
  get is Operations.ResourceRead<Catalog>;

  /**
   * Creates or updates a Catalog resource.
   */
  createOrUpdate is Operations.ResourceCreateOrUpdate<Catalog>;

  /**
   * Deletes Catalog for given Catalog id.
   */
  delete is Operations.ResourceDelete<Catalog>;
}

interface CollectionsOperations {
  /**
   * Returns a paginated list of Collection resources.
   */
  list is Operations.ResourceList<
    Collection,
    QueryParametersTrait<ListOperationQueryParameters> &
      ListOperationResponseTraits
  >;

  /**
   * Gets a specified Collection resource.
   */
  get is Operations.ResourceRead<Collection>;

  /**
   * Creates or updates a Collection resource.
   */
  createOrUpdate is Operations.ResourceCreateOrUpdate<Collection>;

  /**
   * Deletes Collection for given Collection id.
   */
  delete is Operations.ResourceDelete<Collection>;
}

interface FileOperations {
  /**
   * Deletes file.
   */
  @action("delete")
  delete is Operations.ResourceCollectionAction<
    FileResource,
    File,
    NoContentResponse
  >;

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
  upload is Operations.ResourceCollectionAction<FileResource, {}, File>;
}

interface ItemsOperations {
  /**
   * Creates or updates a Item resource.
   */
  @action("create")
  create is Operations.ResourceCollectionAction<
    Item,
    ItemParameters,
    ItemResponse
  >;

  /**
   * Gets a specified Item resource.
   */
  get is Operations.ResourceRead<Item>;

  /**
   * Creates or updates a Item resource.
   */
  createOrUpdate is Operations.ResourceCreateOrUpdate<Item>;

  /**
   * Deletes Item for given Item id.
   */
  delete is Operations.ResourceDelete<Item>;

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
    ItemsInCatalog,
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
    QueryParametersTrait<{
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
    }>
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
    QueryParametersTrait<{
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
    }>
  >;
}

interface SchemasOperations {
  /**
   * Returns a paginated list of Schema resources.
   */
  list is Operations.ResourceList<
    Schema,
    QueryParametersTrait<ListOperationQueryParameters> &
      ListOperationResponseTraits
  >;

  /**
   * Gets a specified Schema resource.
   */
  get is Operations.ResourceRead<Schema>;

  /**
   * Creates or updates a Schema resource.
   */
  createOrUpdate is Operations.ResourceCreateOrUpdate<Schema>;

  /**
   * Deletes Schema for given Schema id.
   */
  delete is Operations.ResourceDelete<Schema>;
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
