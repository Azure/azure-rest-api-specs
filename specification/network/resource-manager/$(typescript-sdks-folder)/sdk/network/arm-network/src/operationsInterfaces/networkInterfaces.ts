import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { PollerLike, PollOperationState } from "@azure/core-lro";
import {
  NetworkInterface,
  NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams,
  NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams,
  NetworkInterfacesListAllOptionalParams,
  NetworkInterfacesListOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams,
  NetworkInterfaceIPConfiguration,
  NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams,
  NetworkInterfacesGetCloudServiceNetworkInterfaceOptionalParams,
  NetworkInterfacesGetCloudServiceNetworkInterfaceResponse,
  NetworkInterfacesDeleteOptionalParams,
  NetworkInterfacesGetOptionalParams,
  NetworkInterfacesGetResponse,
  NetworkInterfacesCreateOrUpdateOptionalParams,
  NetworkInterfacesCreateOrUpdateResponse,
  TagsObject,
  NetworkInterfacesUpdateTagsOptionalParams,
  NetworkInterfacesUpdateTagsResponse,
  NetworkInterfacesGetEffectiveRouteTableOptionalParams,
  NetworkInterfacesGetEffectiveRouteTableResponse,
  NetworkInterfacesListEffectiveNetworkSecurityGroupsOptionalParams,
  NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse,
  NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceOptionalParams,
  NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceResponse,
  NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationOptionalParams,
  NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Interface representing a NetworkInterfaces. */
export interface NetworkInterfaces {
  /**
   * Gets information about all network interfaces in a role instance in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The name of role instance.
   * @param options The options parameters.
   */
  listCloudServiceRoleInstanceNetworkInterfaces(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    options?: NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface>;
  /**
   * Gets all network interfaces in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param options The options parameters.
   */
  listCloudServiceNetworkInterfaces(
    resourceGroupName: string,
    cloudServiceName: string,
    options?: NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface>;
  /**
   * Gets all network interfaces in a subscription.
   * @param options The options parameters.
   */
  listAll(
    options?: NetworkInterfacesListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface>;
  /**
   * Gets all network interfaces in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  list(
    resourceGroupName: string,
    options?: NetworkInterfacesListOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface>;
  /**
   * Gets information about all network interfaces in a virtual machine in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param options The options parameters.
   */
  listVirtualMachineScaleSetVMNetworkInterfaces(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface>;
  /**
   * Gets all network interfaces in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param options The options parameters.
   */
  listVirtualMachineScaleSetNetworkInterfaces(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface>;
  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  listVirtualMachineScaleSetIpConfigurations(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterfaceIPConfiguration>;
  /**
   * Get the specified network interface in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The name of role instance.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  getCloudServiceNetworkInterface(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetCloudServiceNetworkInterfaceOptionalParams
  ): Promise<NetworkInterfacesGetCloudServiceNetworkInterfaceResponse>;
  /**
   * Deletes the specified network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  beginDelete(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>>;
  /**
   * Deletes the specified network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  beginDeleteAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesDeleteOptionalParams
  ): Promise<void>;
  /**
   * Gets information about the specified network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  get(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetOptionalParams
  ): Promise<NetworkInterfacesGetResponse>;
  /**
   * Creates or updates a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param parameters Parameters supplied to the create or update network interface operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdate(
    resourceGroupName: string,
    networkInterfaceName: string,
    parameters: NetworkInterface,
    options?: NetworkInterfacesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkInterfacesCreateOrUpdateResponse>,
      NetworkInterfacesCreateOrUpdateResponse
    >
  >;
  /**
   * Creates or updates a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param parameters Parameters supplied to the create or update network interface operation.
   * @param options The options parameters.
   */
  beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    parameters: NetworkInterface,
    options?: NetworkInterfacesCreateOrUpdateOptionalParams
  ): Promise<NetworkInterfacesCreateOrUpdateResponse>;
  /**
   * Updates a network interface tags.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param parameters Parameters supplied to update network interface tags.
   * @param options The options parameters.
   */
  updateTags(
    resourceGroupName: string,
    networkInterfaceName: string,
    parameters: TagsObject,
    options?: NetworkInterfacesUpdateTagsOptionalParams
  ): Promise<NetworkInterfacesUpdateTagsResponse>;
  /**
   * Gets all route tables applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  beginGetEffectiveRouteTable(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetEffectiveRouteTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkInterfacesGetEffectiveRouteTableResponse>,
      NetworkInterfacesGetEffectiveRouteTableResponse
    >
  >;
  /**
   * Gets all route tables applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  beginGetEffectiveRouteTableAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetEffectiveRouteTableOptionalParams
  ): Promise<NetworkInterfacesGetEffectiveRouteTableResponse>;
  /**
   * Gets all network security groups applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  beginListEffectiveNetworkSecurityGroups(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListEffectiveNetworkSecurityGroupsOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<
        NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse
      >,
      NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse
    >
  >;
  /**
   * Gets all network security groups applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  beginListEffectiveNetworkSecurityGroupsAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListEffectiveNetworkSecurityGroupsOptionalParams
  ): Promise<NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse>;
  /**
   * Get the specified network interface in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  getVirtualMachineScaleSetNetworkInterface(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceOptionalParams
  ): Promise<
    NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceResponse
  >;
  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param ipConfigurationName The name of the ip configuration.
   * @param options The options parameters.
   */
  getVirtualMachineScaleSetIpConfiguration(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    ipConfigurationName: string,
    options?: NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationOptionalParams
  ): Promise<NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationResponse>;
}
