import {
  NetworkManagerDeploymentStatusParameter,
  NetworkManagerDeploymentStatusListOptionalParams,
  NetworkManagerDeploymentStatusListResponse
} from "../models";

/** Interface representing a NetworkManagerDeploymentStatusOperations. */
export interface NetworkManagerDeploymentStatusOperations {
  /**
   * Post to List of Network Manager Deployment Status.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param parameters Parameters supplied to specify which Managed Network deployment status is.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    parameters: NetworkManagerDeploymentStatusParameter,
    options?: NetworkManagerDeploymentStatusListOptionalParams
  ): Promise<NetworkManagerDeploymentStatusListResponse>;
}
