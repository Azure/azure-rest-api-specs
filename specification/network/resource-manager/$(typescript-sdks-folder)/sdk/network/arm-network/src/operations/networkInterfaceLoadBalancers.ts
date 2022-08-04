import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkInterfaceLoadBalancers } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  LoadBalancer,
  NetworkInterfaceLoadBalancersListNextOptionalParams,
  NetworkInterfaceLoadBalancersListOptionalParams,
  NetworkInterfaceLoadBalancersListResponse,
  NetworkInterfaceLoadBalancersListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkInterfaceLoadBalancers operations. */
export class NetworkInterfaceLoadBalancersImpl
  implements NetworkInterfaceLoadBalancers {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkInterfaceLoadBalancers class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * List all load balancers in a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceLoadBalancersListOptionalParams
  ): PagedAsyncIterableIterator<LoadBalancer> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkInterfaceName,
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
          networkInterfaceName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceLoadBalancersListOptionalParams
  ): AsyncIterableIterator<LoadBalancer[]> {
    let result = await this._list(
      resourceGroupName,
      networkInterfaceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkInterfaceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceLoadBalancersListOptionalParams
  ): AsyncIterableIterator<LoadBalancer> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkInterfaceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * List all load balancers in a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfaceLoadBalancersListOptionalParams
  ): Promise<NetworkInterfaceLoadBalancersListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkInterfaceName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkInterfaceName: string,
    nextLink: string,
    options?: NetworkInterfaceLoadBalancersListNextOptionalParams
  ): Promise<NetworkInterfaceLoadBalancersListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkInterfaceName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/loadBalancers",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceLoadBalancerListResult
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
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceLoadBalancerListResult
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
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
