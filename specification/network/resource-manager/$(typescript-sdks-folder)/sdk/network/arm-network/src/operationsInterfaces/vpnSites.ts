import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VpnSite,
  VpnSitesListByResourceGroupOptionalParams,
  VpnSitesListOptionalParams,
  VpnSitesGetOptionalParams,
  VpnSitesGetResponse,
  VpnSitesCreateOrUpdateOptionalParams,
  VpnSitesCreateOrUpdateResponse,
  TagsObject,
  VpnSitesUpdateTagsOptionalParams,
  VpnSitesUpdateTagsResponse,
  VpnSitesDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VpnSites. */
export interface VpnSites {
  /**
   * Lists all the vpnSites in a resource group.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    options?: VpnSitesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<VpnSite>;
  /**
   * Lists all the VpnSites in a subscription.
   * @param options The options parameters.
   */
  list(
    options?: VpnSitesListOptionalParams
  ): PagedAsyncIterableIterator<VpnSite>;
  /**
   * Retrieves the details of a VPN site.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite being retrieved.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSitesGetOptionalParams
  ): Promise<VpnSitesGetResponse>;
  /**
   * Creates a VpnSite resource if it doesn't exist else updates the existing VpnSite.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite being created or updated.
   * @param vpnSiteParameters Parameters supplied to create or update VpnSite.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    vpnSiteName: string,
    vpnSiteParameters: VpnSite,
    options?: VpnSitesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<VpnSitesCreateOrUpdateResponse>,
      VpnSitesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates a VpnSite resource if it doesn't exist else updates the existing VpnSite.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite being created or updated.
   * @param vpnSiteParameters Parameters supplied to create or update VpnSite.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    vpnSiteName: string,
    vpnSiteParameters: VpnSite,
    options?: VpnSitesCreateOrUpdateOptionalParams
  ): Promise<VpnSitesCreateOrUpdateResponse>;
  /**
   * Updates VpnSite tags.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite being updated.
   * @param vpnSiteParameters Parameters supplied to update VpnSite tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    vpnSiteName: string,
    vpnSiteParameters: TagsObject,
    options?: VpnSitesUpdateTagsOptionalParams
  ): Promise<VpnSitesUpdateTagsResponse>;
  /**
   * Deletes a VpnSite.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite being deleted.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSitesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes a VpnSite.
   * @param resourceGroupName The resource group name of the VpnSite.
   * @param vpnSiteName The name of the VpnSite being deleted.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    vpnSiteName: string,
    options?: VpnSitesDeleteOptionalParams
  ): Promise<void>;
}
