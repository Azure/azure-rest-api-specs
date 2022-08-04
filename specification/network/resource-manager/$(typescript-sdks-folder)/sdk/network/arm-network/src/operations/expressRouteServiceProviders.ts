import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteServiceProviders } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ExpressRouteServiceProvider,
  ExpressRouteServiceProvidersListNextOptionalParams,
  ExpressRouteServiceProvidersListOptionalParams,
  ExpressRouteServiceProvidersListResponse,
  ExpressRouteServiceProvidersListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteServiceProviders operations. */
export class ExpressRouteServiceProvidersImpl
  implements ExpressRouteServiceProviders {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteServiceProviders class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the available express route service providers.
   * @param options The options parameters.
   */
  public list(
    options?: ExpressRouteServiceProvidersListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteServiceProvider> {
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
    options?: ExpressRouteServiceProvidersListOptionalParams
  ): AsyncIterableIterator<ExpressRouteServiceProvider[]> {
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
    options?: ExpressRouteServiceProvidersListOptionalParams
  ): AsyncIterableIterator<ExpressRouteServiceProvider> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all the available express route service providers.
   * @param options The options parameters.
   */
  private _list(
    options?: ExpressRouteServiceProvidersListOptionalParams
  ): Promise<ExpressRouteServiceProvidersListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * ListNext
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    nextLink: string,
    options?: ExpressRouteServiceProvidersListNextOptionalParams
  ): Promise<ExpressRouteServiceProvidersListNextResponse> {
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/expressRouteServiceProviders",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteServiceProviderListResult
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
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteServiceProviderListResult
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
