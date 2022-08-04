import {
  ExpressRouteProviderPortsLocationListOptionalParams,
  ExpressRouteProviderPortsLocationListResponse
} from "../models";

/** Interface representing a ExpressRouteProviderPortsLocation. */
export interface ExpressRouteProviderPortsLocation {
  /**
   * Retrieves all the ExpressRouteProviderPorts in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: ExpressRouteProviderPortsLocationListOptionalParams
  ): Promise<ExpressRouteProviderPortsLocationListResponse>;
}
