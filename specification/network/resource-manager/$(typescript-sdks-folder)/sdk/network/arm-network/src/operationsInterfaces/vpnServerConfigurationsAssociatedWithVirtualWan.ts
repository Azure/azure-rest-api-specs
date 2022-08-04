import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams,
  VpnServerConfigurationsAssociatedWithVirtualWanListResponse
} from "../models";

/** Interface representing a VpnServerConfigurationsAssociatedWithVirtualWan. */
export interface VpnServerConfigurationsAssociatedWithVirtualWan {
  /**
   * Gives the list of VpnServerConfigurations associated with Virtual Wan in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN whose associated VpnServerConfigurations is needed.
   * @param options The options parameters.
   */
  beginList(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        VpnServerConfigurationsAssociatedWithVirtualWanListResponse
      >,
      VpnServerConfigurationsAssociatedWithVirtualWanListResponse
    >
  >;
  /**
   * Gives the list of VpnServerConfigurations associated with Virtual Wan in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN whose associated VpnServerConfigurations is needed.
   * @param options The options parameters.
   */
  beginListAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    options?: VpnServerConfigurationsAssociatedWithVirtualWanListOptionalParams
  ): Promise<VpnServerConfigurationsAssociatedWithVirtualWanListResponse>;
}
