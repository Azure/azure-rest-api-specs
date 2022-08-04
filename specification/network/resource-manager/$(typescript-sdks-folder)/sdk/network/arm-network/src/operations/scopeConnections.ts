import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ScopeConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ScopeConnection,
  ScopeConnectionsListNextOptionalParams,
  ScopeConnectionsListOptionalParams,
  ScopeConnectionsCreateOrUpdateOptionalParams,
  ScopeConnectionsCreateOrUpdateResponse,
  ScopeConnectionsGetOptionalParams,
  ScopeConnectionsGetResponse,
  ScopeConnectionsDeleteOptionalParams,
  ScopeConnectionsListResponse,
  ScopeConnectionsListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ScopeConnections operations. */
export class ScopeConnectionsImpl implements ScopeConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ScopeConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * List all scope connections created by this network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: ScopeConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<ScopeConnection> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkManagerName,
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
          networkManagerName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkManagerName: string,
    options?: ScopeConnectionsListOptionalParams
  ): AsyncIterableIterator<ScopeConnection[]> {
    let result = await this._list(
      resourceGroupName,
      networkManagerName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkManagerName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkManagerName: string,
    options?: ScopeConnectionsListOptionalParams
  ): AsyncIterableIterator<ScopeConnection> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkManagerName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Creates or updates scope connection from Network Manager
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param scopeConnectionName Name for the cross-tenant connection.
   * @param parameters Scope connection to be created/updated.
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    scopeConnectionName: string,
    parameters: ScopeConnection,
    options?: ScopeConnectionsCreateOrUpdateOptionalParams
  ): Promise<ScopeConnectionsCreateOrUpdateResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        networkManagerName,
        scopeConnectionName,
        parameters,
        options
      },
      createOrUpdateOperationSpec
    );
  }

  /**
   * Get specified scope connection created by this Network Manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param scopeConnectionName Name for the cross-tenant connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    scopeConnectionName: string,
    options?: ScopeConnectionsGetOptionalParams
  ): Promise<ScopeConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, scopeConnectionName, options },
      getOperationSpec
    );
  }

  /**
   * Delete the pending scope connection created by this network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param scopeConnectionName Name for the cross-tenant connection.
   * @param options The options parameters.
   */
  delete(
    resourceGroupName: string,
    networkManagerName: string,
    scopeConnectionName: string,
    options?: ScopeConnectionsDeleteOptionalParams
  ): Promise<void> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, scopeConnectionName, options },
      deleteOperationSpec
    );
  }

  /**
   * List all scope connections created by this network manager.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkManagerName: string,
    options?: ScopeConnectionsListOptionalParams
  ): Promise<ScopeConnectionsListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkManagerName: string,
    nextLink: string,
    options?: ScopeConnectionsListNextOptionalParams
  ): Promise<ScopeConnectionsListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ScopeConnection
    },
    201: {
      bodyMapper: Mappers.ScopeConnection
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters36,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.scopeConnectionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ScopeConnection
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
    Parameters.networkManagerName,
    Parameters.scopeConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/scopeConnections/{scopeConnectionName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName,
    Parameters.scopeConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/scopeConnections",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ScopeConnectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ScopeConnectionListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [
    Parameters.apiVersion,
    Parameters.top,
    Parameters.skipToken
  ],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
