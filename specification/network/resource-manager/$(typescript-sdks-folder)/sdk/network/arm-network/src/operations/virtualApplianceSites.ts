import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { VirtualApplianceSites } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VirtualApplianceSite,
  VirtualApplianceSitesListNextOptionalParams,
  VirtualApplianceSitesListOptionalParams,
  VirtualApplianceSitesDeleteOptionalParams,
  VirtualApplianceSitesGetOptionalParams,
  VirtualApplianceSitesGetResponse,
  VirtualApplianceSitesCreateOrUpdateOptionalParams,
  VirtualApplianceSitesCreateOrUpdateResponse,
  VirtualApplianceSitesListResponse,
  VirtualApplianceSitesListNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing VirtualApplianceSites operations. */
export class VirtualApplianceSitesImpl implements VirtualApplianceSites {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VirtualApplianceSites class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists all Network Virtual Appliance Sites in a Network Virtual Appliance resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: VirtualApplianceSitesListOptionalParams
  ): PagedAsyncIterableIterator<VirtualApplianceSite> {
    const iter = this.listPagingAll(
      resourceGroupName,
      networkVirtualApplianceName,
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
          networkVirtualApplianceName,
          options
        );
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: VirtualApplianceSitesListOptionalParams
  ): AsyncIterableIterator<VirtualApplianceSite[]> {
    let result = await this._list(
      resourceGroupName,
      networkVirtualApplianceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        networkVirtualApplianceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: VirtualApplianceSitesListOptionalParams
  ): AsyncIterableIterator<VirtualApplianceSite> {
    for await (const page of this.listPagingPage(
      resourceGroupName,
      networkVirtualApplianceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified site from a Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param siteName The name of the site.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    siteName: string,
    options?: VirtualApplianceSitesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>> {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<void> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkVirtualApplianceName, siteName, options },
      deleteOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Deletes the specified site from a Virtual Appliance.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param siteName The name of the site.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    siteName: string,
    options?: VirtualApplianceSitesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkVirtualApplianceName,
      siteName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the specified Virtual Appliance Site.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param siteName The name of the site.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    siteName: string,
    options?: VirtualApplianceSitesGetOptionalParams
  ): Promise<VirtualApplianceSitesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkVirtualApplianceName, siteName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates the specified Network Virtual Appliance Site.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param siteName The name of the site.
   * @param parameters Parameters supplied to the create or update Network Virtual Appliance Site
   *                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    siteName: string,
    parameters: VirtualApplianceSite,
    options?: VirtualApplianceSitesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VirtualApplianceSitesCreateOrUpdateResponse>,
      VirtualApplianceSitesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VirtualApplianceSitesCreateOrUpdateResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      {
        resourceGroupName,
        networkVirtualApplianceName,
        siteName,
        parameters,
        options
      },
      createOrUpdateOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "azure-async-operation"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Creates or updates the specified Network Virtual Appliance Site.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param siteName The name of the site.
   * @param parameters Parameters supplied to the create or update Network Virtual Appliance Site
   *                   operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    siteName: string,
    parameters: VirtualApplianceSite,
    options?: VirtualApplianceSitesCreateOrUpdateOptionalParams
  ): Promise<VirtualApplianceSitesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkVirtualApplianceName,
      siteName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Lists all Network Virtual Appliance Sites in a Network Virtual Appliance resource.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    options?: VirtualApplianceSitesListOptionalParams
  ): Promise<VirtualApplianceSitesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkVirtualApplianceName, options },
      listOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    nextLink: string,
    options?: VirtualApplianceSitesListNextOptionalParams
  ): Promise<VirtualApplianceSitesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkVirtualApplianceName, nextLink, options },
      listNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
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
    Parameters.networkVirtualApplianceName,
    Parameters.siteName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualApplianceSite
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
    Parameters.networkVirtualApplianceName,
    Parameters.siteName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites/{siteName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.VirtualApplianceSite
    },
    201: {
      bodyMapper: Mappers.VirtualApplianceSite
    },
    202: {
      bodyMapper: Mappers.VirtualApplianceSite
    },
    204: {
      bodyMapper: Mappers.VirtualApplianceSite
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters40,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkVirtualApplianceName,
    Parameters.siteName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/virtualApplianceSites",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkVirtualApplianceSiteListResult
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
    Parameters.networkVirtualApplianceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkVirtualApplianceSiteListResult
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
    Parameters.networkVirtualApplianceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
