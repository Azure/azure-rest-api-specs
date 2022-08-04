import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ExpressRouteLinks } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ExpressRouteLink,
  ExpressRouteLinksListNextOptionalParams,
  ExpressRouteLinksListOptionalParams,
  ExpressRouteLinksGetOptionalParams,
  ExpressRouteLinksGetResponse,
  ExpressRouteLinksListResponse,
  ExpressRouteLinksListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ExpressRouteLinks operations. */
export class ExpressRouteLinksImpl implements ExpressRouteLinks {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteLinks class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieve the ExpressRouteLink sub-resources of the specified ExpressRoutePort resource.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the ExpressRoutePort resource.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRouteLinksListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteLink> {
    const iter = this.listPagingAll(
      resourceGroupName,
      expressRoutePortName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(
          resourceGroupName,
          expressRoutePortName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRouteLinksListOptionalParams
  ): AsyncIterableIterator<ExpressRouteLink[]> {
    let result = await this._list(
      resourceGroupName,
      expressRoutePortName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        expressRoutePortName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRouteLinksListOptionalParams
  ): AsyncIterableIterator<ExpressRouteLink> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      expressRoutePortName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the specified ExpressRouteLink resource.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the ExpressRoutePort resource.
   * @param linkName The name of the ExpressRouteLink resource.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    expressRoutePortName: string,
    linkName: string,
    options?: ExpressRouteLinksGetOptionalParams
  ): Promise<ExpressRouteLinksGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRoutePortName, linkName, options },
      getOperationSpec
    );
  }

  /**
   * Retrieve the ExpressRouteLink sub-resources of the specified ExpressRoutePort resource.
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the ExpressRoutePort resource.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    expressRoutePortName: string,
    options?: ExpressRouteLinksListOptionalParams
  ): Promise<ExpressRouteLinksListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRoutePortName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param expressRoutePortName The name of the ExpressRoutePort resource.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    expressRoutePortName: string,
    nextLink: string,
    options?: ExpressRouteLinksListNextOptionalParams
  ): Promise<ExpressRouteLinksListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRoutePortName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ExpressRoutePorts/{expressRoutePortName}/links/{linkName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteLink
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.expressRoutePortName,
    Parameters.linkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ExpressRoutePorts/{expressRoutePortName}/links",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteLinkListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteLinkListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.expressRoutePortName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
