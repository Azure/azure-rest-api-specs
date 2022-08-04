import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualApplianceSkus } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  NetworkVirtualApplianceSku,
  VirtualApplianceSkusListNextOptionalParams,
  VirtualApplianceSkusListOptionalParams,
  VirtualApplianceSkusListResponse,
  VirtualApplianceSkusGetOptionalParams,
  VirtualApplianceSkusGetResponse,
  VirtualApplianceSkusListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualApplianceSkus operations. */
export class VirtualApplianceSkusImpl implements VirtualApplianceSkus {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualApplianceSkus class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * List all SKUs available for a virtual appliance.
   * @param options The options parameters.
   */
  public list(
    options?: VirtualApplianceSkusListOptionalParams
  ): PagedAsyncIterableIterator<NetworkVirtualApplianceSku> {
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
    options?: VirtualApplianceSkusListOptionalParams
  ): AsyncIterableIterator<NetworkVirtualApplianceSku[]> {
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
    options?: VirtualApplianceSkusListOptionalParams
  ): AsyncIterableIterator<NetworkVirtualApplianceSku> {
    for await (const page of this.listPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * List all SKUs available for a virtual appliance.
   * @param options The options parameters.
   */
  private _list(
    options?: VirtualApplianceSkusListOptionalParams
  ): Promise<VirtualApplianceSkusListResponse> {
    return this.client.sendOperationRequest({ options }, listOperationSpec);
  }

  /**
   * Retrieves a single available sku for network virtual appliance.
   * @param skuName Name of the Sku.
   * @param options The options parameters.
   */
  get(
    skuName: string,
    options?: VirtualApplianceSkusGetOptionalParams
  ): Promise<VirtualApplianceSkusGetResponse> {
    return this.client.sendOperationRequest(
      { skuName, options },
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
    options?: VirtualApplianceSkusListNextOptionalParams
  ): Promise<VirtualApplianceSkusListNextResponse> {
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkVirtualApplianceSkus",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkVirtualApplianceSkuListResult
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
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkVirtualApplianceSkus/{skuName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkVirtualApplianceSku
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.skuName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkVirtualApplianceSkuListResult
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
