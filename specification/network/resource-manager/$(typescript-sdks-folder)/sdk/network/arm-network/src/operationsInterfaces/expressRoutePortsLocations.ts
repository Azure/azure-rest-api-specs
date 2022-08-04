import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  ExpressRoutePortsLocation,
  ExpressRoutePortsLocationsListOptionalParams,
  ExpressRoutePortsLocationsGetOptionalParams,
  ExpressRoutePortsLocationsGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ExpressRoutePortsLocations. */
export interface ExpressRoutePortsLocations {
  /**
   * Retrieves all ExpressRoutePort peering locations. Does not return available bandwidths for each
   * location. Available bandwidths can only be obtained when retrieving a specific peering location.
   * @param options The options parameters.
   */
  list(
    options?: ExpressRoutePortsLocationsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRoutePortsLocation>;
  /**
   * Retrieves a single ExpressRoutePort peering location, including the list of available bandwidths
   * available at said peering location.
   * @param locationName Name of the requested ExpressRoutePort peering location.
   * @param options The options parameters.
   */
  get(
    locationName: string,
    options?: ExpressRoutePortsLocationsGetOptionalParams
  ): Promise<ExpressRoutePortsLocationsGetResponse>;
}
