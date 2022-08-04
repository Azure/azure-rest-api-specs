import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { WebCategories } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  AzureWebCategory,
  WebCategoriesListBySubscriptionNextOptionalParams,
  WebCategoriesListBySubscriptionOptionalParams,
  WebCategoriesGetOptionalParams,
  WebCategoriesGetResponse,
  WebCategoriesListBySubscriptionResponse,
  WebCategoriesListBySubscriptionNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing WebCategories operations. */
export class WebCategoriesImpl implements WebCategories {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class WebCategories class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the Azure Web Categories in a subscription.
   * @param options The options parameters.
   */
  public listBySubscription(
    options?: WebCategoriesListBySubscriptionOptionalParams
  ): PagedAsyncIterableIterator<AzureWebCategory> {
    const iter = this.listBySubscriptionPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listBySubscriptionPagingPage(options);
      }
    };
  }

  private async *listBySubscriptionPagingPage(
    options?: WebCategoriesListBySubscriptionOptionalParams
  ): AsyncIterableIterator<AzureWebCategory[]> {
    let result = await this._listBySubscription(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listBySubscriptionNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listBySubscriptionPagingAll(
    options?: WebCategoriesListBySubscriptionOptionalParams
  ): AsyncIterableIterator<AzureWebCategory> {
    for await (const page of this.listBySubscriptionPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets the specified Azure Web Category.
   * @param name The name of the azureWebCategory.
   * @param options The options parameters.
   */
  get(
    name: string,
    options?: WebCategoriesGetOptionalParams
  ): Promise<WebCategoriesGetResponse> {
    return this.client.sendOperationRequest(
      { name, options },
      getOperationSpec
    );
  }

  /**
   * Gets all the Azure Web Categories in a subscription.
   * @param options The options parameters.
   */
  private _listBySubscription(
    options?: WebCategoriesListBySubscriptionOptionalParams
  ): Promise<WebCategoriesListBySubscriptionResponse> {
    return this.client.sendOperationRequest(
      { options },
      listBySubscriptionOperationSpec
    );
  }

  /**
   * ListBySubscriptionNext
   * @param nextLink The nextLink from the previous successful call to the ListBySubscription method.
   * @param options The options parameters.
   */
  private _listBySubscriptionNext(
    nextLink: string,
    options?: WebCategoriesListBySubscriptionNextOptionalParams
  ): Promise<WebCategoriesListBySubscriptionNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listBySubscriptionNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/azureWebCategories/{name}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureWebCategory
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [Parameters.$host, Parameters.subscriptionId, Parameters.name],
  headerParameters: [Parameters.accept],
  serializer
};
const listBySubscriptionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/azureWebCategories",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureWebCategoryListResult
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
const listBySubscriptionNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureWebCategoryListResult
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
