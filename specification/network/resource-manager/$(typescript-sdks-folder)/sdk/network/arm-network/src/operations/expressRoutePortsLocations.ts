import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRoutePortsLocations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ExpressRoutePortsLocation,
  ExpressRoutePortsLocationsListNextOptionalParams,
  ExpressRoutePortsLocationsListOptionalParams,
  ExpressRoutePortsLocationsListResponse,
  ExpressRoutePortsLocationsGetOptionalParams,
  ExpressRoutePortsLocationsGetResponse,
  ExpressRoutePortsLocationsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRoutePortsLocations operations. */
export class ExpressRoutePortsLocationsImpl
  implements ExpressRoutePortsLocations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRoutePortsLocations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves all ExpressRoutePort peering locations. Does not return available bandwidths for each
   * location. Available bandwidths can only be obtained when retrieving a specific peering location.
   * @param options The options parameters.
   */
  public list(
    options?: ExpressRoutePortsLocationsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRoutePortsLocation> {
    const iter = this.listPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(options);
      }
    };
  }

  private async *listPagingPage(
    options?: ExpressRoutePortsLocationsListOptionalParams
  ): AsyncIterableIterator<ExpressRoutePortsLocation[]> {
    let result = await this._list(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    options?: ExpressRoutePortsLocationsListOptionalParams
  ): AsyncIterableIterator<ExpressRoutePortsLocation> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Retrieves all ExpressRoutePort peering locations. Does not return available bandwidths for each
   * location. Available bandwidths can only be obtained when retrieving a specific peering location.
   * @param options The options parameters.
   */
  private _list(
    options?: ExpressRoutePortsLocationsListOptionalParams
  ): Promise<ExpressRoutePortsLocationsListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Retrieves a single ExpressRoutePort peering location, including the list of available bandwidths
   * available at said peering location.
   * @param locationName Name of the requested ExpressRoutePort peering location.
   * @param options The options parameters.
   */
  get(
    locationName: string,
    options?: ExpressRoutePortsLocationsGetOptionalParams
  ): Promise<ExpressRoutePortsLocationsGetResponse> {
    return this.client.sendOperationRequest(
      { locationName, options },
      getOperationSpec
    );
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: ExpressRoutePortsLocationsListNextOptionalParams
  ): Promise<ExpressRoutePortsLocationsListNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/ExpressRoutePortsLocations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortsLocationListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/ExpressRoutePortsLocations/{locationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortsLocation
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.locationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRoutePortsLocationListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
