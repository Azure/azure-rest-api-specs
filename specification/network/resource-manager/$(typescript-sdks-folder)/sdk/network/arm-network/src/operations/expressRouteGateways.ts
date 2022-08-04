import { ExpressRouteGateways } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ExpressRouteGatewaysListBySubscriptionOptionalParams,
  ExpressRouteGatewaysListBySubscriptionResponse,
  ExpressRouteGatewaysListByResourceGroupOptionalParams,
  ExpressRouteGatewaysListByResourceGroupResponse,
  ExpressRouteGateway,
  ExpressRouteGatewaysCreateOrUpdateOptionalParams,
  ExpressRouteGatewaysCreateOrUpdateResponse,
  TagsObject,
  ExpressRouteGatewaysUpdateTagsOptionalParams,
  ExpressRouteGatewaysUpdateTagsResponse,
  ExpressRouteGatewaysGetOptionalParams,
  ExpressRouteGatewaysGetResponse,
  ExpressRouteGatewaysDeleteOptionalParams
} from "../models";

/** Class containing ExpressRouteGateways operations. */
export class ExpressRouteGatewaysImpl implements ExpressRouteGateways {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ExpressRouteGateways class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Lists ExpressRoute gateways under a given subscription.
   * @param options The options parameters.
   */
  listBySubscription(
    options?: ExpressRouteGatewaysListBySubscriptionOptionalParams
  ): Promise<ExpressRouteGatewaysListBySubscriptionResponse> {
    return this.client.sendOperationRequest(
      { options },
      listBySubscriptionOperationSpec
    );
  }

  /**
   * Lists ExpressRoute gateways in a given resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: ExpressRouteGatewaysListByResourceGroupOptionalParams
  ): Promise<ExpressRouteGatewaysListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * Creates or updates a ExpressRoute gateway in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param putExpressRouteGatewayParameters Parameters required in an ExpressRoute gateway PUT
   *                                         operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    putExpressRouteGatewayParameters: ExpressRouteGateway,
    options?: ExpressRouteGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteGatewaysCreateOrUpdateResponse>,
      ExpressRouteGatewaysCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteGatewaysCreateOrUpdateResponse> => {
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
        expressRouteGatewayName,
        putExpressRouteGatewayParameters,
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
   * Creates or updates a ExpressRoute gateway in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param putExpressRouteGatewayParameters Parameters required in an ExpressRoute gateway PUT
   *                                         operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    putExpressRouteGatewayParameters: ExpressRouteGateway,
    options?: ExpressRouteGatewaysCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteGatewaysCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      expressRouteGatewayName,
      putExpressRouteGatewayParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Updates express route gateway tags.
   * @param resourceGroupName The resource group name of the ExpressRouteGateway.
   * @param expressRouteGatewayName The name of the gateway.
   * @param expressRouteGatewayParameters Parameters supplied to update a virtual wan express route
   *                                      gateway tags.
   * @param options The options parameters.
   */
  async beginUpdateTags(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    expressRouteGatewayParameters: TagsObject,
    options?: ExpressRouteGatewaysUpdateTagsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ExpressRouteGatewaysUpdateTagsResponse>,
      ExpressRouteGatewaysUpdateTagsResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ExpressRouteGatewaysUpdateTagsResponse> => {
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
        expressRouteGatewayName,
        expressRouteGatewayParameters,
        options
      },
      updateTagsOperationSpec
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
   * Updates express route gateway tags.
   * @param resourceGroupName The resource group name of the ExpressRouteGateway.
   * @param expressRouteGatewayName The name of the gateway.
   * @param expressRouteGatewayParameters Parameters supplied to update a virtual wan express route
   *                                      gateway tags.
   * @param options The options parameters.
   */
  async beginUpdateTagsAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    expressRouteGatewayParameters: TagsObject,
    options?: ExpressRouteGatewaysUpdateTagsOptionalParams
  ): Promise<ExpressRouteGatewaysUpdateTagsResponse> {
    const poller = await this.beginUpdateTags(
      resourceGroupName,
      expressRouteGatewayName,
      expressRouteGatewayParameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Fetches the details of a ExpressRoute gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteGatewaysGetOptionalParams
  ): Promise<ExpressRouteGatewaysGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, expressRouteGatewayName, options },
      getOperationSpec
    );
  }

  /**
   * Deletes the specified ExpressRoute gateway in a resource group. An ExpressRoute gateway resource can
   * only be deleted when there are no connection subresources.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteGatewaysDeleteOptionalParams
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
      { resourceGroupName, expressRouteGatewayName, options },
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
   * Deletes the specified ExpressRoute gateway in a resource group. An ExpressRoute gateway resource can
   * only be deleted when there are no connection subresources.
   * @param resourceGroupName The name of the resource group.
   * @param expressRouteGatewayName The name of the ExpressRoute gateway.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    expressRouteGatewayName: string,
    options?: ExpressRouteGatewaysDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      expressRouteGatewayName,
      options
    );
    return poller.pollUntilDone();
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listBySubscriptionOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/expressRouteGateways",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteGatewayList
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
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteGatewayList
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    201: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    202: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    204: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.putExpressRouteGatewayParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.expressRouteGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    201: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    202: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    204: {
      bodyMapper: Mappers.ExpressRouteGateway
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.expressRouteGatewayParameters,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.expressRouteGatewayName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ExpressRouteGateway
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
    Parameters.expressRouteGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteGateways/{expressRouteGatewayName}",
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
    Parameters.expressRouteGatewayName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
