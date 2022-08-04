import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AvailableEndpointServices } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  EndpointServiceResult,
  AvailableEndpointServicesListNextOptionalParams,
  AvailableEndpointServicesListOptionalParams,
  AvailableEndpointServicesListResponse,
  AvailableEndpointServicesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AvailableEndpointServices operations. */
export class AvailableEndpointServicesImpl
  implements AvailableEndpointServices {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AvailableEndpointServices class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * List what values of endpoint services are available for use.
   * @param location The location to check available endpoint services.
   * @param options The options parameters.
   */
  public list(
    location: string,
    options?: AvailableEndpointServicesListOptionalParams
  ): PagedAsyncIterableIterator<EndpointServiceResult> {
    const iter = this.listPagingAll(location, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(location, options);
      }
    };
  }

  private async *listPagingPage(
    location: string,
    options?: AvailableEndpointServicesListOptionalParams
  ): AsyncIterableIterator<EndpointServiceResult[]> {
    let result = await this._list(location, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(location, continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    location: string,
    options?: AvailableEndpointServicesListOptionalParams
  ): AsyncIterableIterator<EndpointServiceResult> {
    for await (const page of this.listPagingPage(location, options)) {
      yield* page;
    }
  }

  /**
   * List what values of endpoint services are available for use.
   * @param location The location to check available endpoint services.
   * @param options The options parameters.
   */
  private _list(
    location: string,
    options?: AvailableEndpointServicesListOptionalParams
  ): Promise<AvailableEndpointServicesListResponse> {
    return this.client.sendOperationRequest(
      { location, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param location The location to check available endpoint services.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    location: string,
    nextLink: string,
    options?: AvailableEndpointServicesListNextOptionalParams
  ): Promise<AvailableEndpointServicesListNextResponse> {
    return this.client.sendOperationRequest(
      { location, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/virtualNetworkAvailableEndpointServices",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EndpointServicesListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.EndpointServicesListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
