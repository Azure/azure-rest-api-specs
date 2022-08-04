import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  AvailableServiceAlias,
  AvailableServiceAliasesListOptionalParams,
  AvailableServiceAliasesListByResourceGroupOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a AvailableServiceAliases. */
export interface AvailableServiceAliases {
  /**
   * Gets all available service aliases for this subscription in this region.
   * @param location The location.
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: AvailableServiceAliasesListOptionalParams
  ): PagedAsyncIterableIterator<AvailableServiceAlias>;
  /**
   * Gets all available service aliases for this resource group in this region.
   * @param resourceGroupName The name of the resource group.
   * @param location The location.
   * @param options The options parameters.
   */
  listByResourceGroup(
    resourceGroupName: string,
    location: string,
    options?: AvailableServiceAliasesListByResourceGroupOptionalParams
  ): PagedAsyncIterableIterator<AvailableServiceAlias>;
}
