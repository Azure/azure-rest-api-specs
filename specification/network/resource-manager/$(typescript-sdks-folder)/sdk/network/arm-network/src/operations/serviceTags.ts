import { ServiceTags } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  ServiceTagsListOptionalParams,
  ServiceTagsListResponse
} from "../models";

/** Class containing ServiceTags operations. */
export class ServiceTagsImpl implements ServiceTags {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ServiceTags class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets a list of service tag information resources.
   * @param location The location that will be used as a reference for version (not as a filter based on
   *                 location, you will get the list of service tags with prefix details across all regions but limited
   *                 to the cloud that your subscription belongs to).
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: ServiceTagsListOptionalParams
  ): Promise<ServiceTagsListResponse> {
    return this.client.sendOperationRequest(
      { location, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/locations/{location}/serviceTags",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ServiceTagsListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.location
  ],
  headerParameters: [Parameters.accept],
  serializer
};
