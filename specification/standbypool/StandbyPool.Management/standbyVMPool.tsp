// -----------------------------------------------------------------------
// <copyright file="standbyVMPool.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
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
  @doc("Specifies the elasticity profile of the standby virtual machine pools.")
  @added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
  elasticityProfile?: StandbyVirtualMachinePoolElasticityProfile;

  @doc("Specifies the desired state of virtual machines in the pool.")
  @extension("x-ms-identifiers", ["vmState"])
  virtualMachineState: VirtualMachineState;

  @doc("Specifies the fully qualified resource ID of a virtual machine scale set the pool is attached to.")
  @added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
  attachedVirtualMachineScaleSetId?: armResourceIdentifier<[
    {
      type: "Microsoft.Compute/virtualMachineScaleSet";
    }
  ]>;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("State of standby virtual machines")
union VirtualMachineState {
  string,

  @doc("The virtual machine is up and running.")
  Running: "Running",

  @doc("The virtual machine has released the lease on the underlying hardware and is powered off.")
  Deallocated: "Deallocated",
}

@added(Microsoft.StandbyPool.Versions.`2023-12-01-preview`)
@doc("Details of the elasticity profile.")
model StandbyVirtualMachinePoolElasticityProfile {
  @doc("Specifies the maximum number of virtual machines in the standby virtual machine pool.")
  @maxValue(2000)
  @minValue(0)
  maxReadyCapacity: int64;

  @added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
  @doc("Specifies the desired minimum number of virtual machines in the standby virtual machine pool. MinReadyCapacity cannot exceed MaxReadyCapacity.")
  @maxValue(2000)
  @minValue(0)
  minReadyCapacity?: int64;
}

@armResourceOperations
interface StandbyVirtualMachinePools {
  get is ArmResourceRead<StandbyVirtualMachinePoolResource>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    StandbyVirtualMachinePoolResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StandbyVirtualMachinePoolResource>;
  @parameterVisibility
  update is ArmCustomPatchSync<
    StandbyVirtualMachinePoolResource,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      StandbyVirtualMachinePoolResource,
      StandbyVirtualMachinePoolResourceProperties
    >
  >;
  listByResourceGroup is ArmResourceListByParent<StandbyVirtualMachinePoolResource>;
  listBySubscription is ArmListBySubscription<StandbyVirtualMachinePoolResource>;
}
