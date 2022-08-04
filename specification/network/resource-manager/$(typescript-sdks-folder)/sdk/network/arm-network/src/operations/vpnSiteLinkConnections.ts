import { VpnSiteLinkConnections } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  VpnSiteLinkConnectionsGetOptionalParams,
  VpnSiteLinkConnectionsGetResponse
} from "../models";

/** Class containing VpnSiteLinkConnections operations. */
export class VpnSiteLinkConnectionsImpl implements VpnSiteLinkConnections {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class VpnSiteLinkConnections class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the details of a vpn site link connection.
   * @param resourceGroupName The resource group name of the VpnGateway.
   * @param gatewayName The name of the gateway.
   * @param connectionName The name of the vpn connection.
   * @param linkConnectionName The name of the vpn connection.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    gatewayName: string,
    connectionName: string,
    linkConnectionName: string,
    options?: VpnSiteLinkConnectionsGetOptionalParams
  ): Promise<VpnSiteLinkConnectionsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        gatewayName,
        connectionName,
        linkConnectionName,
        options
      },
      getOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/vpnGateways/{gatewayName}/vpnConnections/{connectionName}/vpnLinkConnections/{linkConnectionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.VpnSiteLinkConnection
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
    Parameters.connectionName,
    Parameters.gatewayName,
    Parameters.linkConnectionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
