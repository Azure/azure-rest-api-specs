import {
  ServiceTagsListOptionalParams,
  ServiceTagsListResponse
} from "../models";

/** Interface representing a ServiceTags. */
export interface ServiceTags {
  /**
   * Gets a list of service tag information resources.
   * @param location The location that will be used as a reference for version (not as a filter based on
   *                 location, you will get the list of service tags with prefix details across all regions but limited
   *                 to the cloud that your subscription belongs to).
   * @param options The options parameters.
   */
  list(
    location: string,
    options?: ServiceTagsListOptionalParams
  ): Promise<ServiceTagsListResponse>;
}
