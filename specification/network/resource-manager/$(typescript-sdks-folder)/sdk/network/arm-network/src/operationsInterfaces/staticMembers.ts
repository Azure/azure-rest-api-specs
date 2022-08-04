import { PagedAsyncIterableIterator } from "@azure/core-paging";
import {
  StaticMember,
  StaticMembersListOptionalParams,
  StaticMembersGetOptionalParams,
  StaticMembersGetResponse,
  StaticMembersCreateOrUpdateOptionalParams,
  StaticMembersCreateOrUpdateResponse,
  StaticMembersDeleteOptionalParams
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a StaticMembers. */
export interface StaticMembers {
  /**
   * Lists the specified static member.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    options?: StaticMembersListOptionalParams
  ): PagedAsyncIterableIterator<StaticMember>;
  /**
   * Gets the specified static member.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param staticMemberName The name of the static member.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    staticMemberName: string,
    options?: StaticMembersGetOptionalParams
  ): Promise<StaticMembersGetResponse>;
  /**
   * Creates or updates a static member.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param staticMemberName The name of the static member.
   * @param parameters Parameters supplied to the specify the static member to create
   * @param options The options parameters.
   */
  createOrUpdate(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    staticMemberName: string,
    parameters: StaticMember,
    options?: StaticMembersCreateOrUpdateOptionalParams
  ): Promise<StaticMembersCreateOrUpdateResponse>;
  /**
   * Deletes a static member.
   * @param resourceGroupName The name of the resource group.
   * @param networkManagerName The name of the network manager.
   * @param networkGroupName The name of the network group.
   * @param staticMemberName The name of the static member.
   * @param options The options parameters.
   */
  delete(
    resourceGroupName: string,
    networkManagerName: string,
    networkGroupName: string,
    staticMemberName: string,
    options?: StaticMembersDeleteOptionalParams
  ): Promise<void>;
}
