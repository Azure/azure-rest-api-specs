import { InboundSecurityRuleOperations } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  InboundSecurityRule,
  InboundSecurityRuleCreateOrUpdateOptionalParams,
  InboundSecurityRuleCreateOrUpdateResponse
} from "../models";

/** Class containing InboundSecurityRuleOperations operations. */
export class InboundSecurityRuleOperationsImpl
  implements InboundSecurityRuleOperations {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class InboundSecurityRuleOperations class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Creates or updates the specified Network Virtual Appliance Inbound Security Rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param ruleCollectionName The name of security rule collection.
   * @param parameters Parameters supplied to the create or update Network Virtual Appliance Inbound
   *                   Security Rules operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    ruleCollectionName: string,
    parameters: InboundSecurityRule,
    options?: InboundSecurityRuleCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<InboundSecurityRuleCreateOrUpdateResponse>,
      InboundSecurityRuleCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<InboundSecurityRuleCreateOrUpdateResponse> => {
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
      {
        resourceGroupName,
        networkVirtualApplianceName,
        ruleCollectionName,
        parameters,
        options
      },
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
   * Creates or updates the specified Network Virtual Appliance Inbound Security Rules.
   * @param resourceGroupName The name of the resource group.
   * @param networkVirtualApplianceName The name of the Network Virtual Appliance.
   * @param ruleCollectionName The name of security rule collection.
   * @param parameters Parameters supplied to the create or update Network Virtual Appliance Inbound
   *                   Security Rules operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkVirtualApplianceName: string,
    ruleCollectionName: string,
    parameters: InboundSecurityRule,
    options?: InboundSecurityRuleCreateOrUpdateOptionalParams
  ): Promise<InboundSecurityRuleCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkVirtualApplianceName,
      ruleCollectionName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkVirtualAppliances/{networkVirtualApplianceName}/inboundSecurityRules/{ruleCollectionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.InboundSecurityRule
    },
    201: {
      bodyMapper: Mappers.InboundSecurityRule
    },
    202: {
      bodyMapper: Mappers.InboundSecurityRule
    },
    204: {
      bodyMapper: Mappers.InboundSecurityRule
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters41,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.ruleCollectionName,
    Parameters.networkVirtualApplianceName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
