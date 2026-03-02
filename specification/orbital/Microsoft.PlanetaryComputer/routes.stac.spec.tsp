// SpatioTemporal Asset Catalog (STAC) API interfaces
import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.stac.spec.tsp";
import "./routes.common.tsp";

using TypeSpec.Http;
namespace Microsoft.PlanetaryComputer;

interface StacLandingPages {
  /**
   * Return the STAC landing page.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Landing Page")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac")
  @get
  get is Azure.Core.Foundations.Operation<{}, StacLandingPage>;
}

interface StacConformanceClass {
  /**
   * Returns the STAC conformance classes.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Conformance Classes")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/conformance")
  @get
  get is Azure.Core.Foundations.Operation<{}, StacConformanceClasses>;
}

interface StacSearch {
  /**
   * STAC search operation with query parameters.
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
      @query(#{ explode: true })
      collections?: string[];

      /**
       * Array of Item IDs to return specific items.
       */
      @query("ids")
      @query(#{ explode: true })
      ids?: string[];

      /**
       * Bounding box for spatial filtering in format [west, south, east, north].
       */
      @query("bbox")
      @query(#{ explode: true })
      boundingBox?: float32[];

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
      sign?: StacAssetUrlSigningMode;

      /**
       * URL signature duration in minutes.
       */
      @query("duration")
      durationInMinutes?: int32;

      /**
       * Property-based filtering expressed as a JSON object.
       */
      @query("query")
      query?: string;

      /**
       * Sort order for items. Format is property name prefixed with "+" for ascending or "-" for descending.
       */
      @query("sortby")
      sortBy?: string;

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
    StacItemCollection
  >;
  /**
   * STAC search operation.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @summary("Search")
  @tag("SpatioTemporal Asset Catalog (STAC) API")
  @route("/stac/search")
  @post
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * Whether to sign asset URLs in the response.
       */
      @query("sign")
      sign?: StacAssetUrlSigningMode;

      /**
       * URL signature duration in minutes.
       */
      @query("duration")
      durationInMinutes?: int32;

      /**
       * Request body
       */
      @body
      body: StacSearchParameters;
    },
    StacItemCollection
  >;
}
