// SpatioTemporal Asset Catalog (STAC) API interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.stac.spec.tsp";
import "./routes.common.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
namespace Microsoft.PlanetaryComputer;

interface StacLandingPages {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Landing Page")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac")
  @get
  get is Azure.Core.Foundations.Operation<{}, LandingPage>;
}

interface StacConformanceClass {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Conformance Classes")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/conformance")
  @get
  get is Azure.Core.Foundations.Operation<{}, ConformanceClasses>;
}

interface StacSearchOperations {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Search")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/search")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * List of Collection IDs to include in the search. Only items in these collections will be searched.
       */
      @query("collections")
      collections?: string;

      /**
       * Array of Item IDs to return specific items.
       */
      @query("ids")
      ids?: string;

      /**
       * Bounding box for spatial filtering in format [west, south, east, north].
       */
      @query("bbox")
      bbox?: string[];

      /**
       * GeoJSON geometry for spatial filtering.
       */
      @query("intersects")
      intersects?: string;

      /**
       * Temporal filter in RFC 3339 format, can be a single time or range.
       */
      @query("datetime")
      datetime?: string;

      /**
       * Maximum number of results to return.
       */
      @query("limit")
      limit?: int32 = 250;

      /**
       * Whether to sign asset URLs in the response.
       */
      @query("sign")
      sign?: SignType;

      /**
       * URL signature duration in seconds.
       */
      @query("duration")
      duration?: int32;

      /**
       * Property-based filtering expressed as a JSON object.
       */
      @query("query")
      query?: string;

      /**
       * Sort order for items. Format is property name prefixed with "+" for ascending or "-" for descending.
       */
      @query("sortby")
      sortby?: string;

      /**
       * Determines which fields to include in the response. Format is comma-separated field names with "-" prefix to exclude fields.
       */
      @query("fields")
      fields?: string;

      /**
       * CQL filter expression for advanced filtering of items.
       */
      @query("filter")
      filter?: string;

      /**
       * Pagination token for fetching the next set of results.
       */
      @query("token")
      token?: string;
    },
    ItemCollection | NoContentResponse
  >;
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Search")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/search")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Request body
       */
      @body
      body: SearchPostRequest;
    },
    ItemCollection | NoContentResponse
  >;
}

interface StacQueryables {
  /**
   * Endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Queryables")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/queryables")
  @get
  getAll is Azure.Core.Foundations.Operation<
    {},
    QueryableDefinition[] | NoContentResponse
  >;
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
    OkResponse | NoContentResponse
  >;
  /**
   * Endpoint.
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
    QueryableDefinition[] | NoContentResponse
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
      body: QueryableDefinition[];
    },
    {
      ...CreatedResponse;

      @body
      body: QueryableDefinition[];
    } | NoContentResponse
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
      body: QueryableDefinition;
    },
    {
      ...CreatedResponse;

      @body
      body: QueryableDefinition;
    } | QueryableDefinition
  >;
}
