import { PagedAsyncIterableIterator } from "@azure/core-paging";
import { NetworkInterfaces } from "../operationsInterfaces";
import * as coreClient from "@azure/core-client";
import * as Mappers from "../models/mappers";
import * as Parameters from "../models/parameters";
import { NetworkManagementClient } from "../networkManagementClient";
import { PollerLike, PollOperationState, LroEngine } from "@azure/core-lro";
import { LroImpl } from "../lroImpl";
import {
  NetworkInterface,
  NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesNextOptionalParams,
  NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams,
  NetworkInterfacesListCloudServiceNetworkInterfacesNextOptionalParams,
  NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams,
  NetworkInterfacesListAllNextOptionalParams,
  NetworkInterfacesListAllOptionalParams,
  NetworkInterfacesListNextOptionalParams,
  NetworkInterfacesListOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesNextOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesNextOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams,
  NetworkInterfaceIPConfiguration,
  NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsNextOptionalParams,
  NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams,
  NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesResponse,
  NetworkInterfacesListCloudServiceNetworkInterfacesResponse,
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
  NetworkInterfacesListAllResponse,
  NetworkInterfacesListResponse,
  NetworkInterfacesGetEffectiveRouteTableOptionalParams,
  NetworkInterfacesGetEffectiveRouteTableResponse,
  NetworkInterfacesListEffectiveNetworkSecurityGroupsOptionalParams,
  NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse,
  NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesResponse,
  NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesResponse,
  NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceOptionalParams,
  NetworkInterfacesGetVirtualMachineScaleSetNetworkInterfaceResponse,
  NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsResponse,
  NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationOptionalParams,
  NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationResponse,
  NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesNextResponse,
  NetworkInterfacesListCloudServiceNetworkInterfacesNextResponse,
  NetworkInterfacesListAllNextResponse,
  NetworkInterfacesListNextResponse,
  NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesNextResponse,
  NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesNextResponse,
  NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsNextResponse
} from "../models";

/// <reference lib="esnext.asynciterable" />
/** Class containing NetworkInterfaces operations. */
export class NetworkInterfacesImpl implements NetworkInterfaces {
  private readonly client: NetworkManagementClient;

  /**
   * Initialize a new instance of the class NetworkInterfaces class.
   * @param client Reference to the service client
   */
  constructor(client: NetworkManagementClient) {
    this.client = client;
  }

  /**
   * Gets information about all network interfaces in a role instance in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The name of role instance.
   * @param options The options parameters.
   */
  public listCloudServiceRoleInstanceNetworkInterfaces(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    options?: NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface> {
    const iter = this.listCloudServiceRoleInstanceNetworkInterfacesPagingAll(
      resourceGroupName,
      cloudServiceName,
      roleInstanceName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listCloudServiceRoleInstanceNetworkInterfacesPagingPage(
          resourceGroupName,
          cloudServiceName,
          roleInstanceName,
          options
        );
      }
    };
  }

