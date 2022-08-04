import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ApplicationGateway,
  ApplicationGatewaysListOptionalParams,
  ApplicationGatewaysListAllOptionalParams,
  ApplicationGatewaySslPredefinedPolicy,
  ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams,
  ApplicationGatewaysDeleteOptionalParams,
  ApplicationGatewaysGetOptionalParams,
  ApplicationGatewaysGetResponse,
  ApplicationGatewaysCreateOrUpdateOptionalParams,
  ApplicationGatewaysCreateOrUpdateResponse,
  TagsObject,
  ApplicationGatewaysUpdateTagsOptionalParams,
  ApplicationGatewaysUpdateTagsResponse,
  ApplicationGatewaysStartOptionalParams,
  ApplicationGatewaysStopOptionalParams,
  ApplicationGatewaysBackendHealthOptionalParams,
  ApplicationGatewaysBackendHealthResponse,
  ApplicationGatewayOnDemandProbe,
  ApplicationGatewaysBackendHealthOnDemandOptionalParams,
  ApplicationGatewaysBackendHealthOnDemandResponse,
  ApplicationGatewaysListAvailableServerVariablesOptionalParams,
  ApplicationGatewaysListAvailableServerVariablesResponse,
  ApplicationGatewaysListAvailableRequestHeadersOptionalParams,
  ApplicationGatewaysListAvailableRequestHeadersResponse,
  ApplicationGatewaysListAvailableResponseHeadersOptionalParams,
  ApplicationGatewaysListAvailableResponseHeadersResponse,
  ApplicationGatewaysListAvailableWafRuleSetsOptionalParams,
  ApplicationGatewaysListAvailableWafRuleSetsResponse,
  ApplicationGatewaysListAvailableSslOptionsOptionalParams,
  ApplicationGatewaysListAvailableSslOptionsResponse,
  ApplicationGatewaysGetSslPredefinedPolicyOptionalParams,
  ApplicationGatewaysGetSslPredefinedPolicyResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ApplicationGateways. */
export interface ApplicationGateways {
  /**
   * Lists all application gateways in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: ApplicationGatewaysListOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGateway>;
  /**
   * Gets all the application gateways in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: ApplicationGatewaysListAllOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGateway>;
  /**
   * Lists all SSL predefined policies for configuring Ssl policy.
   * @param options The options parameters.
   */
  listAvailableSslPredefinedPolicies(
    options?: ApplicationGatewaysListAvailableSslPredefinedPoliciesOptionalParams
  ): PagedAsyncIterableIterator<ApplicationGatewaySslPredefinedPolicy>;
  /**
   * Deletes the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysGetOptionalParams
  ): Promise<ApplicationGatewaysGetResponse>;
  /**
   * Creates or updates the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param parameters Parameters supplied to the create or update application gateway operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    applicationGatewayName: string,
    parameters: ApplicationGateway,
    options?: ApplicationGatewaysCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationGatewaysCreateOrUpdateResponse>,
      ApplicationGatewaysCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param parameters Parameters supplied to the create or update application gateway operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    parameters: ApplicationGateway,
    options?: ApplicationGatewaysCreateOrUpdateOptionalParams
  ): Promise<ApplicationGatewaysCreateOrUpdateResponse>;
  /**
   * Updates the specified application gateway tags.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param parameters Parameters supplied to update application gateway tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    applicationGatewayName: string,
    parameters: TagsObject,
    options?: ApplicationGatewaysUpdateTagsOptionalParams
  ): Promise<ApplicationGatewaysUpdateTagsResponse>;
  /**
   * Starts the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginStart(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStartOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Starts the specified application gateway.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginStartAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStartOptionalParams
  ): Promise<void>;
  /**
   * Stops the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginStop(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStopOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Stops the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginStopAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysStopOptionalParams
  ): Promise<void>;
  /**
   * Gets the backend health of the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginBackendHealth(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysBackendHealthOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationGatewaysBackendHealthResponse>,
      ApplicationGatewaysBackendHealthResponse
    >
  >;
  /**
   * Gets the backend health of the specified application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param options The options parameters.
   */
  beginBackendHealthAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    options?: ApplicationGatewaysBackendHealthOptionalParams
  ): Promise<ApplicationGatewaysBackendHealthResponse>;
  /**
   * Gets the backend health for given combination of backend pool and http setting of the specified
   * application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param probeRequest Request body for on-demand test probe operation.
   * @param options The options parameters.
   */
  beginBackendHealthOnDemand(
    resourceGroupName: string,
    applicationGatewayName: string,
    probeRequest: ApplicationGatewayOnDemandProbe,
    options?: ApplicationGatewaysBackendHealthOnDemandOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<ApplicationGatewaysBackendHealthOnDemandResponse>,
      ApplicationGatewaysBackendHealthOnDemandResponse
    >
  >;
  /**
   * Gets the backend health for given combination of backend pool and http setting of the specified
   * application gateway in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param applicationGatewayName The name of the application gateway.
   * @param probeRequest Request body for on-demand test probe operation.
   * @param options The options parameters.
   */
  beginBackendHealthOnDemandAndWait(
    resourceGroupName: string,
    applicationGatewayName: string,
    probeRequest: ApplicationGatewayOnDemandProbe,
    options?: ApplicationGatewaysBackendHealthOnDemandOptionalParams
  ): Promise<ApplicationGatewaysBackendHealthOnDemandResponse>;
  /**
   * Lists all available server variables.
   * @param options The options parameters.
   */
  listAvailableServerVariables(
    options?: ApplicationGatewaysListAvailableServerVariablesOptionalParams
  ): Promise<ApplicationGatewaysListAvailableServerVariablesResponse>;
  /**
   * Lists all available request headers.
   * @param options The options parameters.
   */
  listAvailableRequestHeaders(
    options?: ApplicationGatewaysListAvailableRequestHeadersOptionalParams
  ): Promise<ApplicationGatewaysListAvailableRequestHeadersResponse>;
  /**
   * Lists all available response headers.
   * @param options The options parameters.
   */
  listAvailableResponseHeaders(
    options?: ApplicationGatewaysListAvailableResponseHeadersOptionalParams
  ): Promise<ApplicationGatewaysListAvailableResponseHeadersResponse>;
  /**
   * Lists all available web application firewall rule sets.
   * @param options The options parameters.
   */
  listAvailableWafRuleSets(
    options?: ApplicationGatewaysListAvailableWafRuleSetsOptionalParams
  ): Promise<ApplicationGatewaysListAvailableWafRuleSetsResponse>;
  /**
   * Lists available Ssl options for configuring Ssl policy.
   * @param options The options parameters.
   */
  listAvailableSslOptions(
    options?: ApplicationGatewaysListAvailableSslOptionsOptionalParams
  ): Promise<ApplicationGatewaysListAvailableSslOptionsResponse>;
  /**
   * Gets Ssl predefined policy with the specified policy name.
   * @param predefinedPolicyName Name of Ssl predefined policy.
   * @param options The options parameters.
   */
  getSslPredefinedPolicy(
    predefinedPolicyName: string,
    options?: ApplicationGatewaysGetSslPredefinedPolicyOptionalParams
  ): Promise<ApplicationGatewaysGetSslPredefinedPolicyResponse>;
}
