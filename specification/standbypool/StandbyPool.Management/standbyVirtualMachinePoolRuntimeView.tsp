// -----------------------------------------------------------------------
// <copyright file="standbyVirtualMachinePoolRuntimeView.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./service.tsp";
import "./standbyVMPool.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.StandbyPool;

@doc("Contains information about a standby virtual machine pool as last known by the StandbyPool resource provider.")
@parentResource(StandbyVirtualMachinePoolResource)
@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
model StandbyVirtualMachinePoolRuntimeViewResource
  is ProxyResource<StandbyVirtualMachinePoolRuntimeViewResourceProperties> {
  @pattern("^[a-zA-Z0-9-]{0,24}$")
  @key("runtimeView")
  @segment("runtimeViews")
  @visibility(Lifecycle.Read)
  @doc("The unique identifier for the runtime view. The input string should be the word 'latest', which will get the latest runtime view of the pool, otherwise the request will fail with NotFound exception.")
  @path
  name: string;
}

@doc("Contains information about a standby pool as last known by the StandbyPool resource provider.")
@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
model StandbyVirtualMachinePoolRuntimeViewResourceProperties {
  @doc("A list containing the counts of virtual machines in each possible power state for each zone if enabled, as known by the StandbyPool resource provider. If zones are not enabled on the attached VMSS, the list will contain a single entry without zone values. Note: any resources in the Running state may still be installing extensions / not fully provisioned.")
  @visibility(Lifecycle.Read)
  @extension("x-ms-identifiers", #[])
  instanceCountSummary: VirtualMachineInstanceCountSummary[];

  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @doc("Display status of the standby pool")
  @visibility(Lifecycle.Read)
  status?: PoolStatus;

  @doc("Displays the provisioning state of the standby pool")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @doc("Displays prediction information of the standby pool")
  @visibility(Lifecycle.Read)
  prediction?: StandbyVirtualMachinePoolPrediction;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@doc("Contains the counts of VMs in each power state in a given zone, fault domain, as known by the StandbyPool resource provider. Note: any resources in the Running state may still be installing extensions / not fully provisioned.")
model VirtualMachineInstanceCountSummary {
  @doc("The zone that the provided counts are in. It will not have a value if zones are not enabled on the attached VMSS.")
  zone?: int64;

  @doc("The count of pooled resources in each state for the given zone.")
  @extension("x-ms-identifiers", #["state"])
  @removed(Microsoft.StandbyPool.Versions.`2025-03-01`)
  @renamedFrom(
    Microsoft.StandbyPool.Versions.`2025-03-01`,
    "instanceCountsByState"
  )
  oldinstanceCountsByState: PoolResourceStateCount[];

  @doc("The count of pooled virtual machines in each state for the given zone.")
  @extension("x-ms-identifiers", #["state"])
  @added(Microsoft.StandbyPool.Versions.`2025-03-01`)
  instanceCountsByState: PoolVirtualMachineStateCount[];
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("The state of the pooled virtual machines.")
union PoolVirtualMachineState {
  @doc("The virtual machine is up and running.")
  Running: "Running",

  @doc("The virtual machine is creating.")
  Creating: "Creating",

  @doc("The virtual machine is starting.")
  Starting: "Starting",

  @doc("The virtual machine is deleting.")
  Deleting: "Deleting",

  @doc("The virtual machine has released the lease on the underlying hardware and is powered off.")
  Deallocated: "Deallocated",

  @doc("The virtual machine is releasing the lease on the underlying hardware and is powered off.")
  Deallocating: "Deallocating",

  @doc("The virtual machine has released the lease on the underlying hardware and is powered off. Memory contents of the VM are stored in the OS disk. When started again, applications and processes that were previously running in your VM resume from the state prior to hibernation.")
  Hibernated: "Hibernated",

  @doc("The virtual machine is hibernating.")
  Hibernating: "Hibernating",

  string,
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays the counts of pooled virtual machines in each state, as known by the StandbyPool resource provider.")
model PoolVirtualMachineStateCount {
  @doc("The state that the pooled virtual machines count is for.")
  state: PoolVirtualMachineState;

  @doc("The count of pooled virtual machines in the given state.")
  count: int64;
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays prediction information of the standby pool.")
model StandbyVirtualMachinePoolPrediction {
  @doc("Displays the forecast information of the standby pool.")
  @visibility(Lifecycle.Read)
  forecastValues: StandbyVirtualMachinePoolForecastValues;

  @doc("Displays the UTC timestamp of when the prediction was retrieved for the standby pool.")
  @visibility(Lifecycle.Read)
  forecastStartTime: utcDateTime;

  @doc("Displays additional information for the prediction of the standby pool.")
  @visibility(Lifecycle.Read)
  forecastInfo: string;
}

@added(Microsoft.StandbyPool.Versions.`2025-03-01`)
@doc("Displays the forecast information of the standby pool.")
model StandbyVirtualMachinePoolForecastValues {
  @doc("Displays the predicted count of instances to be requested from the standby pool.")
  @visibility(Lifecycle.Read)
  instancesRequestedCount: int64[];
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@armResourceOperations
interface StandbyVirtualMachinePoolRuntimeViews {
  get is ArmResourceRead<StandbyVirtualMachinePoolRuntimeViewResource>;
  listByStandbyPool is ArmResourceListByParent<StandbyVirtualMachinePoolRuntimeViewResource>;
}
