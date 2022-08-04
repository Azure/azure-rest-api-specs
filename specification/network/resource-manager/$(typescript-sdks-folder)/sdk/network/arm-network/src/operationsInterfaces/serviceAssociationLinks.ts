import {
  ServiceAssociationLinksListOptionalParams,
  ServiceAssociationLinksListResponse
} from "../models";

/** Interface representing a ServiceAssociationLinks. */
export interface ServiceAssociationLinks {
  /**
   * Gets a list of service association links for a subnet.
   * @param resourceGroupName The name of the resource group.
   * @param virtualNetworkName The name of the virtual network.
   * @param subnetName The name of the subnet.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    virtualNetworkName: string,
    subnetName: string,
    options?: ServiceAssociationLinksListOptionalParams
  ): Promise<ServiceAssociationLinksListResponse>;
}
