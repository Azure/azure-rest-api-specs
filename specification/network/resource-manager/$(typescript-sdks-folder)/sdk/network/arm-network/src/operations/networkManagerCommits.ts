import { NetworkManagerCommits } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkManagerCommit,
  NetworkManagerCommitsPostOptionalParams,
  NetworkManagerCommitsPostResponse
} from "../models";

/** Class containing NetworkManagerCommits operations. */
export class NetworkManagerCommitsImpl implements NetworkManagerCommits {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkManagerCommits class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Post a Network Manager Commit.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which Managed Network commit is.
   * @param options The options parameters.
   */
  async beginPost(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManagerCommit,
    options?: NetworkManagerCommitsPostOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkManagerCommitsPostResponse>,
      NetworkManagerCommitsPostResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkManagerCommitsPostResponse> => {
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
      { resourceGroupName, networkManagerName, parameters, options },
      postOperationSpec
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
   * Post a Network Manager Commit.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which Managed Network commit is.
   * @param options The options parameters.
   */
  async beginPostAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManagerCommit,
    options?: NetworkManagerCommitsPostOptionalParams
  ): Promise<NetworkManagerCommitsPostResponse> {
    const poller = await this.beginPost(
      resourceGroupName,
      networkManagerName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const postOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/commit",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerCommit
    },
    201: {
      bodyMapper: Mappers.NetworkManagerCommit
    },
    202: {
      bodyMapper: Mappers.NetworkManagerCommit
    },
    204: {
      bodyMapper: Mappers.NetworkManagerCommit
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters31,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkManagerName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
