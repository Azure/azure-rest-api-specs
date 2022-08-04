import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  GetVpnSitesConfigurationRequest,
  VpnSitesConfigurationDownloadOptionalParams
} from "../models";

/** Interface representing a VpnSitesConfiguration. */
export interface VpnSitesConfiguration {
  /**
   * Gives the sas-url to download the configurations for vpn-sites in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN for which configuration of all vpn-sites is needed.
   * @param request Parameters supplied to download vpn-sites configuration.
   * @param options The options parameters.
   */
  beginDownload(
    resourceGroupName: string,
    virtualWANName: string,
    request: GetVpnSitesConfigurationRequest,
    options?: VpnSitesConfigurationDownloadOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Gives the sas-url to download the configurations for vpn-sites in a resource group.
   * @param resourceGroupName The resource group name.
   * @param virtualWANName The name of the VirtualWAN for which configuration of all vpn-sites is needed.
   * @param request Parameters supplied to download vpn-sites configuration.
   * @param options The options parameters.
   */
  beginDownloadAndWait(
    resourceGroupName: string,
    virtualWANName: string,
    request: GetVpnSitesConfigurationRequest,
    options?: VpnSitesConfigurationDownloadOptionalParams
  ): Promise<void>;
}
