import { DdosCustomPolicies } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  DdosCustomPoliciesDeleteOptionalParams,
  DdosCustomPoliciesGetOptionalParams,
  DdosCustomPoliciesGetResponse,
  DdosCustomPolicy,
  DdosCustomPoliciesCreateOrUpdateOptionalParams,
  DdosCustomPoliciesCreateOrUpdateResponse,
  TagsObject,
  DdosCustomPoliciesUpdateTagsOptionalParams,
  DdosCustomPoliciesUpdateTagsResponse
} from "../models";

/** Class containing DdosCustomPolicies operations. */
export class DdosCustomPoliciesImpl implements DdosCustomPolicies {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class DdosCustomPolicies class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Deletes the specified DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    options?: DdosCustomPoliciesDeleteOptionalParams
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
      { resourceGroupName, ddosCustomPolicyName, options },
      deleteOperationSpec
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
   * Deletes the specified DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    options?: DdosCustomPoliciesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      ddosCustomPolicyName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets information about the specified DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    options?: DdosCustomPoliciesGetOptionalParams
  ): Promise<DdosCustomPoliciesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ddosCustomPolicyName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    parameters: DdosCustomPolicy,
    options?: DdosCustomPoliciesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<DdosCustomPoliciesCreateOrUpdateResponse>,
      DdosCustomPoliciesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<DdosCustomPoliciesCreateOrUpdateResponse> => {
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
      { resourceGroupName, ddosCustomPolicyName, parameters, options },
      createOrUpdateOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "azure-async-operation"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Creates or updates a DDoS custom policy.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param parameters Parameters supplied to the create or update operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    parameters: DdosCustomPolicy,
    options?: DdosCustomPoliciesCreateOrUpdateOptionalParams
  ): Promise<DdosCustomPoliciesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      ddosCustomPolicyName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Update a DDoS custom policy tags.
   * @param resourceGroupName The name of the resource group.
   * @param ddosCustomPolicyName The name of the DDoS custom policy.
   * @param parameters Parameters supplied to update DDoS custom policy resource tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    ddosCustomPolicyName: string,
    parameters: TagsObject,
    options?: DdosCustomPoliciesUpdateTagsOptionalParams
  ): Promise<DdosCustomPoliciesUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, ddosCustomPolicyName, parameters, options },
      updateTagsOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ddosCustomPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.DdosCustomPolicy
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
    Parameters.ddosCustomPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.DdosCustomPolicy
    },
    201: {
      bodyMapper: Mappers.DdosCustomPolicy
    },
    202: {
      bodyMapper: Mappers.DdosCustomPolicy
    },
    204: {
      bodyMapper: Mappers.DdosCustomPolicy
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters11,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ddosCustomPolicyName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/ddosCustomPolicies/{ddosCustomPolicyName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.DdosCustomPolicy
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ddosCustomPolicyName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
