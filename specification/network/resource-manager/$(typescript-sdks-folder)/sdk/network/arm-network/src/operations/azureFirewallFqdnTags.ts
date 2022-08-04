import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { AzureFirewallFqdnTags } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  AzureFirewallFqdnTag,
  AzureFirewallFqdnTagsListAllNextOptionalParams,
  AzureFirewallFqdnTagsListAllOptionalParams,
  AzureFirewallFqdnTagsListAllResponse,
  AzureFirewallFqdnTagsListAllNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing AzureFirewallFqdnTags operations. */
export class AzureFirewallFqdnTagsImpl implements AzureFirewallFqdnTags {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class AzureFirewallFqdnTags class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all the Azure Firewall FQDN Tags in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: AzureFirewallFqdnTagsListAllOptionalParams
  ): PagedAsyncIterableIterator<AzureFirewallFqdnTag> {
    const iter = this.listAllPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listAllPagingPage(options);
      }
    };
  }

  private async *listAllPagingPage(
    options?: AzureFirewallFqdnTagsListAllOptionalParams
  ): AsyncIterableIterator<AzureFirewallFqdnTag[]> {
    let result = await this._listAll(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAllNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAllPagingAll(
    options?: AzureFirewallFqdnTagsListAllOptionalParams
  ): AsyncIterableIterator<AzureFirewallFqdnTag> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all the Azure Firewall FQDN Tags in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: AzureFirewallFqdnTagsListAllOptionalParams
  ): Promise<AzureFirewallFqdnTagsListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: AzureFirewallFqdnTagsListAllNextOptionalParams
  ): Promise<AzureFirewallFqdnTagsListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/azureFirewallFqdnTags",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewallFqdnTagListResult
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
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.AzureFirewallFqdnTagListResult
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
