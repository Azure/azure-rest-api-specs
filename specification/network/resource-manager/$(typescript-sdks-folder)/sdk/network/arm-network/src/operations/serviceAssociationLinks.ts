import { ServiceAssociationLinks } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ServiceAssociationLinksListOptionalParams,
  ServiceAssociationLinksListResponse
} from "../models";

/** Class containing ServiceAssociationLinks operations. */
export class ServiceAssociationLinksImpl implements ServiceAssociationLinks {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ServiceAssociationLinks class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets a list of service association links for a subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: ServiceAssociationLinksListOptionalParams
  ): Promise<ServiceAssociationLinksListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualNetworkName, subnetName, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}/ServiceAssociationLinks",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ServiceAssociationLinksListResult
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
    Parameters.virtualNetworkName,
    Parameters.subnetName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
