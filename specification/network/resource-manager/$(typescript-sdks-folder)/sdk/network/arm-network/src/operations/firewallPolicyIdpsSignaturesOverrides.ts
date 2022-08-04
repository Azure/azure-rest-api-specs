import { FirewallPolicyIdpsSignaturesOverrides } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import {
  SignaturesOverrides,
  FirewallPolicyIdpsSignaturesOverridesPatchOptionalParams,
  FirewallPolicyIdpsSignaturesOverridesPatchResponse,
  FirewallPolicyIdpsSignaturesOverridesPutOptionalParams,
  FirewallPolicyIdpsSignaturesOverridesPutResponse,
  FirewallPolicyIdpsSignaturesOverridesGetOptionalParams,
  FirewallPolicyIdpsSignaturesOverridesGetResponse,
  FirewallPolicyIdpsSignaturesOverridesListOptionalParams,
  FirewallPolicyIdpsSignaturesOverridesListResponse
} from "../models";

/** Class containing FirewallPolicyIdpsSignaturesOverrides operations. */
export class FirewallPolicyIdpsSignaturesOverridesImpl
  implements FirewallPolicyIdpsSignaturesOverrides {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class FirewallPolicyIdpsSignaturesOverrides class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Will update the status of policy's signature overrides for IDPS
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Will contain all properties of the object to put
   * @param options The options parameters.
   */
  patch(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: SignaturesOverrides,
    options?: FirewallPolicyIdpsSignaturesOverridesPatchOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesOverridesPatchResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, parameters, options },
      patchOperationSpec
    );
  }

  /**
   * Will override/create a new signature overrides for the policy's IDPS
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param parameters Will contain all properties of the object to put
   * @param options The options parameters.
   */
  put(
    resourceGroupName: string,
    firewallPolicyName: string,
    parameters: SignaturesOverrides,
    options?: FirewallPolicyIdpsSignaturesOverridesPutOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesOverridesPutResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, parameters, options },
      putOperationSpec
    );
  }

  /**
   * Returns all signatures overrides for a specific policy.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPolicyIdpsSignaturesOverridesGetOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesOverridesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, options },
      getOperationSpec
    );
  }

  /**
   * Returns all signatures overrides objects for a specific policy as a list containing a single value.
   * @param resourceGroupName The name of the resource group.
   * @param firewallPolicyName The name of the Firewall Policy.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    firewallPolicyName: string,
    options?: FirewallPolicyIdpsSignaturesOverridesListOptionalParams
  ): Promise<FirewallPolicyIdpsSignaturesOverridesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, firewallPolicyName, options },
      listOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const patchOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides/default",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.SignaturesOverrides
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters20,
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
const putOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides/default",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.SignaturesOverrides
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters20,
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
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides/default",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SignaturesOverrides
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
    Parameters.firewallPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/firewallPolicies/{firewallPolicyName}/signatureOverrides",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.SignaturesOverridesList
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
    Parameters.firewallPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
