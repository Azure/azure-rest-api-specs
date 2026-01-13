import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MapsSearch;

interface SearchOperationGroup {
  /**
   *
   *
   * The `Get Geocoding` API is an HTTP `GET` request that returns the longitude and
   * latitude coordinates of the location being searched.
   *
   * In many cases, the complete search service might be too much, for instance if
   * you are only interested in traditional geocoding. Search can also be accessed
   * for address look up exclusively. The geocoding is performed by hitting the
   * geocoding endpoint with just the address or partial address in question. The
   * geocoding search index will be queried for everything above the street level
   * data. No Point of Interest (POIs) will be returned. Note that the geocoder is
   * very tolerant of typos and incomplete addresses. It will also handle everything
   * from exact street addresses or street or intersections as well as higher level
   * geographies such as city centers, counties and states. The response also
   * returns detailed address properties such as street, postal code, municipality,
   * and country/region information.
   *
   * >[!Important]
   * >By using this feature, you agree to the preview legal terms. For more
   * information, see [Preview Supplemental
   * Terms](https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).
   *
   *
   */
  @summary("""
    Use to get longitude and latitude coordinates of a street address or name of a
    place.
    """)
  @operationId("Search_GetGeocoding")
  @route("/geocode")
  @get
  getGeocoding is Azure.Core.Foundations.Operation<
    {
      /**
       * Language in which search results should be returned.
       *
       * Please refer to [Supported
       * Languages](/azure/azure-maps/supported-languages?pivots=service-latest) for
       * details.
       */
      @header
      `Accept-Language`?: string;

      /**
       * Maximum number of responses that will be returned. Default: 5, minimum: 1 and
       * maximum: 20.
       */
      @maxValue(20)
      @minValue(1)
      @query("top")
      top?: int32 = 5;

      /**
       * A string that contains information about a location, such as an address or
       * landmark name.
       */
      @query("query")
      query?: string;

      /**
       * The official street line of an address relative to the area, as specified by
       * the locality, or postalCode, properties. Typical use of this element would be
       * to provide a street address or any official address.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("addressLine")
      addressLine?: string;

      /**
       * Signal for the geocoding result to an [ISO 3166-1 Alpha-2 region/country
       * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) that is specified e.g.
       * FR.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("countryRegion")
      countryRegion?: string;

      /**
       * A rectangular area on the earth defined as a bounding box object. The sides of
       * the rectangle are defined by longitude and latitude values. When you specify
       * this parameter, the geographical area is taken into account when computing the
       * results of a location query.
       *
       * Example: lon1,lat1,lon2,lat2.
       *
       * Minimum size: approximately 0.00001 degrees (~0.01 meters).
       *
       *   Maximum size: up to the full global extent (-180,-90 to 180,90)
       */
      @query("bbox")
      bbox?: float64[];

      /**
       * A string that represents an [ISO 3166-1 Alpha-2 region/country
       * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). This will alter
       * Geopolitical disputed borders and labels to align with the specified user
       * region. By default, the View parameter is set to “Auto” even if you haven’t
       * defined it in the request.
       *
       * Please refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews)
       * for details and to see the available Views.
       */
      @query("view")
      view?: string;

      /**
       * A point on the earth specified as a longitude and latitude. When you specify
       * this parameter, the user’s location is taken into account and the results
       * returned may be more relevant to the user. Example: &coordinates=lon,lat
       */
      @query("coordinates")
      coordinates?: float64[];

      /**
       * The country subdivision portion of an address, such as WA.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("adminDistrict")
      adminDistrict?: string;

      /**
       * The county for the structured address, such as King.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("adminDistrict2")
      adminDistrict2?: string;

      /**
       * The named area for the structured address.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("adminDistrict3")
      adminDistrict3?: string;

      /**
       * The locality portion of an address, such as Seattle.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("locality")
      locality?: string;

      /**
       * The postal code portion of an address.
       *
       * This parameter should not be used when the `query` parameter is included in the
       * request.
       */
      @query("postalCode")
      postalCode?: string;

      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header
      clientId?: string;
    },
    GeocodingResponse & {
      @header
      contentType: "application/geo+json";
    }
  >;

