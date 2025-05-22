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
  @visibility("read")
  @doc("The unique identifier for the runtime view. The input string should be the word 'latest', which will get the latest runtime view of the pool, otherwise the request will fail with NotFound exception.")
  @path
  name: string;
}

@doc("Contains information about a standby pool as last known by the StandbyPool resource provider.")
@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
model StandbyVirtualMachinePoolRuntimeViewResourceProperties {
  @doc("A list containing the counts of virtual machines in each possible power state for each zone if enabled, as known by the StandbyPool resource provider.\nIf zones are not enabled on the attached VMSS, the list will contain a single entry with null zone values.\nNote: any updates to pool resources outside of StandbyPoolRP (i.e deleting a VM through portal) are not reflected here.\nNote: any resources in the Running state may still be installing extensions / not fully provisioned.")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  instanceCountSummary: VirtualMachineInstanceCountSummary[];

  @doc("Displays the provisioning state of the standby pool")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@doc("Contains the counts of VMs in each power state in a given zone, fault domain, as known by the StandbyPool resource provider.\nNote: any updates to pool resources outside of StandbyPoolRP (i.e deleting a VM through portal) are not reflected here.\nNote: any resources in the Running state may still be installing extensions / not fully provisioned.")
model VirtualMachineInstanceCountSummary {
  @doc("The zone that the provided counts are in. This is null if zones are not enabled on the attached VMSS.")
  zone?: int64;

  @doc("The count of pooled resources in each state for the given zone.")
  @extension("x-ms-identifiers", ["state"])
  instanceCountsByState: PoolResourceStateCount[];
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@armResourceOperations
interface StandbyVirtualMachinePoolRuntimeViews {
  get is ArmResourceRead<StandbyVirtualMachinePoolRuntimeViewResource>;
  listByStandbyPool is ArmResourceListByParent<StandbyVirtualMachinePoolRuntimeViewResource>;
}
