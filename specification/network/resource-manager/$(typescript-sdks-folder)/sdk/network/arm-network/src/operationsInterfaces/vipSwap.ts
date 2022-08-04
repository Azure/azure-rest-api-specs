import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  VipSwapGetOptionalParams,
  VipSwapGetResponse,
  SwapResource,
  VipSwapCreateOptionalParams,
  VipSwapListOptionalParams,
  VipSwapListResponse
} from "../models";

/** Interface representing a VipSwap. */
export interface VipSwap {
  /**
   * Gets the SwapResource which identifies the slot type for the specified cloud service. The slot type
   * on a cloud service can either be Staging or Production
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param options The options parameters.
   */
  get(
    groupName: string,
    resourceName: string,
    options?: VipSwapGetOptionalParams
  ): Promise<VipSwapGetResponse>;
  /**
   * Performs vip swap operation on swappable cloud services.
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param parameters SwapResource object where slot type should be the target slot after vip swap for
   *                   the specified cloud service.
   * @param options The options parameters.
   */
  beginCreate(
    groupName: string,
    resourceName: string,
    parameters: SwapResource,
    options?: VipSwapCreateOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Performs vip swap operation on swappable cloud services.
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param parameters SwapResource object where slot type should be the target slot after vip swap for
   *                   the specified cloud service.
   * @param options The options parameters.
   */
  beginCreateAndWait(
    groupName: string,
    resourceName: string,
    parameters: SwapResource,
    options?: VipSwapCreateOptionalParams
  ): Promise<void>;
  /**
   * Gets the list of SwapResource which identifies the slot type for the specified cloud service. The
   * slot type on a cloud service can either be Staging or Production
   * @param groupName The name of the resource group.
   * @param resourceName The name of the cloud service.
   * @param options The options parameters.
   */
  list(
    groupName: string,
    resourceName: string,
    options?: VipSwapListOptionalParams
  ): Promise<VipSwapListResponse>;
}
