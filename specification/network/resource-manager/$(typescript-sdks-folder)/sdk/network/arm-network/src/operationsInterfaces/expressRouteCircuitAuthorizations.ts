import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  ExpressRouteCircuitAuthorization,
  ExpressRouteCircuitAuthorizationsListOptionalParams,
  ExpressRouteCircuitAuthorizationsDeleteOptionalParams,
  ExpressRouteCircuitAuthorizationsGetOptionalParams,
  ExpressRouteCircuitAuthorizationsGetResponse,
  ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams,
  ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ExpressRouteCircuitAuthorizations. */
export interface ExpressRouteCircuitAuthorizations {
  /**
   * Gets all authorizations in an express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the circuit.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    circuitName: string,
    options?: ExpressRouteCircuitAuthorizationsListOptionalParams
  ): PagedAsyncIterableIterator<ExpressRouteCircuitAuthorization>;
  /**
   * Deletes the specified authorization from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    options?: ExpressRouteCircuitAuthorizationsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified authorization from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    options?: ExpressRouteCircuitAuthorizationsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified authorization from the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    options?: ExpressRouteCircuitAuthorizationsGetOptionalParams
  ): Promise<ExpressRouteCircuitAuthorizationsGetResponse>;
  /**
   * Creates or updates an authorization in the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param authorizationParameters Parameters supplied to the create or update express route circuit
   *                                authorization operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    authorizationParameters: ExpressRouteCircuitAuthorization,
    options?: ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse
      >,
      ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates an authorization in the specified express route circuit.
   * @param resourceGroupName The name of the resource group.
   * @param circuitName The name of the express route circuit.
   * @param authorizationName The name of the authorization.
   * @param authorizationParameters Parameters supplied to the create or update express route circuit
   *                                authorization operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    circuitName: string,
    authorizationName: string,
    authorizationParameters: ExpressRouteCircuitAuthorization,
    options?: ExpressRouteCircuitAuthorizationsCreateOrUpdateOptionalParams
  ): Promise<ExpressRouteCircuitAuthorizationsCreateOrUpdateResponse>;
}
