import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  ServiceTagInformation,
  ServiceTagInformationListOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a ServiceTagInformationOperations. */
export interface ServiceTagInformationOperations {
  /**
   * Gets a list of service tag information resources with pagination.
   * @param location The location that will be used as a reference for cloud (not as a filter based on
   *                 location, you will get the list of service tags with prefix details across all regions but limited
   *                 to the cloud that your subscription belongs to).
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: ServiceTagInformationListOptionalParams
  ): PagedAsyncIterableIterator<ServiceTagInformation>;
}
