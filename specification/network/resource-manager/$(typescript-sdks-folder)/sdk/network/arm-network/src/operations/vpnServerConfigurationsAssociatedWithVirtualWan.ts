import { VpnServerConfigurationsAssociatedWithVirtualWan } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams,
  VpnServerConfigurationsAssociatedWithVirtualWanListResponse
} from "../models";

/** Class containing VpnServerConfigurationsAssociatedWithVirtualWan operations. */
export class VpnServerConfigurationsAssociatedWithVirtualWanImpl
  implements VpnServerConfigurationsAssociatedWithVirtualWan {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VpnServerConfigurationsAssociatedWithVirtualWan class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gives the list of VpnServerConfigurations associated with Virtual Wan in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN whose associated VpnServerConfigurations is needed.
   * @param options The options parameters.
   */
  async beginList(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VpnServerConfigurationsAssociatedWithVirtualWanListResponse
      >,
      VpnServerConfigurationsAssociatedWithVirtualWanListResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<VpnServerConfigurationsAssociatedWithVirtualWanListResponse> => {
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
      { resourceGroupName, virtualWANName, options },
      listOperationSpec
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
   * Gives the list of VpnServerConfigurations associated with Virtual Wan in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN whose associated VpnServerConfigurations is needed.
   * @param options The options parameters.
   */
  async beginListAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams
  ): Promise<VpnServerConfigurationsAssociatedWithVirtualWanListResponse> {
    const poller = await this.beginList(
      resourceGroupName,
      virtualWANName,
      options
    );
    return poller.pollUntilDone();
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{virtualWANName}/vpnServerConfigurations",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.VpnServerConfigurationsResponse
    },
    201: {
      bodyMapper: Mappers.VpnServerConfigurationsResponse
    },
    202: {
      bodyMapper: Mappers.VpnServerConfigurationsResponse
    },
    204: {
      bodyMapper: Mappers.VpnServerConfigurationsResponse
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
    Parameters.virtualWANName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
