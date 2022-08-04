import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  BgpServiceCommunity,
  BgpServiceCommunitiesListOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a BgpServiceCommunities. */
export interface BgpServiceCommunities {
  /**
   * Gets all the available bgp service communities.
   * @param options The options parameters.
   */
  list(
    options?: BgpServiceCommunitiesListOptionalParams
  ): PagedAsyncIterableIterator<BgpServiceCommunity>;
}
