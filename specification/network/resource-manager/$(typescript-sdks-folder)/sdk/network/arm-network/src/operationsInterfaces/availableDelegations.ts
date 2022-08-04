import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  AvailableDelegation,
  AvailableDelegationsListOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a AvailableDelegations. */
export interface AvailableDelegations {
  /**
   * Gets all of the available subnet delegations for this subscription in this region.
   * @param location The location of the subnet.
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: AvailableDelegationsListOptionalParams
  ): PagedAsyncIterableIterator<AvailableDelegation>;
}
