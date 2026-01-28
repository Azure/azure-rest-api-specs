import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;

namespace MapsRoute;

alias ContentTypeHeader<T extends string> = {
  /** Content-Type */
  @header("Content-Type")
  contentType: T;
};

op MapsRouteOperation<
  TParams extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model | void,
  TError extends TypeSpec.Reflection.Model = MapsErrorResponse
> is Azure.Core.Foundations.Operation<
  {
    ...ClientIdHeader;
    ...TParams;
  },
  TResponse,
  {},
  TError
>;

interface Route {
  /**
   *
   *
   * The `Route Directions` API is an HTTP `POST` request that returns the ideal
   * route between an origin and destination for automobile (driving), commercial
   * trucks and walking routes. The route passes through a series of waypoints if
   * specified. A waypoint is a geographical location defined by longitude and
   * latitude that is used for navigational purposes. The route considers factors
   * such as current traffic and the typical road speeds on the requested day of the
   * week and time of day.
   *
   * The API returns the distance, estimated travel time, and a representation of
   * the route geometry. More routing information such as an optimized waypoint
   * order or turn by turn instructions is also available, depending on the
   * parameters used.
   *
   * The Route Directions considers local laws, vehicle dimensions, cargo type, max
   * speed, bridge and tunnel heights to calculate the truck specific routes and
   * avoid complex maneuvers and difficult roads. Not all trucks can travel the same
   * routes as other vehicles due to certain restrictions based on the vehicle
   * profile or cargo type. For example, highways often have separate speed limits
   * for trucks, some roads don't allow trucks with flammable or hazardous
   * materials, and there can be height and weight restriction on bridges.
   *
   * Up to 150 waypoints and 10 viaWaypoints between any two waypoints is supported.
   * Each set of waypoints creates a separate route Leg. ViaWaypoints define the
   * route path and can be used for route creation through specific locations, but
   * they don't create route Legs.
   *
   * For information about routing availability in countries/regions, see [Azure
   * Maps routing
   * coverage](https://learn.microsoft.com/azure/azure-maps/routing-coverage?pivots=latest).
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Reported due to response content-type. Needs fix: https://github.com/microsoft/typespec/issues/2853"
  @summary("""
    Use to get the best route between an origin and destination for automobile,
    commercial trucks and walking routes.
    """)
  @route("/route/directions")
  @post
  postRouteDirections is MapsRouteOperation<
    {
      ...ContentTypeHeader<"application/geo+json">;
      ...AcceptLanguageHeader;

      /**
       * Request body of RouteDirections API in GeoJSON format.
       */
      @bodyRoot
      routeDirectionsRequest: DirectionsRequest;
    },
    RouteDirectionsResponse &
      ContentTypeHeader<"application/geo+json" | "application/json">
  >;

  /**
   *
   *
   *
   * The `Route Directions Batch` API is an HTTP `POST` request that sends batches
   * of up to **100** queries in a single call to the [Route
   * Directions](/rest/api/maps/route/post-route-directions?view=rest-maps-2025-01-01)
   * API.
   *
   * ### Submit Synchronous Batch Request
   * The Synchronous API is recommended for lightweight batch requests. When the
   * service receives a request, it will respond as soon as the batch items are
   * calculated and there will be no possibility to retrieve the results later. The
   * Synchronous API will return a timeout error (a 408 response) if the request
   * takes longer than 60 seconds. The number of batch items is limited to **100**
   * for this API.
   * ```
   * POST https://atlas.microsoft.com/route/directions:batch?api-version=2025-01-01
   * ```
   * ### POST Body for Batch Request
   * To send the _directions_ queries you will use a `POST` request where the
   * request body will contain the `batchItems` array in `json` format and the
   * `Content-Type` header will be set to `application/json`. Here's a sample
   * request body containing 2 _directions_ queries:
   *
   *
   * ```
   * {
   *   "batchItems": [
   *     {
   *       "optionalId": "bbc9c0f6-ab52-49d8-a788-a658fa654c94",
   *       "type": "FeatureCollection",
   *       "features": [
   *         {
   *           "type": "Feature",
   *           "geometry": {
   *             "coordinates": [
   *               -122.3368,
   *               47.614988
   *             ],
   *             "type": "Point"
   *           },
   *           "properties": {
   *             "pointIndex": 0,
   *             "pointType": "waypoint"
   *           }
   *         },
   *         {
   *           "type": "Feature",
   *           "geometry": {
   *             "coordinates": [
   *               -122.316067,
   *               47.606356
   *             ],
   *             "type": "Point"
   *           },
   *           "properties": {
   *             "pointIndex": 1,
   *             "pointType": "waypoint"
   *           }
   *         }
   *       ],
   *       "optimizeRoute": "fastestWithoutTraffic",
   *       "routeOutputOptions": [
   *         "routeSummary"
   *       ],
   *       "maxRouteCount": 3,
   *       "travelMode": "driving"
   *     },
   *     {
   *       "optionalId": "a191de3c-1268-4986-98f0-03f0a5d9302a",
   *       "type": "FeatureCollection",
   *       "features": [
   *         {
   *           "type": "Feature",
   *           "geometry": {
   *             "coordinates": [
   *               -122.3368,
   *               47.614988
   *             ],
   *             "type": "Point"
   *           },
   *           "properties": {
   *             "pointIndex": 0,
   *             "pointType": "waypoint"
   *           }
   *         },
   *         {
   *           "type": "Feature",
   *           "geometry": {
   *             "coordinates": [
   *               -122.316067,
   *               47.606356
   *             ],
   *             "type": "Point"
   *           },
   *           "properties": {
   *             "pointIndex": 1,
   *             "pointType": "waypoint"
   *           }
   *         }
   *       ],
   *       "optimizeRoute": "shortest",
   *       "routeOutputOptions": [
   *         "routeSummary"
   *       ],
   *       "maxRouteCount": 2,
   *       "travelMode": "driving"
   *     }
   *   ]
   * }
   *  ```
   *
   * A _directions_ batchItem object can accept any of the supported _directions_
   * [Request
   * body](/rest/api/maps/route/post-route-directions?view=rest-maps-2025-01-01#request-body)
   *
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
   *   - [`DirectionsResponse`](/rest/api/maps/route/post-directions#response) - If
   * the query completed successfully.
   *
   *   - `Error` - If the query failed. The response will contain a `code` and a
   * `message` in this case.
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @summary("""
    Use to send a batch of queries to the [Route
    Directions](/rest/api/maps/route/post-route-directions?view=rest-maps-2025-01-01)
    API in a single synchronous request.
    """)
  @route("/route/directions:batch")
  @post
  postRouteDirectionsBatch is MapsRouteOperation<
    {
      ...AcceptLanguageHeader;

      /**
       * The list of route directions queries/requests to process. The list can contain
       * a max of 100 queries for sync version and must contain at least 1 query.
       */
      @bodyRoot
      routeDirectionsBatchRequest: DirectionsBatchRequestBody;
    },
    DirectionsBatchResponse
  >;

  /**
   * The Snap to Roads API accepts GPS point data, represented as longitude and
   * latitude coordinates, and generates points that aligns with existing roadways
   * on a map. This process, known as "snapping to roads", produces a series of
   * objects that trace a path closely following the road network. The resulting
   * data includes road names and their respective speed limits, pertinent to the
   * traversed segments.
   *
   * Moreover, the Snap to Roads API offers an interpolation feature, which refines
   * the GPS points to create a smoother route that adheres to the road's geometry.
   * This functionality is especially beneficial for asset tracking and enhancing
   * data visualization in mapping applications.
   *
   * >[!Important]
   * > The GPS points must be within 6 kilometer of each other.
   *
   *
   *
   * For information about routing availability in countries/regions, see [Azure
   * Maps routing
   * coverage](https://learn.microsoft.com/azure/azure-maps/routing-coverage?pivots=latest).
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Reported due to response content-type. Needs fix: https://github.com/microsoft/typespec/issues/2853"
  @route("/route/snapToRoads")
  @post
  postSnapToRoads is MapsRouteOperation<
    {
      ...ContentTypeHeader<"application/geo+json">;
      ...AcceptLanguageHeader;

      /**
       * Request body of SnapToRoads API in GeoJSON format.
       */
      @bodyRoot
      snapToRoadsRequest: SnapToRoadsRequest;
    },
    SnapToRoadsResponse &
      ContentTypeHeader<"application/geo+json" | "application/json">
  >;

  /**
   * The Snap To Roads Batch API sends batches of up to **100** queries as a single
   * call to the [Snap To Roads
   * API](/rest/api/maps/route/post-snap-to-roads?view=rest-maps-2025-01-01). This
   * API enables efficient processing of multiple queries in one request, reducing
   * the need for individual calls.
   *
   * ### Submit Synchronous Batch Request
   * The Synchronous API is recommended for lightweight batch requests. When the
   * service receives a request, it will respond as soon as the batch items are
   * calculated and there will be no possibility to retrieve the results later. The
   * Synchronous API will return a timeout error (a 408 response) if the request
   * takes longer than 60 seconds. The number of batch items is limited to **100**
   * for this API.
   * ```
   * POST https://atlas.microsoft.com/route/snapToRoads:batch?api-version=2025-01-01
   * ```
   * ### POST Body for Batch Request
   * To send the _snap to roads_ queries you will use a `POST` request where the
   * request body will contain the `batchItems` array in `json` format and the
   * `Content-Type` header will be set to `application/json`. Here's a sample
   * request body containing 1 _snap to roads_ queries:
   *
   *
   * ```
   * {
   *   "batchItems": [
   *     {
   *       "optionalId": "bbc9c0f6-ab52-49d8-a788-a658fa654c94",
   *       "type": "FeatureCollection",
   *       "features": [
   *         {
   *           "type": "Feature",
   *           "geometry": {
   *             "type": "Point",
   *             "coordinates": [
   *               -122.336691,
   *               47.59085
   *             ]
   *           },
   *           "properties": {
   *           }
   *         },
   *         {
   *           "type": "Feature",
   *           "geometry": {
   *             "type": "Point",
   *             "coordinates": [
   *               -122.336023,
   *               47.601616
   *             ]
   *           },
   *           "properties": {
   *           }
   *         }
   *       ],
   *       "includeSpeedLimit": true,
   *       "travelMode": "driving"
   *     }
   *   ]
   * }
   * ```
   *
   * A _snap to roads_ batchItem object can accept any of the supported _snap to
   * roads_ [Request
   * body](/rest/api/maps/route/post-snap-to-roads?view=rest-maps-2025-01-01#request-body)
   *
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
   *   - [`SnapToRoadsResponse`](/rest/api/maps/route/post-snap-to-roads#response) -
   * If the query completed successfully.
   *
   *   - `Error` - If the query failed. The response will contain a `code` and a
   * `message` in this case.
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @route("/route/snapToRoads:batch")
  @post
  postSnapToRoadsBatch is MapsRouteOperation<
    {
      ...ContentTypeHeader<"application/geo+json">;
      ...AcceptLanguageHeader;

      /**
       * The list of Snap To Roads queries/requests to process. The list can contain a
       * max of 100 queries for sync version and must contain at least 1 query.
       */
      @bodyRoot
      snapToRoadsBatchRequest: SnapToRoadsBatchRequestBody;
    },
    SnapToRoadsBatchResponse
  >;

  /**
   * The Route Range API creates a polygon that depicts the area reachable from a
   * given location within a certain threshold based on the specified time or
   * distance budget. A polygon boundary (or Isochrone) is returned in a
   * counterclockwise orientation as well as the precise polygon center which was
   * the result of the origin point.
   *
   * The returned polygon can be used for spatial filtering to search for features
   * of interest within the provided Isochrone.
   *
   *
   *
   * For information about routing availability in countries/regions, see [Azure
   * Maps routing
   * coverage](https://learn.microsoft.com/azure/azure-maps/routing-coverage?pivots=latest).
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Reported due to response content-type. Needs fix: https://github.com/microsoft/typespec/issues/2853"
  @route("/route/range")
  @post
  postRouteRange is MapsRouteOperation<
    {
      ...ContentTypeHeader<"application/geo+json">;

      /**
       * Request body of RouteRange API in GeoJSON format.
       */
      @bodyRoot
      routeRangeRequest: RouteRangeRequest;
    },
    RouteRangeResponse &
      ContentTypeHeader<"application/geo+json" | "application/json">
  >;

  /**
   * The Route Range Batch API sends batches of up to **100** queries as a single
   * call to the [Route Range
   * API](https://learn.microsoft.com/rest/api/maps/route/post-route-range?view=rest-maps-2025-01-01).
   * This API enables efficient processing of multiple queries in one request,
   * reducing the need for individual calls.
   *
   * ### Submit Synchronous Batch Request
   * The Synchronous API is recommended for lightweight batch requests. When the
   * service receives a request, it will respond as soon as the batch items are
   * calculated and there will be no possibility to retrieve the results later. The
   * Synchronous API will return a timeout error (a 408 response) if the request
   * takes longer than 60 seconds. The number of batch items is limited to **100**
   * for this API.
   * ```
   * POST https://atlas.microsoft.com/route/range:batch?api-version=2025-01-01
   * ```
   * ### POST Body for Batch Request
   * To send the _route range_ queries you will use a `POST` request where the
   * request body will contain the `batchItems` array in `json` format and the
   * `Content-Type` header will be set to `application/json`. Here's a sample
   * request body containing 2 _route_range_ queries:
   *
   *
   * ```
   * {
   *   "batchItems": [
   *     {
   *       "optionalId": "bbc9c0f6-ab52-49d8-a788-a658fa654c94",
   *       "type": "Feature",
   *       "geometry": {
   *         "type": "Point",
   *         "coordinates": [
   *           5.86605,
   *           50.9745
   *         ]
   *       },
   *       "properties": {
   *         "timeBudgetInSec": 6000
   *       }
   *     },
   *     {
   *       "optionalId": "300af787-589b-4088-accd-56828542e293",
   *       "type": "Feature",
   *       "geometry": {
   *         "type": "Point",
   *         "coordinates": [
   *           -122.201669,
   *           47.615076
   *         ]
   *       },
   *       "properties": {
   *         "timeBudgetInSec": 2000
   *       }
   *     }
   *   ]
   * }
   * ```
   *
   * A _route range_ batchItem object can accept any of the supported _snap to
   * roads_ [Request
   * body](/rest/api/maps/route/post-snap-to-roads?view=rest-maps-2025-01-01#request-body)
   *
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
   *   - [`RouteRangeResponse`](/rest/api/maps/route/post-route-range#response) - If
   * the query completed successfully.
   *
   *   - `Error` - If the query failed. The response will contain a `code` and a
   * `message` in this case.
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @route("/route/range:batch")
  @post
  postRouteRangeBatch is MapsRouteOperation<
    {
      /**
       * The list of route directions queries/requests to process. The list can contain
       * a max of 100 queries for sync version and must contain at least 1 query.
       */
      @bodyRoot
      routeRangeBatchRequest: RouteRangeBatchRequestBody;
    },
    RouteRangeBatchResponse
  >;

  /**
   * The `Route Matrix` API is an HTTP `POST` request that allows calculation of a
   * matrix of route summaries for a set of routes defined by origin and destination
   * locations by using a sync request. For every given origin, the service
   * calculates the cost of routing from that origin to every given destination. The
   * set of origins and the set of destinations can be thought of as the column and
   * row headers of a table and each cell in the table contains the costs of routing
   * from the origin to the destination for that cell. Route Matrices can be
   * calculated for driving, walking and truck routes. For example, a food delivery
   * company has 20 drivers and they need to find the closest driver to pick up the
   * delivery from the restaurant. To solve this use case, they can call the Route
   * Matrix API and use the travel cost to sort the drivers by their actual travel
   * distance or time from the restaurant.
   *
   *
   * Route Matrices are used in several different types of applications, most
   * commonly to solve the Traveling Salesman Problem (TSP) and Vehicle Routing
   * Problem (VRP). For each origin-destination pair in the matrix, the travel time
   * and distance are returned. You can use the computed costs to determine which
   * detailed routes to calculate using the Route Directions API.
   *
   *
   * The maximum size of a matrix for sync request it's **2500** (the number of
   * origins multiplied by the number of destinations).
   *
   *
   *
   * ### Submit Synchronous Route Matrix Request
   * If your scenario requires synchronous requests and the maximum size of the
   * matrix is less than or equal to 2500, you might want to make synchronous
   * request. The maximum size of a matrix for this API is **2500** (the number of
   * origins multiplied by the number of destinations). With that constraint in
   * mind, examples of possible matrix dimensions are: 50x50, 60x40, 90x20 (it does
   * not need to be square).
   *
   *
   *
   * ### API Limitations
   *  The synchronous processing of matrix is best suited for fast, small matrices
   * of route calculation. To calculate larger matrices and heavy route calculation,
   * use the asynchronous endpoint. The following limitation is applicable to the
   * synchronous requests. If none of the rows in the following table match the
   * request's parameters, the request does not meet the requirements and will not
   * be processed.
   *
   * | Max matrix size | Max number of origins  | Max number of destinations |
   * Additional limits
   *
   * |------------------|------------------------|----------------------------|------------|
   * | 100              | 100         | 100              | N/A |
   * | 200              | 200         | 200              | All origins and
   * destinations should be contained in an axis-aligned 400 km x 400 km bounding
   * box. Otherwise, some matrix cells will be resolved as OUT_OF_REGION.  |
   * | 2500             | 1000        | 1000             | - `departAt` or
   * `arriveAt` must be any.<br> - `traffic` must be historical.<br> - `travelMode`
   * must be either driving or truck<br> - No other parameters can be used
   * explicitly   |
   *
   *
   * Examples:
   *  - Request of 10x20 matrix with `traffic=live`: This request will be processed
   * with a bounding box limit, as it matches a limit of up to 200, which includes
   * bounding box restrictions.
   *
   *  - Request of 10x20 matrix with default parameters (`traffic=historical`): This
   * request will be processed without a bounding box limit, as it matches a limit
   * of up to 2500, which does  not impose bounding box restrictions.
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @route("/route/matrix")
  @post
  postRouteMatrix is MapsRouteOperation<
    {
      ...ContentTypeHeader<"application/geo+json">;

      /**
       * Request body of RouteMatrix API in GeoJSON format.
       */
      @bodyRoot
      routeMatrixRequest: RouteMatrixRequest;
    },
    RouteMatrixResponse & ContentTypeHeader<"application/geo+json">
  >;

  /**
   * Get the status of an asynchronous operation by its operation ID.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @route("/route/operations/{id}")
  @get
  getRouteOperationsStatus is Foundations.Operation<
    {
      ...OperationIdPathParameter;
    },
    RouteOperation | (NotFoundResponse & MapsErrorResponse),
    {},
    MapsErrorResponse
  >;

  /**
   * Get the result of an asynchronous operation by its operation ID.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @route("/route/operations/{id}/result")
  @get
  getRouteOperationsResult is MapsRouteOperation<
    {
      ...AcceptLanguageHeader;
      ...OperationIdPathParameter;
    },
    RouteOperationResponse | (NotFoundResponse & MapsErrorResponse)
  >;

  /**
   * The `Route Matrix Async` API is an HTTP `POST` request that allows calculation
   * of a matrix of route summaries for a set of routes defined by origin and
   * destination locations by using an asynchronous (async) request. For every given
   * origin, the service calculates the cost of routing from that origin to every
   * given destination. The set of origins and the set of destinations can be
   * thought of as the column and row headers of a table and each cell in the table
   * contains the costs of routing from the origin to the destination for that cell.
   *  Route Matrices can be calculated for driving, walking and truck routes.
   *
   * Route Matrices are used in several different types of applications, most
   * commonly to solve the Traveling Salesman Problem (TSP) and Vehicle Routing
   * Problem (VRP). For each origin-destination pair in the matrix, the travel time
   * and distance are returned. You can use the computed costs to determine which
   * detailed routes to calculate using the Route Directions API.
   *
   *
   * The maximum size of a matrix for async request is **50000** (the number of
   * origins multiplied by the number of destinations).
   *
   *
   * ### Submit Asynchronous Route Matrix Request
   * The Asynchronous API is appropriate for processing big volumes of relatively
   * complex routing requests. When you make a request by using async request, by
   * default the service returns a 202 response code along a URL in the
   * `operation-Location` field of the response header with the Azure Maps geography
   * endpoint {geography}.atlas.microsoft.com. This URL should be checked
   * periodically until the status is Succeeded.
   *
   *
   * The maximum size of a matrix for this API is **50000** (the number of origins
   * multiplied by the number of destinations). With that constraint in mind,
   * examples of possible matrix dimensions are: 500x100, 100x100, 280x170. 100x50
   * (it does not need to be square).
   *
   *
   * The asynchronous responses are stored for **24** hours. The redirect URL
   * returns a 404 response if used after the expiration period.
   *
   *
   *
   *
   * ```
   * POST
   * https://atlas.microsoft.com/route/matrix:async?api-version=2025-01-01&subscription-key={subscription-key}
   * ```
   *
   * Here's a typical sequence of asynchronous operations:
   * 1. Client sends a Route Matrix POST request to Azure Maps
   *
   * 2. The server will respond with one of the following:
   *
   *     > HTTP `202 Accepted` -  Route Matrix request has been accepted.
   *
   *     > HTTP `Error` - There was an error processing your Route Matrix request.
   * This could either be a 400 Bad Request or any other Error status code.
   *
   *
   * 3. If the Matrix Route request was accepted successfully, the
   * `operation-location` header in the response contains the URL to get the status
   * of the request. This status URI looks like the following:
   *
   *   ```
   *     GET
   * https://atlas.microsoft.com/route/operations/{id}?api-version=2025-01-01?subscription-key={subscription-key}
   *   ```
   *
   *
   * 4. Client issues a GET request on the resultUrl obtained in Step 3 to get the
   * results
   *
   *
   *
   *   ```
   *     GET
   * https://atlas.microsoft.com/route/operations/{id}/result?api-version=2025-01-01?subscription-key={subscription-key}
   *    ```
   *
   *
   *
   *  ### API Limitations
   *  The asynchronous processing of matrix is best suited for larger matrices that
   * require heavy route calculation. The following limitation is applicable to the
   * asynchronous requests. If none of the rows in the following table match the
   * request's parameters, the request does not meet the requirements and will not
   * be processed.
   *
   *  | Max matrix size  | Max number of origins | Max number of destinations  |
   * Additional limits |
   *
   * |------------------|-----------------------|-----------------------------|-------------------|
   * | 2500             | 1000                  | 1000                        | All
   * origins and destinations should be contained in an axis-aligned 400 km x 400 km
   * bounding box. Otherwise some matrix cells will be resolved as OUT_OF_REGION.  |
   * | 50,000           | 10,000                | 10,000                      | -
   * `departAt` or `arriveAt` must be any.<br>- `traffic` must be historical.<br/>-
   * `optimizeRoute` must be fastest.<br/>- `travelMode` must be
   * either driving or truck. <br/>- No other parameters can be used explicitly.  |
   *
   *
   *
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API contract"
  @route("/route/matrix:async")
  @post
  @pollingOperation(Route.getRouteOperationsStatus)
  @finalOperation(Route.getRouteOperationsResult)
  postRouteMatrixAsync is Foundations.LongRunningOperation<
    {
      ...ContentTypeHeader<"application/geo+json">;
      ...ClientIdHeader;

      /**
       * Request body of RouteMatrix API in GeoJSON format.
       */
      @bodyRoot
      routeMatrixAsyncRequest: RouteMatrixAsyncRequest;
    },
    AcceptedResponse,
    {},
    MapsErrorResponse
  >;
}
