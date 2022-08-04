import {
  ResourceNavigationLinksListOptionalParams,
  ResourceNavigationLinksListResponse
} from "../models";

/** Interface representing a ResourceNavigationLinks. */
export interface ResourceNavigationLinks {
  /**
   * Gets a list of resource navigation links for a subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: ResourceNavigationLinksListOptionalParams
  ): Promise<ResourceNavigationLinksListResponse>;
}
