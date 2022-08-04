import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ServiceEndpointPolicyDefinition,
  ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams,
  ServiceEndpointPolicyDefinitionsDeleteOptionalParams,
  ServiceEndpointPolicyDefinitionsGetOptionalParams,
  ServiceEndpointPolicyDefinitionsGetResponse,
  ServiceEndpointPolicyDefinitionsCreateOrUpdateOptionalParams,
  ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ServiceEndpointPolicyDefinitions. */
export interface ServiceEndpointPolicyDefinitions {
  /**
   * Gets all service endpoint policy definitions in a service end point policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy name.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    options?: ServiceEndpointPolicyDefinitionsListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<ServiceEndpointPolicyDefinition>;
  /**
   * Deletes the specified ServiceEndpoint policy definitions.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the Service Endpoint Policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    options?: ServiceEndpointPolicyDefinitionsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified ServiceEndpoint policy definitions.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the Service Endpoint Policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    options?: ServiceEndpointPolicyDefinitionsDeleteOptionalParams
  ): Promise<void>;
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
  ): Promise<ServiceEndpointPolicyDefinitionsGetResponse>;
  /**
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition name.
   * @param serviceEndpointPolicyDefinitions Parameters supplied to the create or update service endpoint
   *                                         policy operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
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
  >;
  /**
   * Creates or updates a service endpoint policy definition in the specified service endpoint policy.
   * @param resourceGroupName The name of the resource group.
   * @param serviceEndpointPolicyName The name of the service endpoint policy.
   * @param serviceEndpointPolicyDefinitionName The name of the service endpoint policy definition name.
   * @param serviceEndpointPolicyDefinitions Parameters supplied to the create or update service endpoint
   *                                         policy operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    serviceEndpointPolicyName: string,
    serviceEndpointPolicyDefinitionName: string,
    serviceEndpointPolicyDefinitions: ServiceEndpointPolicyDefinition,
    options?: ServiceEndpointPolicyDefinitionsCreateOrUpdateOptionalParams
  ): Promise<ServiceEndpointPolicyDefinitionsCreateOrUpdateResponse>;
}