  /**
   *
   *
   * The `Get Geocoding Batch` API is an HTTP `POST` request that sends batches of
   * up to **100** queries to the [Geocoding](/rest/api/maps/search/get-geocoding)
   * API in a single request.
   *
   * >[!Important]
   * >By using this feature, you agree to the preview legal terms. For more
   * information, see [Preview Supplemental
   * Terms](https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).
   *
   *
   * ### Submit Synchronous Batch Request
   * The Synchronous API is recommended for lightweight batch requests. When the
   * service receives a request, it will respond as soon as the batch items are
   * calculated and there will be no possibility to retrieve the results later. The
   * Synchronous API will return a timeout error (a 408 response) if the request
   * takes longer than 60 seconds. The number of batch items is limited to **100**
   * for this API.
   * ```
   * POST https://atlas.microsoft.com/geocode:batch?api-version=2023-06-01
   * ```
   * ### POST Body for Batch Request
   * To send the _geocoding_ queries you will use a `POST` request where the request
   * body will contain the `batchItems` array in `json` format and the
   * `Content-Type` header will be set to `application/json`. Here's a sample
   * request body containing 2 _geocoding_ queries:
   *
   *
   * ```
   * {
   *   "batchItems": [
   *     {
   *       "addressLine": "One, Microsoft Way, Redmond, WA 98052",
   *       "top": 2
   *     },
   *     {
   *       "addressLine": "Pike Pl",
   *       "adminDistrict": "WA",
   *       "locality": "Seattle",
   *       "top": 3
   *     }
   *   ]
   * }
   * ```
   *
   * A _geocoding_ batchItem object can accept any of the supported _geocoding_ [URI
   * parameters](/rest/api/maps/search/get-geocoding#uri-parameters).
   *
   *
   * The batch should contain at least **1** query.
   *
   *
   * ### Batch Response Model
   * The batch response contains a `summary` component that indicates the
   * `totalRequests` that were part of the original batch request and
   * `successfulRequests` i.e. queries which were executed successfully. The batch
   * response also includes a `batchItems` array which contains a response for each
   * and every query in the batch request. The `batchItems` will contain the results
   * in the exact same order the original queries were sent in the batch request.
   * Each item is of one of the following types:
   *
   *   -
   * [`GeocodingResponse`](/rest/api/maps/search/get-geocoding#geocodingresponse) -
   * If the query completed successfully.
   *
   *   - `Error` - If the query failed. The response will contain a `code` and a
   * `message` in this case.
   */
  @summary("""
    Use to send a batch of queries to the
    [Geocoding](/rest/api/maps/search/get-geocoding) API in a single request.
    """)
  @operationId("Search_GetGeocodingBatch")
  @route("/geocode:batch")
  @post
  getGeocodingBatch is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header
      clientId?: string;

      /**
       * Language in which search results should be returned.
       *
       * Please refer to [Supported
       * Languages](/azure/azure-maps/supported-languages?pivots=service-latest) for
       * details.
       */
      @header
      `Accept-Language`?: string;

