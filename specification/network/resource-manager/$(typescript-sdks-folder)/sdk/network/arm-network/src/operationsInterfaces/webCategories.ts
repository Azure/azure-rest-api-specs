import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  AzureWebCategory,
  WebCategoriesListBySubscriptionOptionalParams,
  WebCategoriesGetOptionalParams,
  WebCategoriesGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a WebCategories. */
export interface WebCategories {
  /**
   * Gets all the Azure Web Categories in a subscription.
   * @param options The options parameters.
   */
  listBySubscription(
    options?: WebCategoriesListBySubscriptionOptionalParams
  ): PagedAsyncIterableIterator<AzureWebCategory>;
  /**
   * Gets the specified Azure Web Category.
   * @param name The name of the azureWebCategory.
   * @param options The options parameters.
   */
  get(
    name: string,
    options?: WebCategoriesGetOptionalParams
  ): Promise<WebCategoriesGetResponse>;
}
