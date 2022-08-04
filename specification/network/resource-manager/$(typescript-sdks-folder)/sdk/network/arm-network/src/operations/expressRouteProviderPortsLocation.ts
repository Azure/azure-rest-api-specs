import { ExpressRouteProviderPortsLocation } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ExpressRouteProviderPortsLocationListOptionalParams,
  ExpressRouteProviderPortsLocationListResponse
} from "../models";

/** Class containing ExpressRouteProviderPortsLocation operations. */
export class ExpressRouteProviderPortsLocationImpl
  implements ExpressRouteProviderPortsLocation {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteProviderPortsLocation class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves all the ExpressRouteProviderPorts in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: ExpressRouteProviderPortsLocationListOptionalParams
  ): Promise<ExpressRouteProviderPortsLocationListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/expressRouteProviderPorts",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteProviderPortListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.filter],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
