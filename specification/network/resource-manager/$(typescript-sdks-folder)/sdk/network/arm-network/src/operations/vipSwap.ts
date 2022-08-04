import { VipSwap } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VipSwapGetOptionalParams,
  VipSwapGetResponse,
  SwapResource,
  VipSwapCreateOptionalParams,
  VipSwapListOptionalParams,
  VipSwapListResponse
} from "../models";

/** Class containing VipSwap operations. */
export class VipSwapImpl implements VipSwap {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VipSwap class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets the SwapResource which identifies the slot type for the specified cloud service. The slot type
   * on a cloud service can either be Staging or Production
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param options The options parameters.
   */
  get(
    groupName: string,
    resourceName: string,
    options?: VipSwapGetOptionalParams
  ): Promise<VipSwapGetResponse> {
    return this.client.sendOperationRequest(
      { groupName, resourceName, options },
      getOperationSpec
    );
  }

  /**
   * Performs vip swap operation on swappable cloud services.
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param parameters SwapResource object where slot type should be the target slot after vip swap for
   *                   the specified cloud service.
   * @param options The options parameters.
   */
  async beginCreate(
    groupName: string,
    resourceName: string,
    parameters: SwapResource,
    options?: VipSwapCreateOptionalParams
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
      { groupName, resourceName, parameters, options },
      createOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs
    });
    await poller.poll();
    return poller;
  }

  /**
   * Performs vip swap operation on swappable cloud services.
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param parameters SwapResource object where slot type should be the target slot after vip swap for
   *                   the specified cloud service.
   * @param options The options parameters.
   */
  async beginCreateAndWait(
    groupName: string,
    resourceName: string,
    parameters: SwapResource,
    options?: VipSwapCreateOptionalParams
  ): Promise<void> {
    const poller = await this.beginCreate(
      groupName,
      resourceName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets the list of SwapResource which identifies the slot type for the specified cloud service. The
   * slot type on a cloud service can either be Staging or Production
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param options The options parameters.
   */
  list(
    groupName: string,
    resourceName: string,
    options?: VipSwapListOptionalParams
  ): Promise<VipSwapListResponse> {
    return this.client.sendOperationRequest(
      { groupName, resourceName, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Compute/cloudServices/{resourceName}/providers/Microsoft.Network/cloudServiceSlots/{singletonResource}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SwapResource
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.groupName,
    Parameters.resourceName,
    Parameters.singletonResource
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Compute/cloudServices/{resourceName}/providers/Microsoft.Network/cloudServiceSlots/{singletonResource}",
  httpMethod: "PUT",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters88,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.groupName,
    Parameters.resourceName,
    Parameters.singletonResource
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Compute/cloudServices/{resourceName}/providers/Microsoft.Network/cloudServiceSlots",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SwapResourceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.groupName,
    Parameters.resourceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
