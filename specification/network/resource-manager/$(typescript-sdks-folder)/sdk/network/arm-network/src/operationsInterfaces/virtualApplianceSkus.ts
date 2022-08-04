import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  NetworkVirtualApplianceSku,
  VirtualApplianceSkusListOptionalParams,
  VirtualApplianceSkusGetOptionalParams,
  VirtualApplianceSkusGetResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a VirtualApplianceSkus. */
export interface VirtualApplianceSkus {
  /**
   * List all SKUs available for a virtual appliance.
   * @param options The options parameters.
   */
  list(
    options?: VirtualApplianceSkusListOptionalParams
  ): PagedAsyncIterableIterator<NetworkVirtualApplianceSku>;
  /**
   * Retrieves a single available sku for network virtual appliance.
   * @param skuName Name of the Sku.
   * @param options The options parameters.
   */
  get(
    skuName: string,
    options?: VirtualApplianceSkusGetOptionalParams
  ): Promise<VirtualApplianceSkusGetResponse>;
}
