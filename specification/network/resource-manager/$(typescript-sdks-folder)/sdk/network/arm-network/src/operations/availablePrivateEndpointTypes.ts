import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AvailablePrivateEndpointTypes } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  AvailablePrivateEndpointType,
  AvailablePrivateEndpointTypesListNextOptionalParams,
  AvailablePrivateEndpointTypesListOptionalParams,
  AvailablePrivateEndpointTypesListByResourceGroupNextOptionalParams,
  AvailablePrivateEndpointTypesListByResourceGroupOptionalParams,
  AvailablePrivateEndpointTypesListResponse,
  AvailablePrivateEndpointTypesListByResourceGroupResponse,
  AvailablePrivateEndpointTypesListNextResponse,
  AvailablePrivateEndpointTypesListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AvailablePrivateEndpointTypes operations. */
export class AvailablePrivateEndpointTypesImpl
  implements AvailablePrivateEndpointTypes {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AvailablePrivateEndpointTypes class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in
   * this region.
   * @param location The location of the domain name.
   * @param options The options parameters.
   */
  public list(
    location: string,
    options?: AvailablePrivateEndpointTypesListOptionalParams
  ): PagedAsyncIterableIterator<AvailablePrivateEndpointType> {
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
    options?: AvailablePrivateEndpointTypesListOptionalParams
  ): AsyncIterableIterator<AvailablePrivateEndpointType[]> {
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
    options?: AvailablePrivateEndpointTypesListOptionalParams
  ): AsyncIterableIterator<AvailablePrivateEndpointType> {
    for await (const page of this.listPagingPage(location, options)) {
      yield* page;
    }
  }

  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in
   * this region.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    location: string,
    resourceGroupName: string,
    options?: AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<AvailablePrivateEndpointType> {
    const iter = this.listByResourceGroupPagingAll(
      location,
      resourceGroupName,
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
          location,
          resourceGroupName,
          options
        );
      }
    };
  }

  private async *listByResourceGroupPagingPage(
    location: string,
    resourceGroupName: string,
    options?: AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
  ): AsyncIterableIterator<AvailablePrivateEndpointType[]> {
    let result = await this._listByResourceGroup(
      location,
      resourceGroupName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByResourceGroupNext(
        location,
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByResourceGroupPagingAll(
    location: string,
    resourceGroupName: string,
    options?: AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
  ): AsyncIterableIterator<AvailablePrivateEndpointType> {
    for await (const page of this.listByResourceGroupPagingPage(
      location,
      resourceGroupName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in
   * this region.
   * @param location The location of the domain name.
   * @param options The options parameters.
   */
  private _list(
    location: string,
    options?: AvailablePrivateEndpointTypesListOptionalParams
  ): Promise<AvailablePrivateEndpointTypesListResponse> {
    return this.client.sendOperationRequest(
      { location, options },
      listOperationSpec
    );
  }

  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in
   * this region.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    location: string,
    resourceGroupName: string,
    options?: AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
  ): Promise<AvailablePrivateEndpointTypesListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { location, resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * ListNext
   * @param location The location of the domain name.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    location: string,
    nextLink: string,
    options?: AvailablePrivateEndpointTypesListNextOptionalParams
  ): Promise<AvailablePrivateEndpointTypesListNextResponse> {
    return this.client.sendOperationRequest(
      { location, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListByResourceGroupNext
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    location: string,
    resourceGroupName: string,
    nextLink: string,
    options?: AvailablePrivateEndpointTypesListByResourceGroupNextOptionalParams
  ): Promise<AvailablePrivateEndpointTypesListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { location, resourceGroupName, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/availablePrivateEndpointTypes",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AvailablePrivateEndpointTypesResult
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/locations/{location}/availablePrivateEndpointTypes",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AvailablePrivateEndpointTypesResult
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
      bodyMapper: Mappers.AvailablePrivateEndpointTypesResult
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
      bodyMapper: Mappers.AvailablePrivateEndpointTypesResult
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
