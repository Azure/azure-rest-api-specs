import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  AvailablePrivateEndpointType,
  AvailablePrivateEndpointTypesListOptionalParams,
  AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a AvailablePrivateEndpointTypes. */
export interface AvailablePrivateEndpointTypes {
  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in
   * this region.
   * @param location The location of the domain name.
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: AvailablePrivateEndpointTypesListOptionalParams
  ): PagedAsyncIterableIterator<AvailablePrivateEndpointType>;
  /**
   * Returns all of the resource types that can be linked to a Private Endpoint in this subscription in
   * this region.
   * @param location The location of the domain name.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  listByResourceGroup(
    location: string,
    resourceGroupName: string,
    options?: AvailablePrivateEndpointTypesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<AvailablePrivateEndpointType>;
}
