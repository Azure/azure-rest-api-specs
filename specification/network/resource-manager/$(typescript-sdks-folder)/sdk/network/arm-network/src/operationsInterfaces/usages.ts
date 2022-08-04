import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { Usage, UsagesListOptionalParams } from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a Usages. */
export interface Usages {
  /**
   * List network usages for a subscription.
   * @param location The location where resource usage is queried.
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: UsagesListOptionalParams
  ): PagedAsyncIterableIterator<Usage>;
}
