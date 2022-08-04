import { VpnSitesConfiguration } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  GetVpnSitesConfigurationRequest,
  VpnSitesConfigurationDownloadOptionalParams
} from "../models";

/** Class containing VpnSitesConfiguration operations. */
export class VpnSitesConfigurationImpl implements VpnSitesConfiguration {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VpnSitesConfiguration class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gives the sas-url to download the configurations for vpn-sites in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN for which configuration of all vpn-sites is needed.
   * @param request Parameters supplied to download vpn-sites configuration.
   * @param options The options parameters.
   */
  async beginDownload(
    resourceGroupName: string,
    virtualWANName: string,
    request: GetVpnSitesConfigurationRequest,
    options?: VpnSitesConfigurationDownloadOptionalParams
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
      { resourceGroupName, virtualWANName, request, options },
      downloadOperationSpec
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
   * Gives the sas-url to download the configurations for vpn-sites in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN for which configuration of all vpn-sites is needed.
   * @param request Parameters supplied to download vpn-sites configuration.
   * @param options The options parameters.
   */
  async beginDownloadAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    request: GetVpnSitesConfigurationRequest,
    options?: VpnSitesConfigurationDownloadOptionalParams
  ): Promise<void> {
    const poller = await this.beginDownload(
      resourceGroupName,
      virtualWANName,
      request,
      options
    );
    return poller.pollUntilDone();
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const downloadOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualWans/{virtualWANName}/vpnConfiguration",
  httpMethod: "POST",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.request2,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualWANName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
