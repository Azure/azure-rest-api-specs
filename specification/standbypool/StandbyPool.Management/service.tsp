// -----------------------------------------------------------------------
// <copyright file="service.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
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
})
@versioned(Microsoft.StandbyPool.Versions)
namespace Microsoft.StandbyPool;

@doc("Supported API Versions for Microsoft.StandbyPool")
enum Versions {
  @doc("API Version 2023-06-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  `2023-06-01-preview`,

  @doc("API Version 2023-12-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-12-01-preview`,

  @doc("API Version 2024-03-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-03-01-preview`,

  @doc("API Version 2024-08-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-08-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource is being deleted.")
  Deleting: "Deleting",

  string,
}

@added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
@doc("The state that the pooled resources.")
union PoolResourceState {
  @doc("The resource is up and running.")
  Running: "Running",

  @doc("The resource is creating.")
  Creating: "Creating",

  @doc("The resource is Deleting.")
  Deleting: "Deleting",

  @doc("The resource has released the lease on the underlying hardware and is powered off. This state only applies to virtual machines.")
  Deallocated: "Deallocated",

  @doc("The resource is releasing the lease on the underlying hardware and is powered off. This state only applies to virtual machines.") 
  Deallocating: "Deallocating",

  @doc("The resource has released the lease on the underlying hardware and is powered off. Memory contents of the VM are stored in the OS disk.  When started again, applications and processes that were previously running in your VM resume from the state prior to hibernation. This state only applies to virtual machines.")
  Hibernated: "Hibernated",

  string,
}

@added(Microsoft.StandbyPool.Versions.`2024-03-01-preview`)
@doc("Displays the counts of pooled resources in each state, as known by the StandbyPool resource provider.")
model PoolResourceStateCount {
  @doc("The state that the pooled resources count is for.")
  @removed(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
  @renamedFrom(Microsoft.StandbyPool.Versions.`2024-08-01-preview`, "state")
  oldState: string;

  @added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
  @doc("The state that the pooled resources count is for.")
  state: PoolResourceState;

  @doc("The count of pooled resources in the given state.")
  count: int64;
}

@added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
@doc("Displays StandbyPool status.")
model PoolStatus
{
  @doc("Displays the healthy state of the StandbyPool.")
  @visibility("read")
  code: HealthStateCode;

  @doc("Displays the StandbyPool health state details.")
  @visibility("read")
  message?: string;
}


@added(Microsoft.StandbyPool.Versions.`2024-08-01-preview`)
@doc("StandbyPool health state.")
union HealthStateCode {
  string,

  @doc("StandbyPool is in healthy state.")
  healthy: "HealthState/healthy",

  @doc("StandbyPool is in degraded state.")
  degraded: "HealthState/degraded",
}
