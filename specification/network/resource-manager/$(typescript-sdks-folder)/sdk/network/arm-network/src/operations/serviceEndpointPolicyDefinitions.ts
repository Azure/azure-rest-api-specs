import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { ServiceEndpointPolicyDefinitions } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  ServiceEndpointPolicyDefinition,
  ServiceEndpointPolicyDefinitionsListByResourceGroupNextOptionalParams,
  ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams,
  ServiceEndpointPolicyDefinitionsDeleteOptionalParams,
  ServiceEndpointPolicyDefinitionsGetOptionalParams,
  ServiceEndpointPolicyDefinitionsGetResponse,
  ServiceEndpointPolicyDefinitionsCreateOrUpdateOptionalParams,
  ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse,
  ServiceEndpointPolicyDefinitionsListByResourceGroupResponse,
  ServiceEndpointPolicyDefinitionsListByResourceGroupNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing ServiceEndpointPolicyDefinitions operations. */
export class ServiceEndpointPolicyDefinitionsImpl
  implements ServiceEndpointPolicyDefinitions {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class ServiceEndpointPolicyDefinitions class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets all service endpoint policy definitions in a service end point policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy name.
   * @param options The options parameters.
   */
  public listByResourceGroup(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<ServiceEndpointPolicyDefinition> {
    const iter = this.listByResourceGroupPagingAll(
      resourceGroupName,
      serviceEndpointPolicyName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listByResourceGroupPagingPage(
          resourceGroupName,
          serviceEndpointPolicyName,
          options
        );
      }
    };
  }

  private async *listByResourceGroupPagingPage(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<ServiceEndpointPolicyDefinition[]> {
    let result = await this._listByResourceGroup(
      resourceGroupName,
      serviceEndpointPolicyName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listByResourceGroupNext(
        resourceGroupName,
        serviceEndpointPolicyName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listByResourceGroupPagingAll(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams
  ): AsyncIterableIterator<ServiceEndpointPolicyDefinition> {
    for await (const page of this.listByResourceGroupPagingPage(
      resourceGroupName,
      serviceEndpointPolicyName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Deletes the specified ServiceEndpoint policy definitions.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the Service Endpoint Policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    options?: ServiceEndpointPolicyDefinitionsDeleteOptionalParams
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
      {
        resourceGroupName,
        serviceEndpointPolicyName,
        serviceEndpointPolicyDefinitionName,
        options
      },
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
   * Deletes the specified ServiceEndpoint policy definitions.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the Service Endpoint Policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    options?: ServiceEndpointPolicyDefinitionsDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      serviceEndpointPolicyName,
      serviceEndpointPolicyDefinitionName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Get the specified service endpoint policy definitions from service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy name.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition name.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    options?: ServiceEndpointPolicyDefinitionsGetOptionalParams
  ): Promise<ServiceEndpointPolicyDefinitionsGetResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        serviceEndpointPolicyName,
        serviceEndpointPolicyDefinitionName,
        options
      },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition name.
   * @param serviceEndpointPolicyDefinitions Parameters supplied to the create or update service endpoint
   *                                         policy operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    serviceEndpointPolicyDefinitions: ServiceEndpointPolicyDefinition,
    options?: ServiceEndpointPolicyDefinitionsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse
      >,
      ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse> => {
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
        serviceEndpointPolicyName,
        serviceEndpointPolicyDefinitionName,
        serviceEndpointPolicyDefinitions,
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
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition name.
   * @param serviceEndpointPolicyDefinitions Parameters supplied to the create or update service endpoint
   *                                         policy operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    serviceEndpointPolicyDefinitions: ServiceEndpointPolicyDefinition,
    options?: ServiceEndpointPolicyDefinitionsCreateOrUpdateOptionalParams
  ): Promise<ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      serviceEndpointPolicyName,
      serviceEndpointPolicyDefinitionName,
      serviceEndpointPolicyDefinitions,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all service endpoint policy definitions in a service end point policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy name.
   * @param options The options parameters.
   */
  private _listByResourceGroup(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams
  ): Promise<ServiceEndpointPolicyDefinitionsListByResourceGroupResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceEndpointPolicyName, options },
      listByResourceGroupOperationSpec
    );
  }

  /**
   * ListByResourceGroupNext
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy name.
   * @param nextLink The nextLink from the previous successful call to the ListByResourceGroup method.
   * @param options The options parameters.
   */
  private _listByResourceGroupNext(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    nextLink: string,
    options?: ServiceEndpointPolicyDefinitionsListByResourceGroupNextOptionalParams
  ): Promise<ServiceEndpointPolicyDefinitionsListByResourceGroupNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, serviceEndpointPolicyName, nextLink, options },
      listByResourceGroupNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}",
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
    Parameters.serviceEndpointPolicyName,
    Parameters.serviceEndpointPolicyDefinitionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinition
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
    Parameters.serviceEndpointPolicyName,
    Parameters.serviceEndpointPolicyDefinitionName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions/{serviceEndpointPolicyDefinitionName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinition
    },
    201: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinition
    },
    202: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinition
    },
    204: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinition
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.serviceEndpointPolicyDefinitions,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.serviceEndpointPolicyName,
    Parameters.serviceEndpointPolicyDefinitionName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listByResourceGroupOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/serviceEndpointPolicies/{serviceEndpointPolicyName}/serviceEndpointPolicyDefinitions",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinitionListResult
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
    Parameters.serviceEndpointPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listByResourceGroupNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.ServiceEndpointPolicyDefinitionListResult
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
    Parameters.nextLink,
    Parameters.serviceEndpointPolicyName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