      /**
       * The list of address geocoding queries/requests to process. The list can contain
       * a max of 100 queries and must contain at least 1 query.
       */
      @bodyRoot
      geocodingBatchRequestBody: GeocodingBatchRequestBody;
    },
    GeocodingBatchResponse
  >;

  /**
   *
   *
   * The `Get Polygon` API is an HTTP `GET` request that supplies polygon data of a
   * geographical area outline such as a city or a country region.
   *
   * >[!Important]
   * >By using this feature, you agree to the preview legal terms. For more
   * information, see [Preview Supplemental
   * Terms](https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).
   *
   *
   */
  @summary("""
    Use to get polygon data of a geographical area shape such as a city or a
    country region.
    """)
  @operationId("Search_GetPolygon")
  @route("/search/polygon")
  @get
  getPolygon is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header
      clientId?: string;

      /**
       * Language in which search results should be returned.
       *
       * Please refer to [Supported
       * Languages](/azure/azure-maps/supported-languages?pivots=service-latest) for
       * details.
       */
      @header
      `Accept-Language`?: string;

      /**
       * A point on the earth specified as a longitude and latitude. Example:
       * &coordinates=lon,lat
       */
      @query("coordinates")
      coordinates: float64[];

      /**
       * A string that represents an [ISO 3166-1 Alpha-2 region/country
       * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). This will alter
       * Geopolitical disputed borders and labels to align with the specified user
       * region. By default, the View parameter is set to “Auto” even if you haven’t
       * defined it in the request.
       *
       * Please refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews)
       * for details and to see the available Views.
       */
      @query("view")
      view?: string;

      /**
       * The geopolitical concept to return a boundary for. If not specified, the
       * default is `countryRegion` result type.
       */
      @query("resultType")
      resultType?: BoundaryResultTypeEnum = BoundaryResultTypeEnum.countryRegion;

      /**
       * Resolution determines the amount of points to send back. If not specified, the
       * default is medium resolution.
       */
      @query("resolution")
      resolution?: ResolutionEnum = ResolutionEnum.medium;
    },
    Boundary & {
      @header
      contentType: "application/geo+json";
    }
  >;

  /**
   *
   *
   * The `Get Reverse Geocoding` API is an HTTP `GET` request used to translate a
   * coordinate (example: 37.786505, -122.3862) into a human understandable street
   * address. Useful in tracking applications where you receive a GPS feed from the
   * device or asset and wish to know the address associated with the coordinates.
   * This endpoint will return address information for a given coordinate.
   *
   * >[!Important]
   * >By using this feature, you agree to the preview legal terms. For more
   * information, see [Preview Supplemental
   * Terms](https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).
   *
   *
   */
  @summary("""
    Use to get a street address and location info from longitude and latitude
    coordinates.
    """)
  @operationId("Search_GetReverseGeocoding")
  @route("/reverseGeocode")
  @get
  getReverseGeocoding is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header
      clientId?: string;

      /**
       * Language in which search results should be returned.
       *
       * Please refer to [Supported
       * Languages](/azure/azure-maps/supported-languages?pivots=service-latest) for
       * details.
       */
      @header
      `Accept-Language`?: string;

      /**
       * The coordinates of the location that you want to reverse geocode. Example:
       * &coordinates=lon,lat
       */
      @query("coordinates")
      coordinates: float64[];

      /**
       * Specify entity types that you want in the response. Only the types you specify
       * will be returned. If the point cannot be mapped to the entity types you
       * specify, no location information is returned in the response.
       * Default value is all possible entities.
       * A comma separated list of entity types selected from the following options.
       *
       * - Address
       * - Neighborhood
       * - PopulatedPlace
       * - Postcode1
       * - AdminDivision1
       * - AdminDivision2
       * - CountryRegion
       *
       * These entity types are ordered from the most specific entity to the least
       * specific entity. When entities of more than one entity type are found, only the
       * most specific entity is returned. For example, if you specify Address and
       * AdminDistrict1 as entity types and entities were found for both types, only the
       * Address entity information is returned in the response.
       */
      @query("resultTypes")
      resultTypes?: ReverseGeocodingResultTypeEnum[];

      /**
       * A string that represents an [ISO 3166-1 Alpha-2 region/country
       * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). This will alter
       * Geopolitical disputed borders and labels to align with the specified user
       * region. By default, the View parameter is set to “Auto” even if you haven’t
       * defined it in the request.
       *
       * Please refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews)
       * for details and to see the available Views.
       */
      @query("view")
      view?: string;
    },
    GeocodingResponse & {
      @header
      contentType: "application/geo+json";
    }
  >;

  /**
   *
   *
   * The `Get Reverse Geocoding Batch` API is an HTTP `POST` request that sends
   * batches of up to **100** queries to [Reverse
   * Geocoding](/rest/api/maps/search/get-reverse-geocoding) API using a single
   * request.
   *
   * >[!Important]
   * >By using this feature, you agree to the preview legal terms. For more
   * information, see [Preview Supplemental
   * Terms](https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).
   *
   *
   * ### Submit Synchronous Batch Request
   * The Synchronous API is recommended for lightweight batch requests. When the
   * service receives a request, it will respond as soon as the batch items are
   * calculated and there will be no possibility to retrieve the results later. The
   * Synchronous API will return a timeout error (a 408 response) if the request
   * takes longer than 60 seconds. The number of batch items is limited to **100**
   * for this API.
   * ```
   * POST https://atlas.microsoft.com/reverseGeocode:batch?api-version=2023-06-01
   * ```
   * ### POST Body for Batch Request
   * To send the _reverse geocoding_ queries you will use a `POST` request where the
   * request body will contain the `batchItems` array in `json` format and the
   * `Content-Type` header will be set to `application/json`. Here's a sample
   * request body containing 2 _reverse geocoding_ queries:
   *
   *
   * ```
   * {
   *   "batchItems": [
   *     {
   *       "coordinates": [-122.128275, 47.639429],
   *       "resultTypes": ["Address", "PopulatedPlace"]
   *     },
   *     {
   *       "coordinates": [-122.341979399674, 47.6095253501216]
   *     }
   *   ]
   * }
   * ```
   *
   * A _reverse geocoding_ batchItem object can accept any of the supported _reverse
   * geocoding_ [URI
   * parameters](/rest/api/maps/search/get-reverse-geocoding#uri-parameters).
   *
   *
   * The batch should contain at least **1** query.
   *
   *
   * ### Batch Response Model
   * The batch response contains a `summary` component that indicates the
   * `totalRequests` that were part of the original batch request and
   * `successfulRequests` i.e. queries which were executed successfully. The batch
   * response also includes a `batchItems` array which contains a response for each
   * and every query in the batch request. The `batchItems` will contain the results
   * in the exact same order the original queries were sent in the batch request.
   * Each item is of one of the following types:
   *
   *   -
   * [`GeocodingResponse`](/rest/api/maps/search/get-reverse-geocoding#geocodingresponse)
   * - If the query completed successfully.
   *
   *   - `Error` - If the query failed. The response will contain a `code` and a
   * `message` in this case.
   */
  @summary("""
    Use to send a batch of queries to the [Reverse
    Geocoding](/rest/api/maps/search/get-reverse-geocoding) API in a single
    request.
    """)
  @operationId("Search_GetReverseGeocodingBatch")
  @route("/reverseGeocode:batch")
  @post
  getReverseGeocodingBatch is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header
      clientId?: string;

      /**
       * Language in which search results should be returned.
       *
       * Please refer to [Supported
       * Languages](/azure/azure-maps/supported-languages?pivots=service-latest) for
       * details.
       */
      @header
      `Accept-Language`?: string;

      /**
       * The list of reverse geocoding queries/requests to process. The list can contain
       * a max of 100 queries and must contain at least 1 query.
       */
      @bodyRoot
      reverseGeocodingBatchRequestBody: ReverseGeocodingBatchRequestBody;
    },
    GeocodingBatchResponse
  >;

  /**
   *
   *
   * Given a request with a user’s location and a partial query that serves as the
   * prefix of a full query string (referred to as a query prefix), the Azure Maps
   * Autocomplete API returns a list of suggested entities that the user is most
   * likely searching for. These entities are ranked from most to least likely.
   *
   * >[!Important]
   * >By using this feature, you agree to the preview legal terms. For more
   * information, see [Preview Supplemental
   * Terms](https://azure.microsoft.com/en-us/support/legal/preview-supplemental-terms/).
   *
   *
   */
  @added(Versions.v2025_06_01_preview)
  @summary("""
    Use to get ranked list of suggested entities based on a user's location and a
    partial query.
    """)
  @operationId("Search_GetGeocodeAutocomplete")
  @route("/geocode:autocomplete")
  @get
  getGeocodeAutocomplete is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies which account is intended for usage in conjunction with the Azure AD
       * security model.  It represents a unique ID for the Azure Maps account and can
       * be retrieved from the Azure Maps management plane Account API. For more
       * information on using Microsoft Entra ID security in Azure Maps, see [Manage
       * authentication in Azure Maps](/azure/azure-maps/how-to-manage-authentication).
       */
      @header
      clientId?: string;

      /**
       * Language in which search results should be returned.
       *
       * Please refer to [Supported
       * Languages](/azure/azure-maps/supported-languages?pivots=service-latest) for
       * details.
       */
      @header
      `Accept-Language`?: string;

      /**
       * Required. The user's query prefix.
       *
       * Example: "1 Micro" or "Muir Woods".
       *
       */
      @query("query")
      query: string;

      /**
       * Required when `bbox` is not provided. A point on the earth specified as a
       * longitude and latitude. When you specify this parameter, the user’s location is
       * taken into account and the results returned may be more relevant to the user.
       * Example: &coordinates=lon,lat
       *
       * **Note:** `coordinates` becomes a secondary signal if `bbox` is provided.
       */
      @query("coordinates")
      coordinates?: float64[];

      /**
       * Required when `coordinates` is not provided. A rectangular area on the earth
       * defined as a bounding box object. The sides of the rectangle are defined by
       * longitude and latitude values. When you specify this parameter, the
       * geographical area is taken into account when computing the results of a
       * location query.
       *
       * Example: lon1,lat1,lon2,lat2.
       *
       * Minimum size: approximately 0.00001 degrees (~0.01 meters).
       *
       *   Maximum size: up to the full global extent (-180,-90 to 180,90)
       */
      @query("bbox")
      bbox?: float64[];

      /**
       * Maximum number of responses that will be returned. Default: 5, minimum: 1 and
       * maximum: 20.
       */
      @maxValue(20)
      @minValue(1)
      @query("top")
      top?: int32 = 5;

      /**
       * A comma separated list of returned entity type groups. The possible values are
       *
       * - Address
       * - Place
       *
       *
       */
      @query("resultTypeGroups")
      resultTypeGroups?: AutocompleteResultTypeGroupsEnum[];

      /**
       * A comma separated list of returned entity types.
       * When type group is set to Address, the supported types are:
       *
       * - Address
       * - RoadBlock
       *
       * All other types belong to the Place type group. These may include entities such
       * as AdminDivision1, Neighborhood, PopulatedPlace, and more.
       * Default value is all possible entity types.
       */
      @query("resultTypes")
      resultTypes?: AutocompleteResultTypeEnum[];

      /**
       * A string that represents an [ISO 3166-1 Alpha-2 region/country
       * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). This will alter
       * Geopolitical disputed borders and labels to align with the specified user
       * region. By default, the View parameter is set to “Auto” even if you haven’t
       * defined it in the request.
       *
       * Please refer to [Supported Views](https://aka.ms/AzureMapsLocalizationViews)
       * for details and to see the available Views.
       */
      @query("view")
      view?: string;

      /**
       * Signal for the autocomplete result to an [ISO 3166-1 Alpha-2 region/country
       * code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) that is specified e.g.
       * FR. Only results in the specified country/region will be returned.
       *
       *
       */
      @query("countryRegion")
      countryRegion?: string = "none";
    },
    AutocompleteResponse & {
      @header
      contentType: "application/geo+json";
    }
  >;
}
