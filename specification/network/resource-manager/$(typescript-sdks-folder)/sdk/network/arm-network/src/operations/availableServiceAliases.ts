import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AvailableServiceAliases } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  AvailableServiceAlias,
  AvailableServiceAliasesListNextOptionalParams,
  AvailableServiceAliasesListOptionalParams,
  AvailableServiceAliasesListByResourceGroupNextOptionalParams,
  AvailableServiceAliasesListByResourceGroupOptionalParams,
  AvailableServiceAliasesListResponse,
  AvailableServiceAliasesListByResourceGroupResponse,
  AvailableServiceAliasesListNextResponse,
  AvailableServiceAliasesListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AvailableServiceAliases operations. */
export class AvailableServiceAliasesImpl implements AvailableServiceAliases {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AvailableServiceAliases class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all available service aliases for this subscription in this region.
   * @param location The location.
   * @param options The options parameters.
   */
  public list(
    location: string,
    options?: AvailableServiceAliasesListOptionalParams
  ): PagedAsyncIterableIterator<AvailableServiceAlias> {
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
    options?: AvailableServiceAliasesListOptionalParams
  ): AsyncIterableIterator<AvailableServiceAlias[]> {
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
    options?: AvailableServiceAliasesListOptionalParams
  ): AsyncIterableIterator<AvailableServiceAlias> {
    for await (const page of this.listPagingPage(location, options)) {
      yield* page;
    }
  }

  /**
   * Gets all available service aliases for this resource group in this region.
   * @param resourceGroupName The name of the resource group.
   * @param location The location.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    location: string,
    options?: AvailableServiceAliasesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<AvailableServiceAlias> {
    const iter = this.listByResourceGroupPagingAll(
      resourceGroupName,
      location,
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
        return this.listByResourceGroupPagingPage(
          resourceGroupName,
          location,
          options
        );
      }
    };
  }

  private async *listByResourceGroupPagingPage(
    resourceGroupName: string,
    location: string,
    options?: AvailableServiceAliasesListByResourceGroupOptionalParams
  ): AsyncIterableIterator<AvailableServiceAlias[]> {
    let result = await this._listByResourceGroup(
      resourceGroupName,
      location,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByResourceGroupNext(
        resourceGroupName,
        location,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByResourceGroupPagingAll(
    resourceGroupName: string,
    location: string,
    options?: AvailableServiceAliasesListByResourceGroupOptionalParams
  ): AsyncIterableIterator<AvailableServiceAlias> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      location,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all available service aliases for this subscription in this region.
   * @param location The location.
   * @param options The options parameters.
   */
  private _list(
    location: string,
    options?: AvailableServiceAliasesListOptionalParams
  ): Promise<AvailableServiceAliasesListResponse> {
    return this.client.sendOperationRequest(
      { location, options },
      listOperationSpec
    );
  }

  /**
   * Gets all available service aliases for this resource group in this region.
   * @param resourceGroupName The name of the resource group.
   * @param location The location.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    location: string,
    options?: AvailableServiceAliasesListByResourceGroupOptionalParams
  ): Promise<AvailableServiceAliasesListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, location, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * ListNext
   * @param location The location.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    location: string,
    nextLink: string,
    options?: AvailableServiceAliasesListNextOptionalParams
  ): Promise<AvailableServiceAliasesListNextResponse> {
    return this.client.sendOperationRequest(
      { location, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The name of the resource group.
   * @param location The location.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    location: string,
    nextLink: string,
    options?: AvailableServiceAliasesListByResourceGroupNextOptionalParams
  ): Promise<AvailableServiceAliasesListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, location, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/availableServiceAliases",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AvailableServiceAliasesResult
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
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/locations/{location}/availableServiceAliases",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AvailableServiceAliasesResult
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
      bodyMapper: Mappers.AvailableServiceAliasesResult
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
const listByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AvailableServiceAliasesResult
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
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
