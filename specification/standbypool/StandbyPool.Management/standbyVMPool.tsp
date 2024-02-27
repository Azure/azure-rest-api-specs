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
import "./service.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.StandbyPool;

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
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @doc("Specifies maximum number of standby VMs. When the pool is attached to VMScaleSets, the limit applies to each VMScaleSet.")
  @maxValue(2000)
  @removed(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
  maxReadyCapacity: int64;

  @doc("Specifies the elasticity profile of the standby virtual machine pools.")
  @added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
  elasticityProfile?: StandbyVirtualMachinePoolElasticityProfile;

  @doc("Specifies the desired state of virtual machines in the pool.")
  @extension("x-ms-identifiers", ["vmState"])
  virtualMachineState: VirtualMachineState;

  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning"
  @doc("Specifies list of VMScaleSets' fully qualified resource IDs the pool is attached to. When multiple VMScaleSets are specified, standby VMs are created for each VMScaleSet independently.")
  @removed(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
  attachedVirtualMachineScaleSetIds?: string[];

  @doc("Specifies the fully qualified resource ID of a virtual machine scale set the pool is attached to.")
  @added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
  attachedVirtualMachineScaleSetId?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachineScaleSet";
    }
  ]>;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("State of standby virtual machines")
enum VirtualMachineState {
  @doc("The virtual machine is up and running.")
  Running,

  @doc("The virtual machine has released the lease on the underlying hardware and is powered off.")
  Deallocated,
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Details of the elasticity profile.")
model StandbyVirtualMachinePoolElasticityProfile {
  @doc("Specifies maximum number of virtual machines in the standby virtual machine pool.")
  @maxValue(2000)
  @minValue(0)
  maxReadyCapacity: int64;
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
