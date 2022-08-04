import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VpnSiteLinks } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  VpnSiteLink,
  VpnSiteLinksListByVpnSiteNextOptionalParams,
  VpnSiteLinksListByVpnSiteOptionalParams,
  VpnSiteLinksGetOptionalParams,
  VpnSiteLinksGetResponse,
  VpnSiteLinksListByVpnSiteResponse,
  VpnSiteLinksListByVpnSiteNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VpnSiteLinks operations. */
export class VpnSiteLinksImpl implements VpnSiteLinks {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VpnSiteLinks class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all the vpnSiteLinks in a resource group for a vpn site.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite.
   * @param options The options parameters.
   */
  public listByVpnSite(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSiteLinksListByVpnSiteOptionalParams
  ): PagedAsyncIterableIterator<VpnSiteLink> {
    const iter = this.listByVpnSitePagingAll(
      resourceGroupName,
      vpnSiteName,
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
        return this.listByVpnSitePagingPage(
          resourceGroupName,
          vpnSiteName,
          options
        );
      }
    };
  }

  private async *listByVpnSitePagingPage(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSiteLinksListByVpnSiteOptionalParams
  ): AsyncIterableIterator<VpnSiteLink[]> {
    let result = await this._listByVpnSite(
      resourceGroupName,
      vpnSiteName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByVpnSiteNext(
        resourceGroupName,
        vpnSiteName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByVpnSitePagingAll(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSiteLinksListByVpnSiteOptionalParams
  ): AsyncIterableIterator<VpnSiteLink> {
    for await (const page of this.listByVpnSitePagingPage(
      resourceGroupName,
      vpnSiteName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Retrieves the details of a VPN site link.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite.
   * @param vpnSiteLinkName The name of the VpnSiteLink being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    vpnSiteName: string,
    vpnSiteLinkName: string,
    options?: VpnSiteLinksGetOptionalParams
  ): Promise<VpnSiteLinksGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, vpnSiteName, vpnSiteLinkName, options },
      getOperationSpec
    );
  }

  /**
   * Lists all the vpnSiteLinks in a resource group for a vpn site.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite.
   * @param options The options parameters.
   */
  private _listByVpnSite(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSiteLinksListByVpnSiteOptionalParams
  ): Promise<VpnSiteLinksListByVpnSiteResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, vpnSiteName, options },
      listByVpnSiteOperationSpec
    );
  }

  /**
   * ListByVpnSiteNext
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite.
   * @param nextLink The nextLink from the previous successful call to the ListByVpnSite method.
   * @param options The options parameters.
   */
  private _listByVpnSiteNext(
    resourceGroupName: string,
    vpnSiteName: string,
    nextLink: string,
    options?: VpnSiteLinksListByVpnSiteNextOptionalParams
  ): Promise<VpnSiteLinksListByVpnSiteNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, vpnSiteName, nextLink, options },
      listByVpnSiteNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnSites/{vpnSiteName}/vpnSiteLinks/{vpnSiteLinkName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VpnSiteLink
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
    Parameters.vpnSiteName,
    Parameters.vpnSiteLinkName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVpnSiteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnSites/{vpnSiteName}/vpnSiteLinks",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnSiteLinksResult
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
    Parameters.vpnSiteName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByVpnSiteNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ListVpnSiteLinksResult
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
    Parameters.vpnSiteName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
