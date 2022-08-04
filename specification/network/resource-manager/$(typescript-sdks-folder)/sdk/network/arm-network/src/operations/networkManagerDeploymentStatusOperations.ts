import { NetworkManagerDeploymentStatusOperations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  NetworkManagerDeploymentStatusParameter,
  NetworkManagerDeploymentStatusListOptionalParams,
  NetworkManagerDeploymentStatusListResponse
} from "../models";

/** Class containing NetworkManagerDeploymentStatusOperations operations. */
export class NetworkManagerDeploymentStatusOperationsImpl
  implements NetworkManagerDeploymentStatusOperations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkManagerDeploymentStatusOperations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Post to List of Network Manager Deployment Status.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which Managed Network deployment status is.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManagerDeploymentStatusParameter,
    options?: NetworkManagerDeploymentStatusListOptionalParams
  ): Promise<NetworkManagerDeploymentStatusListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkManagerName, parameters, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkManagers/{networkManagerName}/listDeploymentStatus",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkManagerDeploymentStatusListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters32,
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
