// -----------------------------------------------------------------------
// <copyright file="standbyVM.tsp" company="Microsoft Corporation">
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

@parentResource(StandbyVirtualMachinePoolResource)
model StandbyVirtualMachineResource
  is ProxyResource<StandbyVirtualMachineResourceProperties> {
  @pattern("^[_a-zA-Z0-9-]{3,64}$")
  @key("standbyVirtualMachineName")
  @segment("standbyVirtualMachines")
  @visibility("read")
  @doc("Name of the standby virtual machine")
  @path
  name: string;
}

@doc("Details of the StandbyVirtualMachine.")
model StandbyVirtualMachineResourceProperties {
  @doc("Resource id of the virtual machine.")
  virtualMachineResourceId: Azure.Core.armResourceIdentifier<[]>;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface StandbyVirtualMachines {
  get is ArmResourceRead<StandbyVirtualMachineResource>;
  listByStandbyVirtualMachinePoolResource is ArmResourceListByParent<StandbyVirtualMachineResource>;
}
