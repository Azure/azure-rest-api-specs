import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  VpnSiteLink,
  VpnSiteLinksListByVpnSiteOptionalParams,
  VpnSiteLinksGetOptionalParams,
  VpnSiteLinksGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VpnSiteLinks. */
export interface VpnSiteLinks {
  /**
   * Lists all the vpnSiteLinks in a resource group for a vpn site.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite.
   * @param options The options parameters.
   */
  listByVpnSite(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSiteLinksListByVpnSiteOptionalParams
  ): PagedAsyncIterableIterator<VpnSiteLink>;
  /**
   * Retrieves the details of a VPN site link.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite.
   * @param vpnSiteLinkName The name of the VpnSiteLink being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    vpnSiteName: string,
    vpnSiteLinkName: string,
    options?: VpnSiteLinksGetOptionalParams
  ): Promise<VpnSiteLinksGetResponse>;
}