  private async *listCloudServiceRoleInstanceNetworkInterfacesPagingPage(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    options?: NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface[]> {
    let result = await this._listCloudServiceRoleInstanceNetworkInterfaces(
      resourceGroupName,
      cloudServiceName,
      roleInstanceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listCloudServiceRoleInstanceNetworkInterfacesNext(
        resourceGroupName,
        cloudServiceName,
        roleInstanceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listCloudServiceRoleInstanceNetworkInterfacesPagingAll(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    options?: NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface> {
    for await (const page of this.listCloudServiceRoleInstanceNetworkInterfacesPagingPage(
      resourceGroupName,
      cloudServiceName,
      roleInstanceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all network interfaces in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param options The options parameters.
   */
  public listCloudServiceNetworkInterfaces(
    resourceGroupName: string,
    cloudServiceName: string,
    options?: NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface> {
    const iter = this.listCloudServiceNetworkInterfacesPagingAll(
      resourceGroupName,
      cloudServiceName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listCloudServiceNetworkInterfacesPagingPage(
          resourceGroupName,
          cloudServiceName,
          options
        );
      }
    };
  }

  private async *listCloudServiceNetworkInterfacesPagingPage(
    resourceGroupName: string,
    cloudServiceName: string,
    options?: NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface[]> {
    let result = await this._listCloudServiceNetworkInterfaces(
      resourceGroupName,
      cloudServiceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listCloudServiceNetworkInterfacesNext(
        resourceGroupName,
        cloudServiceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listCloudServiceNetworkInterfacesPagingAll(
    resourceGroupName: string,
    cloudServiceName: string,
    options?: NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface> {
    for await (const page of this.listCloudServiceNetworkInterfacesPagingPage(
      resourceGroupName,
      cloudServiceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all network interfaces in a subscription.
   * @param options The options parameters.
   */
  public listAll(
    options?: NetworkInterfacesListAllOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface> {
    const iter = this.listAllPagingAll(options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listAllPagingPage(options);
      }
    };
  }

  private async *listAllPagingPage(
    options?: NetworkInterfacesListAllOptionalParams
  ): AsyncIterableIterator<NetworkInterface[]> {
    let result = await this._listAll(options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listAllNext(continuationToken, options);
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listAllPagingAll(
    options?: NetworkInterfacesListAllOptionalParams
  ): AsyncIterableIterator<NetworkInterface> {
    for await (const page of this.listAllPagingPage(options)) {
      yield* page;
    }
  }

  /**
   * Gets all network interfaces in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  public list(
    resourceGroupName: string,
    options?: NetworkInterfacesListOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface> {
    const iter = this.listPagingAll(resourceGroupName, options);
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listPagingPage(resourceGroupName, options);
      }
    };
  }

  private async *listPagingPage(
    resourceGroupName: string,
    options?: NetworkInterfacesListOptionalParams
  ): AsyncIterableIterator<NetworkInterface[]> {
    let result = await this._list(resourceGroupName, options);
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listNext(
        resourceGroupName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listPagingAll(
    resourceGroupName: string,
    options?: NetworkInterfacesListOptionalParams
  ): AsyncIterableIterator<NetworkInterface> {
    for await (const page of this.listPagingPage(resourceGroupName, options)) {
      yield* page;
    }
  }

  /**
   * Gets information about all network interfaces in a virtual machine in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param options The options parameters.
   */
  public listVirtualMachineScaleSetVMNetworkInterfaces(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface> {
    const iter = this.listVirtualMachineScaleSetVMNetworkInterfacesPagingAll(
      resourceGroupName,
      virtualMachineScaleSetName,
      virtualmachineIndex,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listVirtualMachineScaleSetVMNetworkInterfacesPagingPage(
          resourceGroupName,
          virtualMachineScaleSetName,
          virtualmachineIndex,
          options
        );
      }
    };
  }

  private async *listVirtualMachineScaleSetVMNetworkInterfacesPagingPage(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface[]> {
    let result = await this._listVirtualMachineScaleSetVMNetworkInterfaces(
      resourceGroupName,
      virtualMachineScaleSetName,
      virtualmachineIndex,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listVirtualMachineScaleSetVMNetworkInterfacesNext(
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listVirtualMachineScaleSetVMNetworkInterfacesPagingAll(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface> {
    for await (const page of this.listVirtualMachineScaleSetVMNetworkInterfacesPagingPage(
      resourceGroupName,
      virtualMachineScaleSetName,
      virtualmachineIndex,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets all network interfaces in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param options The options parameters.
   */
  public listVirtualMachineScaleSetNetworkInterfaces(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterface> {
    const iter = this.listVirtualMachineScaleSetNetworkInterfacesPagingAll(
      resourceGroupName,
      virtualMachineScaleSetName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listVirtualMachineScaleSetNetworkInterfacesPagingPage(
          resourceGroupName,
          virtualMachineScaleSetName,
          options
        );
      }
    };
  }

  private async *listVirtualMachineScaleSetNetworkInterfacesPagingPage(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface[]> {
    let result = await this._listVirtualMachineScaleSetNetworkInterfaces(
      resourceGroupName,
      virtualMachineScaleSetName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listVirtualMachineScaleSetNetworkInterfacesNext(
        resourceGroupName,
        virtualMachineScaleSetName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listVirtualMachineScaleSetNetworkInterfacesPagingAll(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams
  ): AsyncIterableIterator<NetworkInterface> {
    for await (const page of this.listVirtualMachineScaleSetNetworkInterfacesPagingPage(
      resourceGroupName,
      virtualMachineScaleSetName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  public listVirtualMachineScaleSetIpConfigurations(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams
  ): PagedAsyncIterableIterator<NetworkInterfaceIPConfiguration> {
    const iter = this.listVirtualMachineScaleSetIpConfigurationsPagingAll(
      resourceGroupName,
      virtualMachineScaleSetName,
      virtualmachineIndex,
      networkInterfaceName,
      options
    );
    return {
      next() {
        return iter.next();
      },
      [Symbol.asyncIterator]() {
        return this;
      },
      byPage: () => {
        return this.listVirtualMachineScaleSetIpConfigurationsPagingPage(
          resourceGroupName,
          virtualMachineScaleSetName,
          virtualmachineIndex,
          networkInterfaceName,
          options
        );
      }
    };
  }

  private async *listVirtualMachineScaleSetIpConfigurationsPagingPage(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams
  ): AsyncIterableIterator<NetworkInterfaceIPConfiguration[]> {
    let result = await this._listVirtualMachineScaleSetIpConfigurations(
      resourceGroupName,
      virtualMachineScaleSetName,
      virtualmachineIndex,
      networkInterfaceName,
      options
    );
    yield result.value || [];
    let continuationToken = result.nextLink;
    while (continuationToken) {
      result = await this._listVirtualMachineScaleSetIpConfigurationsNext(
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        networkInterfaceName,
        continuationToken,
        options
      );
      continuationToken = result.nextLink;
      yield result.value || [];
    }
  }

  private async *listVirtualMachineScaleSetIpConfigurationsPagingAll(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams
  ): AsyncIterableIterator<NetworkInterfaceIPConfiguration> {
    for await (const page of this.listVirtualMachineScaleSetIpConfigurationsPagingPage(
      resourceGroupName,
      virtualMachineScaleSetName,
      virtualmachineIndex,
      networkInterfaceName,
      options
    )) {
      yield* page;
    }
  }

  /**
   * Gets information about all network interfaces in a role instance in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The name of role instance.
   * @param options The options parameters.
   */
  private _listCloudServiceRoleInstanceNetworkInterfaces(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    options?: NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesOptionalParams
  ): Promise<
    NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesResponse
  > {
    return this.client.sendOperationRequest(
      { resourceGroupName, cloudServiceName, roleInstanceName, options },
      listCloudServiceRoleInstanceNetworkInterfacesOperationSpec
    );
  }

  /**
   * Gets all network interfaces in a cloud service.
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param options The options parameters.
   */
  private _listCloudServiceNetworkInterfaces(
    resourceGroupName: string,
    cloudServiceName: string,
    options?: NetworkInterfacesListCloudServiceNetworkInterfacesOptionalParams
  ): Promise<NetworkInterfacesListCloudServiceNetworkInterfacesResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, cloudServiceName, options },
      listCloudServiceNetworkInterfacesOperationSpec
    );
  }

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
  ): Promise<NetworkInterfacesGetCloudServiceNetworkInterfaceResponse> {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        cloudServiceName,
        roleInstanceName,
        networkInterfaceName,
        options
      },
      getCloudServiceNetworkInterfaceOperationSpec
    );
  }

  /**
   * Deletes the specified network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  async beginDelete(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesDeleteOptionalParams
  ): Promise<PollerLike<PollOperationState<void>, void>> {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<void> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkInterfaceName, options },
      deleteOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Deletes the specified network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  async beginDeleteAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesDeleteOptionalParams
  ): Promise<void> {
    const poller = await this.beginDelete(
      resourceGroupName,
      networkInterfaceName,
      options
    );
    return poller.pollUntilDone();
  }

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
  ): Promise<NetworkInterfacesGetResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkInterfaceName, options },
      getOperationSpec
    );
  }

  /**
   * Creates or updates a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param parameters Parameters supplied to the create or update network interface operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdate(
    resourceGroupName: string,
    networkInterfaceName: string,
    parameters: NetworkInterface,
    options?: NetworkInterfacesCreateOrUpdateOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkInterfacesCreateOrUpdateResponse>,
      NetworkInterfacesCreateOrUpdateResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkInterfacesCreateOrUpdateResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkInterfaceName, parameters, options },
      createOrUpdateOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "azure-async-operation"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Creates or updates a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param parameters Parameters supplied to the create or update network interface operation.
   * @param options The options parameters.
   */
  async beginCreateOrUpdateAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    parameters: NetworkInterface,
    options?: NetworkInterfacesCreateOrUpdateOptionalParams
  ): Promise<NetworkInterfacesCreateOrUpdateResponse> {
    const poller = await this.beginCreateOrUpdate(
      resourceGroupName,
      networkInterfaceName,
      parameters,
      options
    );
    return poller.pollUntilDone();
  }

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
  ): Promise<NetworkInterfacesUpdateTagsResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, networkInterfaceName, parameters, options },
      updateTagsOperationSpec
    );
  }

  /**
   * Gets all network interfaces in a subscription.
   * @param options The options parameters.
   */
  private _listAll(
    options?: NetworkInterfacesListAllOptionalParams
  ): Promise<NetworkInterfacesListAllResponse> {
    return this.client.sendOperationRequest({ options }, listAllOperationSpec);
  }

  /**
   * Gets all network interfaces in a resource group.
   * @param resourceGroupName The name of the resource group.
   * @param options The options parameters.
   */
  private _list(
    resourceGroupName: string,
    options?: NetworkInterfacesListOptionalParams
  ): Promise<NetworkInterfacesListResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, options },
      listOperationSpec
    );
  }

  /**
   * Gets all route tables applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  async beginGetEffectiveRouteTable(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetEffectiveRouteTableOptionalParams
  ): Promise<
    PollerLike<
      PollOperationState<NetworkInterfacesGetEffectiveRouteTableResponse>,
      NetworkInterfacesGetEffectiveRouteTableResponse
    >
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkInterfacesGetEffectiveRouteTableResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkInterfaceName, options },
      getEffectiveRouteTableOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Gets all route tables applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  async beginGetEffectiveRouteTableAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesGetEffectiveRouteTableOptionalParams
  ): Promise<NetworkInterfacesGetEffectiveRouteTableResponse> {
    const poller = await this.beginGetEffectiveRouteTable(
      resourceGroupName,
      networkInterfaceName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets all network security groups applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  async beginListEffectiveNetworkSecurityGroups(
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
  > {
    const directSendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ): Promise<NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse> => {
      return this.client.sendOperationRequest(args, spec);
    };
    const sendOperation = async (
      args: coreClient.OperationArguments,
      spec: coreClient.OperationSpec
    ) => {
      let currentRawResponse:
        | coreClient.FullOperationResponse
        | undefined = undefined;
      const providedCallback = args.options?.onResponse;
      const callback: coreClient.RawResponseCallback = (
        rawResponse: coreClient.FullOperationResponse,
        flatResponse: unknown
      ) => {
        currentRawResponse = rawResponse;
        providedCallback?.(rawResponse, flatResponse);
      };
      const updatedArgs = {
        ...args,
        options: {
          ...args.options,
          onResponse: callback
        }
      };
      const flatResponse = await directSendOperation(updatedArgs, spec);
      return {
        flatResponse,
        rawResponse: {
          statusCode: currentRawResponse!.status,
          body: currentRawResponse!.parsedBody,
          headers: currentRawResponse!.headers.toJSON()
        }
      };
    };

    const lro = new LroImpl(
      sendOperation,
      { resourceGroupName, networkInterfaceName, options },
      listEffectiveNetworkSecurityGroupsOperationSpec
    );
    const poller = new LroEngine(lro, {
      resumeFrom: options?.resumeFrom,
      intervalInMs: options?.updateIntervalInMs,
      lroResourceLocationConfig: "location"
    });
    await poller.poll();
    return poller;
  }

  /**
   * Gets all network security groups applied to a network interface.
   * @param resourceGroupName The name of the resource group.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  async beginListEffectiveNetworkSecurityGroupsAndWait(
    resourceGroupName: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListEffectiveNetworkSecurityGroupsOptionalParams
  ): Promise<NetworkInterfacesListEffectiveNetworkSecurityGroupsResponse> {
    const poller = await this.beginListEffectiveNetworkSecurityGroups(
      resourceGroupName,
      networkInterfaceName,
      options
    );
    return poller.pollUntilDone();
  }

  /**
   * Gets information about all network interfaces in a virtual machine in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetVMNetworkInterfaces(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesOptionalParams
  ): Promise<
    NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesResponse
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        options
      },
      listVirtualMachineScaleSetVMNetworkInterfacesOperationSpec
    );
  }

  /**
   * Gets all network interfaces in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetNetworkInterfaces(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesOptionalParams
  ): Promise<
    NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesResponse
  > {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualMachineScaleSetName, options },
      listVirtualMachineScaleSetNetworkInterfacesOperationSpec
    );
  }

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
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        networkInterfaceName,
        options
      },
      getVirtualMachineScaleSetNetworkInterfaceOperationSpec
    );
  }

  /**
   * Get the specified network interface ip configuration in a virtual machine scale set.
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetIpConfigurations(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsOptionalParams
  ): Promise<
    NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsResponse
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        networkInterfaceName,
        options
      },
      listVirtualMachineScaleSetIpConfigurationsOperationSpec
    );
  }

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
  ): Promise<
    NetworkInterfacesGetVirtualMachineScaleSetIpConfigurationResponse
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        networkInterfaceName,
        ipConfigurationName,
        options
      },
      getVirtualMachineScaleSetIpConfigurationOperationSpec
    );
  }

  /**
   * ListCloudServiceRoleInstanceNetworkInterfacesNext
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param roleInstanceName The name of role instance.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListCloudServiceRoleInstanceNetworkInterfaces method.
   * @param options The options parameters.
   */
  private _listCloudServiceRoleInstanceNetworkInterfacesNext(
    resourceGroupName: string,
    cloudServiceName: string,
    roleInstanceName: string,
    nextLink: string,
    options?: NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesNextOptionalParams
  ): Promise<
    NetworkInterfacesListCloudServiceRoleInstanceNetworkInterfacesNextResponse
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        cloudServiceName,
        roleInstanceName,
        nextLink,
        options
      },
      listCloudServiceRoleInstanceNetworkInterfacesNextOperationSpec
    );
  }

  /**
   * ListCloudServiceNetworkInterfacesNext
   * @param resourceGroupName The name of the resource group.
   * @param cloudServiceName The name of the cloud service.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListCloudServiceNetworkInterfaces method.
   * @param options The options parameters.
   */
  private _listCloudServiceNetworkInterfacesNext(
    resourceGroupName: string,
    cloudServiceName: string,
    nextLink: string,
    options?: NetworkInterfacesListCloudServiceNetworkInterfacesNextOptionalParams
  ): Promise<NetworkInterfacesListCloudServiceNetworkInterfacesNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, cloudServiceName, nextLink, options },
      listCloudServiceNetworkInterfacesNextOperationSpec
    );
  }

  /**
   * ListAllNext
   * @param nextLink The nextLink from the previous successful call to the ListAll method.
   * @param options The options parameters.
   */
  private _listAllNext(
    nextLink: string,
    options?: NetworkInterfacesListAllNextOptionalParams
  ): Promise<NetworkInterfacesListAllNextResponse> {
    return this.client.sendOperationRequest(
      { nextLink, options },
      listAllNextOperationSpec
    );
  }

  /**
   * ListNext
   * @param resourceGroupName The name of the resource group.
   * @param nextLink The nextLink from the previous successful call to the List method.
   * @param options The options parameters.
   */
  private _listNext(
    resourceGroupName: string,
    nextLink: string,
    options?: NetworkInterfacesListNextOptionalParams
  ): Promise<NetworkInterfacesListNextResponse> {
    return this.client.sendOperationRequest(
      { resourceGroupName, nextLink, options },
      listNextOperationSpec
    );
  }

  /**
   * ListVirtualMachineScaleSetVMNetworkInterfacesNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListVirtualMachineScaleSetVMNetworkInterfaces method.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetVMNetworkInterfacesNext(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    nextLink: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesNextOptionalParams
  ): Promise<
    NetworkInterfacesListVirtualMachineScaleSetVMNetworkInterfacesNextResponse
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        nextLink,
        options
      },
      listVirtualMachineScaleSetVMNetworkInterfacesNextOperationSpec
    );
  }

  /**
   * ListVirtualMachineScaleSetNetworkInterfacesNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListVirtualMachineScaleSetNetworkInterfaces method.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetNetworkInterfacesNext(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    nextLink: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesNextOptionalParams
  ): Promise<
    NetworkInterfacesListVirtualMachineScaleSetNetworkInterfacesNextResponse
  > {
    return this.client.sendOperationRequest(
      { resourceGroupName, virtualMachineScaleSetName, nextLink, options },
      listVirtualMachineScaleSetNetworkInterfacesNextOperationSpec
    );
  }

  /**
   * ListVirtualMachineScaleSetIpConfigurationsNext
   * @param resourceGroupName The name of the resource group.
   * @param virtualMachineScaleSetName The name of the virtual machine scale set.
   * @param virtualmachineIndex The virtual machine index.
   * @param networkInterfaceName The name of the network interface.
   * @param nextLink The nextLink from the previous successful call to the
   *                 ListVirtualMachineScaleSetIpConfigurations method.
   * @param options The options parameters.
   */
  private _listVirtualMachineScaleSetIpConfigurationsNext(
    resourceGroupName: string,
    virtualMachineScaleSetName: string,
    virtualmachineIndex: string,
    networkInterfaceName: string,
    nextLink: string,
    options?: NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsNextOptionalParams
  ): Promise<
    NetworkInterfacesListVirtualMachineScaleSetIpConfigurationsNextResponse
  > {
    return this.client.sendOperationRequest(
      {
        resourceGroupName,
        virtualMachineScaleSetName,
        virtualmachineIndex,
        networkInterfaceName,
        nextLink,
        options
      },
      listVirtualMachineScaleSetIpConfigurationsNextOperationSpec
    );
  }
}
// Operation Specifications
const serializer = coreClient.createSerializer(Mappers, /* isXml */ false);

const listCloudServiceRoleInstanceNetworkInterfacesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.cloudServiceName,
    Parameters.roleInstanceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listCloudServiceNetworkInterfacesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/cloudServices/{cloudServiceName}/networkInterfaces",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.cloudServiceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getCloudServiceNetworkInterfaceOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/cloudServices/{cloudServiceName}/roleInstances/{roleInstanceName}/networkInterfaces/{networkInterfaceName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterface
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.cloudServiceName,
    Parameters.roleInstanceName,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const deleteOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}",
  httpMethod: "DELETE",
  responses: {
    200: {},
    201: {},
    202: {},
    204: {},
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterface
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion, Parameters.expand],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const createOrUpdateOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}",
  httpMethod: "PUT",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterface
    },
    201: {
      bodyMapper: Mappers.NetworkInterface
    },
    202: {
      bodyMapper: Mappers.NetworkInterface
    },
    204: {
      bodyMapper: Mappers.NetworkInterface
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters8,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const updateTagsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}",
  httpMethod: "PATCH",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterface
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  requestBody: Parameters.parameters1,
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept, Parameters.contentType],
  mediaType: "json",
  serializer
};
const listAllOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/providers/Microsoft.Network/networkInterfaces",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [Parameters.$host, Parameters.subscriptionId],
  headerParameters: [Parameters.accept],
  serializer
};
const listOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getEffectiveRouteTableOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveRouteTable",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.EffectiveRouteListResult
    },
    201: {
      bodyMapper: Mappers.EffectiveRouteListResult
    },
    202: {
      bodyMapper: Mappers.EffectiveRouteListResult
    },
    204: {
      bodyMapper: Mappers.EffectiveRouteListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listEffectiveNetworkSecurityGroupsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveNetworkSecurityGroups",
  httpMethod: "POST",
  responses: {
    200: {
      bodyMapper: Mappers.EffectiveNetworkSecurityGroupListResult
    },
    201: {
      bodyMapper: Mappers.EffectiveNetworkSecurityGroupListResult
    },
    202: {
      bodyMapper: Mappers.EffectiveNetworkSecurityGroupListResult
    },
    204: {
      bodyMapper: Mappers.EffectiveNetworkSecurityGroupListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listVirtualMachineScaleSetVMNetworkInterfacesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualMachineScaleSetName,
    Parameters.virtualmachineIndex
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listVirtualMachineScaleSetNetworkInterfacesOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/networkInterfaces",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.virtualMachineScaleSetName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getVirtualMachineScaleSetNetworkInterfaceOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterface
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.expand, Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName,
    Parameters.virtualMachineScaleSetName,
    Parameters.virtualmachineIndex
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listVirtualMachineScaleSetIpConfigurationsOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceIPConfigurationListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.expand, Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName,
    Parameters.virtualMachineScaleSetName,
    Parameters.virtualmachineIndex
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const getVirtualMachineScaleSetIpConfigurationOperationSpec: coreClient.OperationSpec = {
  path:
    "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations/{ipConfigurationName}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceIPConfiguration
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.expand, Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.networkInterfaceName,
    Parameters.virtualMachineScaleSetName,
    Parameters.virtualmachineIndex,
    Parameters.ipConfigurationName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listCloudServiceRoleInstanceNetworkInterfacesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.cloudServiceName,
    Parameters.roleInstanceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listCloudServiceNetworkInterfacesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.cloudServiceName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listAllNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listVirtualMachineScaleSetVMNetworkInterfacesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.virtualMachineScaleSetName,
    Parameters.virtualmachineIndex
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listVirtualMachineScaleSetNetworkInterfacesNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.virtualMachineScaleSetName
  ],
  headerParameters: [Parameters.accept],
  serializer
};
const listVirtualMachineScaleSetIpConfigurationsNextOperationSpec: coreClient.OperationSpec = {
  path: "{nextLink}",
  httpMethod: "GET",
  responses: {
    200: {
      bodyMapper: Mappers.NetworkInterfaceIPConfigurationListResult
    },
    default: {
      bodyMapper: Mappers.CloudError
    }
  },
  queryParameters: [Parameters.expand, Parameters.apiVersion1],
  urlParameters: [
    Parameters.$host,
    Parameters.resourceGroupName,
    Parameters.subscriptionId,
    Parameters.nextLink,
    Parameters.networkInterfaceName,
    Parameters.virtualMachineScaleSetName,
    Parameters.virtualmachineIndex
  ],
  headerParameters: [Parameters.accept],
  serializer
};
