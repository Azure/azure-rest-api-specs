import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  PublicIPAddress,
  PublicIPAddressesListCloudServicePublicIPAddressesOptionalParams,
  PublicIPAddressesListCloudServiceRoleInstancePublicIPAddressesOptionalParams,
  PublicIPAddressesListAllOptionalParams,
  PublicIPAddressesListOptionalParams,
  PublicIPAddressesListVirtualMachineScaleSetPublicIPAddressesOptionalParams,
  PublicIPAddressesListVirtualMachineScaleSetVMPublicIPAddressesOptionalParams,
  PublicIPAddressesGetCloudServicePublicIPAddressOptionalParams,
  PublicIPAddressesGetCloudServicePublicIPAddressResponse,
  PublicIPAddressesDeleteOptionalParams,
  PublicIPAddressesGetOptionalParams,
  PublicIPAddressesGetResponse,
  PublicIPAddressesCreateOrUpdateOptionalParams,
  PublicIPAddressesCreateOrUpdateResponse,
  TagsObject,
  PublicIPAddressesUpdateTagsOptionalParams,
  PublicIPAddressesUpdateTagsResponse,
  PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddressOptionalParams,
  PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddressResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a PublicIPAddresses. */
export interface PublicIPAddresses {
  /**
   * Gets information about all public IP addresses on a cloud service level.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param options The options parameters.
   */
  listCloudServicePublicIPAddresses(
    resourceGroupName: string,
    cloudServiceName: string,
    options?: PublicIPAddressesListCloudServicePublicIPAddressesOptionalParams
  ): PagedAsyncIterableIterator<PublicIPAddress>;
  /**
   * Gets information about all public IP addresses in a role instance IP configuration in a cloud
   * service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The name of role instance.
   * @param networkInterfaceName The network interface name.
   * @param ipConfigurationName The IP configuration name.
   * @param options The options parameters.
   */
  listCloudServiceRoleInstancePublicIPAddresses(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    networkInterfaceName: string,
    ipConfigurationName: string,
    options?: PublicIPAddressesListCloudServiceRoleInstancePublicIPAddressesOptionalParams
  ): PagedAsyncIterableIterator<PublicIPAddress>;
  /**
   * Gets all the public IP addresses in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: PublicIPAddressesListAllOptionalParams
  ): PagedAsyncIterableIterator<PublicIPAddress>;
  /**
   * Gets all public IP addresses in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: PublicIPAddressesListOptionalParams
  ): PagedAsyncIterableIterator<PublicIPAddress>;
  /**
   * Gets information about all public IP addresses on a virtual machine scale set level.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param options The options parameters.
   */
  listVirtualMachineScaleSetPublicIPAddresses(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    options?: PublicIPAddressesListVirtualMachineScaleSetPublicIPAddressesOptionalParams
  ): PagedAsyncIterableIterator<PublicIPAddress>;
  /**
   * Gets information about all public IP addresses in a virtual machine IP configuration in a virtual
   * machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The network interface name.
   * @param ipConfigurationName The IP configuration name.
   * @param options The options parameters.
   */
  listVirtualMachineScaleSetVMPublicIPAddresses(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    ipConfigurationName: string,
    options?: PublicIPAddressesListVirtualMachineScaleSetVMPublicIPAddressesOptionalParams
  ): PagedAsyncIterableIterator<PublicIPAddress>;
  /**
   * Get the specified public IP address in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The role instance name.
   * @param networkInterfaceName The name of the network interface.
   * @param ipConfigurationName The name of the IP configuration.
   * @param publicIpAddressName The name of the public IP Address.
   * @param options The options parameters.
   */
  getCloudServicePublicIPAddress(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    networkInterfaceName: string,
    ipConfigurationName: string,
    publicIpAddressName: string,
    options?: PublicIPAddressesGetCloudServicePublicIPAddressOptionalParams
  ): Promise<PublicIPAddressesGetCloudServicePublicIPAddressResponse>;
  /**
   * Deletes the specified public IP address.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpAddressName The name of the public IP address.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    publicIpAddressName: string,
    options?: PublicIPAddressesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified public IP address.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpAddressName The name of the public IP address.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    publicIpAddressName: string,
    options?: PublicIPAddressesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets the specified public IP address in a specified resource group.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpAddressName The name of the public IP address.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    publicIpAddressName: string,
    options?: PublicIPAddressesGetOptionalParams
  ): Promise<PublicIPAddressesGetResponse>;
  /**
   * Creates or updates a static or dynamic public IP address.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpAddressName The name of the public IP address.
   * @param parameters Parameters supplied to the create or update public IP address operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    publicIpAddressName: string,
    parameters: PublicIPAddress,
    options?: PublicIPAddressesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<PublicIPAddressesCreateOrUpdateResponse>,
      PublicIPAddressesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a static or dynamic public IP address.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpAddressName The name of the public IP address.
   * @param parameters Parameters supplied to the create or update public IP address operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    publicIpAddressName: string,
    parameters: PublicIPAddress,
    options?: PublicIPAddressesCreateOrUpdateOptionalParams
  ): Promise<PublicIPAddressesCreateOrUpdateResponse>;
  /**
   * Updates public IP address tags.
   * @param resourceGroupName The name of the resource group.
   * @param publicIpAddressName The name of the public IP address.
   * @param parameters Parameters supplied to update public IP address tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    publicIpAddressName: string,
    parameters: TagsObject,
    options?: PublicIPAddressesUpdateTagsOptionalParams
  ): Promise<PublicIPAddressesUpdateTagsResponse>;
  /**
   * Get the specified public IP address in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param ipConfigurationName The name of the IP configuration.
   * @param publicIpAddressName The name of the public IP Address.
   * @param options The options parameters.
   */
  getVirtualMachineScaleSetPublicIPAddress(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    ipConfigurationName: string,
    publicIpAddressName: string,
    options?: PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddressOptionalParams
  ): Promise<PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddressResponse>;
}
