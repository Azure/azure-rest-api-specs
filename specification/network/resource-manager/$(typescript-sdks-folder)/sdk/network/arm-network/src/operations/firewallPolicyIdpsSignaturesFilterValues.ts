import { FirewallPolicyIdpsSignaturesFilterValues } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  SignatureOverridesFilterValuesQuery,
  FirewallPolicyIdpsSignaturesFilterValuesListOptionalParams,
  FirewallPolicyIdpsSignaturesFilterValuesListResponse
} from "../models";

/** Class containing FirewallPolicyIdpsSignaturesFilterValues operations. */
export class FirewallPolicyIdpsSignaturesFilterValuesImpl
  implements FirewallPolicyIdpsSignaturesFilterValues {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class FirewallPolicyIdpsSignaturesFilterValues class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Retrieves the current filter values for the signatures overrides
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Describes the filter values possibles for a given column
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: SignatureOverridesFilterValuesQuery,
    options?: FirewallPolicyIdpsSignaturesFilterValuesListOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesFilterValuesListResponse> {
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
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/listIdpsFilterOptions",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.SignatureOverridesFilterValuesResponse
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters21,
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
