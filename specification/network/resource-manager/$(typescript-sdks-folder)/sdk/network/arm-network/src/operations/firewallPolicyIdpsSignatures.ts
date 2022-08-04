import { FirewallPolicyIdpsSignatures } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  IdpsQueryObject,
  FirewallPolicyIdpsSignaturesListOptionalParams,
  FirewallPolicyIdpsSignaturesListResponse
} from "../models";

/** Class containing FirewallPolicyIdpsSignatures operations. */
export class FirewallPolicyIdpsSignaturesImpl
  implements FirewallPolicyIdpsSignatures {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class FirewallPolicyIdpsSignatures class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the current status of IDPS signatures for the relevant policy
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Will describe the query to run against the IDPS signatures DB
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: IdpsQueryObject,
    options?: FirewallPolicyIdpsSignaturesListOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, parameters, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsSignatures",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.QueryResults
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters19,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.firewallPolicyName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
