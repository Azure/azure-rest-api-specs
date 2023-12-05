// -----------------------------------------------------------------------
// <copyright file="standbyVMPool.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@armProviderNamespace("Microsoft.StandbyPool")
@service({
  title: "Microsoft.StandbyPool",
  version: "2023-06-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.StandbyPool;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A StandbyVirtualMachinePoolResource.")
model StandbyVirtualMachinePoolResource
  is TrackedResource<StandbyVirtualMachinePoolResourceProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("standbyVirtualMachinePoolName")
  @segment("standbyVirtualMachinePools")
  @visibility("read")
  @doc("Name of the standby virtual machine pool")
  @path
  name: string;
}

@doc("Details of the StandbyVirtualMachinePool.")
model StandbyVirtualMachinePoolResourceProperties {
  @doc("Specifies maximum number of standby VMs. When the pool is attached to VMScaleSets, the limit applies to each VMScaleSet.")
  @maxValue(2000)
  maxReadyCapacity: int64;

  @doc("Specifies the desired state of Virtual Machines in the pool.")
  @extension("x-ms-identifiers", ["vmState"])
  virtualMachineState: VirtualMachineState;

  @doc("Specifies list of VMScaleSets' fully qualified resource IDs the pool is attached to. When multiple VMScaleSets are specified, standby VMs are created for each VMScaleSet independently.")
  attachedVirtualMachineScaleSetIds?: string[];

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("State of standby virtual machines")
enum VirtualMachineState {
  @doc("Virtual machine is up and running.")
  Running,

  @doc("The virtual machine has released the lease on the underlying hardware and is powered off.")
  Deallocated,
}

@doc("Provisioning state")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Virtual machine is being deleted.")
  Deleting,
}

@armResourceOperations
interface StandbyVirtualMachinePools {
  get is ArmResourceRead<StandbyVirtualMachinePoolResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StandbyVirtualMachinePoolResource>;
  delete is ArmResourceDeleteWithoutOkAsync<StandbyVirtualMachinePoolResource>;
  update is ArmResourcePatchSync<
    StandbyVirtualMachinePoolResource,
    StandbyVirtualMachinePoolResourceProperties
  >;
  listByResourceGroup is ArmResourceListByParent<StandbyVirtualMachinePoolResource>;
  listBySubscription is ArmListBySubscription<StandbyVirtualMachinePoolResource>;
}
