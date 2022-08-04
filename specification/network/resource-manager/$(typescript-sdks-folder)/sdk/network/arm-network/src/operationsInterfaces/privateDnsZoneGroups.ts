import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  PrivateDnsZoneGroup,
  PrivateDnsZoneGroupsListOptionalParams,
  PrivateDnsZoneGroupsDeleteOptionalParams,
  PrivateDnsZoneGroupsGetOptionalParams,
  PrivateDnsZoneGroupsGetResponse,
  PrivateDnsZoneGroupsCreateOrUpdateOptionalParams,
  PrivateDnsZoneGroupsCreateOrUpdateResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PrivateDnsZoneGroups. */
export interface PrivateDnsZoneGroups {
  /**
   * Gets all private dns zone groups in a private endpoint.
   * @param privateEndpointName The name of the private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    privateEndpointName: string,
    resourceGroupName: string,
    options?: PrivateDnsZoneGroupsListOptionalParams
  ): PagedAsyncIterableIterator<PrivateDnsZoneGroup>;
  /**
   * Deletes the specified private dns zone group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    options?: PrivateDnsZoneGroupsDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified private dns zone group.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    options?: PrivateDnsZoneGroupsDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the private dns zone group resource by specified private dns zone group name.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    options?: PrivateDnsZoneGroupsGetOptionalParams
  ): Promise<PrivateDnsZoneGroupsGetResponse>;
  /**
   * Creates or updates a private dns zone group in the specified private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param parameters Parameters supplied to the create or update private dns zone group operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    parameters: PrivateDnsZoneGroup,
    options?: PrivateDnsZoneGroupsCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PrivateDnsZoneGroupsCreateOrUpdateResponse>,
      PrivateDnsZoneGroupsCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a private dns zone group in the specified private endpoint.
   * @param resourceGroupName The name of the resource group.
   * @param privateEndpointName The name of the private endpoint.
   * @param privateDnsZoneGroupName The name of the private dns zone group.
   * @param parameters Parameters supplied to the create or update private dns zone group operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    privateEndpointName: string,
    privateDnsZoneGroupName: string,
    parameters: PrivateDnsZoneGroup,
    options?: PrivateDnsZoneGroupsCreateOrUpdateOptionalParams
  ): Promise<PrivateDnsZoneGroupsCreateOrUpdateResponse>;
}
