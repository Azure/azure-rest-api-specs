import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkManagerCommit,
  NetworkManagerCommitsPostOptionalParams,
  NetworkManagerCommitsPostResponse
} from "../models";

/** Interface representing a NetworkManagerCommits. */
export interface NetworkManagerCommits {
  /**
   * Post a Network Manager Commit.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which Managed Network commit is.
   * @param options The options parameters.
   */
  beginPost(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManagerCommit,
    options?: NetworkManagerCommitsPostOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkManagerCommitsPostResponse>,
      NetworkManagerCommitsPostResponse
    >
  >;
  /**
   * Post a Network Manager Commit.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which Managed Network commit is.
   * @param options The options parameters.
   */
  beginPostAndWait(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManagerCommit,
    options?: NetworkManagerCommitsPostOptionalParams
  ): Promise<NetworkManagerCommitsPostResponse>;
}
