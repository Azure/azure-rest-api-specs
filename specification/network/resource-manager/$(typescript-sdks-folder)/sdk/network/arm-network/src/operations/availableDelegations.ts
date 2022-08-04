import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AvailableDelegations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  AvailableDelegation,
  AvailableDelegationsListNextOptionalParams,
  AvailableDelegationsListOptionalParams,
  AvailableDelegationsListResponse,
  AvailableDelegationsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AvailableDelegations operations. */
export class AvailableDelegationsImpl implements AvailableDelegations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AvailableDelegations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all of the available subnet delegations for this subscription in this region.
   * @param location The location of the subnet.
   * @param options The options parameters.
   */
  public list(
    location: string,
    options?: AvailableDelegationsListOptionalParams
  ): PagedAsyncIterableIterator<AvailableDelegation> {
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
    options?: AvailableDelegationsListOptionalParams
  ): AsyncIterableIterator<AvailableDelegation[]> {
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
    options?: AvailableDelegationsListOptionalParams
  ): AsyncIterableIterator<AvailableDelegation> {
    for await (const page of this.listPagingPage(location, options)) {
      yield* page;
    }
  }

  /**
   * Gets all of the available subnet delegations for this subscription in this region.
   * @param location The location of the subnet.
   * @param options The options parameters.
   */
  private _list(
    location: string,
    options?: AvailableDelegationsListOptionalParams
  ): Promise<AvailableDelegationsListResponse> {
    return this.client.sendOperationRequest(
      { location, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param location The location of the subnet.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    location: string,
    nextLink: string,
    options?: AvailableDelegationsListNextOptionalParams
  ): Promise<AvailableDelegationsListNextResponse> {
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/availableDelegations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AvailableDelegationsResult
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
      bodyMapper: Mappers.AvailableDelegationsResult
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
