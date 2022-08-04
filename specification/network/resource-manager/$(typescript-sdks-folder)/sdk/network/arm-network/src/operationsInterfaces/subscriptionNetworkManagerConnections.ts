import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  NetworkManagerConnection,
  SubscriptionNetworkManagerConnectionsListOptionalParams,
  SubscriptionNetworkManagerConnectionsCreateOrUpdateOptionalParams,
  SubscriptionNetworkManagerConnectionsCreateOrUpdateResponse,
  SubscriptionNetworkManagerConnectionsGetOptionalParams,
  SubscriptionNetworkManagerConnectionsGetResponse,
  SubscriptionNetworkManagerConnectionsDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a SubscriptionNetworkManagerConnections. */
export interface SubscriptionNetworkManagerConnections {
  /**
   * List all network manager connections created by this subscription.
   * @param options The options parameters.
   */
  list(
    options?: SubscriptionNetworkManagerConnectionsListOptionalParams
  ): PagedAsyncIterableIterator<NetworkManagerConnection>;
  /**
   * Create a network manager connection on this subscription.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param parameters Network manager connection to be created/updated.
   * @param options The options parameters.
   */
  createOrUpdate(
    networkManagerConnectionName: string,
    parameters: NetworkManagerConnection,
    options?: SubscriptionNetworkManagerConnectionsCreateOrUpdateOptionalParams
  ): Promise<SubscriptionNetworkManagerConnectionsCreateOrUpdateResponse>;
  /**
   * Get a specified connection created by this subscription.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param options The options parameters.
   */
  get(
    networkManagerConnectionName: string,
    options?: SubscriptionNetworkManagerConnectionsGetOptionalParams
  ): Promise<SubscriptionNetworkManagerConnectionsGetResponse>;
  /**
   * Delete specified connection created by this subscription.
   * @param networkManagerConnectionName Name for the network manager connection.
   * @param options The options parameters.
   */
  delete(
    networkManagerConnectionName: string,
    options?: SubscriptionNetworkManagerConnectionsDeleteOptionalParams
  ): Promise<void>;
}
